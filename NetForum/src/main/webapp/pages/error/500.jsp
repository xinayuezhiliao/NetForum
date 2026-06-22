<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="error-page">
    <div class="error-page__inner">
        <div class="error-page__code error-page__code--accent" data-text="500">500</div>
        <h1 class="error-page__title">服务器暂时睡着了</h1>
        <p class="error-page__sub">我们的程序在处理请求时遇到了意外。请稍后再试，或先回去看看别处。</p>
        <div class="error-page__actions">
            <a class="btn btn--primary" href="${pageContext.request.contextPath}/">
                <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
                返回首页
            </a>
            <a class="btn btn--quiet" href="javascript:location.reload()">重试</a>
        </div>
    </div>
</div>
</body>
</html>
