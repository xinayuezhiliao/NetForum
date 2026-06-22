package com.netforum.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.netforum.model.Attachment;
import com.netforum.util.DBUtil;

/**
 * 附件DAO
 */
public class AttachmentDAO {

    /**
     * 添加附件记录
     */
    public int create(Attachment attachment) {
        String sql = "INSERT INTO t_attachment(file_name, file_path, file_size, user_id, post_id, create_time) " +
                     "VALUES(?, ?, ?, ?, ?, NOW())";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, attachment.getFileName());
            ps.setString(2, attachment.getFilePath());
            ps.setLong(3, attachment.getFileSize());
            ps.setInt(4, attachment.getUserId());
            if (attachment.getPostId() != null) {
                ps.setInt(5, attachment.getPostId());
            } else {
                ps.setNull(5, Types.INTEGER);
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
     * 查询帖子的附件
     */
    public List<Attachment> findByPostId(Integer postId) {
        List<Attachment> attachments = new ArrayList<>();
        String sql = "SELECT * FROM t_attachment WHERE post_id=? ORDER BY create_time DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, postId);
            rs = ps.executeQuery();
            while (rs.next()) {
                attachments.add(extractAttachment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return attachments;
    }

    /**
     * 根据ID查询附件
     */
    public Attachment findById(Integer id) {
        String sql = "SELECT * FROM t_attachment WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return extractAttachment(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * 删除附件
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM t_attachment WHERE id=?";
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
     * 删除帖子的全部附件
     */
    public boolean deleteByPostId(Integer postId) {
        String sql = "DELETE FROM t_attachment WHERE post_id=?";
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

    private Attachment extractAttachment(ResultSet rs) throws SQLException {
        Attachment att = new Attachment();
        att.setId(rs.getInt("id"));
        att.setFileName(rs.getString("file_name"));
        att.setFilePath(rs.getString("file_path"));
        att.setFileSize(rs.getLong("file_size"));
        att.setUserId(rs.getInt("user_id"));
        Integer postId = rs.getInt("post_id");
        if (rs.wasNull()) {
            postId = null;
        }
        att.setPostId(postId);
        att.setCreateTime(rs.getTimestamp("create_time"));
        return att;
    }
}