# docker安装mysql

### 拉取 MySQL 镜像

```
docker pull mysql:latest
```

![img](https://www.runoob.com/wp-content/uploads/2016/06/docker-mysql3.png)

### 查看本地镜像

```
docker images
```

### 运行容器

```
docker run -itd --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql
```

