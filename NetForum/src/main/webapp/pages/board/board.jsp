<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="com.netforum.model.Post" %>
<%@ page import="com.netforum.service.BoardService" %>
<%@ page import="com.netforum.service.PostService" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("board") != null ? ((Board)request.getAttribute("board")).getName() : "板块" %> - NetForum</title>
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
        .container { max-width: 1200px; margin: 40px auto; padding: 0 24px; }
        .panel { background: #fff; border-radius: 16px; padding: 32px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); border: 1px solid #e9ecef; }
        .board-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 24px; }
        .board-header h2 { font-size: 26px; }
        .board-desc { color: #636e72; margin: 8px 0 0; font-size: 14px; }
        .btn-primary { display: inline-flex; align-items: center; padding: 12px 24px; background: linear-gradient(135deg, #e94560, #ff6b81); color: #fff; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; box-shadow: 0 4px 15px rgba(233,69,96,0.3); transition: all 0.3s; white-space: nowrap; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(233,69,96,0.4); }
        .post-table { width: 100%; border-collapse: collapse; }
        .post-table th { text-align: left; padding: 14px 12px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; color: #636e72; border-bottom: 2px solid #e9ecef; }
        .post-table td { padding: 18px 12px; border-bottom: 1px solid #e9ecef; vertical-align: middle; }
        .post-table tbody tr:hover { background: #f8f9fa; }
        .tag { display: inline-block; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: 600; text-transform: uppercase; }
        .tag-top { background: linear-gradient(135deg, #ff4757, #ff6b81); color: #fff; margin-right: 4px; }
        .tag-elite { background: linear-gradient(135deg, #ffa502, #ffbe76); color: #fff; margin-right: 4px; }
        .post-title { font-weight: 600; color: #1a1a2e; }
        .post-author { color: #636e72; font-size: 13px; }
        .post-stats { text-align: center; color: #636e72; font-size: 13px; }
        .post-time { color: #636e72; font-size: 13px; }
        .empty-tip { text-align: center; padding: 60px 0; color: #636e72; }
        .pagination { display: flex; justify-content: center; gap: 8px; margin-top: 32px; }
        .pagination a { padding: 10px 16px; border: 1px solid #e9ecef; border-radius: 8px; color: #636e72; font-weight: 500; transition: all 0.3s; }
        .pagination a:hover { border-color: #e94560; color: #e94560; }
        .pagination a.active { background: #e94560; border-color: #e94560; color: #fff; }
        .footer { text-align: center; padding: 48px 24px; color: #636e72; font-size: 13px; border-top: 1px solid #e9ecef; margin-top: 60px; }
        @media (max-width: 900px) { .container { padding: 0 16px; } .board-header { flex-direction: column; gap: 16px; } }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"/>

    <div class="container">
        <%
            Board board = (Board) request.getAttribute("board");
            List<Post> posts = (List<Post>) request.getAttribute("posts");
            Integer currentPage = (Integer) request.getAttribute("currentPage");
            Integer totalPages = (Integer) request.getAttribute("totalPages");
            if (currentPage == null) currentPage = 1;
            if (totalPages == null) totalPages = 1;
            User sessionUser = (User) session.getAttribute("loginUser");
        %>
        <div class="panel">
            <div class="board-header">
                <div>
                    <h2><%= board.getName() %></h2>
                    <p class="board-desc"><%= board.getDescription() != null ? board.getDescription() : "" %></p>
                </div>
                <%
                    if (sessionUser != null) {
                %>
                <a href="${pageContext.request.contextPath}/post/create?boardId=<%= board.getId() %>" class="btn-primary">+ 发帖</a>
                <%
                    }
                %>
            </div>

            <div class="post-list">
                <%
                    if (posts == null || posts.isEmpty()) {
                %>
                <p class="empty-tip">暂无帖子</p>
                <%
                    } else {
                        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm");
                %>
                <table class="post-table">
                    <thead>
                        <tr>
                            <th>标题</th>
                            <th>作者</th>
                            <th>回复</th>
                            <th>浏览</th>
                            <th>发布时间</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Post p : posts) {
                        %>
                        <tr>
                            <td>
                                <a href="${pageContext.request.contextPath}/post/detail?id=<%= p.getId() %>" class="post-title">
                                    <%
                                        if (p.getIsTop() != null && p.getIsTop() == 1) {
                                    %>
                                    <span class="tag tag-top">置顶</span>
                                    <%
                                        }
                                        if (p.getIsElite() != null && p.getIsElite() == 1) {
                                    %>
                                    <span class="tag tag-elite">精华</span>
                                    <%
                                        }
                                    %>
                                    <%= p.getTitle() %>
                                </a>
                            </td>
                            <td class="post-author"><%= p.getUsername() != null ? p.getUsername() : "未知" %></td>
                            <td class="post-stats"><%= p.getReplyCount() %></td>
                            <td class="post-stats"><%= p.getViewCount() %></td>
                            <td class="post-time"><%= p.getCreateTime() != null ? sdf.format(p.getCreateTime()) : "" %></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                <%
                    }
                %>
            </div>

            <%
                if (totalPages > 1) {
            %>
            <div class="pagination">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                %>
                <a href="?id=<%= board.getId() %>&page=<%= i %>" class="<%= currentPage == i ? "active" : "" %>"><%= i %></a>
                <%
                    }
                %>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>
