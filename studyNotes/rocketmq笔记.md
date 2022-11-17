# rocketmq笔记

## 1. rocketmq概述

- RocketMQ是使用Java语言开发的一款MQ产品。经过数年阿里双 11 的考验，性能与稳定性非常高。其没有遵循任何常见的MQ协议，而是使用自研协议。对于Spring Cloud Alibaba，其支持RabbitMQ、Kafka，但提倡使用RocketMQ。

### 1.1 对比

| 关键词     | ACTIVEMQ | RABBITMQ | KAFKA                       | ROCKETMQ                  |
| ---------- | -------- | -------- | --------------------------- | ------------------------- |
| 开发语言   | Java     | ErLang   | Java                        | Java                      |
| 单机吞吐量 | 万级     | 万级     | 十万级                      | 十万级                    |
| Topic      | -        | -        | 百级Topic时会影响系统吞吐量 | 千级Topic时会影响系统吞吐 |
| 社区活跃度 | 低       | 高       | 高                          | 高                        |