<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>创建版块 · NetForum</title>
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
                <span style="color:var(--ink-1);font-weight:600">创建版块</span>
            </nav>

            <section class="hero animate-in stagger-1" style="padding:var(--space-7) 0 var(--space-5)">
                <div>
                    <span class="eyebrow">— 社区管理 —</span>
                    <h1 class="hero__title">开辟新版块</h1>
                    <p class="hero__sub">为社区开辟新的讨论空间，让志趣相投的人相遇。</p>
                </div>
            </section>

            <div class="animate-in stagger-2" style="padding-bottom:var(--space-9)">
                <form class="form" action="${pageContext.request.contextPath}/board/create" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="form-row">
                        <label class="form-label" for="name">
                            版块名称
                            <span class="form-label__hint">简短清晰</span>
                        </label>
                        <input id="name" type="text" name="name" class="form-input" required placeholder="如：读书笔记、远足记录">
                    </div>
                    <div class="form-row">
                        <label class="form-label" for="description">
                            版块描述
                            <span class="form-label__hint">一句话介绍这里讨论什么</span>
                        </label>
                        <textarea id="description" name="description" class="form-textarea" rows="5" placeholder="例如：分享阅读心得，每月共读一本书。"></textarea>
                    </div>
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/" class="btn btn--quiet">取消</a>
                        <button type="submit" class="btn btn--primary">
                            创建版块
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
