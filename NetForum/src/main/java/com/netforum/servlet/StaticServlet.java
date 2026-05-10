package com.netforum.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * 静态资源Servlet - 提供CSS等静态文件
 */
@WebServlet("/static/*")
public class StaticServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 移除开头的 /
        String resourcePath = pathInfo.substring(1);

        // 获取真实文件系统路径
        String realPath = getServletContext().getRealPath("/" + resourcePath);

        if (realPath == null || !Files.exists(Paths.get(realPath))) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // 设置内容类型
        if (resourcePath.endsWith(".css")) {
            resp.setContentType("text/css;charset=UTF-8");
        } else if (resourcePath.endsWith(".js")) {
            resp.setContentType("application/javascript;charset=UTF-8");
        } else if (resourcePath.endsWith(".png")) {
            resp.setContentType("image/png");
        } else if (resourcePath.endsWith(".jpg") || resourcePath.endsWith(".jpeg")) {
            resp.setContentType("image/jpeg");
        } else if (resourcePath.endsWith(".gif")) {
            resp.setContentType("image/gif");
        }

        // 读取并发送文件
        Path path = Paths.get(realPath);
        byte[] content = Files.readAllBytes(path);
        resp.getOutputStream().write(content);
    }
}
