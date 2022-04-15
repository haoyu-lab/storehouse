# centos7安装docker

**centos7 命令发生巨大变化**

```
hostname dreids			#注意必须修改机器名hostname
```

## 1.1.1安装Docker

### **1.1.1.1第一步：安装工具包**

```bash
sudo yum install -y yum-utils 		#安装工具包，缺少这些依赖将无法完成
```

![image-20220415101302041](C:\Users\11034\AppData\Roaming\Typora\typora-user-images\image-20220415101302041.png)

### **1.1.1.2第二步：设置远程仓库**

```bash
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

执行结果：

![image-20220415101408101](C:\Users\11034\AppData\Roaming\Typora\typora-user-images\image-20220415101408101.png)

### **1.1.1.3第三步：安装**

```bash
sudo yum install docker-ce
```

执行结果：

![image-20220415101556179](C:\Users\11034\AppData\Roaming\Typora\typora-user-images\image-20220415101556179.png)

### **1.1.1.4第四步：启动**

```bash
$ sudo systemctl start docker
或者
$ sudo service docker start
service docker start        #启动docker
chkconfig docker on         #加入开机启动
```

### **1.1.1.5第五步：查看版本**

```bash
sudo docker version
```

![image-20220415101835767](C:\Users\11034\AppData\Roaming\Typora\typora-user-images\image-20220415101835767.png)

### **1.1.1.6第六步：校验**

```bash
sudo docker run hello-world
```

**执行结果： （注意一下，结果没那么快出来）**

![image-20220415102028743](C:\Users\11034\AppData\Roaming\Typora\typora-user-images\image-20220415102028743.png)

## **1.1.2查看Docker版本**

```bash
docker --help #帮助
docker -v #简单查看版本
docker version #查看版本
```

**docker info #查看信息**