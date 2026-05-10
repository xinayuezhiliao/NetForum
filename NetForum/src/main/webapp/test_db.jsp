<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.util.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>数据库连接测试</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 40px; }
        .success { color: green; font-size: 18px; }
        .fail { color: red; font-size: 18px; }
    </style>
</head>
<body>
    <h2>数据库连接测试</h2>
    <%
        try (Connection conn = DBUtil.getConnection()) {
    %>
        <p class="success">✅ 数据库连接成功！</p>
        <p>数据库版本: <%= conn.getMetaData().getDatabaseProductName() %> 
           <%= conn.getMetaData().getDatabaseProductVersion() %></p>
    <%
        } catch (Exception e) {
    %>
        <p class="fail">❌ 数据库连接失败！</p>
        <p>错误信息: <%= e.getMessage() %></p>
    <%
        }
    %>
    <p><a href="<%= request.getContextPath() %>/">返回首页</a></p>
</body>
</html>