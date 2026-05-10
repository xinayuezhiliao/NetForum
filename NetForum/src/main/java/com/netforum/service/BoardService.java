package com.netforum.service;

import com.netforum.dao.BoardDAO;
import com.netforum.model.Board;
import java.util.List;

/**
 * 板块服务层
 */
public class BoardService {

    private BoardDAO boardDAO = new BoardDAO();

    /**
     * 获取所有板块
     */
    public List<Board> getAllBoards() {
        return boardDAO.findAll();
    }

    /**
     * 根据ID获取板块
     */
    public Board getBoardById(Integer id) {
        return boardDAO.findById(id);
    }

    /**
     * 创建板块
     */
    public boolean createBoard(String name, String description) {
        Board board = new Board();
        board.setName(name);
        board.setDescription(description);
        return boardDAO.create(board);
    }

    /**
     * 更新板块帖子数
     */
    public void updatePostCount(Integer boardId, int delta) {
        boardDAO.updatePostCount(boardId, delta);
    }

    /**
     * 删除板块
     */
    public boolean deleteBoard(Integer id) {
        return boardDAO.delete(id);
    }
}