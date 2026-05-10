package com.netforum.servlet;

import com.google.gson.Gson;
import com.netforum.model.Post;
import com.netforum.model.User;
import com.netforum.model.Attachment;
import com.netforum.service.PostService;
import com.netforum.service.BoardService;
import com.netforum.service.AttachmentService;
import com.netforum.dao.LikeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * 帖子控制器
 */
@WebServlet("/post/*")
@MultipartConfig
public class PostServlet extends HttpServlet {

    private PostService postService = new PostService();
    private BoardService boardService = new BoardService();
    private AttachmentService attachmentService = new AttachmentService();
    private LikeDAO likeDAO = new LikeDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        if (pathInfo.equals("/create")) {
            User loginUser = (User) req.getSession().getAttribute("loginUser");
            if (loginUser == null) {
                resp.sendRedirect(req.getContextPath() + "/user/login");
                return;
            }
            req.setAttribute("boards", boardService.getAllBoards());
            req.getRequestDispatcher("/pages/post/create_post.jsp").forward(req, resp);
        } else if (pathInfo.equals("/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Post post = postService.getPostById(Integer.parseInt(idStr));
                if (post != null) {
                    User loginUser = (User) req.getSession().getAttribute("loginUser");
                    if (loginUser != null && loginUser.getId().equals(post.getUserId())) {
                        req.setAttribute("post", post);
                        req.setAttribute("boards", boardService.getAllBoards());
                        req.getRequestDispatcher("/pages/post/edit_post.jsp").forward(req, resp);
                        return;
                    }
                }
            }
            resp.sendRedirect(req.getContextPath() + "/");
        } else if (pathInfo.equals("/list")) {
            String boardIdStr = req.getParameter("boardId");
            String pageStr = req.getParameter("page");
            int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
            int pageSize = 15;

            List<Post> posts;
            if (boardIdStr != null && !boardIdStr.isEmpty()) {
                posts = postService.getPostsByBoardId(Integer.parseInt(boardIdStr), page, pageSize);
            } else {
                posts = postService.getAllPosts(page, pageSize);
            }

            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write(gson.toJson(posts));
        } else {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                Post post = postService.getPostById(Integer.parseInt(idStr));
                if (post != null) {
                    postService.incrementViewCount(post.getId());
                    post = postService.getPostById(post.getId());
                    req.setAttribute("post", post);
                    req.setAttribute("attachments", attachmentService.getAttachmentsByPostId(post.getId()));
                    req.getRequestDispatcher("/pages/post/post.jsp").forward(req, resp);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) pathInfo = "/";

        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/user/login");
            return;
        }

        if (pathInfo.equals("/create")) {
            handleCreate(req, resp, loginUser);
        } else if (pathInfo.equals("/update")) {
            handleUpdate(req, resp, loginUser);
        } else if (pathInfo.equals("/delete")) {
            handleDelete(req, resp, loginUser);
        } else if (pathInfo.equals("/like")) {
            handleLike(req, resp);
        } else if (pathInfo.equals("/upload")) {
            handleUpload(req, resp, loginUser);
        } else {
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp, User loginUser)
            throws ServletException, IOException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String boardIdStr = req.getParameter("boardId");

        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/post/create");
            return;
        }

        Post post = new Post();
        post.setTitle(title.trim());
        post.setContent(content.trim());
        post.setUserId(loginUser.getId());
        post.setBoardId(Integer.parseInt(boardIdStr));

        int postId = postService.createPost(post);
        if (postId > 0) {
            resp.sendRedirect(req.getContextPath() + "/post/detail?id=" + postId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/post/create");
        }
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp, User loginUser)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Post post = postService.getPostById(Integer.parseInt(idStr));
        if (post == null || !post.getUserId().equals(loginUser.getId()) && !loginUser.isAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String title = req.getParameter("title");
        String content = req.getParameter("content");
        post.setTitle(title);
        post.setContent(content);
        resp.sendRedirect(req.getContextPath() + "/post/detail?id=" + post.getId());
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp, User loginUser)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        System.out.println("=== Delete handler called, id=" + idStr + ", user=" + (loginUser != null ? loginUser.getId() : "null"));

        if (idStr == null) {
            System.out.println("=== id is null, redirecting");
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        try {
            Post post = postService.getPostById(Integer.parseInt(idStr));
            System.out.println("=== post=" + (post != null ? post.getTitle() : "null") + ", userId=" + (post != null ? post.getUserId() : "null"));

            if (post == null) {
                System.out.println("=== post not found, redirecting");
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }

            System.out.println("=== loginUser.getId()=" + loginUser.getId() + ", post.getUserId()=" + post.getUserId());
            System.out.println("=== equals? " + loginUser.getId().equals(post.getUserId()) + ", isAdmin? " + loginUser.isAdmin());

            if (!loginUser.getId().equals(post.getUserId()) && !loginUser.isAdmin()) {
                System.out.println("=== no permission, redirecting");
                resp.sendRedirect(req.getContextPath() + "/post/detail?id=" + post.getId());
                return;
            }

            System.out.println("=== calling postService.deletePost");
            boolean success = postService.deletePost(post.getId());
            System.out.println("=== delete result: " + success);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/board/detail?id=" + post.getBoardId());
            } else {
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":false,\"message\":\"删除失败\"}");
            }
        } catch (Exception e) {
            System.out.println("=== Exception: " + e.getMessage());
            e.printStackTrace();
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    private void handleLike(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User loginUser = (User) req.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"请先登录\"}");
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false}");
            return;
        }

        int postId = Integer.parseInt(idStr);

        // 检查是否已点赞
        if (likeDAO.hasLiked(loginUser.getId(), postId)) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"已点赞过\"}");
            return;
        }

        // 执行点赞
        boolean success = likeDAO.addLike(loginUser.getId(), postId);
        if (success) {
            postService.updateLikeCount(postId, 1);
        }
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"success\":" + success + "}");
    }

    private void handleUpload(HttpServletRequest req, HttpServletResponse resp, User loginUser)
            throws ServletException, IOException {
        String postIdStr = req.getParameter("postId");
        Part filePart = req.getPart("file");

        if (filePart == null || filePart.getInputStream().available() == 0) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.getWriter().write("{\"success\":false,\"message\":\"No file\"}");
            return;
        }

        String uploadPath = getServletContext().getRealPath("/upload/attachment");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String originalFilename = filePart.getSubmittedFileName();
        String ext = originalFilename.substring(originalFilename.lastIndexOf('.'));
        String filename = System.currentTimeMillis() + "_" + (int)(Math.random() * 10000) + ext;
        String savePath = uploadPath + File.separator + filename;
        filePart.write(savePath);

        Attachment att = new Attachment();
        att.setFileName(originalFilename);
        att.setFilePath(filename);
        att.setFileSize((long) filePart.getSize());
        att.setUserId(loginUser.getId());
        if (postIdStr != null && !postIdStr.isEmpty()) {
            att.setPostId(Integer.parseInt(postIdStr));
        }

        int attId = attachmentService.addAttachment(att);

        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"success\":true,\"id\":" + attId + ",\"filename\":\"" + originalFilename + "\"}");
    }
}