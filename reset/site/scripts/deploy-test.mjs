import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '..');
const source = path.join(root, 'dist');
const target = '\\\\192.168.0.9\\web\\teraleaderHomePage';
const backupRoot = '\\\\192.168.0.9\\web';

function timestamp() {
  const now = new Date();
  const pad = (value) => String(value).padStart(2, '0');
  return [
    now.getFullYear(),
    pad(now.getMonth() + 1),
    pad(now.getDate()),
    '_',
    pad(now.getHours()),
    pad(now.getMinutes()),
    pad(now.getSeconds())
  ].join('');
}

function copyRecursive(src, dest) {
  const stat = fs.statSync(src);
  if (stat.isDirectory()) {
    fs.mkdirSync(dest, { recursive: true });
    for (const entry of fs.readdirSync(src)) {
      copyRecursive(path.join(src, entry), path.join(dest, entry));
    }
    return;
  }
  fs.mkdirSync(path.dirname(dest), { recursive: true });
  fs.copyFileSync(src, dest);
}

if (!fs.existsSync(source)) {
  console.error('dist 폴더가 없습니다. 먼저 npm run build를 실행하세요.');
  process.exit(1);
}

if (!fs.existsSync(target)) {
  console.error(`테스트 서버 경로를 찾을 수 없습니다: ${target}`);
  process.exit(1);
}

const backup = path.join(backupRoot, `teraleaderHomePage_backup_${timestamp()}`);
fs.mkdirSync(backup, { recursive: true });

for (const entry of fs.readdirSync(target)) {
  fs.renameSync(path.join(target, entry), path.join(backup, entry));
}

for (const entry of fs.readdirSync(source)) {
  copyRecursive(path.join(source, entry), path.join(target, entry));
}

console.log(`Deployed to ${target}`);
console.log(`Previous version backed up to ${backup}`);
