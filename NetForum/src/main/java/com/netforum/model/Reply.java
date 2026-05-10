package com.netforum.model;

import java.sql.Timestamp;

/**
 * 回复模型
 */
public class Reply {
    private Integer id;
    private String content;
    private Integer userId;
    private String username;       // 回复用户名
    private String userAvatar;    // 回复用户头像
    private Integer postId;
    private Integer quoteId;      // 引用的回复ID
    private String quoteContent;   // 引用内容（冗余字段）
    private String quoteUsername;  // 引用用户名
    private Timestamp createTime;

    // 构造方法
    public Reply() {}

    // Getter和Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getUserAvatar() { return userAvatar; }
    public void setUserAvatar(String userAvatar) { this.userAvatar = userAvatar; }

    public Integer getPostId() { return postId; }
    public void setPostId(Integer postId) { this.postId = postId; }

    public Integer getQuoteId() { return quoteId; }
    public void setQuoteId(Integer quoteId) { this.quoteId = quoteId; }

    public String getQuoteContent() { return quoteContent; }
    public void setQuoteContent(String quoteContent) { this.quoteContent = quoteContent; }

    public String getQuoteUsername() { return quoteUsername; }
    public void setQuoteUsername(String quoteUsername) { this.quoteUsername = quoteUsername; }

    public Timestamp getCreateTime() { return createTime; }
    public void setCreateTime(Timestamp createTime) { this.createTime = createTime; }

    public boolean hasQuote() {
        return quoteId != null && quoteId > 0;
    }
}