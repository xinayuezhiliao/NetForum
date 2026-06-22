package com.netforum.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.netforum.model.Post;
import com.netforum.util.DBUtil;

/**
 * 帖子DAO
 */
public class PostDAO {

    /**
     * 创建帖子
     */
    public int create(Post post) {
        String sql = "INSERT INTO t_post(title, content, user_id, board_id, " +
                     "is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) " +
                     "VALUES(?, ?, ?, ?, ?, ?, 0, 0, 0, NOW(), NOW())";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getUserId());
            ps.setInt(4, post.getBoardId());
            ps.setInt(5, post.getIsTop() != null ? post.getIsTop() : 0);
            ps.setInt(6, post.getIsElite() != null ? post.getIsElite() : 0);
            ps.executeUpdate();
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return 0;
    }

    /**
     * 根据ID查询帖子
     */
    public Post findById(Integer id) {
        String sql = "SELECT p.*, u.username, u.avatar, b.name as board_name " +
                     "FROM t_post p " +
                     "LEFT JOIN t_user u ON p.user_id = u.id " +
                     "LEFT JOIN t_board b ON p.board_id = b.id " +
                     "WHERE p.id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return extractPost(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * 查询板块下的帖子（分页）
     */
    public List<Post> findByBoardId(Integer boardId, int offset, int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username, u.avatar, b.name as board_name " +
                     "FROM t_post p " +
                     "LEFT JOIN t_user u ON p.user_id = u.id " +
                     "LEFT JOIN t_board b ON p.board_id = b.id " +
                     "WHERE p.board_id=? " +
                     "ORDER BY p.is_top DESC, p.create_time DESC " +
                     "LIMIT ? OFFSET ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, boardId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(extractPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return posts;
    }

    /**
     * 获取全部帖子（分页）
     */
    public List<Post> findAll(int offset, int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username, u.avatar, b.name as board_name " +
                     "FROM t_post p " +
                     "LEFT JOIN t_user u ON p.user_id = u.id " +
                     "LEFT JOIN t_board b ON p.board_id = b.id " +
                     "ORDER BY p.is_top DESC, p.create_time DESC " +
                     "LIMIT ? OFFSET ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(extractPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return posts;
    }

    /**
     * 获取用户的帖子
     */
    public List<Post> findByUserId(Integer userId, int offset, int limit) {
        List<Post> posts = new ArrayList<>();
        String sql = "SELECT p.*, u.username, u.avatar, b.name as board_name " +
                     "FROM t_post p " +
                     "LEFT JOIN t_user u ON p.user_id = u.id " +
                     "LEFT JOIN t_board b ON p.board_id = b.id " +
                     "WHERE p.user_id=? " +
                     "ORDER BY p.create_time DESC " +
                     "LIMIT ? OFFSET ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
                posts.add(extractPost(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return posts;
    }

    /**
     * 更新浏览数
     */
    public boolean incrementViewCount(Integer postId) {
        String sql = "UPDATE t_post SET view_count = view_count + 1 WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 更新帖子标题与内容
     */
    public boolean update(Integer id, String title, String content) {
        String sql = "UPDATE t_post SET title=?, content=?, update_time=NOW() WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, content);
            ps.setInt(3, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 更新回复数
     */
    public boolean incrementReplyCount(Integer postId) {
        String sql = "UPDATE t_post SET reply_count = reply_count + 1, update_time=NOW() WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 更新点赞数
     */
    public boolean updateLikeCount(Integer postId, int delta) {
        String sql = "UPDATE t_post SET like_count = like_count + ? WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, delta);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 删除帖子
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM t_post WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 获取板块帖子总数
     */
    public int countByBoardId(Integer boardId) {
        String sql = "SELECT COUNT(*) FROM t_post WHERE board_id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, boardId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return 0;
    }

    private Post extractPost(ResultSet rs) throws SQLException {
        Post post = new Post();
        post.setId(rs.getInt("id"));
        post.setTitle(rs.getString("title"));
        post.setContent(rs.getString("content"));
        post.setUserId(rs.getInt("user_id"));
        post.setUsername(rs.getString("username"));
        post.setUserAvatar(rs.getString("avatar"));
        post.setBoardId(rs.getInt("board_id"));
        post.setBoardName(rs.getString("board_name"));
        post.setIsTop(rs.getInt("is_top"));
        post.setIsElite(rs.getInt("is_elite"));
        post.setViewCount(rs.getInt("view_count"));
        post.setReplyCount(rs.getInt("reply_count"));
        post.setLikeCount(rs.getInt("like_count"));
        post.setCreateTime(rs.getTimestamp("create_time"));
        post.setUpdateTime(rs.getTimestamp("update_time"));
        return post;
    }
}