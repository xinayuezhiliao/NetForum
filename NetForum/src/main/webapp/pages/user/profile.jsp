<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - NetForum</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=DM+Serif+Display&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'DM Sans', sans-serif; font-size: 15px; line-height: 1.7; color: #2d3436; background: #f8f9fa; min-height: 100vh; }
        h1, h2, h3, h4 { font-family: 'DM Serif Display', serif; font-weight: 400; color: #1a1a2e; line-height: 1.3; }
        a { color: #e94560; text-decoration: none; transition: all 0.3s; }
        a:hover { color: #d63a52; }
        .header { background: rgba(255,255,255,0.95); box-shadow: 0 2px 8px rgba(0,0,0,0.04); position: sticky; top: 0; z-index: 100; }
        .header-content { max-width: 1200px; margin: 0 auto; padding: 0 24px; height: 72px; display: flex; justify-content: space-between; align-items: center; }
        .logo a { font-family: 'DM Serif Display', serif; font-size: 28px; color: #1a1a2e; }
        .logo a span { color: #e94560; }
        .nav { display: flex; align-items: center; gap: 32px; }
        .nav a { color: #636e72; font-weight: 500; font-size: 14px; }
        .nav a:hover { color: #1a1a2e; }
        .container { max-width: 600px; margin: 40px auto; padding: 0 24px; }
        .panel { background: #fff; border-radius: 16px; padding: 40px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); border: 1px solid #e9ecef; }
        .panel h2 { margin-bottom: 32px; font-size: 24px; }
        .profile-info { display: flex; flex-direction: column; gap: 20px; }
        .avatar-section { text-align: center; margin-bottom: 20px; }
        .profile-avatar { width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid #e9ecef; }
        .avatar-placeholder { width: 100px; height: 100px; border-radius: 50%; background: #f8f9fa; display: inline-flex; align-items: center; justify-content: center; color: #636e72; font-size: 14px; border: 3px solid #e9ecef; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #1a1a2e; font-size: 14px; }
        .form-group input { width: 100%; padding: 14px 16px; border: 1px solid #e9ecef; border-radius: 8px; font-size: 15px; font-family: 'DM Sans', sans-serif; transition: all 0.3s; }
        .form-group input:focus { outline: none; border-color: #e94560; box-shadow: 0 0 0 3px rgba(233,69,96,0.1); }
        .form-group input:disabled { background: #f8f9fa; color: #636e72; cursor: not-allowed; }
        .btn-primary { display: inline-flex; align-items: center; padding: 14px 28px; background: linear-gradient(135deg, #e94560, #ff6b81); color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; box-shadow: 0 4px 15px rgba(233,69,96,0.3); transition: all 0.3s; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(233,69,96,0.4); }
        .success-msg { background: #d4edda; color: #155724; padding: 14px 20px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; border-left: 4px solid #28a745; }
        .footer { text-align: center; padding: 48px 24px; color: #636e72; font-size: 13px; border-top: 1px solid #e9ecef; margin-top: 60px; }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"/>

    <div class="container">
        <div class="panel">
            <h2>个人中心</h2>
            <%
                String updated = request.getParameter("updated");
                if ("true".equals(updated)) {
            %>
            <div class="success-msg">个人信息已更新</div>
            <%
                }
                User loginUser = (User) session.getAttribute("loginUser");
                if (loginUser == null) {
                    response.sendRedirect(request.getContextPath() + "/user/login");
                    return;
                }
            %>
            <form action="${pageContext.request.contextPath}/user/update" method="post" enctype="multipart/form-data">
                <div class="profile-info">
                    <div class="avatar-section">
                        <%
                            if (loginUser.getAvatar() != null && !loginUser.getAvatar().isEmpty()) {
                        %>
                        <img src="${pageContext.request.contextPath}<%= loginUser.getAvatar() %>" alt="头像" class="profile-avatar">
                        <%
                            } else {
                        %>
                        <div class="avatar-placeholder">暂无头像</div>
                        <%
                            }
                        %>
                    </div>
                    <div class="form-group">
                        <label>用户名</label>
                        <input type="text" value="<%= loginUser.getUsername() %>" disabled>
                    </div>
                    <div class="form-group">
                        <label>邮箱</label>
                        <input type="email" name="email" value="<%= loginUser.getEmail() != null ? loginUser.getEmail() : "" %>" placeholder="请输入邮箱">
                    </div>
                    <div class="form-group">
                        <label>新头像</label>
                        <input type="file" name="avatar" accept="image/*">
                    </div>
                    <div class="form-group">
                        <label>注册时间</label>
                        <%
                            String createTime = "";
                            if (loginUser.getCreateTime() != null) {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                                createTime = sdf.format(loginUser.getCreateTime());
                            }
                        %>
                        <input type="text" value="<%= createTime %>" disabled>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn-primary">保存修改</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>