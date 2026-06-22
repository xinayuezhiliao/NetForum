package com.netforum.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.netforum.model.Reply;
import com.netforum.util.DBUtil;

/**
 * 回复DAO
 */
public class ReplyDAO {

    /**
     * 添加回复
     */
    public int create(Reply reply) {
        String sql = "INSERT INTO t_reply(content, user_id, post_id, quote_id, create_time) " +
                     "VALUES(?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, reply.getContent());
            ps.setInt(2, reply.getUserId());
            ps.setInt(3, reply.getPostId());
            if (reply.getQuoteId() != null && reply.getQuoteId() > 0) {
                ps.setInt(4, reply.getQuoteId());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
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
     * 查询帖子的所有回复（分页）
     */
    public List<Reply> findByPostId(Integer postId, int offset, int limit) {
        List<Reply> replies = new ArrayList<>();
        String sql = "SELECT r.*, u.username, u.avatar, " +
                     "q.content as quote_content, q.username as quote_username " +
                     "FROM t_reply r " +
                     "LEFT JOIN t_user u ON r.user_id = u.id " +
                     "LEFT JOIN (SELECT r2.id, r2.content, u2.username FROM t_reply r2 " +
                     "           LEFT JOIN t_user u2 ON r2.user_id = u2.id) q ON r.quote_id = q.id " +
                     "WHERE r.post_id=? " +
                     "ORDER BY r.create_time ASC " +
                     "LIMIT ? OFFSET ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            rs = ps.executeQuery();
            while (rs.next()) {
                replies.add(extractReply(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return replies;
    }

    /**
     * 查询回复详情
     */
    public Reply findById(Integer id) {
        String sql = "SELECT r.*, u.username, u.avatar, " +
                     "q.content as quote_content, q.username as quote_username " +
                     "FROM t_reply r " +
                     "LEFT JOIN t_user u ON r.user_id = u.id " +
                     "LEFT JOIN (SELECT r2.id, r2.content, u2.username FROM t_reply r2 " +
                     "           LEFT JOIN t_user u2 ON r2.user_id = u2.id) q ON r.quote_id = q.id " +
                     "WHERE r.id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return extractReply(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * 删除回复
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM t_reply WHERE id=?";
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
     * 删除帖子的全部回复
     */
    public boolean deleteByPostId(Integer postId) {
        String sql = "DELETE FROM t_reply WHERE post_id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            return ps.executeUpdate() >= 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 获取帖子回复总数
     */
    public int countByPostId(Integer postId) {
        String sql = "SELECT COUNT(*) FROM t_reply WHERE post_id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
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

    private Reply extractReply(ResultSet rs) throws SQLException {
        Reply reply = new Reply();
        reply.setId(rs.getInt("id"));
        reply.setContent(rs.getString("content"));
        reply.setUserId(rs.getInt("user_id"));
        reply.setUsername(rs.getString("username"));
        reply.setUserAvatar(rs.getString("avatar"));
        reply.setPostId(rs.getInt("post_id"));
        Integer quoteId = rs.getInt("quote_id");
        if (rs.wasNull()) {
            quoteId = null;
        }
        reply.setQuoteId(quoteId);
        reply.setQuoteContent(rs.getString("quote_content"));
        reply.setQuoteUsername(rs.getString("quote_username"));
        reply.setCreateTime(rs.getTimestamp("create_time"));
        return reply;
    }
}