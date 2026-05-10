package com.netforum.dao;

import java.sql.*;
import com.netforum.util.DBUtil;

/**
 * 点赞DAO
 */
public class LikeDAO {

    /**
     * 检查用户是否已点赞
     */
    public boolean hasLiked(Integer userId, Integer postId) {
        String sql = "SELECT COUNT(*) FROM t_like WHERE user_id=? AND post_id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, postId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return false;
    }

    /**
     * 添加点赞
     */
    public boolean addLike(Integer userId, Integer postId) {
        String sql = "INSERT INTO t_like (user_id, post_id) VALUES (?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, postId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            // 重复点赞会抛异常，返回false
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 取消点赞
     */
    public boolean removeLike(Integer userId, Integer postId) {
        String sql = "DELETE FROM t_like WHERE user_id=? AND post_id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
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
     * 删除帖子的所有点赞记录
     */
    public boolean removeLikesByPostId(Integer postId) {
        String sql = "DELETE FROM t_like WHERE post_id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }
}
