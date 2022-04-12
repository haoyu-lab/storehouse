# centos7安装jdk8



下载网址：http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

![img](https://img-blog.csdn.net/2018060513192683?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3BhbmdfcGluZw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)



新建文件夹命令：mkdir /usr/java



将下载的压缩包上传到新建的java目录下面



解压命令：tar zxvf 压缩包名称



编辑环境变量：vi /etc/profile，添加jdk环境

```shell
export JAVA_HOME=/usr/java/jdk1.8.0_321
export CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
export PATH=$PATH:$JAVA_HOME/bin
```

保存退出

生效命令：source /etc/profile



测试命令：java -version











