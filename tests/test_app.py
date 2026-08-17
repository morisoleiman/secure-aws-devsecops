import json
import os
import sys
import unittest
from http.client import HTTPConnection
from http.server import HTTPServer
from threading import Thread

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))
from app.main import Handler


class AppTests(unittest.TestCase):
    def test_health_endpoint(self):
        server = HTTPServer(("127.0.0.1", 0), Handler)
        thread = Thread(target=server.handle_request)
        thread.start()
        conn = HTTPConnection("127.0.0.1", server.server_port, timeout=3)
        conn.request("GET", "/health")
        response = conn.getresponse()
        body = json.loads(response.read())
        thread.join(timeout=3)
        server.server_close()
        self.assertEqual(response.status, 200)
        self.assertEqual(body, {"status": "ok"})

    def test_not_found(self):
        server = HTTPServer(("127.0.0.1", 0), Handler)
        thread = Thread(target=server.handle_request)
        thread.start()
        conn = HTTPConnection("127.0.0.1", server.server_port, timeout=3)
        conn.request("GET", "/does-not-exist")
        response = conn.getresponse()
        body = json.loads(response.read())
        thread.join(timeout=3)
        server.server_close()
        self.assertEqual(response.status, 404)
        self.assertEqual(body, {"error": "not found"})


if __name__ == "__main__":
    unittest.main()
