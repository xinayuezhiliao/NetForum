package com.netforum.service;

import com.netforum.dao.UserDAO;
import com.netforum.model.User;

/**
 * 用户服务层
 */
public class UserService {

    private UserDAO userDAO = new UserDAO();

    /**
     * 用户注册
     */
    public boolean register(String username, String password, String email, String avatar) {
        // 检查用户名是否已存在
        if (userDAO.findByUsername(username) != null) {
            return false;
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setAvatar(avatar);
        return userDAO.register(user);
    }

    /**
     * 用户登录
     */
    public User login(String username, String password) {
        return userDAO.login(username, password);
    }

    /**
     * 根据用户名查询
     */
    public User findByUsername(String username) {
        return userDAO.findByUsername(username);
    }

    /**
     * 根据ID查询
     */
    public User findById(Integer id) {
        return userDAO.findById(id);
    }

    /**
     * 更新用户信息
     */
    public boolean update(User user) {
        return userDAO.update(user);
    }

    /**
     * 修改密码
     */
    public boolean changePassword(Integer userId, String oldPassword, String newPassword) {
        User user = userDAO.findById(userId);
        if (user == null) return false;
        // 验证旧密码
        User loginUser = userDAO.login(user.getUsername(), oldPassword);
        if (loginUser == null) return false;
        return userDAO.changePassword(userId, newPassword);
    }
}