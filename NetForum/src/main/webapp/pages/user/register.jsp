<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth">
    <div class="auth__box">
        <a class="auth__brand link-bare" href="${pageContext.request.contextPath}/">
            Net<span class="auth__brand__mark"></span><span class="auth__brand__suffix">Forum</span>
        </a>
        <h1 class="auth__title">加入我们</h1>
        <p class="auth__sub">Create your account</p>

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
        <div class="msg msg--error">
            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 8v4M12 16h.01"/></svg>
            <%= error %>
        </div>
        <% } %>

        <form class="form" action="${pageContext.request.contextPath}/user/register" method="post" enctype="multipart/form-data">
            <div class="form-row">
                <label class="form-label" for="username">用户名 <span class="form-label__hint">4-20 个字符</span></label>
                <input id="username" type="text" name="username" class="form-input" required value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" placeholder="4-20个字符">
            </div>
            <div class="form-row">
                <label class="form-label" for="password">密码 <span class="form-label__hint">至少 6 位</span></label>
                <input id="password" type="password" name="password" class="form-input" required placeholder="至少6位">
            </div>
            <div class="form-row">
                <label class="form-label" for="confirmPassword">确认密码</label>
                <input id="confirmPassword" type="password" name="confirmPassword" class="form-input" required placeholder="再次输入">
            </div>
            <div class="form-row">
                <label class="form-label" for="email">邮箱 <span class="form-label__hint">用于找回密码（可选）</span></label>
                <input id="email" type="email" name="email" class="form-input" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>" placeholder="your@email.com">
            </div>
            <div class="form-row">
                <label class="form-label" for="avatar">头像 <span class="form-label__hint">可选</span></label>
                <input id="avatar" type="file" name="avatar" accept="image/*" class="form-file">
            </div>
            <button type="submit" class="btn btn--primary btn--block btn--lg">
                注册
                <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M19 8v6M22 11h-6"/></svg>
            </button>
        </form>

        <div class="auth__foot">
            已有账号？<a href="${pageContext.request.contextPath}/user/login">立即登录</a>
        </div>
    </div>
</div>
</body>
</html>
