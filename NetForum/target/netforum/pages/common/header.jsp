<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.User" %>
<style>
.header { background: rgba(255,255,255,0.95); box-shadow: 0 2px 8px rgba(0,0,0,0.04); position: sticky; top: 0; z-index: 100; }
.header-content { max-width: 1200px; margin: 0 auto; padding: 0 24px; height: 72px; display: flex; justify-content: space-between; align-items: center; }
.logo a { font-family: 'DM Serif Display', serif; font-size: 28px; color: #1a1a2e; }
.logo a span { color: #e94560; }
.nav { display: flex; align-items: center; gap: 32px; }
.nav a { color: #636e72; font-weight: 500; font-size: 14px; transition: all 0.3s; }
.nav a:hover { color: #1a1a2e; }
.user-info { display: flex; align-items: center; gap: 10px; }
.avatar-small { width: 32px; height: 32px; border-radius: 50%; object-fit: cover; border: 2px solid #e9ecef; }
.user-name { color: #1a1a2e; font-weight: 600; }
.badge-admin { background: linear-gradient(135deg, #e94560, #ff6b81); color: #fff; font-size: 11px; padding: 3px 8px; border-radius: 10px; font-weight: 600; }
.btn-logout { color: #e94560; }
.btn-logout:hover { color: #d63a52; }
</style>
<div class="header">
    <div class="header-content">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">Net<span>Forum</span></a>
        </div>
        <nav class="nav">
            <a href="${pageContext.request.contextPath}/">首页</a>
            <%
                User loginUser = (User) session.getAttribute("loginUser");
                if (loginUser != null) {
            %>
            <span class="user-info">
                <%
                    if (loginUser.getAvatar() != null && !loginUser.getAvatar().isEmpty()) {
                %>
                <img src="${pageContext.request.contextPath}<%= loginUser.getAvatar() %>" alt="头像" class="avatar-small">
                <%
                    }
                %>
                <a href="${pageContext.request.contextPath}/user/profile" class="user-name"><%= loginUser.getUsername() %></a>
                <%
                    if (loginUser.isAdmin()) {
                %>
                <span class="badge-admin">管理员</span>
                <%
                    }
                %>
            </span>
            <a href="${pageContext.request.contextPath}/user/logout" class="btn-logout">登出</a>
            <%
                } else {
            %>
            <a href="${pageContext.request.contextPath}/user/login">登录</a>
            <a href="${pageContext.request.contextPath}/user/register">注册</a>
            <%
                }
            %>
        </nav>
    </div>
</div>