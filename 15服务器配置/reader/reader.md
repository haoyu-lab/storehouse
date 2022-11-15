### Docker-Compose版(推荐)

#安装docker-compose
#Debian/Ubuntu
apt install docker-compose -y
#CentOS
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose --version

# 下载项目里的 docker-compose.yaml
wget https://raw.githubusercontent.com/hectorqin/reader/master/docker-compose.yaml
# 根据 docker-compose.yaml 里面的注释编辑所需配置
# 启动 docker-compose
docker-compose up -d

# 停止 docker-compose
docker-compose stop

# 查看实时日志
docker logs -f reader

# 手动更新
docker-compose pull && docker-compose up -d