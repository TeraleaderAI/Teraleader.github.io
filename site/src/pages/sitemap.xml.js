import products from '../data/products.json';
import notices from '../data/notices.json';

const base = 'https://teraleader.synology.me:50081';

const staticPages = ['', 'company/', 'products/', 'technology/', 'support/', 'notices/'];
const productPages = products.filter((product) => product.visible).map((product) => `products/${product.id}/`);
const noticePages = notices.map((notice) => `notices/${notice.id}/`);

export function GET() {
  const urls = [...staticPages, ...productPages, ...noticePages]
    .map((url) => `  <url><loc>${base}/${url}</loc></url>`)
    .join('\n');

  return new Response(`<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>\n`, {
    headers: {
      'Content-Type': 'application/xml; charset=utf-8'
    }
  });
}
