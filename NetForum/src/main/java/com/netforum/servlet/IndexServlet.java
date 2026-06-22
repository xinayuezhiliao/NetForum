package com.netforum.servlet;

import com.netforum.model.Board;
import com.netforum.service.BoardService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * 首页控制器 - 处理根路径 /
 */
@WebServlet(name = "IndexServlet", urlPatterns = {"", "/index"})
public class IndexServlet extends HttpServlet {

    private BoardService boardService = new BoardService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Board> boards = boardService.getAllBoards();
        req.setAttribute("boards", boards);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}