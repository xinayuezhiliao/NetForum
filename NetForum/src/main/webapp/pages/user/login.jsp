<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - NetForum</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=DM+Serif+Display&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'DM Sans', sans-serif;
            font-size: 15px;
            line-height: 1.7;
            color: #2d3436;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-box {
            background: #fff;
            padding: 48px;
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 420px;
            animation: fadeInUp 0.5s ease-out;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .login-box h2 {
            font-family: 'DM Serif Display', serif;
            text-align: center;
            margin-bottom: 8px;
            font-size: 28px;
            color: #1a1a2e;
        }
        .login-box > p {
            text-align: center;
            color: #636e72;
            margin-bottom: 32px;
        }
        .form-group { margin-bottom: 24px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #1a1a2e;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            font-size: 15px;
            font-family: 'DM Sans', sans-serif;
            transition: all 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: #e94560;
            box-shadow: 0 0 0 3px rgba(233,69,96,0.1);
        }
        .btn-primary {
            width: 100%;
            padding: 14px 28px;
            background: linear-gradient(135deg, #e94560, #ff6b81);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(233,69,96,0.3);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(233,69,96,0.4);
        }
        .login-footer {
            text-align: center;
            margin-top: 24px;
            padding-top: 24px;
            border-top: 1px solid #e9ecef;
            color: #636e72;
            font-size: 14px;
        }
        .login-footer a { color: #e94560; font-weight: 500; }
        .login-footer a:hover { color: #d63a52; }
        .msg {
            padding: 16px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .msg-error {
            background: #fff5f5;
            color: #c0392b;
            border-left: 4px solid #e74c3c;
        }
        .msg-success {
            background: #f0fff4;
            color: #27ae60;
            border-left: 4px solid #2ecc71;
        }
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: rgba(255,255,255,0.95);
            padding: 16px 24px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            z-index: 100;
        }
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo a {
            font-family: 'DM Serif Display', serif;
            font-size: 24px;
            color: #1a1a2e;
        }
        .logo a span { color: #e94560; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">Net<span>Forum</span></a>
            </div>
        </div>
    </div>
    <div style="padding-top: 80px;">
        <div class="login-box">
            <h2>用户登录</h2>
            <p>欢迎回来</p>
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
            <div class="msg msg-error"><%= error %></div>
            <%
                }
                String registered = request.getParameter("registered");
                if ("true".equals(registered)) {
            %>
            <div class="msg msg-success">注册成功，请登录</div>
            <%
                }
            %>
            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" name="username" required placeholder="请输入用户名">
                </div>
                <div class="form-group">
                    <label>密码</label>
                    <input type="password" name="password" required placeholder="请输入密码">
                </div>
                <div class="form-group">
                    <button type="submit" class="btn-primary">登录</button>
                </div>
            </form>
            <div class="login-footer">
                还没有账号？<a href="${pageContext.request.contextPath}/user/register">立即注册</a>
            </div>
        </div>
    </div>
</body>
</html>
