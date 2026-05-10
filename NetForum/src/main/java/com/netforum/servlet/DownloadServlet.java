package com.netforum.servlet;

import com.netforum.model.Attachment;
import com.netforum.service.AttachmentService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * 文件下载控制器
 */
@WebServlet("/download/*")
public class DownloadServlet extends HttpServlet {

    private AttachmentService attachmentService = new AttachmentService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Attachment att = attachmentService.getAttachmentById(Integer.parseInt(idStr));
        if (att == null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        String uploadPath = getServletContext().getRealPath("/upload/attachment");
        File file = new File(uploadPath, att.getFilePath());
        if (!file.exists()) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition",
                "attachment; filename=\"" + new String(att.getFileName().getBytes("UTF-8"), "ISO-8859-1") + "\"");
        resp.setContentLength((int) file.length());

        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = resp.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}