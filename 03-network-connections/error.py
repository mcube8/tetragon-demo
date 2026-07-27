#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer
from datetime import datetime


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):

        print()
        print("=" * 70)
        print("🚨🚨🚨  TETRAGON SECURITY ALERT  🚨🚨🚨")
        print("=" * 70)
        print()
        print("Unexpected external network activity detected!")
        print()
        print(f"Time: {datetime.now().isoformat()}")
        print(f"Trigger: {self.path}")
        print()
        print("Tetragon detected a tcp_connect() matching")
        print("our external-network TracingPolicy.")
        print()
        print("=" * 70)
        print()

        response = """
        Tetragon alert received.

        Security automation triggered successfully.
        """

        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()

        self.wfile.write(response.encode())

    def log_message(self, format, *args):
        return


server = HTTPServer(("0.0.0.0", 9090), Handler)

print("Tetragon alert server listening on :9090")
server.serve_forever()