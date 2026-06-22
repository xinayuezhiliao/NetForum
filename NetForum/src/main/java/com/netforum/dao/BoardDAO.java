package com.netforum.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.netforum.model.Board;
import com.netforum.util.DBUtil;

/**
 * 板块DAO
 */
public class BoardDAO {

    /**
     * 获取所有板块
     */
    public List<Board> findAll() {
        List<Board> boards = new ArrayList<>();
        String sql = "SELECT b.*, COUNT(p.id) as real_post_count " +
                     "FROM t_board b " +
                     "LEFT JOIN t_post p ON b.id = p.board_id " +
                     "GROUP BY b.id " +
                     "ORDER BY b.create_time DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Board board = extractBoard(rs);
                board.setPostCount(rs.getInt("real_post_count"));
                boards.add(board);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return boards;
    }

    /**
     * 根据ID查询板块
     */
    public Board findById(Integer id) {
        String sql = "SELECT * FROM t_board WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return extractBoard(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, ps, rs);
        }
        return null;
    }

    /**
     * 创建板块
     */
    public boolean create(Board board) {
        String sql = "INSERT INTO t_board(name, description, post_count, create_time) " +
                     "VALUES(?, ?, 0, NOW())";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, board.getName());
            ps.setString(2, board.getDescription());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 更新板块帖子数
     */
    public boolean updatePostCount(Integer boardId, int delta) {
        String sql = "UPDATE t_board SET post_count = post_count + ? WHERE id=?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, delta);
            ps.setInt(2, boardId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBUtil.close(conn, ps);
        }
    }

    /**
     * 删除板块
     */
    public boolean delete(Integer id) {
        String sql = "DELETE FROM t_board WHERE id=?";
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

    private Board extractBoard(ResultSet rs) throws SQLException {
        Board board = new Board();
        board.setId(rs.getInt("id"));
        board.setName(rs.getString("name"));
        board.setDescription(rs.getString("description"));
        board.setPostCount(rs.getInt("post_count"));
        board.setCreateTime(rs.getTimestamp("create_time"));
        return board;
    }
}