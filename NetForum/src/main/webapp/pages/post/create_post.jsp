<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="com.netforum.service.BoardService" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发表新帖 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>

    <main>
        <div class="container-narrow">
            <nav class="post-detail__breadcrumb animate-in">
                <a href="${pageContext.request.contextPath}/" class="link-bare">
                    <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12l9-9 9 9M5 10v10h14V10"/></svg>
                    首页
                </a>
                <span class="post-detail__breadcrumb__sep">/</span>
                <span style="color:var(--ink-1);font-weight:600">发表新帖</span>
            </nav>

            <section class="hero animate-in stagger-1" style="padding:var(--space-7) 0 var(--space-5)">
                <div>
                    <span class="eyebrow">— 写作 —</span>
                    <h1 class="hero__title">分享你的想法</h1>
                    <p class="hero__sub">写下一个观点、一段经历或一个问题。文字会被认真阅读。</p>
                </div>
            </section>

            <div class="animate-in stagger-2" style="padding-bottom:var(--space-9)">
                <form class="form" action="${pageContext.request.contextPath}/post/create" method="post">
                    <%
                        BoardService boardService = new BoardService();
                        List<Board> boards = boardService.getAllBoards();
                        Long preBoardId = (Long) request.getAttribute("preBoardId");
                    %>
                    <div class="form-row">
                        <label class="form-label" for="boardId">
                            所属版块
                            <span class="form-label__hint">选一个最贴切的话题空间</span>
                        </label>
                        <select id="boardId" name="boardId" class="form-select" required>
                            <% for (Board board : boards) { %>
                            <option value="<%= board.getId() %>" <%= (preBoardId != null && preBoardId.equals(board.getId())) ? "selected" : "" %>><%= board.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-row">
                        <label class="form-label" for="title">
                            标题
                            <span class="form-label__hint">不超过 200 字</span>
                        </label>
                        <input id="title" type="text" name="title" class="form-input" required maxlength="200" placeholder="请输入帖子标题">
                    </div>
                    <div class="form-row">
                        <label class="form-label" for="content">
                            正文
                            <span class="form-label__hint">支持纯文本与简单换行</span>
                        </label>
                        <textarea id="content" name="content" class="form-textarea form-textarea--tall" required placeholder="在此输入内容..."></textarea>
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/" class="btn btn--quiet">取消</a>
                        <button type="submit" class="btn btn--primary">
                            发布
                            <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
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
