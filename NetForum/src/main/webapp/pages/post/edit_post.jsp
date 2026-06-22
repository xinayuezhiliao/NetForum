<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Post" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="com.netforum.service.BoardService" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>编辑帖子 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>

    <main>
        <div class="container-narrow">
            <%
                Post post = (Post) request.getAttribute("post");
                BoardService boardService = new BoardService();
                List<Board> boards = boardService.getAllBoards();

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
                <a href="${pageContext.request.contextPath}/post/detail?id=<%= post.getId() %>" class="link-bare">帖子</a>
                <span class="post-detail__breadcrumb__sep">/</span>
                <span style="color:var(--ink-1);font-weight:600">编辑</span>
            </nav>

            <section class="hero animate-in stagger-1" style="padding:var(--space-7) 0 var(--space-5)">
                <div>
                    <span class="eyebrow">— 修改 —</span>
                    <h1 class="hero__title">编辑帖子</h1>
                    <p class="hero__sub">细微之处，更见用心。</p>
                </div>
            </section>

            <div class="animate-in stagger-2" style="padding-bottom:var(--space-9)">
                <form class="form" action="${pageContext.request.contextPath}/post/update" method="post">
                    <input type="hidden" name="id" value="<%= post.getId() %>">
                    <div class="form-row">
                        <label class="form-label" for="boardId">所属版块</label>
                        <select id="boardId" name="boardId" class="form-select" required>
                            <% for (Board board : boards) { %>
                            <option value="<%= board.getId() %>" <%= board.getId().equals(post.getBoardId()) ? "selected" : "" %>><%= board.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row">
                        <label class="form-label" for="title">标题</label>
                        <input id="title" type="text" name="title" class="form-input" required value="<%= post.getTitle() %>" maxlength="200">
                    </div>
                    <div class="form-row">
                        <label class="form-label" for="content">正文</label>
                        <textarea id="content" name="content" class="form-textarea form-textarea--tall" required><%= post.getContent() %></textarea>
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/post/detail?id=<%= post.getId() %>" class="btn btn--quiet">取消</a>
                        <button type="submit" class="btn btn--primary">
                            保存修改
                            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><path d="M17 21v-8H7v8M7 3v5h8"/></svg>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="/pages/common/footer.jsp"/>
</div>
</body>
</html>
