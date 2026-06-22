<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>联系我们 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>
    <main>
        <div class="container-narrow">
            <article class="static-page animate-in">
                <h1 class="static-page__title">联系我们</h1>
                <p class="static-page__lead">如果你在使用 NetForum 时遇到问题、想要反馈建议，或者希望与我们合作，欢迎通过以下方式联系。</p>

                <h2>反馈建议</h2>
                <p>如果你发现 Bug、想要新功能、或者对界面有改进建议，可以前往"反馈建议"板块发帖，管理员会定期查看并跟进。</p>

                <h2>站内私信</h2>
                <p>注册并登录后，可以通过帖子回复或评论区与作者直接交流（目前社区暂未开放独立的私信功能）。</p>

                <h2>邮件联系</h2>
                <ul class="static-page__contact">
                    <li><strong>支持邮箱：</strong>support@netforum.example.com</li>
                    <li><strong>管理员邮箱：</strong>admin@netforum.example.com</li>
                    <li><strong>合作邮箱：</strong>bd@netforum.example.com</li>
                </ul>

                <h2>常见问题</h2>
                <p>在向我们反馈之前，建议先查看 <a href="${pageContext.request.contextPath}/page/help" class="link-bare">使用指南</a>，里面已经覆盖了注册、发帖、回复、附件等常见操作的说明。</p>

                <p class="static-page__back">
                    <a href="${pageContext.request.contextPath}/" class="link-bare">← 返回首页</a>
                </p>
            </article>
        </div>
    </main>
    <jsp:include page="/pages/common/footer.jsp"/>
</div>
</body>
</html>
