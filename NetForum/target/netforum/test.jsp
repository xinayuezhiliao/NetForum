<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>测试</title>
</head>
<body>
    <h1>NetForum 运行正常！</h1>
    <p>JSP 编译成功！</p>
    <p>当前时间：<%= new java.util.Date() %></p>
    <p><a href="<%= request.getContextPath() %>/">返回首页</a></p>
</body>
</html>