package com.netforum.servlet;

import com.netforum.model.User;
import com.netforum.service.UserService;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;

/**
 * 用户控制器
 */
@WebServlet("/user/*")
@MultipartConfig
public class UserServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        switch (pathInfo) {
            case "/login":
                req.getRequestDispatcher("/pages/user/login.jsp").forward(req, resp);
                break;
            case "/register":
                req.getRequestDispatcher("/pages/user/register.jsp").forward(req, resp);
                break;
            case "/profile":
                User loginUser = (User) req.getSession().getAttribute("loginUser");
                if (loginUser == null) {
                    resp.sendRedirect(req.getContextPath() + "/user/login");
                    return;
                }
                req.getRequestDispatcher("/pages/user/profile.jsp").forward(req, resp);
                break;
            case "/logout":
                req.getSession().invalidate();
                resp.sendRedirect(req.getContextPath() + "/");
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        switch (pathInfo) {
            case "/login":
                handleLogin(req, resp);
                break;
            case "/register":
                handleRegister(req, resp);
                break;
            case "/update":
                handleUpdate(req, resp);
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userService.login(username, password);
        if (user != null) {
            req.getSession().setAttribute("loginUser", user);
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            req.setAttribute("error", "用户名或密码错误");
            req.getRequestDispatcher("/pages/user/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        String avatar = null;
        Part avatarPart = req.getPart("avatar");
        if (avatarPart != null && avatarPart.getInputStream().available() > 0) {
            String uploadPath = getServletContext().getRealPath("/upload/avatar");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filename = System.currentTimeMillis() + "_" + avatarPart.getSubmittedFileName();
            String savePath = uploadPath + File.separator + filename;
            avatarPart.write(savePath);
            avatar = "/upload/avatar/" + filename;
        }

        boolean success = userService.register(username, password, email, avatar);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/user/login?registered=true");
        } else {
            req.setAttribute("error", "用户名已存在");
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/pages/user/register.jsp").forward(req, resp);
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login");
            return;
        }

        String email = req.getParameter("email");
        Part avatarPart = req.getPart("avatar");
        String avatar = loginUser.getAvatar();

        if (avatarPart != null && avatarPart.getInputStream().available() > 0) {
            String uploadPath = getServletContext().getRealPath("/upload/avatar");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            String filename = System.currentTimeMillis() + "_" + avatarPart.getSubmittedFileName();
            String savePath = uploadPath + File.separator + filename;
            avatarPart.write(savePath);
            avatar = "/upload/avatar/" + filename;
        }

        loginUser.setEmail(email);
        loginUser.setAvatar(avatar);
        boolean success = userService.update(loginUser);

        if (success) {
            req.getSession().setAttribute("loginUser", userService.findById(loginUser.getId()));
            resp.sendRedirect(req.getContextPath() + "/user/profile?updated=true");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/profile?error=update_failed");
        }
    }
}