# docker安装nginx

## 取最新版的 Nginx 镜像

```shell
docker pull nginx:latest
```

## 随便创建并运行一个nginx容器

```powershell
docker run --name mynginx -p 80:80 -d --restart=always nginx:latest
```

## 创建对应的挂载目录

```powershell
mkdir -p /data/nginx
```

```powershell
mkdir -p /data/nginx/html/dist
```

```powershell
mkdir -p /data/nginx/logs
```

## 复制nginx容器内的配置文件到对应的挂载目录下

1.首先复制nginx配置文件地址

```powershell
docker cp mynginx:/etc/nginx /data/nginx
```

2.再复制nginx网页文件地址

```powershell
docker cp mynginx:/usr/share/nginx/html /data/nginx/html/dist
```

3.最后复制nginx日志文件地址

```powershell
docker cp mynginx:/var/log/nginx /data/nginx/logs
```



注意：如果提示：No such container:path: mynginx::/etc/nginx

需要进入nginx容器然后退出容器再试

```bash
docker exec -it mynginx bash
cd /etc/nginx
ls
exit
```

## 关闭临时容器

```bash
docker stop ‘nginx容器ID’
```

```bash
docker container rm mynginx
```

## 创建nginx容器并挂载配置目录

```bash
docker run --name ainginx1 -p 8001:80 -v /data/nginx/html/dist:/usr/share/nginx/html -v /data/nginx/nginx/nginx.conf:/etc/nginx/ningx.conf  -v /data/nginx/nginx/conf.d:/etc/nginx/conf.d -d nginx:latest
```

## 查看配置目录

```bash
cd /data/nginx/nginx
```

