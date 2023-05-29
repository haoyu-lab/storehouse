# 基于chatGLM-6B模型预训练，添加自己的数据集微调（linux版）（ptuning & lora）

## 准备工作

### 安装7z

```shell
sudo apt install p7zip-full p7zip-rar
```



## ptuning预训练

### ChatGLM-6B-Ptuning.7z 懒人包下载

链接：https://pan.baidu.com/s/1v-7qWwj28lc6r1qNBzdZjw?pwd=vd2u 
提取码：vd2u 

### 上传文件并解压缩

```shell
# 提取完整路径文件
7z x -y ChatGLM-6B-Ptuning.7z -o/home/user/data
```

### 拉取依赖

```shell
pip3 install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
pip3 install tensorboard gradio mdtex2html -i https://pypi.tuna.tsinghua.edu.cn/simple
```



### 进行训练

训练前先上传自己的数据集 answers.json

我的数据集如下

```json
{"prompt": "你们公司有哪些产品", "response": "公司主要业务包括系统集成、软件开发、应用软件销售、技术服务、IT人才培训、互联网金融等领域。公司已经为银行、证券、期货、基金、保险等金融机构提供了全面的信息化建设解决方案，并在国内金融行业享有良好声誉。", "history": []}
{"prompt": "你是谁", "response": "我是北京北方金证科技有限公司智能助手小金，很高兴为您解答", "history": []}
{"prompt": "可以介绍一下你嘛", "response": "我是北京北方金证科技有限公司智能助手小金，是由北京北方金证软件部基于清华大学chatGLM大语言模型研发的，我的职责是负责解答您的各种问题", "history": []}
{"prompt": "谁开发的你", "response": "我是北京北方金证科技有限公司软件部开发的", "history": []}
{"prompt": "可以介绍一下你们公司么", "response": "北京北方金证科技有限公司成立于1993年，是一家专业从事金融信息化解决方案提供商和服务商的高科技企业。公司总部位于北京，在上海、深圳、广州、成都、西安等地设有分支机构。公司致力于为金融行业提供完整的信息化解决方案和优质的服务。", "history": []}
{"prompt": "你好", "response": "你好呀，我是北京北方金证科技有限公司智能助手小金，很高兴为您解答", "history": []}
```

编辑保存训练脚本

```shell
# 编辑新脚本
vi 01Ptuning.sh
# 输入如下并保存
cd ptuning
python3 main.py --do_train --train_file ../answers.json --validation_file ../dev.json --prompt_column prompt --response_column response --overwrite_cache --model_name_or_path ../model --output_dir ../output --overwrite_output_dir --max_source_length 256 --max_target_length 256 --per_device_train_batch_size 1 --per_device_eval_batch_size 1 --gradient_accumulation_steps 16 --predict_with_generate --max_steps 500 --logging_steps 10 --save_steps 50 --learning_rate 2e-2 --pre_seq_len 128
```

```shell
# 执行脚本
sh 01Ptuning.sh
```

### 启动服务

```shell
python3 web_demo.py
```

### 注意事项（揽睿星舟云算力平台）

使用揽睿星舟云算力平台启动服务时，需要使用 本机IP + 27777端口对外访问。

获取本机IP

```
hostname -I
```

然后复制本机IP，修改web_demo.py最后一行

```shell
# 原始
demo.queue().launch(share=True, inbrowser=True)

# 改为
demo.queue().launch(share=True, inbrowser=True, server_name='本机IP', server_port=27777)
```

然后再启动服务

## lora预训练

### chatGLM-All-In-One.7z懒人包下载

链接：https://pan.baidu.com/s/1vBFhEVPgIm6qAVaE4Bdfyg?pwd=d6zz 
提取码：d6zz 

### 上传文件并解压缩

```shell
# 提取完整路径文件
7z x -y chatGLM-All-In-One.7z -o/home/user/data
```

### 拉取依赖

```shell
pip3 install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
pip3 install tensorboard gradio mdtex2html -i https://pypi.tuna.tsinghua.edu.cn/simple
```

### 进行训练

训练前先上传自己的数据集 answers.json

编辑保存训练脚本

```shell
# 编辑新脚本
vi 03.sh
# 输入如下并保存
python3 finetune.py --dataset_path data --lora_rank 32 --per_device_train_batch_size 2 --gradient_accumulation_steps 1 --max_steps 400 --save_steps 50 --save_total_limit 2 --learning_rate 1e-4 --fp16 --remove_unused_columns false --logging_steps 50 --output_dir output
```

```shell
# 执行脚本
sh 03.sh
```

### 启动服务

```shell
python3 web_demo.py
```

### 注意事项（揽睿星舟云算力平台）

使用揽睿星舟云算力平台启动服务时，需要先获取本机IP

```
hostname -I
```

然后复制本机IP，修改web_demo.py最后一行

```shell
# 原始
demo.queue().launch(share=True, inbrowser=True)

# 改为
demo.queue().launch(share=True, inbrowser=True, server_name='本机IP', server_port=27777)
```

然后再启动服务

## 展示

![image-20230426150855034](C:\Users\11034\AppData\Roaming\Typora\typora-user-images\image-20230426150855034.png)
