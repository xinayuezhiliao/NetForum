package com.netforum.model;

import java.sql.Timestamp;

/**
 * 用户模型
 */
public class User {
    private Integer id;
    private String username;
    private String password;
    private String email;
    private String avatar;
    private Integer role;       // 0=普通用户 1=管理员
    private Timestamp createTime;

    // 构造方法
    public User() {}

    public User(Integer id, String username, String password, String email,
                String avatar, Integer role, Timestamp createTime) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.avatar = avatar;
        this.role = role;
        this.createTime = createTime;
    }

    // Getter和Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public Integer getRole() { return role; }
    public void setRole(Integer role) { this.role = role; }

    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }

    public boolean isAdmin() {
        return role != null && role == 1;
    }
}