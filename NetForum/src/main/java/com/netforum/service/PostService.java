package com.netforum.service;

import com.netforum.dao.PostDAO;
import com.netforum.dao.BoardDAO;
import com.netforum.dao.LikeDAO;
import com.netforum.dao.ReplyDAO;
import com.netforum.dao.AttachmentDAO;
import com.netforum.model.Post;
import com.netforum.model.Board;
import java.util.List;

/**
 * 帖子服务层
 */
public class PostService {

    private PostDAO postDAO = new PostDAO();
    private BoardDAO boardDAO = new BoardDAO();
    private LikeDAO likeDAO = new LikeDAO();
    private ReplyDAO replyDAO = new ReplyDAO();
    private AttachmentDAO attachmentDAO = new AttachmentDAO();

    /**
     * 创建帖子
     */
    public int createPost(Post post) {
        int postId = postDAO.create(post);
        if (postId > 0) {
            // 更新板块帖子数
            boardDAO.updatePostCount(post.getBoardId(), 1);
        }
        return postId;
    }

    /**
     * 获取帖子详情
     */
    public Post getPostById(Integer id) {
        return postDAO.findById(id);
    }

    /**
     * 增加浏览数
     */
    public void incrementViewCount(Integer postId) {
        postDAO.incrementViewCount(postId);
    }

    /**
     * 更新帖子
     */
    public boolean updatePost(Integer postId, String title, String content) {
        if (title == null || title.trim().isEmpty() || content == null) {
            return false;
        }
        return postDAO.update(postId, title.trim(), content);
    }

    /**
     * 增加回复数
     */
    public void incrementReplyCount(Integer postId) {
        postDAO.incrementReplyCount(postId);
    }

    /**
     * 更新点赞数
     */
    public boolean updateLikeCount(Integer postId, int delta) {
        return postDAO.updateLikeCount(postId, delta);
    }

    /**
     * 获取板块下的帖子
     */
    public List<Post> getPostsByBoardId(Integer boardId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return postDAO.findByBoardId(boardId, offset, pageSize);
    }

    /**
     * 获取全部帖子
     */
    public List<Post> getAllPosts(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return postDAO.findAll(offset, pageSize);
    }

    /**
     * 获取用户帖子
     */
    public List<Post> getUserPosts(Integer userId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return postDAO.findByUserId(userId, offset, pageSize);
    }

    /**
     * 删除帖子（级联删除关联的回复、附件、点赞）
     */
    public boolean deletePost(Integer postId) {
        Post post = postDAO.findById(postId);
        if (post != null) {
            // 1. 删除该帖子的回复
            replyDAO.deleteByPostId(postId);
            // 2. 删除该帖子的附件
            attachmentDAO.deleteByPostId(postId);
            // 3. 删除该帖子的点赞记录
            likeDAO.removeLikesByPostId(postId);
            // 4. 删除帖子
            boolean deleted = postDAO.delete(postId);
            if (deleted) {
                boardDAO.updatePostCount(post.getBoardId(), -1);
            }
            return deleted;
        }
        return false;
    }

    /**
     * 获取板块帖子数
     */
    public int getBoardPostCount(Integer boardId) {
        return postDAO.countByBoardId(boardId);
    }

    /**
     * 获取板块信息
     */
    public Board getBoardById(Integer boardId) {
        return boardDAO.findById(boardId);
    }
}