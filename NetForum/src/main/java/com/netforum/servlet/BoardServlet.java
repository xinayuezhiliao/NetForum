package com.netforum.servlet;

import com.netforum.model.Board;
import com.netforum.model.Post;
import com.netforum.model.User;
import com.netforum.service.BoardService;
import com.netforum.service.PostService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 板块控制器
 */
@WebServlet("/board/*")
public class BoardServlet extends HttpServlet {

    private BoardService boardService = new BoardService();
    private PostService postService = new PostService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        switch (pathInfo) {
            case "/create":
                User loginUser = (User) req.getSession().getAttribute("loginUser");
                if (loginUser == null || !loginUser.isAdmin()) {
                    resp.sendRedirect(req.getContextPath() + "/");
                    return;
                }
                req.getRequestDispatcher("/pages/board/create_board.jsp").forward(req, resp);
                break;
            case "/detail":
                String idStr = req.getParameter("id");
                if (idStr != null) {
                    Board board = boardService.getBoardById(Integer.parseInt(idStr));
                    if (board != null) {
                        // 获取帖子列表（分页）
                        String pageStr = req.getParameter("page");
                        int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
                        int pageSize = 15;
                        List<Post> posts = postService.getPostsByBoardId(board.getId(), page, pageSize);
                        int totalCount = postService.getBoardPostCount(board.getId());
                        int totalPages = (totalCount + pageSize - 1) / pageSize;

                        req.setAttribute("board", board);
                        req.setAttribute("posts", posts);
                        req.setAttribute("currentPage", page);
                        req.setAttribute("totalPages", totalPages);
                        req.getRequestDispatcher("/pages/board/board.jsp").forward(req, resp);
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/");
                    }
                } else {
                    resp.sendRedirect(req.getContextPath() + "/");
                }
                break;
            default:
                resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null || !loginUser.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String action = req.getParameter("action");
        if ("create".equals(action)) {
            String name = req.getParameter("name");
            String description = req.getParameter("description");
            if (name != null && !name.trim().isEmpty()) {
                boardService.createBoard(name.trim(), description);
            }
            resp.sendRedirect(req.getContextPath() + "/");
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }
}