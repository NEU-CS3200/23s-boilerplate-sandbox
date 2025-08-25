# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 
---翟梓荏的贡献----
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
        
    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v2
        
    - name: Build Docker images
      run: docker compose build
      
    - name: Run Tests
      run: |
        # 创建必要的密钥文件
        mkdir -p secrets
        echo "your_root_password" > secrets/db_root_password.txt
        echo "your_webapp_password" > secrets/db_password.txt
        
        # 启动 Docker 容器
        docker compose up -d
        
        # 等待服务启动
        sleep 30
        
        # 运行测试（需要在项目中添加测试脚本）
        # docker compose exec flask python -m pytest
        
    - name: Stop containers
      if: always()
      run: docker compose down

  deploy:
    needs: build-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - name: Deploy to production
      run: |
        echo "部署步骤将根据实际部署环境配置"
        # 这里添加实际的部署命令

# MySQL + Flask Boilerplate Project

A modern, containerized web application boilerplate that combines the power of MySQL 8, Flask REST API, and AppSmith for rapid application development.

## Project Overview

This project provides a production-ready foundation for building web applications with the following key features:

- **MySQL 8 Database**: Robust and scalable database solution
- **Flask REST API**: Python-based backend with RESTful architecture
- **AppSmith Integration**: Low-code platform for building admin dashboards and user interfaces
- **Docker Containerization**: Easy deployment and development environment setup

## Architecture

The project is structured as three main components:

1. **MySQL Container**
   - MySQL 8.0
   - Configurable root and application user credentials
   - Persistent data storage
   - Optimized for production use

2. **Flask API Container**
   - Python-based REST API
   - Built with Flask framework
   - Ready for API development
   - Includes basic security configurations

3. **AppSmith Container**
   - Local development server
   - Pre-configured for database connection
   - Ready for UI development

## Quick Start
**Prerequisites**: Docker Desktop must be installed

1. Clone this repository
2. Set up database credentials:
   - Create `secrets/db_root_password.txt` with MySQL root password
   - Create `secrets/db_password.txt` with password for webapp user
3. Build and start containers:
   ```bash
   docker compose build
   docker compose up        # Run in foreground
   # OR
   docker compose up -d    # Run in detached mode
   ``` 
--卢冬华贡献--
##周玉涛##
## 🚀 Installation & Deployment Guide

### Prerequisites
- Docker Engine (20.10.x or higher)
- Docker Compose (v2.x or higher)
- Git
- 2GB+ RAM
- 1GB+ free disk space

### Quick Start
1. Clone the repository:
```bash
git clone <repository-url>
cd <project-directory>
```

2. Set up secrets:
```bash
# Create secrets directory
mkdir -p secrets

# Create and populate password files
echo "your_db_password" > secrets/db_password.txt
echo "your_db_root_password" > secrets/db_root_password.txt

# Set proper permissions
chmod 600 secrets/db_password.txt secrets/db_root_password.txt
```

3. Launch the application:
```bash
docker compose up -d
```

The application will be available at:
- Web Application: `http://localhost:8001`
- Database (for admin access): `localhost:3200`

### 🐳 Docker Configuration Details

Our application uses a multi-container setup managed by Docker Compose:

#### Web Application Container (`web`)
- Built from custom Flask application
- Exposed on port 8001 (host) → 4000 (container)
- Auto-restarts on failure
- Volume mappings:
  - `./flask-app:/code` - Application code
  - `./secrets:/secrets` - Secure credentials

#### Database Container (`db`)
- MySQL 8.0
- Exposed on port 3200 (host) → 3306 (container)
- Secure credential management using Docker secrets
- Volume mapping:
  - `./db:/docker-entrypoint-initdb.d/:ro` - Initial database setup scripts

### 🔐 Security Features
- Database passwords stored as Docker secrets
- Read-only volume mounts where applicable
- Separate user account for application database access
- Restricted port exposure

### 🛠 Environment Configuration
The application uses the following environment variables (configured in docker-compose.yml):
```yaml
MYSQL_USER: webapp
MYSQL_PASSWORD_FILE: /run/secrets/secret_db_pw
MYSQL_ROOT_PASSWORD_FILE: /run/secrets/secret_db_root_pw
```

### 📝 Container Management Commands

#### View running containers:
```bash
docker compose ps
```

#### View application logs:
```bash
# All containers
docker compose logs

# Specific container
docker compose logs web
docker compose logs db
```

#### Restart services:
```bash
# All services
docker compose restart

# Specific service
docker compose restart web
```

#### Stop and remove containers:
```bash
docker compose down
## 🔍 Troubleshooting

1. **Container fails to start**
   - Check logs: `docker compose logs`
   - Verify secret files exist and have correct permissions
   - Ensure ports 8001 and 3200 are not in use

2. **Database connection issues**
   - Verify MySQL container is running: `docker compose ps`
   - Check database logs: `docker compose logs db`
   - Ensure password files contain correct credentials

3. **Volume mount issues**
   - Verify directory permissions
   - Check if paths in docker-compose.yml match your project structure

### 🔄 Updating the Application

1. Pull latest changes:
```bash
git pull origin main
```

2. Rebuild and restart containers:
```bash
docker compose down
docker compose up -d --build
```

### 💻 Development Setup

For development purposes, you can use the following additional commands:

```bash
# View real-time logs
docker compose logs -f

# Access MySQL CLI
docker compose exec db mysql -u root -p

# Access web container shell
docker compose exec web /bin/bash
```

### 📊 System Requirements Monitoring

Monitor your container resources:
```bash
# View container resource usage
docker stats

# View container processes
docker compose top


-------傅可的贡献（User manual）
# MySQL + Flask Boilerplate Project

A development environment boilerplate that sets up three Docker containers:
1. MySQL 8 database server
2. Python Flask REST API server
3. Local AppSmith server for frontend development

## Prerequisites

- Docker Desktop installed on your machine
- Git for cloning the repository
- Basic understanding of Docker and containerization

## Quick Start

1. Clone this repository:



2. Configure database credentials:
   - Create `secrets_root_password.txt` with MySQL root password
   - Create `secrets_password.txt` with password for 'webapp' user

3. Build and start containers:



## Container Access

| Service | URL | Port |
|---------|-----|------|
| MySQL Database | localhost | 3306 |
| Flask API | localhost | 5000 |
| AppSmith | localhost | 80 |

## Common Commands



## Troubleshooting

1. **Docker not running**
   - Ensure Docker Desktop is running
   - Check Docker service status

2. **Container startup issues**
   - Verify secret files exist in `secrets/` directory
   - Check container logs: `docker compose logs`
   - Ensure ports are not in use

3. **Database connection issues**
   - Verify MySQL container is running
   - Check database credentials
   - Ensure network connectivity between containers

## Development

- Flask API code is in `api/` directory
- Database migrations can be managed through Flask-Migrate
- AppSmith configurations are stored in `appsmith/` directory

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [AppSmith Documentation](https://docs.appsmith.com/)


# MySQL + Flask Boilerplate Project

A development environment boilerplate that sets up three Docker containers:
1. MySQL 8 database server
2. Python Flask REST API server
3. Local AppSmith server for frontend development

## Prerequisites

- Docker Desktop installed on your machine
- Git for cloning the repository
- Basic understanding of Docker and containerization

## Quick Start

1. Clone this repository:



2. Configure database credentials:
   - Create `secrets_root_password.txt` with MySQL root password
   - Create `secrets_password.txt` with password for 'webapp' user

3. Build and start containers:



## Container Access

| Service | URL | Port |
|---------|-----|------|
| MySQL Database | localhost | 3306 |
| Flask API | localhost | 5000 |
| AppSmith | localhost | 80 |

## Common Commands



## Troubleshooting

1. **Docker not running**
   - Ensure Docker Desktop is running
   - Check Docker service status

2. **Container startup issues**
   - Verify secret files exist in `secrets/` directory
   - Check container logs: `docker compose logs`
   - Ensure ports are not in use

3. **Database connection issues**
   - Verify MySQL container is running
   - Check database credentials
   - Ensure network connectivity between containers

## Development

- Flask API code is in `api/` directory
- Database migrations can be managed through Flask-Migrate
- AppSmith configurations are stored in `appsmith/` directory

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [AppSmith Documentation](https://docs.appsmith.com/)
