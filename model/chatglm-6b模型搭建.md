# 								chatglm-6b模型搭建

## 环境

centos7.6

CPU32G

SSD>=40G

python3.9

pip23.1

### 必备软件及安装

```shell
yum install -y libffi-devel python-devel openssl-devel
yum install psutil
yum install gcc python3-devel
yum install gcc g++ make openssl-devel zlib-devel
yum install gcc-c++
```

### 拉取模型架构

```shell
git clone git@github.com:THUDM/ChatGLM-6B.git
```

```shell
cd ChatGLM-6B
```

### 使用 pip 安装依赖

```shell
pip3 install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
pip3 install fastapi uvicorn -i https://pypi.tuna.tsinghua.edu.cn/simple
pip3 install streamlit -i https://pypi.tuna.tsinghua.edu.cn/simple
pip3 install streamlit-chat -i https://pypi.tuna.tsinghua.edu.cn/simple
```

## 部署（GPU）

### 从云端加载模型

#### 页面交互部署

执行脚本

```shell
streamlit run web_demo2.py --server.port 7860
```

浏览器访问路径：

```shell
ip:7860
```

#### 命令行交互部署

```shell
python3 cli_demo.py
```

#### API接口交互部署

```shell
python3 api.py
```

默认部署在本地的 8000 端口，通过 POST 方法进行调用

```shell
curl -X POST "http://127.0.0.1:8000" \
     -H 'Content-Type: application/json' \
     -d '{"prompt": "你好", "history": []}'
```

### 从本地加载模型

如果网络较差，下载过慢，可从清华仓库手动下载模型文件

#### 从Hugging Face Hub 仓库下载模型

1.安装git lfs

```shell
$ git lfs install
> Git LFS initialized.
```

2.下载模型实现（生成chatglm-6b文件夹）

```shell
GIT_LFS_SKIP_SMUDGE=1 git clone https://huggingface.co/THUDM/chatglm-6b
```

3.从清华仓库下载模型参数文件，并将下载的文件替换到本地的 `chatglm-6b` 目录下

https://cloud.tsinghua.edu.cn/d/fb9f16d6dc8f482596c2/

#### 页面交互部署

修改web_demo2.py文件并保存

```python
# 默认
tokenizer = AutoTokenizer.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True).half().cuda()
#修改为如下：
tokenizer = AutoTokenizer.from_pretrained("chatglm-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("chatglm-6b", trust_remote_code=True).half().cuda()
# "THUDM/chatglm-6b"修改为"chatglm-6b"，"chatglm-6b"为  （从Hugging Face Hub 仓库下载模型——2.下载模型实现）生成的文件夹路径
```

执行脚本

```shell
streamlit run web_demo2.py --server.port 7860
```

浏览器访问路径：

```shell
ip:7860
```

#### 命令行交互部署

修改cli_demo.py文件并保存

```python
# 默认
tokenizer = AutoTokenizer.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True).half().cuda()
#修改为如下：
tokenizer = AutoTokenizer.from_pretrained("chatglm-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("chatglm-6b", trust_remote_code=True).half().cuda()
# "THUDM/chatglm-6b"修改为"chatglm-6b"，"chatglm-6b"为  （从Hugging Face Hub 仓库下载模型——2.下载模型实现）生成的文件夹路径
```

```shell
python3 cli_demo.py
```

#### API接口交互部署

修改api.py文件并保存

```python
# 默认
tokenizer = AutoTokenizer.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True).half().cuda()
#修改为如下：
tokenizer = AutoTokenizer.from_pretrained("chatglm-6b", trust_remote_code=True)
model = AutoModel.from_pretrained("chatglm-6b", trust_remote_code=True).half().cuda()
# "THUDM/chatglm-6b"修改为"chatglm-6b"，"chatglm-6b"为  （从Hugging Face Hub 仓库下载模型——2.下载模型实现）生成的文件夹路径
```

```shell
python3 api.py
```

默认部署在本地的 8000 端口，通过 POST 方法进行调用

```shell
curl -X POST "http://127.0.0.1:8000" \
     -H 'Content-Type: application/json' \
     -d '{"prompt": "你好", "history": []}'
```



以上均使用GPU部署（不低于13G），如GPU 显存有限，可使用CPU部署（需要大概 32GB 内存）

## 部署（CPU）

将 部署（GPU）中所有需修改文件的地方修改如下，

```python
# 默认文件
model = AutoModel.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True).half().cuda()

# 云端加载模型修改方式
model = AutoModel.from_pretrained("THUDM/chatglm-6b", trust_remote_code=True).float()
#本地加载模型修改方式
model = AutoModel.from_pretrained("chatglm-6b", trust_remote_code=True).float()
```

其余操作步骤同  部署（GPU）

## 训练及微调

使用 ChatGLM-6B-PT 对模型基于[P-Tuning v2](https://github.com/THUDM/P-tuning-v2) 进行的微调，最低只需要 7GB 显存即可运行。

### 使用 pip 安装依赖

```shell
pip3 install rouge_chinese nltk jieba datasets -i https://pypi.tuna.tsinghua.edu.cn/simple
```























