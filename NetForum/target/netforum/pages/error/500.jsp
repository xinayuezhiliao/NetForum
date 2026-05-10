<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - 服务器错误</title>
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
        .error-box {
            background: #fff;
            padding: 60px 48px;
            border-radius: 16px;
            box-shadow: 0 8px 40px rgba(0,0,0,0.3);
            text-align: center;
            animation: fadeInUp 0.5s ease-out;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .error-code {
            font-family: 'DM Serif Display', serif;
            font-size: 96px;
            color: #e94560;
            line-height: 1;
            margin-bottom: 16px;
        }
        .error-box h2 {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            color: #1a1a2e;
            margin-bottom: 16px;
        }
        .error-box p {
            color: #636e72;
            margin-bottom: 32px;
            font-size: 15px;
        }
        .btn-primary {
            display: inline-flex;
            align-items: center;
            padding: 14px 28px;
            background: linear-gradient(135deg, #e94560, #ff6b81);
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(233,69,96,0.3);
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(233,69,96,0.4);
        }
    </style>
</head>
<body>
    <div class="error-box">
        <div class="error-code">500</div>
        <h2>服务器内部错误</h2>
        <p>抱歉，服务器处理您的请求时发生了错误。</p>
        <a href="${pageContext.request.contextPath}/" class="btn-primary">返回首页</a>
    </div>
</body>
</html>