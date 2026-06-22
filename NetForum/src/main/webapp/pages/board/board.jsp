<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="com.netforum.model.Post" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("board") != null ? ((Board)request.getAttribute("board")).getName() : "版块" %> · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>

    <main>
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

            <nav class="post-detail__breadcrumb animate-in">
                <a href="${pageContext.request.contextPath}/" class="link-bare">
                    <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
                    首页
                </a>
                <span class="post-detail__breadcrumb__sep">/</span>
                <span>版块</span>
                <span class="post-detail__breadcrumb__sep">/</span>
                <span style="color:var(--ink-1);font-weight:600"><%= board.getName() %></span>
            </nav>

            <section class="hero animate-in stagger-1">
                <div>
                    <span class="eyebrow">版块 №<%= String.format("%03d", board.getId()) %></span>
                    <h1 class="hero__title"><%= board.getName() %></h1>
                    <p class="hero__sub"><%= board.getDescription() != null ? board.getDescription() : "本版块暂无描述" %></p>
                    <%
                        if (sessionUser != null) {
                    %>
                    <div class="flex gap-3 mt-4">
                        <a class="btn btn--primary" href="${pageContext.request.contextPath}/post/create?boardId=<%= board.getId() %>">
                            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"><path d="M12 5v14M5 12h14"/></svg>
                            在本版发帖
                        </a>
                    </div>
                    <% } %>
                </div>
            </section>

            <section class="section">
                <div class="section__head">
                    <h2 class="section__title">主题</h2>
                    <span class="section__sub">
                        共 <span class="mono"><%= posts != null ? posts.size() : 0 %></span> 篇 ·
                        第 <span class="mono"><%= currentPage %></span> / <span class="mono"><%= totalPages %></span> 页
                    </span>
                </div>

                <%
                    if (posts == null || posts.isEmpty()) {
                %>
                <div class="empty">
                    <div class="empty__icon">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><path d="M14 2v6h6M16 13H8M16 17H8M10 9H8"/></svg>
                    </div>
                    <h3 class="empty__title">本版块暂无帖子</h3>
                    <p class="empty__sub">成为第一个发声的人</p>
                </div>
                <%
                    } else {
                        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm");
                %>
                <div class="post-list">
                    <%
                        int idx = 0;
                        for (Post p : posts) {
                            idx++;
                    %>
                    <a class="post-row link-bare animate-in stagger-<%= Math.min(idx, 8) %>" href="${pageContext.request.contextPath}/post/detail?id=<%= p.getId() %>">
                        <div class="post-row__body">
                            <h3 class="post-row__title">
                                <%
                                    if (p.getIsTop() != null && p.getIsTop() == 1) {
                                %><span class="tag tag--pin">置顶</span><% } %>
                                <%
                                    if (p.getIsElite() != null && p.getIsElite() == 1) {
                                %><span class="tag tag--elite">精华</span><% } %>
                                <%= p.getTitle() %>
                            </h3>
                            <div class="post-row__meta">
                                <span class="post-row__meta-item">
                                    <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                                    <%= p.getUsername() != null ? p.getUsername() : "匿名" %>
                                </span>
                                <span class="post-row__meta-item">
                                    <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/></svg>
                                    <span class="mono"><%= p.getCreateTime() != null ? sdf.format(p.getCreateTime()) : "" %></span>
                                </span>
                            </div>
                        </div>
                        <div class="post-row__stats">
                            <div class="post-row__stat">
                                <div class="post-row__stat-value"><%= p.getReplyCount() %></div>
                                <div class="post-row__stat-label">回复</div>
                            </div>
                            <div class="post-row__stat">
                                <div class="post-row__stat-value"><%= p.getViewCount() %></div>
                                <div class="post-row__stat-label">浏览</div>
                            </div>
                            <svg class="ic ic--md post-row__arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18l6-6-6-6"/></svg>
                        </div>
                    </a>
                    <%
                        }
                    %>
                </div>

                <%
                    if (totalPages > 1) {
                %>
                <nav class="pagination">
                    <%
                        int start = Math.max(1, currentPage - 2);
                        int end = Math.min(totalPages, start + 4);
                        if (end - start < 4) start = Math.max(1, end - 4);
                    %>
                    <%
                        if (currentPage > 1) {
                    %><a href="?id=<%= board.getId() %>&page=<%= currentPage - 1 %>" class="link-bare">←</a><%
                        } else {
                    %><span class="is-disabled">←</span><%
                        }
                        for (int i = start; i <= end; i++) {
                    %>
                    <a href="?id=<%= board.getId() %>&page=<%= i %>" class="<%= currentPage == i ? "is-active" : "link-bare" %>"><%= i %></a>
                    <%
                        }
                        if (currentPage < totalPages) {
                    %><a href="?id=<%= board.getId() %>&page=<%= currentPage + 1 %>" class="link-bare">→</a><%
                        } else {
                    %><span class="is-disabled">→</span><%
                        }
                    %>
                </nav>
                <%
                    }
                %>
                <% } %>
            </section>
        </div>
    </main>

    <jsp:include page="/pages/common/footer.jsp"/>
</div>
</body>
</html>
