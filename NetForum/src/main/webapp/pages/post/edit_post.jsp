<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Post" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="com.netforum.service.BoardService" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑帖子 - NetForum</title>
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
        .container { max-width: 800px; margin: 40px auto; padding: 0 24px; }
        .panel { background: #fff; border-radius: 16px; padding: 40px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); border: 1px solid #e9ecef; }
        .panel h2 { margin-bottom: 32px; font-size: 24px; }
        .form-group { margin-bottom: 24px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 600; color: #1a1a2e; font-size: 14px; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 14px 16px; border: 1px solid #e9ecef; border-radius: 8px; font-size: 15px; font-family: 'DM Sans', sans-serif; transition: all 0.3s; }
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus { outline: none; border-color: #e94560; box-shadow: 0 0 0 3px rgba(233,69,96,0.1); }
        .form-group textarea { resize: vertical; min-height: 200px; }
        .form-actions { display: flex; gap: 16px; margin-top: 32px; }
        .btn-primary { display: inline-flex; align-items: center; padding: 14px 28px; background: linear-gradient(135deg, #e94560, #ff6b81); color: #fff; border: none; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; box-shadow: 0 4px 15px rgba(233,69,96,0.3); transition: all 0.3s; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(233,69,96,0.4); }
        .btn-secondary { display: inline-flex; align-items: center; padding: 14px 28px; background: #f8f9fa; color: #636e72; border: 1px solid #e9ecef; border-radius: 8px; font-size: 15px; font-weight: 600; transition: all 0.3s; }
        .btn-secondary:hover { background: #1a1a2e; color: #fff; border-color: #1a1a2e; }
        .footer { text-align: center; padding: 48px 24px; color: #636e72; font-size: 13px; border-top: 1px solid #e9ecef; margin-top: 60px; }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"/>

    <%
        Post post = (Post) request.getAttribute("post");
        BoardService boardService = new BoardService();
        List<Board> boards = boardService.getAllBoards();
    %>
    <div class="container">
        <div class="panel">
            <h2>编辑帖子</h2>
            <form action="${pageContext.request.contextPath}/post/update" method="post">
                <input type="hidden" name="id" value="<%= post.getId() %>">
                <div class="form-group">
                    <label>板块</label>
                    <select name="boardId" required>
                        <%
                            for (Board board : boards) {
                        %>
                        <option value="<%= board.getId() %>" <%= board.getId().equals(post.getBoardId()) ? "selected" : "" %>><%= board.getName() %></option>
                        <%
                            }
                        %>
                    </select>
                </div>
                <div class="form-group">
                    <label>标题</label>
                    <input type="text" name="title" required value="<%= post.getTitle() %>" maxlength="200">
                </div>
                <div class="form-group">
                    <label>内容</label>
                    <textarea name="content" rows="15" required><%= post.getContent() %></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-primary">保存</button>
                    <a href="${pageContext.request.contextPath}/post/detail?id=<%= post.getId() %>" class="btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/pages/common/footer.jsp"/>
</body>
</html>
