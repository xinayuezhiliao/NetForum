"""
使用本地 HTTP 代理（注入 admin JSESSIONID）配合 Edge headless 完成 admin 登录后截图
"""
import subprocess
import os
import time
import threading
import urllib.request
import urllib.parse
import socketserver
import http.server
import http.client
from http.cookiejar import CookieJar

BASE = "http://127.0.0.1:80"
CONTEXT = "/netforum"
SHOTS_DIR = "D:/虚拟机/期末考核/NetForum/docs/screenshots"
PROXY_PORT = 8989
PROXY_HOST = "127.0.0.1"
os.makedirs(SHOTS_DIR, exist_ok=True)


# === 1. 登录拿 session ===
cj = CookieJar()
opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))
opener.open(f"{BASE}{CONTEXT}/user/login")
data = urllib.parse.urlencode({"username": "admin", "password": "admin123"}).encode()
resp = opener.open(f"{BASE}{CONTEXT}/user/login", data=data)
print(f"Login: HTTP {resp.status}, redirected to {resp.url}")

jsessionid = None
for c in cj:
    if c.name == "JSESSIONID":
        jsessionid = c.value
        break
print(f"JSESSIONID: {jsessionid[:16]}..." if jsessionid else "NO SESSION COOKIE")
if not jsessionid:
    raise SystemExit(1)


# === 2. 启动本地代理：注入 Cookie 头 ===
class ProxyHandler(http.server.BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass  # 静音

    def do_GET(self):
        # 去掉 /proxy 前缀
        target_path = self.path
        if target_path.startswith("/proxy"):
            target_path = target_path[len("/proxy"):]
        # 转发到真实后端
        conn = http.client.HTTPConnection("127.0.0.1", 80, timeout=15)
        headers = {
            "Cookie": f"JSESSIONID={jsessionid}",
            "User-Agent": "Mozilla/5.0 (ProxyShot)",
        }
        try:
            conn.request("GET", target_path, headers=headers)
            resp = conn.getresponse()
            body = resp.read()
            self.send_response(resp.status)
            for k, v in resp.getheaders():
                if k.lower() in ("transfer-encoding", "connection"):
                    continue
                self.send_header(k, v)
            self.end_headers()
            self.wfile.write(body)
        except Exception as e:
            self.send_response(502)
            self.end_headers()
            self.wfile.write(f"Proxy error: {e}".encode())
        finally:
            conn.close()


def start_proxy():
    with socketserver.TCPServer((PROXY_HOST, PROXY_PORT), ProxyHandler) as httpd:
        httpd.serve_forever()


proxy_thread = threading.Thread(target=start_proxy, daemon=True)
proxy_thread.start()
time.sleep(0.5)

# 验证代理
test = urllib.request.urlopen(f"http://{PROXY_HOST}:{PROXY_PORT}/proxy{CONTEXT}/user/profile").read().decode("utf-8", errors="replace")
if "ADMIN" in test:
    print(f"[OK] Proxy injecting cookie works (admin detected)")
else:
    print(f"[X] Proxy failed - body[:200]={test[:200]}")
    raise SystemExit(1)


# === 3. 截图 ===
EDGE_CANDIDATES = [
    "C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe",
    "C:/Program Files/Microsoft/Edge/Application/msedge.exe",
]
EDGE = next((p for p in EDGE_CANDIDATES if os.path.exists(p)), None)
print(f"Edge: {EDGE}")
USER_DATA = "D:/cowork-temp/edge-shot-profile"
os.makedirs(USER_DATA, exist_ok=True)


def edge_screenshot(url: str, out_png: str, w: int, h: int):
    cmd = [
        EDGE, "--headless=new", "--disable-gpu", "--no-sandbox",
        "--hide-scrollbars", "--force-device-scale-factor=1",
        f"--window-size={w},{h}",
        f"--screenshot={out_png}",
        f"--virtual-time-budget=3000",
        f"--user-data-dir={USER_DATA}",
        url,
    ]
    env = os.environ.copy()
    env["PYTHONIOENCODING"] = "utf-8"
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=30, env=env)
    return os.path.exists(out_png)


# 公共页面用真实 URL
PAGES_PUBLIC = [
    ("/", "01-home.png", (1440, 900)),
    ("/board/list", "02-boards.png", (1440, 900)),
    ("/board/detail?id=1", "03-board-1.png", (1440, 1200)),
    ("/board/detail?id=2", "04-board-2.png", (1440, 1200)),
    ("/board/detail?id=3", "05-board-3.png", (1440, 1200)),
    ("/post?id=1", "06-post-1.png", (1440, 1400)),
    ("/post?id=5", "07-post-5.png", (1440, 1400)),
    ("/post?id=15", "08-post-15.png", (1440, 1400)),
    ("/user/login", "09-login.png", (1440, 900)),
    ("/user/register", "10-register.png", (1440, 900)),
    ("/pages/error/404.jsp", "11-404.png", (1440, 900)),
    ("/pages/error/500.jsp", "12-500.png", (1440, 900)),
]

# 登录态页面用 proxy
PAGES_ADMIN = [
    ("/post/create", "13-post-create.png", (1440, 1200)),
    ("/board/create", "14-board-create.png", (1440, 900)),
    ("/user/profile", "15-profile.png", (1440, 1300)),
]

print("\n=== Public pages ===")
for path, name, (w, h) in PAGES_PUBLIC:
    out = os.path.join(SHOTS_DIR, name)
    if edge_screenshot(f"{BASE}{CONTEXT}{path}", out, w, h):
        print(f"  [OK] {name}  ({os.path.getsize(out)//1024} KB)")
    else:
        print(f"  [X] {name}")
    time.sleep(0.3)

print("\n=== Admin pages (via proxy) ===")
for path, name, (w, h) in PAGES_ADMIN:
    out = os.path.join(SHOTS_DIR, name)
    proxy_url = f"http://{PROXY_HOST}:{PROXY_PORT}/proxy{CONTEXT}{path}"
    if edge_screenshot(proxy_url, out, w, h):
        print(f"  [OK] {name}  ({os.path.getsize(out)//1024} KB)")
    else:
        print(f"  [X] {name}")
    time.sleep(0.3)

print("\n=== Done ===")
