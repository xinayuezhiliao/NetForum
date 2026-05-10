package com.netforum.servlet;

import com.google.gson.Gson;
import com.netforum.model.Reply;
import com.netforum.model.User;
import com.netforum.service.ReplyService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 回复控制器
 */
@WebServlet("/reply/*")
public class ReplyServlet extends HttpServlet {

    private ReplyService replyService = new ReplyService();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"请先登录\"}");
            return;
        }

        String action = req.getParameter("action");
        if ("add".equals(action)) {
            handleAdd(req, resp, loginUser);
        } else if ("delete".equals(action)) {
            handleDelete(req, resp, loginUser);
        } else if ("list".equals(action)) {
            handleList(req, resp);
        } else {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false}");
        }
    }

    private void handleAdd(HttpServletRequest req, HttpServletResponse resp, User loginUser)
            throws IOException {
        String content = req.getParameter("content");
        String postIdStr = req.getParameter("postId");
        String quoteIdStr = req.getParameter("quoteId");

        if (content == null || content.trim().isEmpty() || postIdStr == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"Invalid data\"}");
            return;
        }

        Reply reply = new Reply();
        reply.setContent(content.trim());
        reply.setUserId(loginUser.getId());
        reply.setPostId(Integer.parseInt(postIdStr));
        if (quoteIdStr != null && !quoteIdStr.isEmpty()) {
            reply.setQuoteId(Integer.parseInt(quoteIdStr));
        }

        int replyId = replyService.addReply(reply);
        if (replyId > 0) {
            reply = replyService.getReplyById(replyId);
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write(gson.toJson(reply));
        } else {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"Add reply failed\"}");
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, User loginUser)
            throws IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false}");
            return;
        }

        Reply reply = replyService.getReplyById(Integer.parseInt(idStr));
        if (reply == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"Reply not found\"}");
            return;
        }

        if (!reply.getUserId().equals(loginUser.getId()) && !loginUser.isAdmin()) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"No permission\"}");
            return;
        }

        boolean success = replyService.deleteReply(Integer.parseInt(idStr), reply.getPostId());
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"success\":" + success + "}");
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String postIdStr = req.getParameter("postId");
        String pageStr = req.getParameter("page");
        int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
        int pageSize = 20;

        if (postIdStr == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("[]");
            return;
        }

        var replies = replyService.getRepliesByPostId(Integer.parseInt(postIdStr), page, pageSize);
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(gson.toJson(replies));
    }
}