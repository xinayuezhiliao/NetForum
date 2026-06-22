<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>社区公约 · NetForum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="page">
    <jsp:include page="/pages/common/header.jsp"/>
    <main>
        <div class="container-narrow">
            <article class="static-page animate-in">
                <h1 class="static-page__title">社区公约</h1>
                <p class="static-page__lead">为了让 NetForum 成为一个友善、有价值的交流空间，请所有用户共同遵守以下公约。</p>

                <h2>一、内容规范</h2>
                <ul>
                    <li>禁止发布违反国家法律法规的内容。</li>
                    <li>禁止发布色情、暴力、血腥、赌博等不良信息。</li>
                    <li>禁止发布虚假信息、谣言或恶意中伤他人的内容。</li>
                    <li>禁止未经授权发布他人隐私、版权材料等。</li>
                </ul>

                <h2>二、行为规范</h2>
                <ul>
                    <li>尊重他人观点，理性讨论，禁止人身攻击与谩骂。</li>
                    <li>禁止恶意刷屏、灌水、发布广告与垃圾信息。</li>
                    <li>禁止冒充他人或管理员身份。</li>
                    <li>禁止利用社区从事任何商业牟利活动。</li>
                </ul>

                <h2>三、版权说明</h2>
                <p>用户在 NetForum 发布的内容，默认视为作者同意在保留署名的情况下被社区引用。转载第三方内容请注明来源。</p>

                <h2>四、违规处理</h2>
                <p>对于违反公约的内容，社区管理员将根据情节轻重予以警告、编辑、删除或封禁账号的处理。处理决定不接受申诉时请通过"联系我们"与我们沟通。</p>

                <h2>五、条款变更</h2>
                <p>本公约可能根据社区发展需要进行调整，修改后会通过公告或站内通知告知用户。</p>

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
