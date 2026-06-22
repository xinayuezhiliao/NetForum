<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth">
    <div class="auth__box">
        <a class="auth__brand link-bare" href="${pageContext.request.contextPath}/">
            Net<span class="auth__brand__mark"></span><span class="auth__brand__suffix">Forum</span>
        </a>
        <h1 class="auth__title">欢迎回来</h1>
        <p class="auth__sub">Sign in to continue</p>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="msg msg--error">
            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 8v4M12 16h.01"/></svg>
            <%= error %>
        </div>
        <% } %>
        <%
            if ("true".equals(request.getParameter("registered"))) {
        %>
        <div class="msg msg--success">
            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>
            注册成功，请登录
        </div>
        <% } %>

        <form class="form" action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="form-row">
                <label class="form-label" for="username">用户名</label>
                <input id="username" type="text" name="username" class="form-input" required autocomplete="username" placeholder="请输入用户名">
            </div>
            <div class="form-row">
                <label class="form-label" for="password">密码</label>
                <input id="password" type="password" name="password" class="form-input" required autocomplete="current-password" placeholder="请输入密码">
            </div>
            <button type="submit" class="btn btn--primary btn--block btn--lg">
                登录
                <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4M10 17l5-5-5-5M15 12H3"/></svg>
            </button>
        </form>

        <div class="auth__foot">
            还没有账号？<a href="${pageContext.request.contextPath}/user/register">立即注册</a>
        </div>
    </div>
</div>
</body>
</html>
