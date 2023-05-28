# 闻达（wenda+chatGLM-6B）一键部署包

本文是《基于闻达（wenda+chatGLM-6B），构建自己的知识库小助手》的一键部署包，将处理数据、模型启动整理为

可执行脚本，并提供内置python虚拟环境，无需任何额外的环境配置，只需要上传自己的知识库文件即可使用。

部署包链接：

链接: https://pan.baidu.com/s/1unV-0lYthIRoCbj_AX_zjg?pwd=desv 提取码: desv 

## 1、下载并解压

文件如下：

![image-20230528162912445](/Users/houhaoyu/Library/Application Support/typora-user-images/image-20230528162912445.png)

## 2、上传知识库文件

将自己的知识库文件上传到txt目录下

## 3、处理知识库数据

执行脚本 gen_data_st.sh

```shell
sh gen_data_st.sh
```

## 4、启动、停止服务

### 4.1 启动服务

```shell
sh start.sh
```

### 4.2 停止服务

```shell
sh stop.sh
```

### 日志

如想查看服务日志，可使用以下命令查看

```shell
tail -1000f nohup.out
```

