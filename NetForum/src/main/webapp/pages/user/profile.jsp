<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>

    <main>
        <div class="container-narrow">
            <%
                User loginUser = (User) session.getAttribute("loginUser");
                if (loginUser == null) {
                    response.sendRedirect(request.getContextPath() + "/user/login");
                    return;
                }
                String createTime = "";
                if (loginUser.getCreateTime() != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    createTime = sdf.format(loginUser.getCreateTime());
                }
            %>

            <nav class="post-detail__breadcrumb animate-in">
                <a href="${pageContext.request.contextPath}/" class="link-bare">
                    <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
                    首页
                </a>
                <span class="post-detail__breadcrumb__sep">/</span>
                <span style="color:var(--ink-1);font-weight:600">个人中心</span>
            </nav>

            <section class="profile animate-in stagger-1">
                <div class="profile__avatar-wrap">
                    <%
                        if (loginUser.getAvatar() != null && !loginUser.getAvatar().isEmpty()) {
                    %><img src="${pageContext.request.contextPath}<%= loginUser.getAvatar() %>" alt="avatar" class="profile__avatar"><%
                    } else { %>
                    <div class="profile__avatar-placeholder">暂无头像</div>
                    <% } %>
                </div>
                <div class="profile__name">
                    <%= loginUser.getUsername() %>
                    <%
                        if (loginUser.isAdmin()) {
                    %><span class="tag tag--admin">ADMIN</span><% } %>
                </div>
                <div class="profile__meta">Joined since <%= createTime %></div>
            </section>

            <%
                if ("true".equals(request.getParameter("updated"))) {
            %>
            <div class="msg msg--success">
                <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>
                个人信息已更新
            </div>
            <% } %>

            <form class="form animate-in stagger-2" action="${pageContext.request.contextPath}/user/update" method="post" enctype="multipart/form-data" style="padding-bottom:var(--space-9)">
                <div class="form-row">
                    <label class="form-label" for="username">用户名 <span class="form-label__hint">不可修改</span></label>
                    <input id="username" type="text" class="form-input" value="<%= loginUser.getUsername() %>" disabled>
                </div>
                <div class="form-row">
                    <label class="form-label" for="email">邮箱</label>
                    <input id="email" type="email" name="email" class="form-input" value="<%= loginUser.getEmail() != null ? loginUser.getEmail() : "" %>" placeholder="请输入邮箱">
                </div>
                <div class="form-row">
                    <label class="form-label" for="avatar">更换头像 <span class="form-label__hint">JPG / PNG · 最大 2MB</span></label>
                    <input id="avatar" type="file" name="avatar" accept="image/*" class="form-file">
                </div>
                <div class="form-row">
                    <label class="form-label">注册时间</label>
                    <input type="text" class="form-input" value="<%= createTime %>" disabled>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn--primary">
                        保存修改
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><path d="M17 21v-8H7v8M7 3v5h8"/></svg>
                    </button>
                </div>
            </form>
        </div>
    </main>

    <jsp:include page="/pages/common/footer.jsp"/>
</div>
</body>
</html>
