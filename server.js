import http from 'http';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const server = http.createServer((req, res) => {
  let filePath;

  switch (req.url) {
    case '/':
    case '/page1':
      filePath = path.join(__dirname, 'page1.html');
      break;
    case '/page2':
      filePath = path.join(__dirname, 'page2.html');
      break;
    case '/style.css':
        filePath = path.join(__dirname, 'style.css');
        break;
    default:
      res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
      res.end('<h1>404: Страница не найдена</h1>');
      return;
  }

  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(500, { 'Content-Type': 'text/html; charset=utf-8' });
      res.end('<h1>Ошибка при чтении файла</h1>');
      return;
    }

    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(data);
  });
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`✅ Сервер запущен: http://localhost:${PORT}`);
});
