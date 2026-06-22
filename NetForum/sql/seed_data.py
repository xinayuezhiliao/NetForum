#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
NetForum 论坛种子数据生成器
- 8 个新普通用户（凑齐 10 用户）
- ~30 帖子 + ~120 回复 + ~59 点赞 = 209 论坛数据
- 自动维护 t_post / t_board 的 count 字段
"""

import random
import hashlib
from datetime import datetime, timedelta

random.seed(20260614)  # 固定随机种子，结果可复现

# 8 个新用户名 + 邮箱（避开已存在的 admin / 孤稳火车）
NEW_USERS = [
    ("林书白", "linshubai@example.com"),
    ("苏沐之", "sumuzhi@example.com"),
    ("周怀瑾", "zhouhuaijin@example.com"),
    ("青山客", "qingshanke@example.com"),
    ("云在青天", "yunzaitian@example.com"),
    ("何九潇", "hejiuxiao@example.com"),
    ("江雪残", "jiangxuecan@example.com"),
    ("柳青衣", "liuqingyi@example.com"),
]

# 所有用户 ID（admin=1, 孤稳火车=2, 加上 8 个新 = 10）
USER_IDS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# 4 个版块 ID
BOARD_IDS = [1, 2, 3, 4]

# 帖标题模板（按版块）
POST_TITLES = {
    1: [  # 技术交流
        "聊聊我理解的微服务拆分粒度", "RESTful API 设计的 5 个常见误区",
        "Spring Boot 配置项加密的三种姿势", "一次 JVM 调优实战：GC 优化 30%",
        "为什么我们最终放弃了 GraphQL", "Maven 多模块项目的最佳实践",
        "记一次诡异的 NPE 排查过程", "Tomcat 连接池调参经验总结",
        "谈谈我对 DDD 的一点浅见", "ID 生成器：Snowflake 在小厂的落地",
        "Java 中的 Optional 真的好用吗", "我们用 Redis 踩过的那些坑",
        "Kafka 入门到放弃", "从单体到微服务：一年实践复盘",
        "关于分布式锁的几点思考", "为什么我们团队放弃了 Lombok",
        "Spring AOP 在审计日志中的应用", "消息队列选型：Kafka vs RabbitMQ",
        "新人如何系统地学习后端", "用 Go 重写一个 Java 项目的得失",
    ],
    2: [  # 生活休闲
        "今天赚了300刀", "周末去了一趟西山徒步",
        "做了三年程序员，最大的变化是什么", "推荐几本我反复读过的书",
        "城市骑行：京西古道一日", "咖啡馆常去的 5 家小店",
        "2026 上半年观影清单", "聊聊我的极简生活尝试",
        "养猫一年记：从抗拒到上瘾", "最近爱上的几个播客",
        "茶与咖啡：成年人的两难", "重读《活着》：二十岁和三十岁不同",
        "为什么开始写手帐", "周末厨房：番茄牛腩最稳的做法",
        "城市散步：那些被忽略的小路", "一个下雨天的下午",
        "朋友送的生日礼物合集", "关于搬家：独居生活指南",
    ],
    3: [  # 职场人生
        "为什么我离开大厂去了小公司", "技术 leader 必备的 3 个习惯",
        "聊聊程序员的中年危机", "远程工作一年的真实感受",
        "被裁员后我的 30 天", "面试 50 个候选人后的一点心得",
        "我眼中好的 code review 是什么样的", "向上管理：怎么跟老板有效沟通",
        "P5 到 P7：我用 5 年走过的路", "想转管理但又怕失去技术深度",
        "跳槽前你需要想清楚的 3 件事", "如何在工作中保持学习曲线",
        "加班文化的真实成本", "创业一年：踩过的那些坑",
        "从技术转产品的 90 天", "我们是这样淘汰 35+ 员工的",
        "裸辞 6 个月后我怎么样了", "我为什么拒绝了一份高薪 offer",
    ],
    4: [  # 反馈建议
        "建议增加深色模式", "发帖时希望能草稿自动保存",
        "搜索功能太弱了", "希望支持 Markdown 全文",
        "评论能不能加 @ 提醒", "建议加个'我点赞的'列表",
        "移动端体验需要优化", "新版 UI 好看但有点不习惯",
        "希望加个无图模式", "附件能不能支持文件夹上传",
    ],
}

# 帖内容模板（按版块，多样化）
POST_CONTENT = {
    1: """最近在重构公司的老系统，感触很深。

原来我们把"用户中心、订单、商品、库存、支付、营销、消息"全部塞在一个大单体里，
跑了一两年之后，团队从 8 个人扩张到 30 个人，每次发布都像在拆炸弹。

后来开始拆分微服务。我的体会是：粒度不能太细，否则分布式事务、链路追踪、服务治理的复杂度会反噬。

我们最终的拆法是按"业务能力"切，每个服务对应一个完整的子域，团队规模控制在 5-8 人。

各位怎么看？你们的拆分粒度是怎么定的？
""",
    2: """周末一个人去了一趟西山。

早上 7 点出门，背了 2 升水、两个苹果、一本《置身事内》。
山路上人不多，走到半山腰的时候，遇见一只松鼠在吃松果，完全不怕人。

坐在亭子里发了半小时的呆，看远处的城市一点点被云雾盖住。
没有消息、没有会、没有 deadline。

回来之后整个人松了一档。

也许我们都需要这样的一个下午。
""",
    3: """待过两家公司，面试过 50+ 候选人，聊聊我的真实感受。

首先，技术能力只是入场券。
我见过太多技术面很硬的人，进组之后完全推不动项目。

我比较看重的几样：
1. **能不能把复杂问题说清楚**——让他解释一个他做过的项目，3 分钟内能不能讲明白背景、难点、自己的贡献
2. **遇到不懂的会不会直接说**——比硬编一个答案好得多
3. **代码之外有没有好奇心**——读过什么书、对行业有没有看法

技术 leader 这个岗位，技术只是底盘。""",
    4: """新版本上线后用了几天，整体很赞，编辑感很强！

但有几个小建议：
- 草稿自动保存真的很重要，写到一半电脑死机就要哭
- 希望能加个深色模式，晚上写东西不刺眼
- 移动端发帖体验一般，输入框太小

期待越来越好！""",
}

# 回复模板（按版块，60+ 模板）
REPLY_TEMPLATES = {
    1: [
        "这个我们项目也遇到过，后来是这么解决的：把粒度控制在子域级别，不要一上来就追求'完美的微服务'。",
        "同意楼主观点，A 股技术 leader 真的不能只会写代码。",
        "JVM 调优那块写得不错。G1 在大堆场景下确实比 CMS 稳得多，但停顿时间要降到 50ms 以下还得调参。",
        "我们最后也是放弃了 GraphQL，最大的问题是 N+1 和缓存失效难以处理。",
        "DDD 看着美好，落地很重。楼主能展开讲讲你们的'子域'是怎么切的吗？",
        "Lombok 真的是个坑，团队新人的 IDE 配置五花八门，调试时各种诡异。",
        "Maven 多模块 + Spring Boot Starter 是真的香，谁用谁知道。",
        "Snowflake 在并发 < 4w/s 的场景下基本够用了，再高就要考虑 Leaf 之类的。",
        "记一次诡异的 NPE —— 我们遇到过类似问题，最后发现是 thread local 没清理。",
        "Tomcat 调参这块，建议直接看 asyncTimeout 和 maxConnections 的关系。",
    ],
    2: [
        "西山的雾真的绝，有机会我也去一次。",
        "极简生活第三年，最大的感受是：少买反而更快乐。",
        "播客推荐：'文化有限'、'纵横四海'、'日谈公园'，各有各的味道。",
        "茶和咖啡我都喝，但晚上只喝茶。咖啡因代谢慢真的会影响睡眠。",
        "番茄牛腩最重要的是要炒糖色，小火慢炖 2 小时。",
        "养猫最大的好处是，强制你 6 点起床。",
        "读《活着》读到福贵一家死的只剩他和老牛，眼泪止不住。",
        "一个人住最大的好处是安静，最大的坏处也是安静。",
        "手帐的本质是跟自己对话，不是为了给别人看。",
        "推荐《最好的告别》《当呼吸化为空气》，重塑对生死的看法。",
    ],
    3: [
        "裸辞 6 个月后精神状态好多了，钱虽然少了点，但生活不是只有 KPI。",
        "35+ 不是被淘汰，是被'性价比更低'。这是两件事。",
        "技术转产品最难的，是从'解决问题'转向'发现值得解决的问题'。",
        "P5 到 P7 不只是技术深度，是'能独立负责一个方向'的能力。",
        "远程办公最大的坑是时区。跟美国同事开完会，国内都半夜了。",
        "code review 不是找 bug，是传递上下文。新人从这个过程学到最多。",
        "向上管理不是讨好，是降低老板的认知负担。",
        "被裁那天反而松了一口气，可能是潜意识里早就想走了。",
        "创业一年，最大的教训是：不要用爱发电，所有东西都要算账。",
        "不接 offer 的时候列了 5 条硬性要求，宁缺毋滥。",
    ],
    4: [
        "+1 强烈支持深色模式，编辑设计本身就很适合做暗色版本。",
        "草稿自动保存是底线，知乎、V2 都有，期望 NetForum 也有。",
        "搜索功能同意，可以加个全文索引（FTS）。",
        "Markdown 全文支持，开发者刚需。",
        "@提醒功能可以加，类似 GitHub 的 mention。",
        "移动端优化很需要，手机端发帖体验确实差。",
        "新版设计真的很舒服，希望坚持下去。",
        "无图模式 +1，省流量。",
    ],
}

def md5(s: str) -> str:
    return hashlib.md5(s.encode("utf-8")).hexdigest()

def fmt_dt(dt: datetime) -> str:
    return dt.strftime("%Y-%m-%d %H:%M:%S")

def esc(s: str) -> str:
    """MySQL string escape — escape single quote and backslash"""
    return s.replace("\\", "\\\\").replace("'", "''")

# 起始时间（最近 60 天内）
NOW = datetime(2026, 6, 14, 10, 0, 0)

# 生成 SQL
sql_parts = []
sql_parts.append("-- NetForum 种子数据 — 10 用户 + 209 论坛数据")
sql_parts.append("-- 生成时间: 2026-06-14")
sql_parts.append("")
sql_parts.append("USE netforum;")
sql_parts.append("SET NAMES utf8mb4;")
sql_parts.append("")

# 1. 插入 8 个新用户
sql_parts.append("-- ============ 1. 用户（8 个新普通用户）============")
for i, (name, email) in enumerate(NEW_USERS):
    uid = 3 + i  # 3..10
    pwd = md5("123456")  # 默认密码 123456
    avatar = f"/upload/avatar/avatar_{uid}.jpg"
    create_time = NOW - timedelta(days=random.randint(1, 60))
    sql_parts.append(
        f"INSERT INTO t_user (id, username, password, email, avatar, role, create_time) VALUES "
        f"({uid}, '{name}', '{pwd}', '{email}', '{avatar}', 0, '{fmt_dt(create_time)}');"
    )
sql_parts.append("")

# 2. 插入帖子
sql_parts.append("-- ============ 2. 帖子（30 个，分布 4 版块）============")
post_data = []  # (id, board_id, user_id, title, content, is_top, is_elite, view, reply, like, time)
post_id_counter = 4  # 现有 3 个
# 现有 3 帖的额外虚拟数据 (id, board, user, view, reply, like)
post_data.append((1, 1, 1, 0, 0, 156, 12, 45))  # post 1
post_data.append((2, 1, 1, 0, 1, 89, 8, 32))   # post 2 精华
post_data.append((3, 2, 2, 0, 0, 234, 18, 67))  # post 3

# 生成 30 个新帖
all_new_titles = []
for bid in BOARD_IDS:
    for t in POST_TITLES[bid]:
        all_new_titles.append((bid, t))
random.shuffle(all_new_titles)
# 选 30 个
selected_titles = all_new_titles[:30]

# 选 5 个置顶，4 个精华
top_idx = set(random.sample(range(30), 5))
elite_idx = set(random.sample(range(30), 4))

# 选 3 个用户作为"活跃用户"（多发帖）
active_users = [3, 4, 5, 6, 7]  # 5 个新用户

for i, (board_id, title) in enumerate(selected_titles):
    pid = post_id_counter + i
    user_id = random.choice(active_users) if random.random() < 0.7 else random.choice(USER_IDS)
    content = esc(POST_CONTENT[board_id].strip())
    title_esc = esc(title)
    is_top = 1 if i in top_idx else 0
    is_elite = 1 if i in elite_idx else 0
    # 发布时间：最近 30 天
    create_time = NOW - timedelta(days=random.randint(0, 30), hours=random.randint(0, 23))
    update_time = create_time
    # 浏览 / 回复 / 点赞：先填 0，后面按 reply / like 表实际数量回填
    sql_parts.append(
        f"INSERT INTO t_post (id, title, content, user_id, board_id, is_top, is_elite, "
        f"view_count, reply_count, like_count, create_time, update_time) VALUES "
        f"({pid}, '{title_esc}', '{content}', {user_id}, {board_id}, {is_top}, {is_elite}, "
        f"0, 0, 0, '{fmt_dt(create_time)}', '{fmt_dt(update_time)}');"
    )
    post_data.append((pid, board_id, user_id, is_top, is_elite, 0, 0, 0))

sql_parts.append("")

# 3. 插入回复
sql_parts.append("-- ============ 3. 回复（120 个）============")
reply_data = []  # (post_id, user_id) 用于生成 likes
reply_id_counter = 3  # 现有 2 个
# 现有 2 回复
reply_data.append((1, 1))
reply_data.append((2, 1))

target_replies = 120
for i in range(target_replies):
    rid = reply_id_counter + i
    # 70% 在新帖，30% 在老帖
    if random.random() < 0.7:
        post_id = random.randint(4, 33)  # 4-33 是新帖
    else:
        post_id = random.choice([1, 2, 3])  # 现有 3 帖
    user_id = random.choice(USER_IDS)
    # 选模板
    # 先查 board_id：从 post_data
    post_info = next((p for p in post_data if p[0] == post_id), None)
    if not post_info:
        continue
    board_id = post_info[1]
    templates = REPLY_TEMPLATES[board_id]
    content = esc(random.choice(templates))
    create_time = NOW - timedelta(days=random.randint(0, 28), hours=random.randint(0, 23))
    sql_parts.append(
        f"INSERT INTO t_reply (id, content, user_id, post_id, create_time) VALUES "
        f"({rid}, '{content}', {user_id}, {post_id}, '{fmt_dt(create_time)}');"
    )
    reply_data.append((post_id, user_id))

sql_parts.append("")

# 4. 插入点赞
sql_parts.append("-- ============ 4. 点赞（59 个）============")
like_id_counter = 3  # 现有 2 个
like_data = []
# 现有 2 点赞
like_data.append((2, 1))  # user 1 like post 2
like_data.append((3, 1))  # user 1 like post 3

# 已有 (user, post) 用于去重
existing_likes = set(like_data)
existing_likes.add((1, 2))  # 历史
existing_likes.add((1, 3))  # 历史

target_likes = 59  # 30 + 120 + 59 = 209 精确
attempts = 0
while len(like_data) < target_likes + 2 and attempts < 500:
    attempts += 1
    user_id = random.choice(USER_IDS)
    post_id = random.choice([p[0] for p in post_data])
    if (user_id, post_id) in existing_likes:
        continue
    existing_likes.add((user_id, post_id))
    lid = like_id_counter + len(like_data) - 2
    create_time = NOW - timedelta(days=random.randint(0, 28), hours=random.randint(0, 23))
    sql_parts.append(
        f"INSERT INTO t_like (id, user_id, post_id, create_time) VALUES "
        f"({lid}, {user_id}, {post_id}, '{fmt_dt(create_time)}');"
    )
    like_data.append((post_id, user_id))

sql_parts.append("")

# 5. 触发器方式更新 count
sql_parts.append("-- ============ 5. 更新 t_post 的 reply_count / view_count / like_count ============")
sql_parts.append("-- reply_count")
sql_parts.append("UPDATE t_post p SET p.reply_count = (SELECT COUNT(*) FROM t_reply r WHERE r.post_id = p.id);")
sql_parts.append("-- like_count")
sql_parts.append("UPDATE t_post p SET p.like_count = (SELECT COUNT(*) FROM t_like l WHERE l.post_id = p.id);")
sql_parts.append("-- view_count（按 reply_count 推一个合理值：50-300）")
sql_parts.append("UPDATE t_post SET view_count = 30 + reply_count * 8 + FLOOR(RAND() * 200);")
sql_parts.append("")
sql_parts.append("-- ============ 6. 更新 t_board 的 post_count ============")
sql_parts.append("UPDATE t_board b SET b.post_count = (SELECT COUNT(*) FROM t_post p WHERE p.board_id = b.id);")
sql_parts.append("")

# 输出
output = "\n".join(sql_parts)

with open("D:/虚拟机/期末考核/NetForum/sql/seed_data.sql", "w", encoding="utf-8") as f:
    f.write(output)

print(f"Generated SQL: {len(sql_parts)} lines")
print(f"Posts (new): 30 | Replies (new): 120 | Likes (new): 59")
print(f"Total new data: 8 users + 30 posts + 120 replies + 59 likes = 217 rows")
print(f"Existing data: 2 users + 3 posts + 2 replies + 2 likes = 9 rows")
print(f"After: 10 users + 33 posts + 122 replies + 61 likes")
print(f"Forum data only: 33+122+61 = {33+122+61} (>209 target)")
