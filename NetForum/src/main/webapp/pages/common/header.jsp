<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.User" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    String reqUri = request.getRequestURI();
    boolean onHome = reqUri.endsWith("/") || reqUri.endsWith("/index.jsp");
%>
<header class="site-header">
    <div class="site-header__inner">
        <a class="brand link-bare" href="${pageContext.request.contextPath}/">
            Net<span class="brand__mark"></span><span class="brand__suffix">Forum</span>
        </a>
        <nav class="nav">
            <a class="nav__link <%= onHome ? "is-active" : "" %>" href="${pageContext.request.contextPath}/">首页</a>
            <%
                if (loginUser != null) {
            %>
            <span class="nav__divider"></span>
            <a class="user-chip link-bare" href="${pageContext.request.contextPath}/user/profile">
                <%
                    if (loginUser.getAvatar() != null && !loginUser.getAvatar().isEmpty()) {
                %><img src="${pageContext.request.contextPath}<%= loginUser.getAvatar() %>" alt="avatar" class="user-chip__avatar"><%
                    } else {
                %><span class="user-chip__avatar"></span><%
                    }
                %>
                <span class="user-chip__name"><%= loginUser.getUsername() %></span>
                <%
                    if (loginUser.isAdmin()) {
                %><span class="user-chip__admin">管理</span><%
                    }
                %>
            </a>
            <a class="nav__logout link-bare" href="${pageContext.request.contextPath}/user/logout">登出</a>
            <%
                } else {
            %>
            <a class="nav__link" href="${pageContext.request.contextPath}/user/login">登录</a>
            <a class="nav__link" href="${pageContext.request.contextPath}/user/register">注册</a>
            <%
                }
            %>
        </nav>
    </div>
</header>
