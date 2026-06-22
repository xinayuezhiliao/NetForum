<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.netforum.service.BoardService" %>
<%@ page import="com.netforum.model.Board" %>
<%@ page import="com.netforum.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NetForum — 网上论坛</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>

    <main>
        <div class="container">
            <%
                BoardService bs = new BoardService();
                List<Board> boards = bs.getAllBoards();
                int totalPosts = 0;
                if (boards != null) for (Board b : boards) totalPosts += b.getPostCount();
                int onlineCount = 0;
                Object countObj = application.getAttribute("onlineCount");
                if (countObj != null) {
                    if (countObj instanceof AtomicInteger) onlineCount = ((AtomicInteger) countObj).get();
                    else if (countObj instanceof Integer) onlineCount = (Integer) countObj;
                }
            %>

            <!-- HERO -->
            <section class="hero hero--ornament animate-in">
                <div class="hero__grid">
                    <div>
                        <span class="eyebrow">No.<%= boards != null ? boards.size() : 0 %> Edition · 2026</span>
                        <h1 class="hero__title">记录思考，<em>慢一点</em>也无妨。</h1>
                        <p class="hero__sub">一个安静的中文论坛。挑选你感兴趣的版块，与社区一起分享观点，沉淀文字。</p>
                        <div class="hero__meta">
                            <div class="hero__stat">
                                <div class="hero__stat-num mono"><%= boards != null ? boards.size() : 0 %></div>
                                <div class="hero__stat-label">版块</div>
                            </div>
                            <div class="hero__stat">
                                <div class="hero__stat-num mono"><%= totalPosts %></div>
                                <div class="hero__stat-label">帖子</div>
                            </div>
                            <div class="hero__stat">
                                <div class="hero__stat-num mono"><%= onlineCount %></div>
                                <div class="hero__stat-label">在线</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- BOARDS -->
            <section class="section">
                <div class="section__head">
                    <h2 class="section__title">所有版块</h2>
                    <span class="section__sub">A selection of rooms · <%= boards != null ? boards.size() : 0 %> in total</span>
                </div>

                <%
                    if (boards == null || boards.isEmpty()) {
                %>
                <div class="empty">
                    <div class="empty__icon">
                        <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3 7l9-4 9 4M3 7v10l9 4 9-4V7M3 7l9 4m0 0l9-4m-9 4v10"/></svg>
                    </div>
                    <h3 class="empty__title">还没有版块</h3>
                    <p class="empty__sub">管理员可以创建第一个版块</p>
                </div>
                <%
                    } else {
                %>
                <div class="board-grid">
                    <%
                        for (Board board : boards) {
                            int iconIdx = (int)(Math.abs(board.getId() == null ? board.getName().hashCode() : board.getId().longValue()) % 7);
                    %>
                    <a class="board-card link-bare animate-in stagger-<%= Math.min(boards.indexOf(board) + 1, 8) %>" href="${pageContext.request.contextPath}/board/detail?id=<%= board.getId() %>">
                        <div class="board-card__head">
                            <span class="board-card__icon">
                                <%
                                    switch (iconIdx) {
                                        case 0: // hash
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"><path d="M4 9h16M4 15h16M10 3L8 21M16 3l-2 18"/></svg><%
                                            break;
                                        case 1: // chat bubble
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg><%
                                            break;
                                        case 2: // book
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2zM22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"/></svg><%
                                            break;
                                        case 3: // music
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18V5l12-2v13M9 18a3 3 0 1 1-6 0 3 3 0 0 1 6 0zM21 16a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/></svg><%
                                            break;
                                        case 4: // film
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="2"/><path d="M7 2v20M17 2v20M2 12h20M2 7h5M2 17h5M17 17h5M17 7h5"/></svg><%
                                            break;
                                        case 5: // code
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M16 18l6-6-6-6M8 6l-6 6 6 6"/></svg><%
                                            break;
                                        case 6: // spark / star
                                %><svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2l2.39 7.36H22l-6.18 4.49L18.21 22 12 17.27 5.79 22l2.39-8.15L2 9.36h7.61z"/></svg><%
                                            break;
                                    }
                                %>
                            </span>
                            <span class="board-card__count">№ <%= String.format("%03d", board.getId()) %></span>
                        </div>
                        <h3 class="board-card__name"><%= board.getName() %></h3>
                        <p class="board-card__desc"><%= board.getDescription() != null ? board.getDescription() : "尚未添加描述" %></p>
                        <div class="board-card__foot">
                            <span class="post-row__meta-item">
                                <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z" stroke-linecap="round" stroke-linejoin="round"/></svg>
                                <span class="mono"><%= board.getPostCount() %></span>
                            </span>
                            <span class="post-row__meta-item">
                                <svg class="ic ic--sm" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M3 7l9-4 9 4M3 7v10l9 4 9-4V7M3 7l9 4m0 0l9-4m-9 4v10" stroke-linecap="round" stroke-linejoin="round"/></svg>
                                <span>版块</span>
                            </span>
                            <svg class="ic board-card__arrow" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                        </div>
                    </a>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </section>

            <%
                User idxUser = (User) session.getAttribute("loginUser");
                if (idxUser != null) {
            %>
            <!-- CTA 登录态 -->
            <section class="section__divider"><span class="section__divider__label">— 继续 —</span></section>
            <section class="section flex flex-center" style="gap:var(--space-4);flex-wrap:wrap">
                <a class="btn btn--primary" href="${pageContext.request.contextPath}/post/create">
                    <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"><path d="M12 5v14M5 12h14"/></svg>
                    发布新帖
                </a>
                <%
                    if (idxUser.isAdmin()) {
                %>
                <a class="btn btn--quiet" href="${pageContext.request.contextPath}/board/create">
                    <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"><path d="M3 7l9-4 9 4M3 7v10l9 4 9-4V7M3 7l9 4m0 0l9-4m-9 4v10" stroke-linejoin="round"/></svg>
                    创建版块
                </a>
                <%
                    }
                %>
            </section>
            <%
                } else {
            %>
            <section class="section__divider"><span class="section__divider__label">— 加入我们 —</span></section>
            <section class="section flex flex-center" style="gap:var(--space-4);flex-wrap:wrap">
                <a class="btn btn--primary" href="${pageContext.request.contextPath}/user/register">
                    立即注册
                    <svg class="ic" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </a>
                <a class="btn btn--quiet" href="${pageContext.request.contextPath}/user/login">
                    已有账号 · 登录
                </a>
            </section>
            <%
                }
            %>
        </div>
    </main>

    <jsp:include page="/pages/common/footer.jsp"/>
</div>
</body>
</html>
