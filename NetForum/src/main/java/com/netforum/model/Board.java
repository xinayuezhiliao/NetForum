package com.netforum.model;

import java.sql.Timestamp;

/**
 * 板块模型
 */
public class Board {
    private Integer id;
    private String name;
    private String description;
    private Integer postCount;
    private Timestamp createTime;

    // 构造方法
    public Board() {}

    public Board(Integer id, String name, String description, Integer postCount, Timestamp createTime) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.postCount = postCount;
        this.createTime = createTime;
    }

    // Getter和Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getPostCount() { return postCount; }
    public void setPostCount(Integer postCount) { this.postCount = postCount; }

    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }
}