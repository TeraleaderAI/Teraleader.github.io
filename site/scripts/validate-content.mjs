import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const productsPath = path.join(root, 'src', 'data', 'products.json');
const companyPath = path.join(root, 'src', 'data', 'company.json');
const noticesPath = path.join(root, 'src', 'data', 'notices.json');
const publicDir = path.join(root, 'public');

const errors = [];
const warnings = [];

function readJson(file) {
  try {
    return JSON.parse(fs.readFileSync(file, 'utf8'));
  } catch (error) {
    errors.push(`${path.relative(root, file)}: JSON을 읽을 수 없습니다. ${error.message}`);
    return null;
  }
}

function assertFile(publicPath, label) {
  if (!publicPath) return;
  if (!publicPath.startsWith('/')) {
    errors.push(`${label}: public 경로는 /로 시작해야 합니다. (${publicPath})`);
    return;
  }
  const filePath = path.join(publicDir, publicPath.slice(1));
  if (!fs.existsSync(filePath)) {
    errors.push(`${label}: 파일이 없습니다. ${publicPath}`);
  }
}

const products = readJson(productsPath) ?? [];
const company = readJson(companyPath) ?? {};
const notices = readJson(noticesPath) ?? [];

const ids = new Set();
for (const product of products) {
  const label = `products:${product.id || '(id 없음)'}`;
  if (!product.id) errors.push(`${label}: id가 없습니다.`);
  if (ids.has(product.id)) errors.push(`${label}: id가 중복됩니다.`);
  ids.add(product.id);

  if (typeof product.visible !== 'boolean') errors.push(`${label}: visible은 true/false여야 합니다.`);
  if (!Number.isFinite(product.order)) errors.push(`${label}: order는 숫자여야 합니다.`);
  if (!product.name) errors.push(`${label}: name이 없습니다.`);
  if (!product.summary) warnings.push(`${label}: summary가 비어 있습니다.`);
  if (product.visible) {
    assertFile(product.image, `${label}.image`);
    assertFile(product.cardImage, `${label}.cardImage`);
  }
  for (const download of product.downloads ?? []) {
    assertFile(download.file, `${label}.downloads:${download.label || download.file}`);
  }
}

for (const field of ['name', 'legalName', 'address', 'tel', 'email']) {
  if (!company[field]) errors.push(`company:${field} 값이 없습니다.`);
}

const noticeIds = new Set();
for (const notice of notices) {
  const label = `notices:${notice.id || '(id 없음)'}`;
  if (!notice.id) errors.push(`${label}: id가 없습니다.`);
  if (noticeIds.has(notice.id)) errors.push(`${label}: id가 중복됩니다.`);
  noticeIds.add(notice.id);
  if (!notice.date) errors.push(`${label}: date가 없습니다.`);
  if (!notice.title) errors.push(`${label}: title이 없습니다.`);
  if (!notice.body) warnings.push(`${label}: body가 비어 있습니다.`);
}

if (warnings.length > 0) {
  console.warn('Warnings');
  warnings.forEach((warning) => console.warn(`- ${warning}`));
}

if (errors.length > 0) {
  console.error('Errors');
  errors.forEach((error) => console.error(`- ${error}`));
  process.exit(1);
}

console.log(`Content validation passed. Products: ${products.length}, notices: ${notices.length}`);
