jdk 21
tomcat 9
运行时候打开NetFounm文件直接部署运行
使用的是组件运行方法

---

# 测试账号

## 管理员

| 用户名 | 密码 | 邮箱 | 角色 |
|---|---|---|---|
| `admin` | `admin123` | admin@example.com | 管理员 (role=1) |

## 普通用户

| ID | 用户名 | 密码 | 邮箱 | 角色 |
|---:|---|---|---|---|
| 2 | 孤稳火车 | `qwertyuiop` | maxlyp22@gmail.com | 普通用户 (role=0) |
| 3 | 林书白 | `123456` | linshubai@example.com | 普通用户 (role=0) |
| 4 | 苏沐之 | `123456` | sumuzhi@example.com | 普通用户 (role=0) |
| 5 | 周怀瑾 | `123456` | zhouhuaijin@example.com | 普通用户 (role=0) |
| 6 | 青山客 | `123456` | qingshanke@example.com | 普通用户 (role=0) |
| 7 | 云在青天 | `123456` | yunzaitian@example.com | 普通用户 (role=0) |
| 8 | 何九潇 | `123456` | hejiuxiao@example.com | 普通用户 (role=0) |
| 9 | 江雪残 | `123456` | jiangxuecan@example.com | 普通用户 (role=0) |
| 10 | 柳青衣 | `123456` | liuqingyi@example.com | 普通用户 (role=0) |

> 说明：
> - `admin` 密码哈希为 MD5 (`0192023a7bbd73250516f069df18b500`)，明文 `admin123`
> - id=2 孤稳火车 密码哈希为 BCrypt (`$2a$10$...`)，明文 `qwertyuiop`（原注册密码）
> - id=3~10 由 `sql/seed_data.py` 生成，统一使用明文 `123456`，哈希为 MD5 (`e10adc3949ba59abbe56e057f20f883e`)
> - 详细数据见 `docs/database-dump.md` 中的 `t_user` 表
