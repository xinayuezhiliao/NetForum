package com.netforum.model;

import java.sql.Timestamp;

/**
 * 帖子模型
 */
public class Post {
    private Integer id;
    private String title;
    private String content;
    private Integer userId;
    private String username;       // 发帖用户名（冗余字段，便于展示）
    private String userAvatar;     // 发帖用户头像
    private Integer boardId;
    private String boardName;      // 板块名称
    private Integer isTop;         // 0=普通 1=置顶
    private Integer isElite;       // 0=普通 1=精华
    private Integer viewCount;
    private Integer replyCount;
    private Integer likeCount;
    private Timestamp createTime;
    private Timestamp updateTime;

    // 构造方法
    public Post() {}

    // Getter和Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getUserAvatar() { return userAvatar; }
    public void setUserAvatar(String userAvatar) { this.userAvatar = userAvatar; }

    public Integer getBoardId() { return boardId; }
    public void setBoardId(Integer boardId) { this.boardId = boardId; }

    public String getBoardName() { return boardName; }
    public void setBoardName(String boardName) { this.boardName = boardName; }

    public Integer getIsTop() { return isTop; }
    public void setIsTop(Integer isTop) { this.isTop = isTop; }

    public Integer getIsElite() { return isElite; }
    public void setIsElite(Integer isElite) { this.isElite = isElite; }

    public Integer getViewCount() { return viewCount; }
    public void setViewCount(Integer viewCount) { this.viewCount = viewCount; }

    public Integer getReplyCount() { return replyCount; }
    public void setReplyCount(Integer replyCount) { this.replyCount = replyCount; }

    public Integer getLikeCount() { return likeCount; }
    public void setLikeCount(Integer likeCount) { this.likeCount = likeCount; }

    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }

    public Timestamp getUpdateTime() { return updateTime; }
    public void setUpdateTime(Timestamp updateTime) { this.updateTime = updateTime; }

    public boolean isTop() { return isTop != null && isTop == 1; }
    public boolean isElite() { return isElite != null && isElite == 1; }
}