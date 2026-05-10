package com.netforum.listener;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 在线用户统计监听器
 */
@WebListener
public class OnlineUserListener implements HttpSessionListener {

    public static final String ONLINE_COUNT = "onlineCount";

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ServletContext ctx = se.getSession().getServletContext();
        AtomicInteger count = (AtomicInteger) ctx.getAttribute(ONLINE_COUNT);
        if (count == null) {
            count = new AtomicInteger(0);
            ctx.setAttribute(ONLINE_COUNT, count);
        }
        count.incrementAndGet();
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        ServletContext ctx = se.getSession().getServletContext();
        AtomicInteger count = (AtomicInteger) ctx.getAttribute(ONLINE_COUNT);
        if (count != null) {
            count.decrementAndGet();
        }
    }
}