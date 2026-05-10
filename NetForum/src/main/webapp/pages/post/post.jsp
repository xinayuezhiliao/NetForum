<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Post" %>
<%@ page import="com.netforum.model.Reply" %>
<%@ page import="com.netforum.model.Attachment" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="com.netforum.service.ReplyService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("post") != null ? ((Post)request.getAttribute("post")).getTitle() : "帖子" %> - NetForum</title>
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
        .container { max-width: 1200px; margin: 40px auto; padding: 0 24px; display: grid; grid-template-columns: 1fr 320px; gap: 32px; }
        .main-content { min-width: 0; }
        .panel { background: #fff; border-radius: 16px; padding: 32px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); border: 1px solid #e9ecef; }
        .post-header { margin-bottom: 32px; padding-bottom: 24px; border-bottom: 1px solid #e9ecef; }
        .post-header h1 { font-size: 28px; margin-bottom: 16px; display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
        .tag { display: inline-block; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: 600; text-transform: uppercase; }
        .tag-top { background: linear-gradient(135deg, #ff4757, #ff6b81); color: #fff; }
        .tag-elite { background: linear-gradient(135deg, #ffa502, #ffbe76); color: #fff; margin-left: 4px; }
        .post-meta { display: flex; flex-wrap: wrap; gap: 20px; color: #636e72; font-size: 14px; }
        .post-meta a { color: #e94560; font-weight: 500; }
        .post-content { font-size: 16px; line-height: 1.9; margin-bottom: 32px; min-height: 100px; }
        .post-actions { display: flex; align-items: center; gap: 16px; padding-top: 24px; border-top: 1px solid #e9ecef; }
        .btn-like { display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 50px; cursor: pointer; color: #2d3436; font-weight: 500; font-size: 14px; transition: all 0.3s; }
        .btn-like:hover { background: #e94560; border-color: #e94560; color: #fff; transform: scale(1.05); }
        .btn-delete { display: inline-flex; align-items: center; padding: 12px 24px; background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 50px; color: #636e72; font-size: 14px; transition: all 0.3s; }
        .btn-delete:hover { background: #fee; border-color: #e94560; color: #e94560; }
        .reply-section h3 { font-size: 18px; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }
        .reply-count { background: #f8f9fa; padding: 4px 12px; border-radius: 20px; font-size: 13px; font-family: 'DM Sans', sans-serif; }
        .reply-item { padding: 24px 0; border-bottom: 1px solid #e9ecef; animation: fadeInUp 0.4s ease-out; }
        .reply-item:last-child { border-bottom: none; }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .reply-header { display: flex; align-items: center; gap: 12px; margin-bottom: 12px; }
        .reply-avatar { width: 40px; height: 40px; border-radius: 50%; background: #f8f9fa; display: flex; align-items: center; justify-content: center; color: #636e72; font-weight: 600; }
        .reply-user { font-weight: 600; color: #1a1a2e; }
        .reply-time { color: #636e72; font-size: 12px; margin-left: auto; }
        .reply-content { padding-left: 52px; color: #2d3436; line-height: 1.8; }
        .reply-quote { background: #f8f9fa; padding: 16px 20px; margin-bottom: 16px; border-left: 3px solid #e94560; border-radius: 0 8px 8px 0; color: #636e72; font-size: 14px; }
        .reply-quote-user { font-weight: 600; color: #e94560; margin-bottom: 4px; }
        .btn-delete-reply { background: none; border: none; color: #636e72; cursor: pointer; font-size: 13px; padding: 4px 8px; border-radius: 4px; transition: all 0.3s; margin-left: auto; }
        .btn-delete-reply:hover { background: #fee; color: #e94560; }
        .reply-form { margin-top: 32px; padding-top: 32px; border-top: 1px solid #e9ecef; }
        .reply-form h3 { font-size: 18px; margin-bottom: 20px; }
        .reply-form textarea { width: 100%; padding: 16px; border: 1px solid #e9ecef; border-radius: 12px; font-size: 15px; font-family: 'DM Sans', sans-serif; resize: vertical; min-height: 120px; transition: all 0.3s; }
        .reply-form textarea:focus { outline: none; border-color: #e94560; box-shadow: 0 0 0 3px rgba(233,69,96,0.1); }
        .reply-form-actions { display: flex; justify-content: flex-end; margin-top: 16px; }
        .btn-primary { display: inline-flex; align-items: center; padding: 12px 24px; background: linear-gradient(135deg, #e94560, #ff6b81); color: #fff; border: none; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; box-shadow: 0 4px 15px rgba(233,69,96,0.3); transition: all 0.3s; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(233,69,96,0.4); }
        .login-tip { text-align: center; padding: 40px; background: #f8f9fa; border-radius: 12px; color: #636e72; }
        .footer { text-align: center; padding: 48px 24px; color: #636e72; font-size: 13px; border-top: 1px solid #e9ecef; margin-top: 60px; }
        @media (max-width: 900px) { .container { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <jsp:include page="/pages/common/header.jsp"/>

    <%
        Post post = (Post) request.getAttribute("post");
        List<Attachment> attachments = (List<Attachment>) request.getAttribute("attachments");
        User loginUser = (User) session.getAttribute("loginUser");
        ReplyService replyService = new ReplyService();
        List<Reply> replies = replyService.getRepliesByPostId(post.getId(), 1, 100);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    %>
    <div class="container">
        <div class="main-content">
            <div class="panel">
                <div class="post-header">
                    <h1>
                        <%
                            if (post.getIsTop() != null && post.getIsTop() == 1) {
                        %>
                        <span class="tag tag-top">置顶</span>
                        <%
                            }
                            if (post.getIsElite() != null && post.getIsElite() == 1) {
                        %>
                        <span class="tag tag-elite">精华</span>
                        <%
                            }
                        %>
                        <%= post.getTitle() %>
                    </h1>
                    <div class="post-meta">
                        <span>板块：<a href="${pageContext.request.contextPath}/board/detail?id=<%= post.getBoardId() %>"><%= post.getBoardName() != null ? post.getBoardName() : "未知" %></a></span>
                        <span>作者：<%= post.getUsername() != null ? post.getUsername() : "未知" %></span>
                        <span>发布时间：<%= post.getCreateTime() != null ? sdf.format(post.getCreateTime()) : "" %></span>
                        <span>浏览：<%= post.getViewCount() %></span>
                        <span>回复：<%= post.getReplyCount() %></span>
                    </div>
                </div>
                <div class="post-content">
                    <%= post.getContent() != null ? post.getContent().replace("\n", "<br>") : "" %>
                </div>
                <div class="post-actions">
                    <button class="btn-like" onclick="likePost(<%= post.getId() %>)">
                        👍 赞 <span id="likeCount"><%= post.getLikeCount() %></span>
                    </button>
                    <%
                        if (loginUser != null && (loginUser.getId().equals(post.getUserId()) || loginUser.isAdmin())) {
                    %>
                    <form action="${pageContext.request.contextPath}/post/delete" method="POST" onsubmit="return confirm('确定删除该帖子？')" style="display:inline;">
                        <input type="hidden" name="id" value="<%= post.getId() %>">
                        <button type="submit" class="btn-delete">🗑 删除</button>
                    </form>
                    <%
                        }
                    %>
                </div>

                <%
                    if (attachments != null && !attachments.isEmpty()) {
                %>
                <div style="margin-top: 24px; padding-top: 24px; border-top: 1px dashed #e9ecef;">
                    <h4 style="font-size: 14px; color: #636e72; margin-bottom: 12px; font-family: 'DM Sans', sans-serif;">附件：</h4>
                    <ul style="list-style: none;">
                        <%
                            for (Attachment att : attachments) {
                        %>
                        <li style="padding: 8px 0;">
                            <a href="${pageContext.request.contextPath}/download?id=<%= att.getId() %>">
                                📎 <%= att.getFileName() %> (<%= att.getSizeDesc() %>)
                            </a>
                        </li>
                        <%
                            }
                        %>
                    </ul>
                </div>
                <%
                    }
                %>
            </div>

            <div class="panel reply-section">
                <h3>回复 <span id="replyCount" class="reply-count"><%= post.getReplyCount() %></span></h3>
                <div id="repliesContainer">
                    <%
                        for (Reply reply : replies) {
                    %>
                    <div class="reply-item" id="reply-<%= reply.getId() %>">
                        <div class="reply-header">
                            <div class="reply-avatar"><%= reply.getUsername() != null ? reply.getUsername().substring(0,1).toUpperCase() : "?" %></div>
                            <span class="reply-user"><%= reply.getUsername() != null ? reply.getUsername() : "匿名" %></span>
                            <span class="reply-time"><%= reply.getCreateTime() != null ? sdf.format(reply.getCreateTime()) : "" %></span>
                            <%
                                if (loginUser != null && (loginUser.getId().equals(reply.getUserId()) || loginUser.isAdmin())) {
                            %>
                            <button class="btn-delete-reply" onclick="deleteReply(<%= reply.getId() %>)">删除</button>
                            <%
                                }
                            %>
                        </div>
                        <div class="reply-content">
                            <%
                                if (reply.hasQuote()) {
                            %>
                            <div class="reply-quote">
                                <div class="reply-quote-user">引用 <%= reply.getQuoteUsername() != null ? reply.getQuoteUsername() : "未知" %> 的回复：</div>
                                <%= reply.getQuoteContent() != null ? reply.getQuoteContent() : "" %>
                            </div>
                            <%
                                }
                            %>
                            <%= reply.getContent() != null ? reply.getContent().replace("\n", "<br>") : "" %>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="panel reply-form">
                <h3>发表回复</h3>
                <%
                    if (loginUser != null) {
                %>
                <textarea id="replyContent" rows="5" placeholder="请输入回复内容..."></textarea>
                <div class="reply-form-actions">
                    <button class="btn-primary" onclick="submitReply(<%= post.getId() %>)">提交回复</button>
                </div>
                <%
                    } else {
                %>
                <p class="login-tip">请 <a href="${pageContext.request.contextPath}/user/login">登录</a> 后回复</p>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <jsp:include page="/pages/common/footer.jsp"/>

    <script>
        function submitReply(postId) {
            var content = document.getElementById('replyContent').value.trim();
            if (!content) { alert('请输入回复内容'); return; }
            fetch('${pageContext.request.contextPath}/reply/add', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=add&postId=' + postId + '&content=' + encodeURIComponent(content)
            })
            .then(r => r.json())
            .then(data => { if (data.id) { location.reload(); } else { alert('回复失败'); } });
        }
        function deleteReply(replyId) {
            if (!confirm('确定删除该回复？')) return;
            fetch('${pageContext.request.contextPath}/reply/delete', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=delete&id=' + replyId
            })
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('reply-' + replyId).remove();
                    document.getElementById('replyCount').textContent = parseInt(document.getElementById('replyCount').textContent) - 1;
                } else { alert(data.message || '删除失败'); }
            });
        }
        function likePost(postId) {
            fetch('${pageContext.request.contextPath}/post/like?id=' + postId, {method: 'POST'})
            .then(r => r.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('likeCount').textContent = parseInt(document.getElementById('likeCount').textContent) + 1;
                } else { alert(data.message || '操作失败'); }
            });
        }
    </script>
</body>
</html>
