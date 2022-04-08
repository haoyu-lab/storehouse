# Markdown安装和使用 #
## 认识Markdown ##
  Markdown是一种 [标记语言]，通常为程序员群体所用，也是国际杂志编辑和写作者广泛使用的标记语言。

  应运而生：使用word或pages写作，可能会因为操作系统不同而出现格式问题。使用txt写作，又苦于没有排版。

  Markdown语法十分简单，常用的标记符号不超过十个，不到半小时就能完全掌握，却能让人专注内容而不是纠结排版。

  优点：
（1）纯文本，兼容性极强
（2）专注文字而不是排版
（3）格式转换方便，可以轻松转换为html、电子书等
（4）标记语法具有极好的可读性。

## 语法 ##
标题使用#
列表使用
引用使用>
粗体使用一对**包含文字
斜体使用一对*包含文字、
插入图片：![]（）
插入文本链接：[]（）（使用英文括号即可，此处中文括号是为了显示）
代办清单：-[x]表示已完成项目，-[]表示未完成项目
表格：使用 | 来分隔不同的单元格，使用 - 来分隔表头和其他行
流程图、序列图、甘特图
## 安装Markdown ##
 1. Windows安装包：http://markdownpad.com/download/markdownpad2-setup.exe，正常安装即可。

  2. 使用收费版需要提交key，感谢dalao的注册码：
邮箱：Soar360@live.com
授权秘钥：
GBPduHjWfJU1mZqcPM3BikjYKF6xKhlKIys3i1MU2eJHqWGImDHzWdD6xhMNLGVpbP2M5SN6bnxn2kSE8qHqNY5QaaRxmO3YSMHxlv2EYpjdwLcPwfeTG7kUdnhKE0vVy4RidP6Y2wZ0q74f47fzsZo45JE2hfQBFi2O9Jldjp1mW8HUpTtLA2a5/sQytXJUQl/QKO0jUQY4pa5CCx20sV1ClOTZtAGngSOJtIOFXK599sBr5aIEFyH0K7H4BoNMiiDMnxt1rD8Vb/ikJdhGMMQr0R4B+L3nWU97eaVPTRKfWGDE8/eAgKzpGwrQQoDh+nzX1xoVQ8NAuH+s4UcSeQ==
  效果如图：
![](https://img-blog.csdnimg.cn/20210302113749834.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NvbGRpX2Vy,size_16,color_FFFFFF,t_70)

错

  实时预览报错如下，缺少实时预览的引擎，相当于html解析的引擎。

![](https://img-blog.csdnimg.cn/20210302205047754.png)

  下载地址：（该说不说，晚上的下载速度too slow）
http://markdownpad.com/download/awesomium_v1.6.6_sdk_win.exe

  安装之后，重新打开markdownPad2会自动载入，实时预览√。

## 使用记录 ##
### 为md文件生成跳转目录 ###
命令行安装依赖 npm install --save markdown-toc：

![](https://img-blog.csdnimg.cn/20210304082719829.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NvbGRpX2Vy,size_16,color_FFFFFF,t_70)

![](https://img-blog.csdnimg.cn/20210304082805667.png)

![](https://img-blog.csdnimg.cn/20210304082834201.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NvbGRpX2Vy,size_16,color_FFFFFF,t_70)