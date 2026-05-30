# 🚗 4Scar - 汽车4S店售后管理系统

一个基于 Java Web 的汽车4S店售后服务管理系统，提供车辆管理、服务订单、配件管理、用户评价、咨询留言、投诉处理等功能。

## 📖 项目介绍

4Scar 是一个面向汽车4S店的售后服务管理平台，支持三种角色：
- **管理员**：系统管理、用户管理、配件管理、投诉处理
- **维修师傅**：接单处理、回复留言
- **车主**：管理车辆、预约服务、咨询留言、投诉评价

## ✨ 功能特性

### 管理员功能
- 用户管理（添加、编辑、删除用户）
- 车辆信息查看
- 服务订单管理
- 配件管理（添加、编辑、删除配件）
- 评价查看
- 留言查看
- 投诉处理

### 维修师傅功能
- 查看待处理订单
- 处理服务订单
- 回复车主留言
- 个人信息管理

### 车主功能
- 车辆管理（添加、编辑车辆）
- 预约服务订单
- 查看订单状态
- 咨询留言
- 提交投诉
- 服务评价
- 个人信息管理

## 🔧 技术栈

| 类别 | 技术 | 版本 |
|------|------|------|
| 开发语言 | Java | JDK 21 |
| Web 容器 | Jakarta Servlet | 6.0.0 |
| 视图模板 | JSP + JSTL | JSTL 3.0.1 |
| 构建工具 | Maven | 3.x |
| 数据库 | MySQL | 8.2.0 |
| 连接池 | Alibaba Druid | 1.2.20 |
| ORM 工具 | Apache Commons DbUtils | 1.7 |
| JSON 处理 | Jackson | 2.16.0 |
| 运行容器 | Apache Tomcat | 10.1.x |

## 📁 项目结构

```
4Scar/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/car4s/
│   │   │       ├── entity/          # 实体类
│   │   │       │   ├── User.java
│   │   │       │   ├── Car.java
│   │   │       │   ├── ServiceOrder.java
│   │   │       │   ├── Part.java
│   │   │       │   ├── Review.java
│   │   │       │   ├── Message.java
│   │   │       │   └── Complaint.java
│   │   │       ├── dao/              # 数据访问层
│   │   │       ├── service/          # 业务逻辑层
│   │   │       ├── servlet/          # 控制层
│   │   │       └── util/             # 工具类
│   │   ├── resources/
│   │   │   ├── druid.properties      # 数据库配置
│   │   │   └── sql/
│   │   │       └── init.sql          # 数据库初始化脚本
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── admin/                # 管理员页面
│   │       ├── mechanic/             # 维修师傅页面
│   │       ├── owner/                # 车主页面
│   │       ├── login.jsp
│   │       ├── register.jsp
│   │       └── index.jsp
│   └── test/
├── pom.xml
└── README.md
```

## 🚀 快速开始

### 环境要求

- JDK 21+
- Maven 3.6+
- MySQL 8.0+
- Tomcat 10.1+

### 本地运行

#### 1. 克隆项目

```bash
git clone https://github.com/LuckyDogHwk/4Scar.git
cd 4Scar
```

#### 2. 创建数据库

```sql
CREATE DATABASE car_4s CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

执行 `src/main/resources/sql/init.sql` 初始化表结构和数据。

#### 3. 配置数据库连接

修改 `src/main/resources/druid.properties`：

```properties
driverClassName=com.mysql.cj.jdbc.Driver
url=jdbc:mysql://localhost:3306/car_4s?useSSL=false&serverTimezone=Asia/Shanghai&characterEncoding=UTF-8
username=你的用户名
password=你的密码
```

#### 4. 构建项目

```bash
mvn clean package -DskipTests
```

#### 5. 部署到 Tomcat

将 `target/4Scar-1.0-SNAPSHOT.war` 复制到 Tomcat 的 `webapps` 目录，重命名为 `ROOT.war`。

#### 6. 启动 Tomcat

```bash
# Linux/Mac
./bin/startup.sh

# Windows
bin\startup.bat
```

#### 7. 访问系统

打开浏览器访问：`http://47.99.93.204:8080`

### 云服务器部署

详细部署教程请参考项目 Wiki。

## 🔑 测试账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | admin123 |
| 维修师傅 | mechanic1 | 123456 |
| 维修师傅 | mechanic2 | 123456 |
| 维修师傅 | mechanic3 | 123456 |
| 车主 | owner1 | 123456 |
| 车主 | owner2 | 123456 |
| ... | ... | ... |

## 📸 系统截图

### 登录页面
用户登录界面，支持管理员、维修师傅、车主三种角色登录。

### 管理员首页
管理员可查看系统概况、用户统计、订单统计等信息。

### 车主首页
车主可查看自己的车辆、订单、留言等信息。

### 维修师傅首页
维修师傅可查看待处理订单、留言回复等信息。

## 🗄️ 数据库设计

### 主要数据表

| 表名 | 说明 |
|------|------|
| user | 用户表（管理员、维修师傅、车主） |
| car | 车辆信息表 |
| service_order | 服务订单表 |
| part | 配件表 |
| review | 评价表 |
| message | 留言表 |
| complaint | 投诉表 |

### ER 图

```
user ──1:N──> car
user ──1:N──> service_order
car ──1:N──> service_order
service_order ──1:1──> review
user ──1:N──> message
user ──1:N──> complaint
service_order ──1:1──> complaint
```

## 🛠️ 开发说明

### MVC 架构

项目采用经典的 MVC 三层架构：

- **Model（实体层）**：`entity/` 目录下的实体类
- **View（视图层）**：`webapp/` 目录下的 JSP 页面
- **Controller（控制层）**：`servlet/` 目录下的 Servlet 类

### 数据库操作

使用 Apache Commons DbUtils 简化 JDBC 操作，配合 Druid 连接池管理数据库连接。

### 前端样式

采用纯 CSS 实现，无第三方前端框架，支持响应式布局。

## 📝 更新日志

### v1.0.0 (2026-05-30)
- 完成基础功能开发
- 支持三种角色登录
- 实现车辆管理、订单管理、配件管理等核心功能
- 完成云服务器部署

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

## 👨‍💻 作者

- GitHub: [@LuckyDogHwk](https://github.com/LuckyDogHwk)

## 🙏 致谢

感谢以下开源项目：
- [Apache Tomcat](https://tomcat.apache.org/)
- [Alibaba Druid](https://github.com/alibaba/druid)
- [Jackson](https://github.com/FasterXML/jackson)

---

⭐ 如果这个项目对你有帮助，请给一个 Star！