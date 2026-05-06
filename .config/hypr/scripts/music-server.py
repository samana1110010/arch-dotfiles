#!/usr/bin/env python3
import subprocess
import json
from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/music':
            try:
                title = subprocess.check_output(['playerctl', 'metadata', 'title'], text=True).strip()
                artist = subprocess.check_output(['playerctl', 'metadata', 'artist'], text=True).strip()
                status = subprocess.check_output(['playerctl', 'status'], text=True).strip()
                data = json.dumps({'title': title, 'artist': artist, 'status': status})
            except:
                data = json.dumps({'title': '', 'artist': '', 'status': 'stopped'})
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(data.encode())
    def log_message(self, *args):
        pass

HTTPServer(('localhost', 9999), Handler).serve_forever()

