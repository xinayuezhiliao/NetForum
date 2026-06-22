-- NetForum 种子数据 — 10 用户 + 209 论坛数据
-- 生成时间: 2026-06-14

USE netforum;
SET NAMES utf8mb4;

-- ============ 1. 用户（8 个新普通用户）============
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (3, '林书白', 'e10adc3949ba59abbe56e057f20f883e', 'linshubai@example.com', '/upload/avatar/avatar_3.jpg', 0, '2026-04-25 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (4, '苏沐之', 'e10adc3949ba59abbe56e057f20f883e', 'sumuzhi@example.com', '/upload/avatar/avatar_4.jpg', 0, '2026-06-03 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (5, '周怀瑾', 'e10adc3949ba59abbe56e057f20f883e', 'zhouhuaijin@example.com', '/upload/avatar/avatar_5.jpg', 0, '2026-05-08 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (6, '青山客', 'e10adc3949ba59abbe56e057f20f883e', 'qingshanke@example.com', '/upload/avatar/avatar_6.jpg', 0, '2026-06-03 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (7, '云在青天', 'e10adc3949ba59abbe56e057f20f883e', 'yunzaitian@example.com', '/upload/avatar/avatar_7.jpg', 0, '2026-05-28 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (8, '何九潇', 'e10adc3949ba59abbe56e057f20f883e', 'hejiuxiao@example.com', '/upload/avatar/avatar_8.jpg', 0, '2026-04-20 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (9, '江雪残', 'e10adc3949ba59abbe56e057f20f883e', 'jiangxuecan@example.com', '/upload/avatar/avatar_9.jpg', 0, '2026-05-09 10:00:00');
INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES (10, '柳青衣', 'e10adc3949ba59abbe56e057f20f883e', 'liuqingyi@example.com', '/upload/avatar/avatar_10.jpg', 0, '2026-05-21 10:00:00');

-- ============ 2. 帖子（30 个，分布 4 版块）============
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (4, '从技术转产品的 90 天', '待过两家公司，面试过 50+ 候选人，聊聊我的真实感受。

首先，技术能力只是入场券。
我见过太多技术面很硬的人，进组之后完全推不动项目。

我比较看重的几样：
1. **能不能把复杂问题说清楚**——让他解释一个他做过的项目，3 分钟内能不能讲明白背景、难点、自己的贡献
2. **遇到不懂的会不会直接说**——比硬编一个答案好得多
3. **代码之外有没有好奇心**——读过什么书、对行业有没有看法

技术 leader 这个岗位，技术只是底盘。', 5, 3, 0, 0, 0, 0, 0, '2026-05-14 14:00:00', '2026-05-14 14:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (5, '从单体到微服务：一年实践复盘', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 3, 1, 0, 0, 0, 0, 0, '2026-06-10 18:00:00', '2026-06-10 18:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (6, '关于分布式锁的几点思考', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 4, 1, 0, 0, 0, 0, 0, '2026-05-16 16:00:00', '2026-05-16 16:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (7, '搜索功能太弱了', '新版本上线后用了几天，整体很赞，编辑感很强！

但有几个小建议：
- 草稿自动保存真的很重要，写到一半电脑死机就要哭
- 希望能加个深色模式，晚上写东西不刺眼
- 移动端发帖体验一般，输入框太小

期待越来越好！', 7, 4, 0, 0, 0, 0, 0, '2026-05-20 16:00:00', '2026-05-20 16:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (8, '为什么我们团队放弃了 Lombok', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 7, 1, 1, 1, 0, 0, 0, '2026-05-20 15:00:00', '2026-05-20 15:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (9, '一个下雨天的下午', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 5, 2, 0, 0, 0, 0, 0, '2026-05-19 19:00:00', '2026-05-19 19:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (10, '附件能不能支持文件夹上传', '新版本上线后用了几天，整体很赞，编辑感很强！

但有几个小建议：
- 草稿自动保存真的很重要，写到一半电脑死机就要哭
- 希望能加个深色模式，晚上写东西不刺眼
- 移动端发帖体验一般，输入框太小

期待越来越好！', 3, 4, 1, 0, 0, 0, 0, '2026-06-02 01:00:00', '2026-06-02 01:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (11, '做了三年程序员，最大的变化是什么', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 3, 2, 0, 0, 0, 0, 0, '2026-06-11 19:00:00', '2026-06-11 19:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (12, '重读《活着》：二十岁和三十岁不同', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 7, 2, 0, 1, 0, 0, 0, '2026-05-22 16:00:00', '2026-05-22 16:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (13, '关于搬家：独居生活指南', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 3, 2, 0, 0, 0, 0, 0, '2026-06-08 09:00:00', '2026-06-08 09:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (14, '一次 JVM 调优实战：GC 优化 30%', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 7, 1, 0, 0, 0, 0, 0, '2026-05-20 14:00:00', '2026-05-20 14:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (15, '新版 UI 好看但有点不习惯', '新版本上线后用了几天，整体很赞，编辑感很强！

但有几个小建议：
- 草稿自动保存真的很重要，写到一半电脑死机就要哭
- 希望能加个深色模式，晚上写东西不刺眼
- 移动端发帖体验一般，输入框太小

期待越来越好！', 7, 4, 0, 0, 0, 0, 0, '2026-05-15 08:00:00', '2026-05-15 08:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (16, '跳槽前你需要想清楚的 3 件事', '待过两家公司，面试过 50+ 候选人，聊聊我的真实感受。

首先，技术能力只是入场券。
我见过太多技术面很硬的人，进组之后完全推不动项目。

我比较看重的几样：
1. **能不能把复杂问题说清楚**——让他解释一个他做过的项目，3 分钟内能不能讲明白背景、难点、自己的贡献
2. **遇到不懂的会不会直接说**——比硬编一个答案好得多
3. **代码之外有没有好奇心**——读过什么书、对行业有没有看法

技术 leader 这个岗位，技术只是底盘。', 7, 3, 0, 0, 0, 0, 0, '2026-06-09 20:00:00', '2026-06-09 20:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (17, '评论能不能加 @ 提醒', '新版本上线后用了几天，整体很赞，编辑感很强！

但有几个小建议：
- 草稿自动保存真的很重要，写到一半电脑死机就要哭
- 希望能加个深色模式，晚上写东西不刺眼
- 移动端发帖体验一般，输入框太小

期待越来越好！', 7, 4, 0, 0, 0, 0, 0, '2026-05-30 09:00:00', '2026-05-30 09:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (18, '2026 上半年观影清单', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 5, 2, 0, 0, 0, 0, 0, '2026-05-16 13:00:00', '2026-05-16 13:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (19, 'Tomcat 连接池调参经验总结', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 7, 1, 0, 1, 0, 0, 0, '2026-06-10 06:00:00', '2026-06-10 06:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (20, '向上管理：怎么跟老板有效沟通', '待过两家公司，面试过 50+ 候选人，聊聊我的真实感受。

首先，技术能力只是入场券。
我见过太多技术面很硬的人，进组之后完全推不动项目。

我比较看重的几样：
1. **能不能把复杂问题说清楚**——让他解释一个他做过的项目，3 分钟内能不能讲明白背景、难点、自己的贡献
2. **遇到不懂的会不会直接说**——比硬编一个答案好得多
3. **代码之外有没有好奇心**——读过什么书、对行业有没有看法

技术 leader 这个岗位，技术只是底盘。', 4, 3, 0, 0, 0, 0, 0, '2026-06-05 18:00:00', '2026-06-05 18:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (21, '咖啡馆常去的 5 家小店', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 5, 2, 1, 0, 0, 0, 0, '2026-06-03 07:00:00', '2026-06-03 07:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (22, '聊聊我理解的微服务拆分粒度', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 5, 1, 0, 0, 0, 0, 0, '2026-06-01 19:00:00', '2026-06-01 19:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (23, '茶与咖啡：成年人的两难', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 6, 2, 0, 0, 0, 0, 0, '2026-05-15 00:00:00', '2026-05-15 00:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (24, 'Spring Boot 配置项加密的三种姿势', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 7, 1, 1, 0, 0, 0, 0, '2026-06-13 20:00:00', '2026-06-13 20:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (25, 'RESTful API 设计的 5 个常见误区', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 7, 1, 0, 0, 0, 0, 0, '2026-06-08 11:00:00', '2026-06-08 11:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (26, '被裁员后我的 30 天', '待过两家公司，面试过 50+ 候选人，聊聊我的真实感受。

首先，技术能力只是入场券。
我见过太多技术面很硬的人，进组之后完全推不动项目。

我比较看重的几样：
1. **能不能把复杂问题说清楚**——让他解释一个他做过的项目，3 分钟内能不能讲明白背景、难点、自己的贡献
2. **遇到不懂的会不会直接说**——比硬编一个答案好得多
3. **代码之外有没有好奇心**——读过什么书、对行业有没有看法

技术 leader 这个岗位，技术只是底盘。', 3, 3, 0, 0, 0, 0, 0, '2026-06-05 09:00:00', '2026-06-05 09:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (27, 'Maven 多模块项目的最佳实践', '最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？', 7, 1, 0, 0, 0, 0, 0, '2026-05-18 03:00:00', '2026-05-18 03:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (28, '城市散步：那些被忽略的小路', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 7, 2, 0, 0, 0, 0, 0, '2026-05-30 02:00:00', '2026-05-30 02:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (29, '希望支持 Markdown 全文', '新版本上线后用了几天，整体很赞，编辑感很强！

但有几个小建议：
- 草稿自动保存真的很重要，写到一半电脑死机就要哭
- 希望能加个深色模式，晚上写东西不刺眼
- 移动端发帖体验一般，输入框太小

期待越来越好！', 5, 4, 0, 0, 0, 0, 0, '2026-06-09 19:00:00', '2026-06-09 19:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (30, '为什么开始写手帐', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 3, 2, 0, 1, 0, 0, 0, '2026-06-08 15:00:00', '2026-06-08 15:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (31, '聊聊我的极简生活尝试', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 7, 2, 1, 0, 0, 0, 0, '2026-06-12 08:00:00', '2026-06-12 08:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (32, '推荐几本我反复读过的书', '周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。', 2, 2, 0, 0, 0, 0, 0, '2026-06-01 13:00:00', '2026-06-01 13:00:00');
INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, view_count, reply_count, like_count, create_time, update_time) VALUES (33, '我为什么拒绝了一份高薪 offer', '待过两家公司，面试过 50+ 候选人，聊聊我的真实感受。

首先，技术能力只是入场券。
我见过太多技术面很硬的人，进组之后完全推不动项目。

我比较看重的几样：
1. **能不能把复杂问题说清楚**——让他解释一个他做过的项目，3 分钟内能不能讲明白背景、难点、自己的贡献
2. **遇到不懂的会不会直接说**——比硬编一个答案好得多
3. **代码之外有没有好奇心**——读过什么书、对行业有没有看法

技术 leader 这个岗位，技术只是底盘。', 1, 3, 0, 0, 0, 0, 0, '2026-05-15 12:00:00', '2026-05-15 12:00:00');

-- ============ 3. 回复（120 个）============
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (3, '被裁那天反而松了一口气，可能是潜意识里早就想走了。', 8, 20, '2026-06-06 07:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (4, '记一次诡异的 NPE —— 我们遇到过类似问题，最后发现是 thread local 没清理。', 2, 1, '2026-06-14 04:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (5, '茶和咖啡我都喝，但晚上只喝茶。咖啡因代谢慢真的会影响睡眠。', 7, 12, '2026-06-11 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (6, '技术转产品最难的，是从''解决问题''转向''发现值得解决的问题''。', 7, 33, '2026-05-16 23:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (7, '移动端优化很需要，手机端发帖体验确实差。', 6, 29, '2026-05-20 15:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (8, '这个我们项目也遇到过，后来是这么解决的：把粒度控制在子域级别，不要一上来就追求''完美的微服务''。', 3, 1, '2026-06-08 19:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (9, '同意楼主观点，A 股技术 leader 真的不能只会写代码。', 4, 1, '2026-06-08 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (10, '手帐的本质是跟自己对话，不是为了给别人看。', 8, 23, '2026-06-09 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (11, '推荐《最好的告别》《当呼吸化为空气》，重塑对生死的看法。', 8, 23, '2026-05-28 01:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (12, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 10, 1, '2026-06-04 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (13, '一个人住最大的好处是安静，最大的坏处也是安静。', 5, 3, '2026-05-19 11:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (14, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 7, 24, '2026-06-02 14:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (15, 'DDD 看着美好，落地很重。楼主能展开讲讲你们的''子域''是怎么切的吗？', 5, 1, '2026-06-05 17:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (16, '推荐《最好的告别》《当呼吸化为空气》，重塑对生死的看法。', 6, 9, '2026-06-08 19:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (17, '手帐的本质是跟自己对话，不是为了给别人看。', 6, 31, '2026-05-27 09:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (18, 'Lombok 真的是个坑，团队新人的 IDE 配置五花八门，调试时各种诡异。', 2, 8, '2026-06-02 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (19, '番茄牛腩最重要的是要炒糖色，小火慢炖 2 小时。', 7, 18, '2026-06-08 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (20, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 1, 19, '2026-05-19 02:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (21, 'Lombok 真的是个坑，团队新人的 IDE 配置五花八门，调试时各种诡异。', 10, 2, '2026-06-05 04:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (22, '无图模式 +1，省流量。', 8, 17, '2026-05-21 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (23, '创业一年，最大的教训是：不要用爱发电，所有东西都要算账。', 2, 20, '2026-06-04 02:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (24, '番茄牛腩最重要的是要炒糖色，小火慢炖 2 小时。', 2, 9, '2026-06-11 15:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (25, '+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。', 9, 7, '2026-05-24 01:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (26, '读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。', 6, 12, '2026-05-19 09:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (27, 'Markdown 全文支持，开发者刚需。', 1, 7, '2026-06-07 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (28, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 8, 24, '2026-05-16 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (29, '这个我们项目也遇到过，后来是这么解决的：把粒度控制在子域级别，不要一上来就追求''完美的微服务''。', 7, 2, '2026-06-12 19:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (30, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 6, 27, '2026-05-18 11:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (31, 'DDD 看着美好，落地很重。楼主能展开讲讲你们的''子域''是怎么切的吗？', 9, 6, '2026-06-11 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (32, '我们最后也是放弃了 GraphQL，最大的问题是 N+1 和缓存失效难以处理。', 6, 27, '2026-05-27 01:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (33, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 1, 1, '2026-05-18 10:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (34, 'DDD 看着美好，落地很重。楼主能展开讲讲你们的''子域''是怎么切的吗？', 6, 22, '2026-05-24 09:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (35, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 1, 6, '2026-06-06 20:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (36, 'JVM 调优那块写得不错。G1 在大堆场景下确实比 CMS 稳得多，但停顿时间要降到 50ms 以下还得调参。', 4, 2, '2026-05-17 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (37, '极简生活第三年，最大的感受是：少买反而更快乐。', 1, 23, '2026-05-26 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (38, '我们最后也是放弃了 GraphQL，最大的问题是 N+1 和缓存失效难以处理。', 8, 2, '2026-06-13 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (39, '+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。', 3, 15, '2026-06-04 22:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (40, '记一次诡异的 NPE —— 我们遇到过类似问题，最后发现是 thread local 没清理。', 10, 1, '2026-06-07 07:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (41, '西山的雾真的绝，有机会我也去一次。', 8, 3, '2026-05-22 02:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (42, '+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。', 8, 10, '2026-05-25 03:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (43, '茶和咖啡我都喝，但晚上只喝茶。咖啡因代谢慢真的会影响睡眠。', 10, 11, '2026-06-01 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (44, '番茄牛腩最重要的是要炒糖色，小火慢炖 2 小时。', 1, 13, '2026-05-23 14:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (45, 'Lombok 真的是个坑，团队新人的 IDE 配置五花八门，调试时各种诡异。', 7, 2, '2026-06-05 02:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (46, '手帐的本质是跟自己对话，不是为了给别人看。', 10, 30, '2026-05-31 23:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (47, '播客推荐：''文化有限''、''纵横四海''、''日谈公园''，各有各的味道。', 9, 3, '2026-06-10 10:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (48, '茶和咖啡我都喝，但晚上只喝茶。咖啡因代谢慢真的会影响睡眠。', 9, 13, '2026-06-06 08:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (49, '记一次诡异的 NPE —— 我们遇到过类似问题，最后发现是 thread local 没清理。', 10, 25, '2026-06-12 10:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (50, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 9, 1, '2026-05-17 07:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (51, '同意楼主观点，A 股技术 leader 真的不能只会写代码。', 10, 1, '2026-05-25 20:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (52, 'code review 不是找 bug，是传递上下文。新人从这个过程学到最多。', 7, 16, '2026-05-27 02:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (53, 'P5 到 P7 不只是技术深度，是''能独立负责一个方向''的能力。', 2, 4, '2026-06-04 19:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (54, '极简生活第三年，最大的感受是：少买反而更快乐。', 4, 3, '2026-06-06 23:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (55, '+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。', 5, 29, '2026-06-01 23:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (56, '茶和咖啡我都喝，但晚上只喝茶。咖啡因代谢慢真的会影响睡眠。', 2, 32, '2026-06-03 14:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (57, '被裁那天反而松了一口气，可能是潜意识里早就想走了。', 3, 26, '2026-06-07 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (58, '同意楼主观点，A 股技术 leader 真的不能只会写代码。', 1, 1, '2026-06-02 04:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (59, '播客推荐：''文化有限''、''纵横四海''、''日谈公园''，各有各的味道。', 7, 31, '2026-05-22 05:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (60, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 8, 2, '2026-05-17 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (61, 'Maven 多模块 + Spring Boot Starter 是真的香，谁用谁知道。', 4, 27, '2026-05-18 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (62, '读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。', 4, 3, '2026-06-08 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (63, '这个我们项目也遇到过，后来是这么解决的：把粒度控制在子域级别，不要一上来就追求''完美的微服务''。', 7, 1, '2026-06-10 14:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (64, '记一次诡异的 NPE —— 我们遇到过类似问题，最后发现是 thread local 没清理。', 10, 5, '2026-06-11 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (65, '手帐的本质是跟自己对话，不是为了给别人看。', 1, 12, '2026-06-06 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (66, '向上管理不是讨好，是降低老板的认知负担。', 2, 4, '2026-06-05 04:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (67, '这个我们项目也遇到过，后来是这么解决的：把粒度控制在子域级别，不要一上来就追求''完美的微服务''。', 5, 1, '2026-05-27 10:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (68, '极简生活第三年，最大的感受是：少买反而更快乐。', 5, 30, '2026-05-28 15:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (69, 'JVM 调优那块写得不错。G1 在大堆场景下确实比 CMS 稳得多，但停顿时间要降到 50ms 以下还得调参。', 2, 1, '2026-05-28 20:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (70, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 6, 2, '2026-06-06 10:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (71, '播客推荐：''文化有限''、''纵横四海''、''日谈公园''，各有各的味道。', 10, 31, '2026-05-31 10:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (72, '手帐的本质是跟自己对话，不是为了给别人看。', 9, 32, '2026-05-28 23:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (73, '播客推荐：''文化有限''、''纵横四海''、''日谈公园''，各有各的味道。', 1, 18, '2026-06-04 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (74, '养猫最大的好处是，强制你 6 点起床。', 8, 12, '2026-05-18 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (75, '+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。', 3, 10, '2026-06-01 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (76, '手帐的本质是跟自己对话，不是为了给别人看。', 1, 23, '2026-05-17 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (77, '这个我们项目也遇到过，后来是这么解决的：把粒度控制在子域级别，不要一上来就追求''完美的微服务''。', 1, 1, '2026-05-19 07:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (78, 'Markdown 全文支持，开发者刚需。', 4, 10, '2026-05-23 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (79, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 10, 19, '2026-05-29 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (80, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 9, 1, '2026-06-13 17:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (81, '被裁那天反而松了一口气，可能是潜意识里早就想走了。', 6, 20, '2026-05-18 15:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (82, '新版设计真的很舒服，希望坚持下去。', 6, 29, '2026-05-21 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (83, '草稿自动保存是底线，知乎、V2 都有，期望 NetForum 也有。', 7, 10, '2026-05-31 22:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (84, '远程办公最大的坑是时区。跟美国同事开完会，国内都半夜了。', 3, 33, '2026-05-25 04:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (85, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 3, 2, '2026-05-29 07:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (86, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 8, 1, '2026-05-23 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (87, '读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。', 7, 3, '2026-06-13 08:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (88, 'DDD 看着美好，落地很重。楼主能展开讲讲你们的''子域''是怎么切的吗？', 2, 27, '2026-05-26 11:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (89, '极简生活第三年，最大的感受是：少买反而更快乐。', 4, 3, '2026-06-01 17:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (90, 'Lombok 真的是个坑，团队新人的 IDE 配置五花八门，调试时各种诡异。', 3, 2, '2026-05-29 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (91, '同意楼主观点，A 股技术 leader 真的不能只会写代码。', 5, 2, '2026-06-03 19:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (92, '推荐《最好的告别》《当呼吸化为空气》，重塑对生死的看法。', 8, 9, '2026-05-18 18:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (93, '向上管理不是讨好，是降低老板的认知负担。', 8, 33, '2026-05-18 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (94, '+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。', 3, 17, '2026-05-18 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (95, '一个人住最大的好处是安静，最大的坏处也是安静。', 4, 9, '2026-06-02 18:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (96, '养猫最大的好处是，强制你 6 点起床。', 5, 3, '2026-05-30 09:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (97, '记一次诡异的 NPE —— 我们遇到过类似问题，最后发现是 thread local 没清理。', 1, 1, '2026-05-17 13:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (98, '极简生活第三年，最大的感受是：少买反而更快乐。', 2, 13, '2026-05-19 11:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (99, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 1, 2, '2026-06-04 02:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (100, 'P5 到 P7 不只是技术深度，是''能独立负责一个方向''的能力。', 8, 4, '2026-05-31 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (101, 'Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。', 1, 2, '2026-05-26 18:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (102, '读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。', 10, 32, '2026-06-02 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (103, 'P5 到 P7 不只是技术深度，是''能独立负责一个方向''的能力。', 1, 4, '2026-06-12 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (104, '西山的雾真的绝，有机会我也去一次。', 4, 9, '2026-06-12 17:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (105, 'code review 不是找 bug，是传递上下文。新人从这个过程学到最多。', 8, 4, '2026-05-25 00:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (106, '同意楼主观点，A 股技术 leader 真的不能只会写代码。', 3, 1, '2026-05-30 20:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (107, '同意楼主观点，A 股技术 leader 真的不能只会写代码。', 3, 2, '2026-05-29 20:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (108, '读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。', 7, 28, '2026-05-16 18:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (109, '极简生活第三年，最大的感受是：少买反而更快乐。', 10, 3, '2026-06-07 05:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (110, '不接 offer 的时候列了 5 条硬性要求，宁缺毋滥。', 2, 20, '2026-05-21 14:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (111, '远程办公最大的坑是时区。跟美国同事开完会，国内都半夜了。', 9, 20, '2026-05-21 08:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (112, '我们最后也是放弃了 GraphQL，最大的问题是 N+1 和缓存失效难以处理。', 2, 5, '2026-05-28 11:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (113, 'Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。', 9, 5, '2026-06-03 11:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (114, '手帐的本质是跟自己对话，不是为了给别人看。', 9, 31, '2026-05-19 03:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (115, 'DDD 看着美好，落地很重。楼主能展开讲讲你们的''子域''是怎么切的吗？', 2, 1, '2026-06-13 18:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (116, 'Maven 多模块 + Spring Boot Starter 是真的香，谁用谁知道。', 5, 8, '2026-05-30 23:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (117, '读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。', 7, 3, '2026-05-30 21:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (118, '不接 offer 的时候列了 5 条硬性要求，宁缺毋滥。', 2, 26, '2026-05-23 16:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (119, '我们最后也是放弃了 GraphQL，最大的问题是 N+1 和缓存失效难以处理。', 4, 2, '2026-06-04 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (120, 'JVM 调优那块写得不错。G1 在大堆场景下确实比 CMS 稳得多，但停顿时间要降到 50ms 以下还得调参。', 9, 22, '2026-05-30 12:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (121, '手帐的本质是跟自己对话，不是为了给别人看。', 10, 3, '2026-05-28 06:00:00');
INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES (122, '@提醒功能可以加，类似 GitHub 的 mention。', 9, 10, '2026-06-08 06:00:00');

-- ============ 4. 点赞（59 个）============
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (3, 3, 14, '2026-05-30 00:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (4, 3, 18, '2026-06-01 08:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (5, 9, 21, '2026-05-24 17:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (6, 1, 33, '2026-05-17 19:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (7, 10, 19, '2026-05-28 19:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (8, 4, 21, '2026-05-24 06:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (9, 6, 22, '2026-05-26 11:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (10, 3, 15, '2026-05-27 14:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (11, 4, 27, '2026-05-17 03:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (12, 5, 28, '2026-06-13 08:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (13, 7, 31, '2026-05-18 00:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (14, 1, 6, '2026-06-03 05:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (15, 6, 25, '2026-06-09 11:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (16, 4, 4, '2026-05-24 08:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (17, 6, 20, '2026-06-10 10:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (18, 5, 2, '2026-05-17 05:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (19, 10, 3, '2026-06-09 10:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (20, 6, 6, '2026-06-08 23:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (21, 6, 27, '2026-06-04 12:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (22, 1, 26, '2026-05-31 09:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (23, 6, 16, '2026-05-22 14:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (24, 7, 13, '2026-06-04 03:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (25, 1, 11, '2026-05-27 14:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (26, 4, 3, '2026-05-23 11:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (27, 2, 21, '2026-05-30 01:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (28, 8, 28, '2026-05-25 18:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (29, 4, 13, '2026-06-04 10:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (30, 7, 29, '2026-06-12 06:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (31, 1, 28, '2026-05-26 01:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (32, 8, 9, '2026-05-25 00:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (33, 10, 32, '2026-06-02 20:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (34, 3, 26, '2026-06-02 06:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (35, 5, 26, '2026-06-05 20:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (36, 5, 4, '2026-06-09 05:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (37, 6, 1, '2026-05-30 02:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (38, 8, 11, '2026-05-24 07:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (39, 5, 18, '2026-06-08 12:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (40, 8, 30, '2026-06-14 09:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (41, 3, 16, '2026-06-14 05:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (42, 4, 15, '2026-06-09 20:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (43, 8, 31, '2026-05-20 15:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (44, 7, 17, '2026-05-20 13:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (45, 9, 19, '2026-06-06 16:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (46, 7, 9, '2026-06-05 21:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (47, 7, 24, '2026-06-04 21:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (48, 4, 16, '2026-05-25 08:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (49, 4, 31, '2026-05-24 17:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (50, 9, 33, '2026-05-27 12:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (51, 2, 6, '2026-05-25 12:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (52, 6, 23, '2026-05-23 14:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (53, 4, 7, '2026-06-08 06:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (54, 1, 17, '2026-05-18 16:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (55, 10, 24, '2026-05-30 10:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (56, 1, 30, '2026-06-05 19:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (57, 6, 4, '2026-05-28 01:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (58, 3, 29, '2026-06-13 19:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (59, 10, 4, '2026-05-23 04:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (60, 3, 27, '2026-06-03 13:00:00');
INSERT INTO t_like (id, user_id, post_id, create_time) VALUES (61, 7, 21, '2026-06-12 14:00:00');

-- ============ 5. 更新 t_post 的 reply_count / view_count / like_count ============
-- reply_count
UPDATE t_post p SET p.reply_count = (SELECT COUNT(*) FROM t_reply r WHERE r.post_id = p.id);
-- like_count
UPDATE t_post p SET p.like_count = (SELECT COUNT(*) FROM t_like l WHERE l.post_id = p.id);
-- view_count（按 reply_count 推一个合理值：50-300）
UPDATE t_post SET view_count = 30 + reply_count * 8 + FLOOR(RAND() * 200);

-- ============ 6. 更新 t_board 的 post_count ============
UPDATE t_board b SET b.post_count = (SELECT COUNT(*) FROM t_post p WHERE p.board_id = b.id);
