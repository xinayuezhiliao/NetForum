<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.service.BoardService" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NetForum - 网上论坛</title>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=DM+Serif+Display&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'DM Sans', -apple-system, BlinkMacSystemFont, sans-serif;
            font-size: 15px;
            line-height: 1.7;
            color: #2d3436;
            background: #f8f9fa;
            min-height: 100vh;
        }
        h1, h2, h3, h4 {
            font-family: 'DM Serif Display', serif;
            font-weight: 400;
            color: #1a1a2e;
            line-height: 1.3;
        }
        a {
            color: #e94560;
            text-decoration: none;
            transition: all 0.3s;
        }
        a:hover {
            color: #d63a52;
        }
        .header {
            background: rgba(255,255,255,0.95);
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
            height: 72px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo a {
            font-family: 'DM Serif Display', serif;
            font-size: 28px;
            color: #1a1a2e;
            letter-spacing: -0.5px;
        }
        .logo a span { color: #e94560; }
        .nav { display: flex; align-items: center; gap: 32px; }
        .nav a {
            color: #636e72;
            font-weight: 500;
            font-size: 14px;
            position: relative;
        }
        .nav a:hover { color: #1a1a2e; }
        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 24px;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 32px;
        }
        .sidebar { position: sticky; top: 96px; height: fit-content; }
        .panel {
            background: #ffffff;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            border: 1px solid #e9ecef;
        }
        .panel h2 {
            margin-bottom: 24px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e9ecef;
            font-size: 22px;
        }
        .panel h3 {
            margin-bottom: 20px;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #636e72;
            opacity: 0.9;
        }
        .stat-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .stat-item:last-child { border-bottom: none; }
        .stat-label { font-size: 14px; opacity: 0.8; color: #fff; }
        .stat-value {
            font-size: 24px;
            font-weight: 700;
            font-family: 'DM Serif Display', serif;
            color: #fff;
        }
        .stats-panel {
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #fff;
            border: none;
        }
        .board-table { width: 100%; border-collapse: collapse; }
        .board-table th {
            text-align: left;
            padding: 16px 12px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #636e72;
            border-bottom: 2px solid #e9ecef;
        }
        .board-table td {
            padding: 20px 12px;
            border-bottom: 1px solid #e9ecef;
            vertical-align: middle;
        }
        .board-table tbody tr:hover { background: #f8f9fa; }
        .board-name {
            font-weight: 600;
            color: #1a1a2e;
            font-size: 16px;
        }
        .board-desc { color: #636e72; font-size: 13px; }
        .board-stats { text-align: center; color: #636e72; font-size: 14px; }
        .btn-enter {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 16px;
            background: #f8f9fa;
            color: #2d3436;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-enter:hover {
            background: #e94560;
            color: #fff;
            transform: translateX(4px);
        }
        .footer {
            text-align: center;
            padding: 48px 24px;
            color: #636e72;
            font-size: 13px;
            border-top: 1px solid #e9ecef;
            margin-top: 60px;
        }
        @media (max-width: 900px) {
            .container { grid-template-columns: 1fr; }
            .sidebar { position: static; }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/">Net<span>Forum</span></a>
            </div>
            <nav class="nav">
                <a href="${pageContext.request.contextPath}/">首页</a>
                <a href="${pageContext.request.contextPath}/user/login">登录</a>
                <a href="${pageContext.request.contextPath}/user/register">注册</a>
            </nav>
        </div>
    </div>

    <div class="container">
        <div class="sidebar">
            <div class="panel stats-panel">
                <h3>论坛统计</h3>
                <div class="stat-item">
                    <span class="stat-label">在线用户</span>
                    <%
                        int onlineCount = 0;
                        Object countObj = application.getAttribute("onlineCount");
                        if (countObj != null) {
                            if (countObj instanceof AtomicInteger) {
                                onlineCount = ((AtomicInteger) countObj).get();
                            } else if (countObj instanceof Integer) {
                                onlineCount = (Integer) countObj;
                            }
                        }
                    %>
                    <span class="stat-value"><%= onlineCount %></span>
                </div>
            </div>
        </div>

        <div class="main-content">
            <div class="panel">
                <h2>论坛板块</h2>
                <div class="board-list">
                    <%
                        BoardService boardService = new BoardService();
                        List<Board> boards = boardService.getAllBoards();
                        if (boards == null || boards.isEmpty()) {
                    %>
                    <p style="text-align:center;padding:60px 0;color:#636e72;">暂无板块，管理员可以创建板块</p>
                    <%
                        } else {
                    %>
                    <table class="board-table">
                        <thead>
                            <tr>
                                <th>板块名称</th>
                                <th>描述</th>
                                <th>帖子数</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Board board : boards) {
                            %>
                            <tr>
                                <td><a href="${pageContext.request.contextPath}/board/detail?id=<%= board.getId() %>" class="board-name"><%= board.getName() %></a></td>
                                <td class="board-desc"><%= board.getDescription() != null ? board.getDescription() : "" %></td>
                                <td class="board-stats"><%= board.getPostCount() %></td>
                                <td><a href="${pageContext.request.contextPath}/board/detail?id=<%= board.getId() %>" class="btn-enter">进入 &rarr;</a></td>
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
            </div>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2024 NetForum 网上论坛系统 - JavaWeb课程设计</p>
    </div>
</body>
</html>
