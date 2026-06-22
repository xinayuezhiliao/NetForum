<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="error-page">
    <div class="error-page__inner">
        <div class="error-page__code" data-text="404">404</div>
        <h1 class="error-page__title">此处无路</h1>
        <p class="error-page__sub">你寻找的页面已不在这里。也许它从未存在过，又或者去了别处。</p>
        <div class="error-page__actions">
            <a class="btn btn--primary" href="${pageContext.request.contextPath}/">
                <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
                返回首页
            </a>
            <a class="btn btn--quiet" href="javascript:history.back()">← 后退</a>
        </div>
    </div>
</div>
</body>
</html>
