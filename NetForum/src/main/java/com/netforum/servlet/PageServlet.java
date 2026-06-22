package com.netforum.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 站内静态页面路由（帮助、协议、联系等）
 */
@WebServlet("/page/*")
public class PageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        String jspPath;
        switch (pathInfo) {
            case "/help":
                jspPath = "/pages/static/help.jsp";
                break;
            case "/agreement":
                jspPath = "/pages/static/agreement.jsp";
                break;
            case "/contact":
                jspPath = "/pages/static/contact.jsp";
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/");
                return;
        }
        req.getRequestDispatcher(jspPath).forward(req, resp);
    }
}
