-- NetForum 数据库初始化脚本

-- 创建数据库
CREATE DATABASE IF NOT EXISTS netforum DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE netforum;

-- 1. 用户表
CREATE TABLE IF NOT EXISTS t_user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(128) NOT NULL COMMENT '密码(MD5)',
    email VARCHAR(100) COMMENT '邮箱',
    avatar VARCHAR(255) COMMENT '头像路径',
    role INT DEFAULT 0 COMMENT '角色:0=普通用户,1=管理员',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 2. 板块表
CREATE TABLE IF NOT EXISTS t_board (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT '板块名称',
    description VARCHAR(500) COMMENT '板块描述',
    post_count INT DEFAULT 0 COMMENT '帖子数量',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='板块表';

-- 3. 帖子表
CREATE TABLE IF NOT EXISTS t_post (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL COMMENT '帖子标题',
    content TEXT NOT NULL COMMENT '帖子内容',
    user_id INT NOT NULL COMMENT '发帖用户ID',
    board_id INT NOT NULL COMMENT '所属板块ID',
    is_top INT DEFAULT 0 COMMENT '是否置顶:0=否,1=是',
    is_elite INT DEFAULT 0 COMMENT '是否精华:0=否,1=是',
    view_count INT DEFAULT 0 COMMENT '浏览数',
    reply_count INT DEFAULT 0 COMMENT '回复数',
    like_count INT DEFAULT 0 COMMENT '点赞数',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    INDEX idx_board (board_id),
    INDEX idx_user (user_id),
    INDEX idx_create_time (create_time),
    FOREIGN KEY (user_id) REFERENCES t_user(id),
    FOREIGN KEY (board_id) REFERENCES t_board(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='帖子表';

-- 4. 回复表
CREATE TABLE IF NOT EXISTS t_reply (
    id INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT NOT NULL COMMENT '回复内容',
    user_id INT NOT NULL COMMENT '回复用户ID',
    post_id INT NOT NULL COMMENT '所属帖子ID',
    quote_id INT COMMENT '引用的回复ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '回复时间',
    INDEX idx_post (post_id),
    INDEX idx_user (user_id),
    FOREIGN KEY (user_id) REFERENCES t_user(id),
    FOREIGN KEY (post_id) REFERENCES t_post(id),
    FOREIGN KEY (quote_id) REFERENCES t_reply(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='回复表';

-- 5. 附件表
CREATE TABLE IF NOT EXISTS t_attachment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    file_name VARCHAR(255) NOT NULL COMMENT '原始文件名',
    file_path VARCHAR(255) NOT NULL COMMENT '存储路径',
    file_size BIGINT COMMENT '文件大小',
    user_id INT COMMENT '上传用户ID',
    post_id INT COMMENT '关联帖子ID',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
    INDEX idx_post (post_id),
    FOREIGN KEY (user_id) REFERENCES t_user(id),
    FOREIGN KEY (post_id) REFERENCES t_post(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='附件表';

-- 初始数据：创建管理员账号 (密码: admin123)
INSERT INTO t_user (username, password, email, role) VALUES 
('admin', '0192023a7bbd73250516f069df18b500', 'admin@example.com', 1);

-- 初始数据：创建默认板块
INSERT INTO t_board (name, description) VALUES 
('技术交流', '编程语言、开发框架、工具使用等技术的讨论'),
('生活休闲', '日常生活、兴趣爱好、旅行分享'),
('职场人生', '职业发展、工作经验、职场感悟'),
('反馈建议', '功能反馈、问题报告、产品建议');

-- 初始数据：创建测试帖子 (板块1, 管理员)
INSERT INTO t_post (title, content, user_id, board_id) VALUES 
('欢迎来到NetForum！', '欢迎大家来到网上论坛系统！\n\n这里可以讨论技术、分享生活、交流心得。\n\n请遵守论坛规则，文明发言。', 1, 1),
('JavaWeb学习指南', '整理了一份JavaWeb学习路线，适合初学者参考：\n\n1. HTML/CSS/JS基础\n2. Servlet/JSP\n3. JDBC数据库操作\n4. Spring/Hibernate框架\n5. 项目实战\n\n欢迎补充！', 1, 1);

-- 初始数据：创建测试回帖
INSERT INTO t_reply (content, user_id, post_id) VALUES 
('论坛建设得不错，点赞！', 1, 1),
('很全面的学习路线，感谢分享！', 1, 2);