<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="site-footer">
    <div class="site-footer__inner">
        <div class="site-footer__brand-col">
            <a class="site-footer__brand link-bare" href="${pageContext.request.contextPath}/">
                Net<span class="site-footer__brand__mark"></span><span class="site-footer__brand__suffix">Forum</span>
            </a>
            <p class="site-footer__tag">一处安静的园地，存放观点、记录思考。</p>
            <p class="site-footer__copy">© 2026 NetForum · JavaWeb 课程设计</p>
        </div>
        <div class="site-footer__col">
            <h6>导航</h6>
            <ul>
                <li><a href="${pageContext.request.contextPath}/">首页</a></li>
                <li><a href="${pageContext.request.contextPath}/user/register">注册账号</a></li>
                <li><a href="${pageContext.request.contextPath}/user/login">用户登录</a></li>
            </ul>
        </div>
        <div class="site-footer__col">
            <h6>关于</h6>
            <ul>
                <li><a href="${pageContext.request.contextPath}/page/help">使用指南</a></li>
                <li><a href="${pageContext.request.contextPath}/page/agreement">社区公约</a></li>
                <li><a href="${pageContext.request.contextPath}/page/contact">联系我们</a></li>
            </ul>
        </div>
    </div>
</footer>
