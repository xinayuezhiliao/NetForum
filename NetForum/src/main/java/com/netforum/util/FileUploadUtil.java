package com.netforum.util;

import java.io.File;
import java.util.UUID;

/**
 * 文件上传工具类
 */
public class FileUploadUtil {

    private static final String UPLOAD_PATH = "/upload/";

    /**
     * 生成唯一文件名
     */
    public static String generateFileName(String originalFilename) {
        String ext = "";
        int dotIndex = originalFilename.lastIndexOf('.');
        if (dotIndex > 0) {
            ext = originalFilename.substring(dotIndex);
        }
        return UUID.randomUUID().toString() + ext;
    }

    /**
     * 获取文件存储路径
     */
    public static String getSavePath(String filename, String uploadDir) {
        return uploadDir + File.separator + filename;
    }

    /**
     * 获取访问URL路径
     */
    public static String getAccessPath(String filename) {
        return UPLOAD_PATH + filename;
    }
}