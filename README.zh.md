杨攀贡献





MySQL + Flask 样板项目
这个代码仓库包含了用于启动 3 个 Docker 容器的样板设置：
一个 MySQL 8 容器，原因显而易见。
一个用于实现 REST API 的 Python Flask 容器。
一个本地 AppSmith 服务器。
如何设置并启动容器
重要提示：你需要安装 Docker Desktop。
克隆这个代码仓库。
在 secrets/ 文件夹中创建一个名为 db_root_password.txt 的文件，并在其中输入 MySQL 的根密码。
在 secrets/ 文件夹中创建一个名为 db_password.txt 的文件，并在其中输入你想为名为 webapp 的非根用户设置的密码。
在终端或命令提示符中，导航到包含 docker-compose.yml 文件的文件夹。
使用 docker compose build 构建镜像。
使用 docker compose up 启动容器。若要以分离模式运行，请执行 docker compose up -d。
                --- 翟梓荏的贡献 ----
名称：CI/CD 流水线
触发条件：
推送操作：
分支为 [main]
拉取请求：
分支为 [ main ]
任务：
构建与测试：
在 ubuntu-latest 环境中运行
步骤：
使用 actions/checkout@v3
名称：设置 Python
使用 actions/setup-python@v4
配置：
Python 版本：'3.9'
名称：设置 Docker Buildx
使用 docker/setup-buildx-action@v2
名称：构建 Docker 镜像
运行：docker compose build
名称：运行测试
执行：|
创建必要的密钥文件
mkdir -p secrets
echo "your_root_password" > secrets/db_root_password.txt
echo "your_webapp_password" > secrets/db_password.txt
启动 Docker 容器
docker compose up -d
等待服务启动
sleep 30
运行测试（需要在项目中添加测试脚本）
docker compose exec flask python -m pytest
名称：停止容器
条件：always ()
运行：docker compose down
部署：
依赖：构建与测试
在 ubuntu-latest 环境中运行
条件：github.ref == 'refs/heads/main'
步骤：
名称：部署到生产环境
执行：|echo "部署步骤将根据实际部署环境配置"
这里添加实际的部署命令
MySQL + Flask 样板项目
一个现代化的、经过容器化处理的 Web 应用样板，它结合了 MySQL 8、Flask REST API 和 AppSmith 的强大功能，用于快速应用开发。
项目概述
该项目为构建 Web 应用提供了可用于生产环境的基础，具备以下关键特性：
MySQL 8 数据库：强大且可扩展的数据库解决方案
Flask REST API：基于 Python 的具有 RESTful 架构的后端
AppSmith 集成：用于构建管理仪表盘和用户界面的低代码平台
Docker 容器化：便于部署和开发环境设置
架构
该项目由三个主要组件构成：
MySQL 容器
MySQL 8.0
可配置的根用户和应用程序用户凭据
持久化数据存储
针对生产使用进行了优化
Flask API 容器
基于 Python 的 REST API
使用 Flask 框架构建
可用于 API 开发
包含基本的安全配置
AppSmith 容器
本地开发服务器
预先配置好了数据库连接
可用于用户界面开发
快速上手
前提条件：必须安装 Docker Desktop。
克隆此代码仓库。
设置数据库凭据：
创建 secrets/db_root_password.txt 文件，并在其中写入 MySQL 根密码。
创建 secrets/db_password.txt 文件，并在其中写入 webapp 用户的密码。
构建并启动容器：
bash
docker compose build
docker compose up        # 在前台运行
# 或者
docker compose up -d    # 以分离模式运行

卢文宝贡献



============= 周玉涛 ===========
🚀 安装与部署指南
环境要求
• Docker Engine 20.10.x 或更高版本
• Docker Compose v2.x 或更高版本
• Git
• 2GB以上内存
• 1GB以上可用磁盘空间
快速开始
1. 克隆代码仓库：
git clone <仓库地址>
cd <项目目录>
2. 配置密钥文件：
创建密钥目录
mkdir -p secrets
创建密码文件
echo "数据库密码" > secrets/db_password.txt
echo "root用户密码" > secrets/db_root_password.txt
设置文件权限
chmod 600 secrets/db_password.txt secrets/db_root_password.txt
3. 启动应用：
docker compose up -d
应用访问地址：
• Web应用：http://localhost:8001
• 数据库(管理员访问)：localhost:3200
🐳 Docker配置详情
采用Docker Compose管理的多容器架构：
Web应用容器 (web)
• 基于定制Flask应用构建
• 端口映射 8001(主机) → 4000(容器)
• 故障时自动重启
• 卷映射：
./flask-app:/code —— 应用代码
./secrets:/secrets —— 安全凭证
数据库容器 (db)
• MySQL 8.0
• 端口映射 3200(主机) → 3306(容器)
• 使用Docker密钥管理安全凭证
• 卷映射：
./db:/docker-entrypoint-initdb.d/:ro —— 数据库初始化脚本
🔐 安全特性
• 数据库密码通过Docker密钥管理
• 启用只读卷映射
• 为应用数据库访问配置独立账户
• 限制非必要端口暴露
🛠 环境配置
应用使用以下环境变量（配置于docker-compose.yml）：
MYSQL_USER: webapp
MYSQL_PASSWORD_FILE: /run/secrets/secret_db_pw
MYSQL_ROOT_PASSWORD_FILE: /run/secrets/secret_db_root_pw
📝 容器管理命令
查看运行中的容器：
docker compose ps
查看应用日志：
所有容器：docker compose logs
指定容器：docker compose logs web 或 docker compose logs db
重启服务：
全部服务：docker compose restart
指定服务：docker compose restart web
停止并移除容器：
docker compose down
🔍 故障排查
1. 容器启动失败
◦ 查看日志：docker compose logs
◦ 确认密钥文件存在且权限正确
◦ 确保8001和3200端口未被占用     
2. 数据库连接问题
◦ 确认MySQL容器运行状态：docker compose ps
◦ 检查数据库日志：docker compose logs db
◦ 确保密码文件包含正确凭证
3. 卷挂载问题
◦ 检查目录权限
◦ 确认docker-compose.yml中的路径与项目结构匹配
🔄 应用更新
1. 拉取最新代码：
git pull origin main
2. 重建并重启容器：
docker compose down
docker compose up -d --build
💻 开发环境配置
实时查看日志：
docker compose logs -f
访问MySQL命令行：
docker compose exec db mysql -u root -p
进入web容器shell：
docker compose exec web /bin/bash
📊 系统资源监控
查看容器资源占用：
docker stats
查看容器进程：
docker compose top
==================== 傅可的贡献（用户手册） ====================
MySQL + Flask 项目模板
开发环境模板，包含三个Docker容器：
1. MySQL 8 数据库服务器
2. Python Flask REST API 服务
3. 本地AppSmith前端开发服务器
环境要求
• 已安装Docker Desktop
• 已安装Git用于克隆仓库
• 基本了解Docker和容器化概念
快速开始
1. 克隆本仓库：
git clone <仓库地址>
cd <项目目录>
2. 配置数据库凭证：
◦ 创建secrets_root_password.txt文件并写入MySQL root密码
◦ 创建secrets_password.txt文件并写入'webapp'用户密码
3. 构建并启动容器：
docker compose up -d
容器访问信息
服务 URL 端口
MySQL数据库 localhost 3306
Flask API localhost 5000
AppSmith localhost 80
常用命令
查看容器状态：docker compose ps
查看日志：docker compose logs
停止服务：docker compose down
故障排查
1. Docker未运行
◦ 确保Docker Desktop正在运行
◦ 检查Docker服务状态
2. 容器启动问题
◦ 验证secrets/目录中的密钥文件是否存在
◦ 检查容器日志：docker compose logs
◦ 确保端口未被占用
3. 数据库连接问题
◦ 确认MySQL容器是否运行
◦ 检查数据库凭证
◦ 确保容器间网络连通性
开发说明
• Flask API代码位于api/目录
• 数据库迁移可通过Flask-Migrate管理
• AppSmith配置文件存储在appsmith/目录
参考资料
Docker文档：https://docs.docker.com/
Flask文档：https://flask.palletsprojects.com/
MySQL文档：https://dev.mysql.com/doc/
AppSmith文档：https://docs.appsmith.com/
注意事项
1. 生产环境部署时务必修改默认密码
2. 敏感配置建议使用环境变量管理
3. 定期备份重要数据
4. 所有命令行操作需在项目根目录执行
5. 开发时修改代码后可能需要重启容器生效