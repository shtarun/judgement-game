#!/usr/bin/env python3
import http.server
import json
import os

STATS_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'stats.txt')

class Handler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/api/stats':
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.end_headers()
            try:
                with open(STATS_FILE, 'r') as f:
                    data = f.read()
                json.loads(data)
                self.wfile.write(data.encode())
            except (FileNotFoundError, json.JSONDecodeError):
                self.wfile.write(b'{}')
            return
        super().do_GET()

    def do_POST(self):
        if self.path == '/api/stats':
            length = int(self.headers.get('Content-Length', 0))
            body = self.rfile.read(length).decode()
            try:
                stats = json.loads(body)
                with open(STATS_FILE, 'w') as f:
                    json.dump(stats, f, indent=2)
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(b'{"ok":true}')
            except json.JSONDecodeError:
                self.send_response(400)
                self.end_headers()
                self.wfile.write(b'{"error":"invalid json"}')
            return
        self.send_response(404)
        self.end_headers()

    def log_message(self, format, *args):
        pass

if __name__ == '__main__':
    import sys
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
    directory = os.path.dirname(os.path.abspath(__file__))
    os.chdir(directory)
    server = http.server.HTTPServer(('', port), Handler)
    print(f'Serving on http://localhost:{port}')
    server.serve_forever()
