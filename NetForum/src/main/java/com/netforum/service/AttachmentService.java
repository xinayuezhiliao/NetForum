package com.netforum.service;

import com.netforum.dao.AttachmentDAO;
import com.netforum.model.Attachment;
import java.io.File;
import java.util.List;

/**
 * 附件服务层
 */
public class AttachmentService {

    private AttachmentDAO attachmentDAO = new AttachmentDAO();

    /**
     * 添加附件记录
     */
    public int addAttachment(Attachment attachment) {
        return attachmentDAO.create(attachment);
    }

    /**
     * 获取帖子的附件
     */
    public List<Attachment> getAttachmentsByPostId(Integer postId) {
        return attachmentDAO.findByPostId(postId);
    }

    /**
     * 获取附件
     */
    public Attachment getAttachmentById(Integer id) {
        return attachmentDAO.findById(id);
    }

    /**
     * 删除附件（同时删除文件）
     */
    public boolean deleteAttachment(Integer id, String uploadPath) {
        Attachment att = attachmentDAO.findById(id);
        if (att == null) return false;
        // 删除物理文件
        File file = new File(uploadPath, att.getFilePath());
        if (file.exists()) {
            file.delete();
        }
        return attachmentDAO.delete(id);
    }
}