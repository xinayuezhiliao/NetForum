package com.netforum.service;

import com.netforum.dao.ReplyDAO;
import com.netforum.dao.PostDAO;
import com.netforum.model.Reply;
import java.util.List;

/**
 * 回复服务层
 */
public class ReplyService {

    private ReplyDAO replyDAO = new ReplyDAO();
    private PostDAO postDAO = new PostDAO();

    /**
     * 添加回复
     */
    public int addReply(Reply reply) {
        int replyId = replyDAO.create(reply);
        if (replyId > 0) {
            // 更新帖子的回复数
            postDAO.incrementReplyCount(reply.getPostId());
        }
        return replyId;
    }

    /**
     * 获取帖子的回复
     */
    public List<Reply> getRepliesByPostId(Integer postId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return replyDAO.findByPostId(postId, offset, pageSize);
    }

    /**
     * 获取回复详情
     */
    public Reply getReplyById(Integer id) {
        return replyDAO.findById(id);
    }

    /**
     * 删除回复
     */
    public boolean deleteReply(Integer replyId, Integer postId) {
        boolean deleted = replyDAO.delete(replyId);
        return deleted;
    }

    /**
     * 获取回复总数
     */
    public int getReplyCount(Integer postId) {
        return replyDAO.countByPostId(postId);
    }
}