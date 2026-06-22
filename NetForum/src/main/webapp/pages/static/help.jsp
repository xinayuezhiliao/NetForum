<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>使用指南 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>
    <main>
        <div class="container-narrow">
            <article class="static-page animate-in">
                <h1 class="static-page__title">使用指南</h1>
                <p class="static-page__lead">欢迎来到 NetForum，这里是一份快速上手手册。</p>

                <h2>1. 注册与登录</h2>
                <p>点击右上角的"登录"，未注册用户可以前往"注册账号"创建新账户。注册时需填写用户名、邮箱与密码，密码将经过 MD5 加密后入库。</p>

                <h2>2. 浏览与发帖</h2>
                <ul>
                    <li>在首页可以看到全部板块与最新帖子。</li>
                    <li>点击板块名进入板块详情，浏览该板块下的所有帖子。</li>
                    <li>登录后点击"发布新帖"，填写标题、内容并选择板块即可发布。</li>
                </ul>

                <h2>3. 回复与互动</h2>
                <p>登录后可在帖子详情页底部写下回复，支持 Markdown 语法。每位登录用户都能对帖子点赞，点赞数会显示在帖子标题旁。</p>

                <h2>4. 附件上传</h2>
                <p>发布帖子或编辑帖子时，可以点击"上传附件"按钮添加文件，单个文件大小请控制在 20MB 以内。</p>

                <h2>5. 编辑与删除</h2>
                <p>帖子的作者和管理员可以编辑或删除帖子，普通用户仅能管理自己发布的帖子。</p>

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
