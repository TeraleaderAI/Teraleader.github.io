import http from 'node:http';
import fs from 'node:fs';
import path from 'node:path';
import { spawn } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const toolDir = path.dirname(fileURLToPath(import.meta.url));
const rootDir = path.resolve(toolDir, '..', '..');
const siteDir = path.join(rootDir, 'site');
const dataDir = path.join(siteDir, 'src', 'data');
const host = '127.0.0.1';
const port = Number(process.env.PORT || 5081);

const files = {
  products: path.join(dataDir, 'products.json'),
  notices: path.join(dataDir, 'notices.json'),
  company: path.join(dataDir, 'company.json')
};

const uploadDirs = {
  productImages: path.join(siteDir, 'public', 'images', 'products'),
  downloads: path.join(siteDir, 'public', 'downloads')
};

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function writeJson(file, data) {
  fs.writeFileSync(file, `${JSON.stringify(data, null, 2)}\n`, 'utf8');
}

function send(res, status, body, type = 'application/json; charset=utf-8') {
  res.writeHead(status, {
    'Content-Type': type,
    'Cache-Control': 'no-store'
  });
  res.end(type.startsWith('application/json') ? JSON.stringify(body) : body);
}

function readBody(req) {
  return new Promise((resolve, reject) => {
    let body = '';
    req.on('data', (chunk) => {
      body += chunk;
      if (body.length > 10_000_000) {
        req.destroy();
        reject(new Error('Request body too large'));
      }
    });
    req.on('end', () => resolve(body ? JSON.parse(body) : {}));
    req.on('error', reject);
  });
}

function runNpm(script) {
  return new Promise((resolve) => {
    const child = spawn('npm.cmd', ['run', script], {
      cwd: siteDir,
      shell: false,
      windowsHide: true
    });

    let output = '';
    child.stdout.on('data', (data) => {
      output += data.toString();
    });
    child.stderr.on('data', (data) => {
      output += data.toString();
    });
    child.on('close', (code) => {
      resolve({ code, output });
    });
  });
}

function safeBasename(value) {
  const parsed = path.parse(String(value || 'file').replace(/[\\/:*?"<>|]+/g, '-'));
  const name = parsed.name
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9가-힣._-]+/g, '-')
    .replace(/^-+|-+$/g, '') || 'file';
  const ext = parsed.ext.toLowerCase();
  return `${name}${ext}`;
}

function uniqueFilePath(dir, filename) {
  const parsed = path.parse(safeBasename(filename));
  let candidate = path.join(dir, `${parsed.name}${parsed.ext}`);
  let index = 1;
  while (fs.existsSync(candidate)) {
    candidate = path.join(dir, `${parsed.name}-${index}${parsed.ext}`);
    index += 1;
  }
  return candidate;
}

function parseMultipart(req, boundary) {
  return new Promise((resolve, reject) => {
    const chunks = [];
    req.on('data', (chunk) => chunks.push(chunk));
    req.on('error', reject);
    req.on('end', () => {
      const body = Buffer.concat(chunks);
      const marker = Buffer.from(`--${boundary}`);
      const parts = [];
      let start = body.indexOf(marker);

      while (start !== -1) {
        start += marker.length;
        if (body[start] === 45 && body[start + 1] === 45) break;
        if (body[start] === 13 && body[start + 1] === 10) start += 2;

        const next = body.indexOf(marker, start);
        if (next === -1) break;

        let part = body.subarray(start, next);
        if (part.length >= 2 && part[part.length - 2] === 13 && part[part.length - 1] === 10) {
          part = part.subarray(0, part.length - 2);
        }

        const headerEnd = part.indexOf(Buffer.from('\r\n\r\n'));
        if (headerEnd !== -1) {
          const rawHeaders = part.subarray(0, headerEnd).toString('utf8');
          const content = part.subarray(headerEnd + 4);
          const disposition = rawHeaders.match(/content-disposition:\s*form-data;([^\r\n]+)/i)?.[1] || '';
          const name = disposition.match(/name="([^"]+)"/)?.[1];
          const filename = disposition.match(/filename="([^"]*)"/)?.[1];
          if (name) parts.push({ name, filename, content });
        }

        start = next;
      }

      resolve(parts);
    });
  });
}

function slugify(value) {
  return String(value)
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9가-힣]+/g, '-')
    .replace(/^-+|-+$/g, '');
}

function publicPathForUpload(kind, filename) {
  if (kind === 'download') return `/downloads/${filename}`;
  return `/images/products/${filename}`;
}

function normalizeProduct(product, existing = {}) {
  const id = product.id?.trim() || existing.id || slugify(product.name);
  return {
    id,
    visible: Boolean(product.visible),
    status: product.visible ? 'active' : 'hidden',
    order: Number(product.order || existing.order || 999),
    name: product.name || existing.name || id,
    subtitle: product.subtitle || '',
    category: product.category || '',
    tags: Array.isArray(product.tags) ? product.tags : [],
    inquirySubject: product.inquirySubject || `[TeraLeader] ${product.name || id} 제품 문의`,
    summary: product.summary || '',
    description: product.description || '',
    image: product.image || '',
    cardImage: product.cardImage || '',
    features: Array.isArray(product.features) ? product.features : [],
    specs: Array.isArray(product.specs) ? product.specs : [],
    downloads: Array.isArray(product.downloads) ? product.downloads : []
  };
}

function renderPage() {
  return `<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>TeraLeader Content Manager</title>
  <style>
    :root { --primary:#0068a9; --line:#d9e1ea; --bg:#f5f7fa; --text:#17202a; --muted:#667085; }
    * { box-sizing:border-box; }
    body { margin:0; font-family:system-ui,-apple-system,"Segoe UI",sans-serif; background:var(--bg); color:var(--text); }
    header { position:sticky; top:0; z-index:5; background:#fff; border-bottom:1px solid var(--line); }
    .bar { width:min(1280px, calc(100% - 32px)); margin:0 auto; min-height:64px; display:flex; align-items:center; justify-content:space-between; gap:16px; }
    h1 { margin:0; font-size:20px; }
    main { width:min(1280px, calc(100% - 32px)); margin:24px auto; display:grid; gap:18px; }
    .tabs { display:flex; flex-wrap:wrap; gap:8px; }
    button, .btn { min-height:38px; padding:8px 12px; border:1px solid var(--line); border-radius:8px; background:#fff; color:var(--text); font-weight:700; cursor:pointer; }
    button.primary { background:var(--primary); border-color:var(--primary); color:#fff; }
    button.danger { color:#b42318; }
    button.active { background:#e8f3fb; color:#004f82; border-color:#b7d5e9; }
    .panel { background:#fff; border:1px solid var(--line); border-radius:8px; padding:18px; }
    .grid { display:grid; gap:14px; }
    .cols { grid-template-columns:330px minmax(0,1fr); align-items:start; }
    .list { display:grid; gap:8px; }
    .item { padding:12px; border:1px solid var(--line); border-radius:8px; cursor:pointer; background:#fff; }
    .item.active { border-color:#0068a9; background:#f0f8fe; }
    .item small { color:var(--muted); display:block; margin-top:4px; }
    label { display:grid; gap:6px; font-size:13px; font-weight:800; color:#344054; }
    input, textarea { width:100%; padding:10px; border:1px solid var(--line); border-radius:8px; font:inherit; }
    textarea { min-height:86px; resize:vertical; }
    .form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:12px; }
    .full { grid-column:1 / -1; }
    .row { display:flex; flex-wrap:wrap; gap:8px; align-items:center; }
    .muted { color:var(--muted); }
    pre { white-space:pre-wrap; overflow:auto; max-height:360px; background:#111827; color:#e5e7eb; padding:14px; border-radius:8px; }
    [hidden] { display:none !important; }
    @media (max-width:860px) { .cols, .form-grid { grid-template-columns:1fr; } }
  </style>
</head>
<body>
  <header>
    <div class="bar">
      <h1>TeraLeader Content Manager</h1>
      <div class="row">
        <button onclick="runCommand('validate')">검증</button>
        <button onclick="runCommand('build')">빌드</button>
        <button class="primary" onclick="runCommand('deploy:test')">테스트 배포</button>
      </div>
    </div>
  </header>
  <main>
    <div class="tabs">
      <button class="active" data-tab-button="products" onclick="showTab('products')">제품</button>
      <button data-tab-button="notices" onclick="showTab('notices')">공지사항</button>
      <button data-tab-button="company" onclick="showTab('company')">회사정보</button>
      <button data-tab-button="log" onclick="showTab('log')">작업 로그</button>
    </div>

    <section class="panel" data-tab="products">
      <div class="grid cols">
        <div>
          <div class="row" style="justify-content:space-between; margin-bottom:12px;">
            <strong>제품 목록</strong>
            <button onclick="newProduct()">새 제품</button>
          </div>
          <div id="productList" class="list"></div>
        </div>
        <form id="productForm" class="grid" onsubmit="saveProduct(event)">
          <div class="form-grid">
            <label>ID<input name="id" required></label>
            <label>순서<input name="order" type="number" required></label>
            <label>제품명<input name="name" required></label>
            <label>Subtitle<input name="subtitle"></label>
            <label>분류<input name="category"></label>
            <label>태그(쉼표 구분)<input name="tagsText"></label>
            <label class="full">요약<textarea name="summary"></textarea></label>
            <label class="full">상세 설명<textarea name="description"></textarea></label>
            <label>상세 이미지 경로<input name="image"></label>
            <label>카드 이미지 경로<input name="cardImage"></label>
            <label class="full">특징(줄바꿈 구분)<textarea name="featuresText"></textarea></label>
            <label class="full">사양(JSON 배열)<textarea name="specsText"></textarea></label>
            <label class="full">다운로드(JSON 배열)<textarea name="downloadsText"></textarea></label>
            <label class="full">문의 메일 제목<input name="inquirySubject"></label>
            <label class="row full"><input name="visible" type="checkbox" style="width:auto;"> 홈페이지 노출</label>
          </div>
          <div class="row">
            <button class="primary" type="submit">제품 저장</button>
            <button class="danger" type="button" onclick="deleteProduct()">제품 삭제</button>
          </div>
          <div class="panel">
            <strong>파일 업로드</strong>
            <p class="muted">선택한 파일은 사이트 public 폴더로 복사되고, 현재 제품 데이터에 경로가 반영됩니다. 반영 후 제품 저장을 누르세요.</p>
            <div class="form-grid">
              <label>상세 이미지<input id="detailImageFile" type="file" accept="image/*"></label>
              <label>카드 이미지<input id="cardImageFile" type="file" accept="image/*"></label>
              <label class="full">다운로드 파일<input id="downloadFile" type="file" accept=".pdf,.zip,.png,.jpg,.jpeg,.gif,.webp"></label>
            </div>
            <div class="row" style="margin-top:10px;">
              <button type="button" onclick="uploadProductFile('detail')">상세 이미지 반영</button>
              <button type="button" onclick="uploadProductFile('card')">카드 이미지 반영</button>
              <button type="button" onclick="uploadProductFile('download')">다운로드 추가</button>
            </div>
          </div>
        </form>
      </div>
    </section>

    <section class="panel" data-tab="notices" hidden>
      <div class="grid cols">
        <div>
          <div class="row" style="justify-content:space-between; margin-bottom:12px;">
            <strong>공지 목록</strong>
            <button onclick="newNotice()">새 공지</button>
          </div>
          <div id="noticeList" class="list"></div>
        </div>
        <form id="noticeForm" class="grid" onsubmit="saveNotice(event)">
          <label>ID<input name="id" required></label>
          <label>날짜<input name="date" type="date" required></label>
          <label>제목<input name="title" required></label>
          <label>본문<textarea name="body"></textarea></label>
          <div class="row">
            <button class="primary" type="submit">공지 저장</button>
            <button class="danger" type="button" onclick="deleteNotice()">공지 삭제</button>
          </div>
        </form>
      </div>
    </section>

    <section class="panel" data-tab="company" hidden>
      <form id="companyForm" class="grid" onsubmit="saveCompany(event)">
        <div class="form-grid">
          <label>회사명<input name="name"></label>
          <label>법인명<input name="legalName"></label>
          <label class="full">태그라인<input name="tagline"></label>
          <label class="full">요약<textarea name="summary"></textarea></label>
          <label class="full">주소<input name="address"></label>
          <label>전화<input name="tel"></label>
          <label>팩스<input name="fax"></label>
          <label>이메일<input name="email"></label>
          <label class="full">Copyright<input name="copyright"></label>
        </div>
        <button class="primary" type="submit">회사정보 저장</button>
      </form>
    </section>

    <section class="panel" data-tab="log" hidden>
      <p class="muted">검증, 빌드, 배포 결과가 여기에 표시됩니다.</p>
      <pre id="logOutput"></pre>
    </section>
  </main>

  <script>
    let state = { products: [], notices: [], company: {}, selectedProduct: null, selectedNotice: null };

    async function api(path, options = {}) {
      const res = await fetch(path, {
        ...options,
        headers: { 'Content-Type': 'application/json', ...(options.headers || {}) }
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.message || '요청 실패');
      return data;
    }

    async function loadData() {
      state = await api('/api/data');
      renderProducts();
      renderNotices();
      fillCompany();
      if (!state.selectedProduct && state.products[0]) selectProduct(state.products[0].id);
      if (!state.selectedNotice && state.notices[0]) selectNotice(state.notices[0].id);
    }

    function showTab(name) {
      document.querySelectorAll('[data-tab]').forEach(el => el.hidden = el.dataset.tab !== name);
      document.querySelectorAll('[data-tab-button]').forEach(el => el.classList.toggle('active', el.dataset.tabButton === name));
    }

    function renderProducts() {
      const list = document.getElementById('productList');
      list.innerHTML = state.products
        .slice()
        .sort((a,b) => a.order - b.order)
        .map(p => '<div class="item ' + (state.selectedProduct === p.id ? 'active' : '') + '" onclick="selectProduct(\\'' + p.id + '\\')"><strong>' + p.name + '</strong><small>' + p.id + ' · ' + (p.visible ? '노출' : '숨김') + '</small></div>')
        .join('');
    }

    function selectProduct(id) {
      state.selectedProduct = id;
      const product = state.products.find(p => p.id === id);
      const form = document.getElementById('productForm');
      form.id.value = product.id || '';
      form.order.value = product.order || 999;
      form.name.value = product.name || '';
      form.subtitle.value = product.subtitle || '';
      form.category.value = product.category || '';
      form.tagsText.value = (product.tags || []).join(', ');
      form.summary.value = product.summary || '';
      form.description.value = product.description || '';
      form.image.value = product.image || '';
      form.cardImage.value = product.cardImage || '';
      form.featuresText.value = (product.features || []).join('\\n');
      form.specsText.value = JSON.stringify(product.specs || [], null, 2);
      form.downloadsText.value = JSON.stringify(product.downloads || [], null, 2);
      form.inquirySubject.value = product.inquirySubject || '';
      form.visible.checked = Boolean(product.visible);
      renderProducts();
    }

    function newProduct() {
      const id = 'new-product-' + Date.now();
      state.products.push({ id, visible:false, order:999, name:'새 제품', subtitle:'', category:'', tags:[], inquirySubject:'', summary:'', description:'', image:'', cardImage:'', features:[], specs:[], downloads:[] });
      selectProduct(id);
    }

    async function saveProduct(event) {
      event.preventDefault();
      const form = event.currentTarget;
      const product = {
        id: form.id.value.trim(),
        visible: form.visible.checked,
        order: Number(form.order.value),
        name: form.name.value.trim(),
        subtitle: form.subtitle.value.trim(),
        category: form.category.value.trim(),
        tags: form.tagsText.value.split(',').map(v => v.trim()).filter(Boolean),
        summary: form.summary.value,
        description: form.description.value,
        image: form.image.value.trim(),
        cardImage: form.cardImage.value.trim(),
        features: form.featuresText.value.split('\\n').map(v => v.trim()).filter(Boolean),
        specs: JSON.parse(form.specsText.value || '[]'),
        downloads: JSON.parse(form.downloadsText.value || '[]'),
        inquirySubject: form.inquirySubject.value.trim()
      };
      await api('/api/products/' + encodeURIComponent(state.selectedProduct || product.id), { method:'PUT', body: JSON.stringify(product) });
      await loadData();
      selectProduct(product.id);
      log('제품 저장 완료: ' + product.name);
    }

    async function deleteProduct() {
      if (!state.selectedProduct || !confirm('선택한 제품을 삭제할까요?')) return;
      await api('/api/products/' + encodeURIComponent(state.selectedProduct), { method:'DELETE' });
      state.selectedProduct = null;
      await loadData();
      log('제품 삭제 완료');
    }

    async function uploadProductFile(kind) {
      const input = kind === 'detail'
        ? document.getElementById('detailImageFile')
        : kind === 'card'
          ? document.getElementById('cardImageFile')
          : document.getElementById('downloadFile');

      if (!input.files || !input.files[0]) {
        alert('파일을 선택하세요.');
        return;
      }

      const form = document.getElementById('productForm');
      const productId = form.id.value.trim() || state.selectedProduct;
      if (!productId) {
        alert('제품 ID가 필요합니다.');
        return;
      }

      const body = new FormData();
      body.append('file', input.files[0]);
      body.append('kind', kind);
      body.append('productId', productId);

      const res = await fetch('/api/upload', { method: 'POST', body });
      const data = await res.json();
      if (!res.ok) throw new Error(data.message || '업로드 실패');

      if (kind === 'detail') {
        form.image.value = data.publicPath;
      } else if (kind === 'card') {
        form.cardImage.value = data.publicPath;
      } else {
        const downloads = JSON.parse(form.downloadsText.value || '[]');
        downloads.push({ label: data.originalName.replace(/\\.[^.]+$/, ''), file: data.publicPath });
        form.downloadsText.value = JSON.stringify(downloads, null, 2);
      }
      input.value = '';
      log('파일 업로드 완료: ' + data.publicPath);
    }

    function renderNotices() {
      const list = document.getElementById('noticeList');
      list.innerHTML = state.notices
        .slice()
        .sort((a,b) => b.date.localeCompare(a.date))
        .map(n => '<div class="item ' + (state.selectedNotice === n.id ? 'active' : '') + '" onclick="selectNotice(\\'' + n.id + '\\')"><strong>' + n.title + '</strong><small>' + n.date + ' · ' + n.id + '</small></div>')
        .join('');
    }

    function selectNotice(id) {
      state.selectedNotice = id;
      const notice = state.notices.find(n => n.id === id);
      const form = document.getElementById('noticeForm');
      form.id.value = notice.id || '';
      form.date.value = notice.date || '';
      form.title.value = notice.title || '';
      form.body.value = notice.body || '';
      renderNotices();
    }

    function newNotice() {
      const today = new Date().toISOString().slice(0, 10);
      const id = 'notice-' + Date.now();
      state.notices.unshift({ id, date: today, title:'새 공지사항', body:'' });
      selectNotice(id);
    }

    async function saveNotice(event) {
      event.preventDefault();
      const form = event.currentTarget;
      const notice = { id: form.id.value.trim(), date: form.date.value, title: form.title.value.trim(), body: form.body.value };
      await api('/api/notices/' + encodeURIComponent(state.selectedNotice || notice.id), { method:'PUT', body: JSON.stringify(notice) });
      await loadData();
      selectNotice(notice.id);
      log('공지 저장 완료: ' + notice.title);
    }

    async function deleteNotice() {
      if (!state.selectedNotice || !confirm('선택한 공지를 삭제할까요?')) return;
      await api('/api/notices/' + encodeURIComponent(state.selectedNotice), { method:'DELETE' });
      state.selectedNotice = null;
      await loadData();
      log('공지 삭제 완료');
    }

    function fillCompany() {
      const form = document.getElementById('companyForm');
      for (const [key, value] of Object.entries(state.company)) {
        if (form[key] && typeof value !== 'object') form[key].value = value || '';
      }
    }

    async function saveCompany(event) {
      event.preventDefault();
      const form = event.currentTarget;
      const next = { ...state.company };
      for (const key of ['name','legalName','tagline','summary','address','tel','fax','email','copyright']) {
        next[key] = form[key].value;
      }
      await api('/api/company', { method:'PUT', body: JSON.stringify(next) });
      await loadData();
      log('회사정보 저장 완료');
    }

    async function runCommand(command) {
      showTab('log');
      log('실행 중: npm run ' + command);
      const result = await api('/api/commands/' + encodeURIComponent(command), { method:'POST' });
      log(result.output || '(출력 없음)');
    }

    function log(message) {
      const output = document.getElementById('logOutput');
      output.textContent = (output.textContent ? output.textContent + '\\n\\n' : '') + message;
      output.scrollTop = output.scrollHeight;
    }

    loadData().catch(error => log(error.stack || error.message));
  </script>
</body>
</html>`;
}

async function route(req, res) {
  const url = new URL(req.url, `http://${host}:${port}`);

  try {
    if (req.method === 'GET' && url.pathname === '/') {
      send(res, 200, renderPage(), 'text/html; charset=utf-8');
      return;
    }

    if (req.method === 'GET' && url.pathname === '/api/data') {
      send(res, 200, {
        products: readJson(files.products),
        notices: readJson(files.notices),
        company: readJson(files.company)
      });
      return;
    }

    if (req.method === 'PUT' && url.pathname.startsWith('/api/products/')) {
      const originalId = decodeURIComponent(url.pathname.split('/').pop());
      const body = await readBody(req);
      const products = readJson(files.products);
      const index = products.findIndex((product) => product.id === originalId);
      const existing = index >= 0 ? products[index] : {};
      const next = normalizeProduct(body, existing);
      if (index >= 0) products[index] = next;
      else products.push(next);
      writeJson(files.products, products.sort((a, b) => a.order - b.order));
      send(res, 200, { success: true, product: next });
      return;
    }

    if (req.method === 'DELETE' && url.pathname.startsWith('/api/products/')) {
      const id = decodeURIComponent(url.pathname.split('/').pop());
      const products = readJson(files.products).filter((product) => product.id !== id);
      writeJson(files.products, products);
      send(res, 200, { success: true });
      return;
    }

    if (req.method === 'PUT' && url.pathname.startsWith('/api/notices/')) {
      const originalId = decodeURIComponent(url.pathname.split('/').pop());
      const body = await readBody(req);
      const notices = readJson(files.notices);
      const index = notices.findIndex((notice) => notice.id === originalId);
      const next = {
        id: body.id?.trim() || originalId || `notice-${Date.now()}`,
        date: body.date,
        title: body.title,
        body: body.body || ''
      };
      if (index >= 0) notices[index] = next;
      else notices.unshift(next);
      writeJson(files.notices, notices.sort((a, b) => b.date.localeCompare(a.date)));
      send(res, 200, { success: true, notice: next });
      return;
    }

    if (req.method === 'DELETE' && url.pathname.startsWith('/api/notices/')) {
      const id = decodeURIComponent(url.pathname.split('/').pop());
      const notices = readJson(files.notices).filter((notice) => notice.id !== id);
      writeJson(files.notices, notices);
      send(res, 200, { success: true });
      return;
    }

    if (req.method === 'PUT' && url.pathname === '/api/company') {
      const body = await readBody(req);
      writeJson(files.company, body);
      send(res, 200, { success: true });
      return;
    }

    if (req.method === 'POST' && url.pathname === '/api/upload') {
      const contentType = req.headers['content-type'] || '';
      const boundary = contentType.match(/boundary=(.+)$/)?.[1];
      if (!boundary) {
        send(res, 400, { message: 'multipart boundary가 없습니다.' });
        return;
      }

      const parts = await parseMultipart(req, boundary);
      const fields = Object.fromEntries(parts.filter((part) => !part.filename).map((part) => [part.name, part.content.toString('utf8')]));
      const file = parts.find((part) => part.name === 'file' && part.filename);
      if (!file || file.content.length === 0) {
        send(res, 400, { message: '업로드 파일이 없습니다.' });
        return;
      }

      const kind = fields.kind || 'download';
      const targetDir = kind === 'download' ? uploadDirs.downloads : uploadDirs.productImages;
      fs.mkdirSync(targetDir, { recursive: true });
      const productPrefix = fields.productId ? `${fields.productId}-` : '';
      const finalPath = uniqueFilePath(targetDir, `${productPrefix}${file.filename}`);
      fs.writeFileSync(finalPath, file.content);
      const filename = path.basename(finalPath);

      send(res, 200, {
        success: true,
        originalName: file.filename,
        publicPath: publicPathForUpload(kind, filename)
      });
      return;
    }

    if (req.method === 'POST' && url.pathname.startsWith('/api/commands/')) {
      const command = decodeURIComponent(url.pathname.split('/').pop());
      if (!['validate', 'build', 'deploy:test'].includes(command)) {
        send(res, 400, { message: '허용되지 않은 명령입니다.' });
        return;
      }
      const result = await runNpm(command);
      send(res, result.code === 0 ? 200 : 500, result);
      return;
    }

    send(res, 404, { message: 'Not found' });
  } catch (error) {
    send(res, 500, { message: error.message, stack: error.stack });
  }
}

const server = http.createServer(route);
server.listen(port, host, () => {
  console.log(`TeraLeader Content Manager: http://${host}:${port}/`);
});
