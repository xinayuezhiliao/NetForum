<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Post" %>
<%@ page import="com.netforum.model.Reply" %>
<%@ page import="com.netforum.model.Attachment" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="com.netforum.service.ReplyService" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("post") != null ? ((Post)request.getAttribute("post")).getTitle() : "帖子" %> · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>

    <main>
        <div class="container-narrow">
            <%
                Post post = (Post) request.getAttribute("post");
                List<Attachment> attachments = (List<Attachment>) request.getAttribute("attachments");
                User loginUser = (User) session.getAttribute("loginUser");
                ReplyService replyService = new ReplyService();
                List<Reply> replies = replyService.getRepliesByPostId(post.getId(), 1, 100);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

                String flashError = (String) session.getAttribute("flashError");
                if (flashError != null) {
                    session.removeAttribute("flashError");
                }
            %>

            <% if (flashError != null) { %>
            <div class="alert alert--error animate-in" role="alert">
                <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                <span><%= flashError %></span>
            </div>
            <% } %>

            <nav class="post-detail__breadcrumb animate-in">
                <a href="${pageContext.request.contextPath}/" class="link-bare">
                    <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
                    首页
                </a>
                <span class="post-detail__breadcrumb__sep">/</span>
                <a href="${pageContext.request.contextPath}/board/detail?id=<%= post.getBoardId() %>" class="link-bare"><%= post.getBoardName() != null ? post.getBoardName() : "未知版块" %></a>
                <span class="post-detail__breadcrumb__sep">/</span>
                <span style="color:var(--ink-1);font-weight:600;max-width:30ch;overflow:hidden;text-overflow:ellipsis;white-space:nowrap"><%= post.getTitle() %></span>
            </nav>

            <article class="post-detail animate-in stagger-1">
                <h1 class="post-detail__title">
                    <%
                        if (post.getIsTop() != null && post.getIsTop() == 1) {
                    %><span class="tag tag--pin">置顶</span><% } %>
                    <%
                        if (post.getIsElite() != null && post.getIsElite() == 1) {
                    %><span class="tag tag--elite">精华</span><% } %>
                    <span><%= post.getTitle() %></span>
                </h1>
                <div class="post-detail__meta">
                    <span class="post-detail__meta-item">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        <%= post.getUsername() != null ? post.getUsername() : "匿名" %>
                    </span>
                    <span class="post-detail__meta-item">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
                        <span class="mono"><%= post.getCreateTime() != null ? sdf.format(post.getCreateTime()) : "" %></span>
                    </span>
                    <span class="post-detail__meta-item">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        <span class="mono"><%= post.getViewCount() %></span> 浏览
                    </span>
                    <span class="post-detail__meta-item">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
                        <span class="mono"><%= post.getReplyCount() %></span> 回复
                    </span>
                </div>

                <div class="post-detail__content"><%= post.getContent() != null ? post.getContent() : "" %></div>

                <%
                    if (attachments != null && !attachments.isEmpty()) {
                %>
                <div class="attachments">
                    <div class="attachments__head">
                        <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21.44 11.05l-9.19 9.19a6 6 0 0 1-8.49-8.49l9.19-9.19a4 4 0 0 1 5.66 5.66l-9.2 9.19a2 2 0 0 1-2.83-2.83l8.49-8.48"/></svg>
                        附件
                    </div>
                    <ul class="attachments__list">
                        <% for (Attachment att : attachments) { %>
                        <li>
                            <a href="${pageContext.request.contextPath}/download?id=<%= att.getId() %>" class="link-bare">
                                <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6"/></svg>
                                <span class="attachments__name"><%= att.getFileName() %></span>
                                <span class="attachments__size"><%= att.getSizeDesc() %></span>
                            </a>
                        </li>
                        <% } %>
                    </ul>
                </div>
                <% } %>

                <div class="post-detail__actions">
                    <button class="btn-like" onclick="likePost(<%= post.getId() %>)" type="button">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
                        <span>赞</span>
                        <span class="mono" id="likeCount"><%= post.getLikeCount() %></span>
                    </button>
                    <%
                        if (loginUser != null && (loginUser.getId().equals(post.getUserId()) || loginUser.isAdmin())) {
                    %>
                    <a href="${pageContext.request.contextPath}/post/edit?id=<%= post.getId() %>" class="btn btn--quiet btn--sm">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 20h9M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4z"/></svg>
                        编辑
                    </a>
                    <form action="${pageContext.request.contextPath}/post/delete" method="POST" onsubmit="return confirm('确定删除？')" style="display:inline">
                        <input type="hidden" name="id" value="<%= post.getId() %>">
                        <button type="submit" class="btn btn--danger btn--sm">
                            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6M8 6V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2M10 11v6M14 11v6"/></svg>
                            删除
                        </button>
                    </form>
                    <% } %>
                </div>
            </article>

            <section class="replies">
                <div class="replies__head">
                    <h2 class="replies__title">
                        回复
                        <span class="replies__count" id="replyCount">(<%= post.getReplyCount() %>)</span>
                    </h2>
                </div>

                <div id="repliesContainer">
                    <% for (Reply reply : replies) { %>
                    <div class="reply" id="reply-<%= reply.getId() %>">
                        <div class="reply__avatar">
                            <%= reply.getUsername() != null ? reply.getUsername().substring(0,1).toUpperCase() : "·" %>
                        </div>
                        <div>
                            <div class="reply__head">
                                <span class="reply__user"><%= reply.getUsername() != null ? reply.getUsername() : "匿名" %></span>
                                <span class="reply__time"><%= reply.getCreateTime() != null ? sdf.format(reply.getCreateTime()) : "" %></span>
                                <%
                                    if (loginUser != null && (loginUser.getId().equals(reply.getUserId()) || loginUser.isAdmin())) {
                                %>
                                <button class="reply__delete" onclick="deleteReply(<%= reply.getId() %>)" type="button">删除</button>
                                <% } %>
                            </div>
                            <div class="reply__body">
                                <%
                                    if (reply.hasQuote()) {
                                %>
                                <div class="reply__quote">
                                    <div class="reply__quote-user">引用 <%= reply.getQuoteUsername() != null ? reply.getQuoteUsername() : "未知" %></div>
                                    <%= reply.getQuoteContent() != null ? reply.getQuoteContent() : "" %>
                                </div>
                                <% } %>
                                <%= reply.getContent() != null ? reply.getContent() : "" %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </section>

            <div class="reply-form">
                <div class="reply-form__head">
                    <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4z"/></svg>
                    写下你的回复
                </div>
                <%
                    if (loginUser != null) {
                %>
                <textarea id="replyContent" class="form-textarea reply-form__textarea" rows="5" placeholder="说点什么..."></textarea>
                <div class="reply-form__actions">
                    <span class="reply-form__hint">支持 Markdown</span>
                    <button class="btn btn--primary" onclick="submitReply(<%= post.getId() %>)" type="button">
                        提交回复
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 2L11 13M22 2l-7 20-4-9-9-4z"/></svg>
                    </button>
                </div>
                <% } else { %>
                <div class="login-tip">请 <a href="${pageContext.request.contextPath}/user/login">登录</a> 后参与讨论</div>
                <% } %>
            </div>
        </div>
    </main>

    <jsp:include page="/pages/common/footer.jsp"/>
</div>

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
                document.getElementById('replyCount').textContent = '(' + (parseInt(document.getElementById('replyCount').textContent.replace(/[()]/g, '')) - 1) + ')';
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
