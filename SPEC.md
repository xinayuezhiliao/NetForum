# 网上论坛系统 - 项目规格说明书

## 1. 项目概述

**项目名称：** NetForum（网上论坛系统）

**项目类型：** JavaWeb 应用程序（Servlet + JSP + JDBC）

**核心功能：** 用户注册登录、板块管理、发帖回帖、文件上传下载、异步交互

**目标用户：** 普通网民，用于日常发帖交流

---

## 2. 功能模块

### 2.1 用户模块

| 功能 | 说明 |
|------|------|
| 用户注册 | 填写用户名、密码、邮箱、头像（非必需） |
| 用户登录 | 用户名+密码登录，Session 跟踪会话 |
| 用户登出 | 销毁 Session |
| 个人中心 | 查看个人信息、修改资料 |

### 2.2 板块模块

| 功能 | 说明 |
|------|------|
| 板块列表 | 首页展示所有板块及帖子统计 |
| 板块详情 | 查看板块下所有帖子（分页） |
| 板块创建 | 管理员创建新板块 |

### 2.3 帖子模块

| 功能 | 说明 |
|------|------|
| 发帖 | 标题 + 内容，支持富文本，支持上传附件 |
| 帖子列表 | 分页展示，支持按最新/最热排序 |
| 帖子详情 | 展示帖子内容 + 回复列表 |
| 帖子删除 | 作者或管理员删除 |
| 点赞 | Ajax 异步点赞 |

### 2.4 回帖模块

| 功能 | 说明 |
|------|------|
| 回帖/回复 | 对帖子进行回复，支持嵌套引用 |
| 回帖删除 | 作者或管理员删除 |
| 无刷新回帖 | Ajax 异步提交，回帖后页面无刷新追加 |

### 2.5 文件上传/下载

| 功能 | 说明 |
|------|------|
| 用户头像上传 | 头像上传，支持 jpg/png/gif |
| 附件上传 | 发帖时上传附件，存储到服务器 |
| 附件下载 | 点击附件名称下载 |

---

## 3. 技术架构

### 3.1 MVC 架构

```
视图层(JSP) → 控制层(Servlet) → 业务层(Service) → 数据层(DAO) → 数据库(MySQL)
```

### 3.2 核心组件

| 组件 | 实现 |
|------|------|
| Servlet 控制层 | UserServlet, PostServlet, ReplyServlet, BoardServlet |
| Filter 过滤器 | LoginFilter(登录过滤), EncodingFilter(字符编码) |
| Listener 监听器 | OnlineUserListener(Session在线统计) |
| JavaBean 模型 | User, Board, Post, Reply |
| DAO 层 | UserDAO, BoardDAO, PostDAO, ReplyDAO |
| DB 工具类 | DBUtil（JDBC 连接池） |

### 3.3 前端技术

| 技术 | 用途 |
|------|------|
| HTML/CSS/JavaScript | 页面构建 |
| Ajax + JSON | 异步交互 |
| JSTL + EL | JSP 动态渲染 |

---

## 4. 数据库设计

### 4.1 数据表

**用户表 (t_user)**

| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT (PK, AUTO) | 用户ID |
| username | VARCHAR(50) | 用户名（唯一） |
| password | VARCHAR(128) | 密码（MD5加密存储） |
| email | VARCHAR(100) | 邮箱 |
| avatar | VARCHAR(255) | 头像路径 |
| role | INT | 0=普通用户 1=管理员 |
| create_time | DATETIME | 注册时间 |

**板块表 (t_board)**

| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT (PK, AUTO) | 板块ID |
| name | VARCHAR(100) | 板块名称 |
| description | VARCHAR(500) | 板块描述 |
| post_count | INT | 帖子数量 |
| create_time | DATETIME | 创建时间 |

**帖子表 (t_post)**

| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT (PK, AUTO) | 帖子ID |
| title | VARCHAR(200) | 帖子标题 |
| content | TEXT | 帖子内容 |
| user_id | INT (FK) | 发帖用户ID |
| board_id | INT (FK) | 所属板块ID |
| is_top | INT | 0=普通 1=置顶 |
| is_elite | INT | 0=普通 1=精华 |
| view_count | INT | 浏览数 |
| reply_count | INT | 回复数 |
| like_count | INT | 点赞数 |
| create_time | DATETIME | 发布时间 |
| update_time | DATETIME | 更新时间 |

**回复表 (t_reply)**

| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT (PK, AUTO) | 回复ID |
| content | TEXT | 回复内容 |
| user_id | INT (FK) | 回复用户ID |
| post_id | INT (FK) | 所属帖子ID |
| quote_id | INT | 引用的回复ID（可空） |
| create_time | DATETIME | 回复时间 |

**附件表 (t_attachment)**

| 字段 | 类型 | 说明 |
|------|------|------|
| id | INT (PK, AUTO) | 附件ID |
| file_name | VARCHAR(255) | 原始文件名 |
| file_path | VARCHAR(255) | 存储路径 |
| file_size | BIGINT | 文件大小 |
| user_id | INT (FK) | 上传用户ID |
| post_id | INT (FK) | 关联帖子ID |
| create_time | DATETIME | 上传时间 |

---

## 5. 页面结构

```
pages/
├── index.jsp              # 首页（板块列表）
├── user/                  # 用户模块
│   ├── register.jsp       # 注册页
│   ├── login.jsp          # 登录页
│   └── profile.jsp        # 个人中心
├── board/                 # 板块模块
│   ├── board.jsp          # 板块内帖子列表
│   └── create_board.jsp   # 创建板块
├── post/                  # 帖子模块
│   ├── post.jsp           # 帖子详情
│   ├── create_post.jsp    # 发帖页
│   └── edit_post.jsp      # 编辑帖子
└── common/                # 公共组件
    ├── header.jsp         # 公共头部
    └── footer.jsp         # 公共尾部
```

---

## 6. 实现时间估算

| 阶段 | 内容 | 预计时间 |
|------|------|----------|
| 阶段1 | 项目搭建 + 数据库设计 + DBUtil | 2h |
| 阶段2 | 用户模块（注册/登录/Session） | 3h |
| 阶段3 | 板块模块（列表/创建） | 2h |
| 阶段4 | 帖子模块（发帖/列表/详情） | 4h |
| 阶段5 | 回帖模块（回复/异步） | 3h |
| 阶段6 | 文件上传/下载 | 2h |
| 阶段7 | 过滤器/监听器 | 1.5h |
| 阶段8 | Ajax 增强体验 | 2h |
| 阶段9 | 整合测试 + 报告整理 | 2.5h |
| **合计** | | **约 22h** |

---

## 7. 验收标准

- [x] 用户可以注册、登录、登出
- [x] Session 正确跟踪用户状态
- [x] 板块正常显示，发帖功能正常
- [x] 回帖功能正常，支持无刷新提交
- [x] 文件上传下载正常
- [x] 过滤器正确拦截未登录用户
- [x] 在线人数监听器正常统计
- [x] 数据库 CRUD 操作完整
- [x] 页面无明显样式问题
- [x] 报告文档完整