/*
 Navicat Premium Data Transfer

 Source Server         : 82.157.101.15服务器数据库
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : 82.157.101.15:3306
 Source Schema         : glados

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 22/09/2022 17:40:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for power
-- ----------------------------
DROP TABLE IF EXISTS `power`;
CREATE TABLE `power`  (
  `EMAIL` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `COOKIE` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'cookie',
  `PUSH_PLUS_TOKEN` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推送加微信推送token'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of power
-- ----------------------------
INSERT INTO `power` VALUES ('1103455965@qq.com', '_ga=GA1.2.1042438543.1662621794; koa:sess=eyJ1c2VySWQiOjc1ODI1LCJfZXhwaXJlIjoxNjg4NTQxODk0MTQ2LCJfbWF4QWdlIjoyNTkyMDAwMDAwMH0=; koa:sess.sig=W5Qxvo77qTtsySEkT58FoZS-ZJo; __stripe_mid=4a4a8be9-77bc-49c0-8d42-402e0ac7d306ccfc71; _gid=GA1.2.1552200551.1663839016; _gat_gtag_UA_104464600_2=1', '6dc0c0dd0ef347239c0aaad2eecb1e58');
INSERT INTO `power` VALUES ('wgywmm@gmail.com', 'koa:sess=eyJ1c2VySWQiOjE3Mzc2NSwiX2V4cGlyZSI6MTY4MjIxNTE0Mjg2MSwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=PddqvNX3f2PvLkJJA8HpHRur8Ig', '2c295101ebb9404a944b176f0aad9afc');
INSERT INTO `power` VALUES ('819243425@qq.com', '_ga=GA1.2.1115722588.1655531801; koa:sess=eyJ1c2VySWQiOjEzMTM4OCwiX2V4cGlyZSI6MTY4MTQ1MTg1NDA5OSwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=BYxkx_N7vOGSIO-hoy2HaAGhLhw; _gid=GA1.2.1313836814.1656466507; _gat_gtag_UA_104464600_2=1; __cf_bm=mMjWU8M898U74l3mLxaXwGkgvfFr7Vst8qmI8t5Ej4k-1656466513-0-AYQVEB+14lPhjACiUbAkjxehcEfKmjyO77giOe7i7kedxySMM+hTqgBvxrz4yavEcAq/NwW4wzNdxixNhHEKwMt0/d2mbdJsn08IA85o38FsD1ZH3Drx84FDmL3ei7T1cw==', '1754b39c4c2a4141abba0f5f2efd129c');
INSERT INTO `power` VALUES ('1871229316@qq.com', 'GA1.2.1919745517.1662621908; _gid=GA1.2.127833677.1662621908; koa:sess=eyJ1c2VySWQiOjIwMTY3NSwiX2V4cGlyZSI6MTY4ODU0MjU5ODYyNSwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=2yRpW_iGXQt0U7oJdZ5_TOd0bhE; Cookie=enabled; Cookie.sig=lbtpENsrE0x6riM8PFTvoh9nepc; _gat_gtag_UA_104464600_2=1', '59a487740f874bd0b95ef9ca53557438');
INSERT INTO `power` VALUES ('wy_zhiwei_huang@163.com', '_ga=GA1.2.555041472.1662622289; _gid=GA1.2.1070167786.1662622289; koa:sess=eyJ1c2VySWQiOjIwMTY3NCwiX2V4cGlyZSI6MTY4ODU0MjM0Njg5NiwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=R9VlPvq7aa0bx2-D5N_B0Yt5vSk; _gat_gtag_UA_104464600_2=1', '66db51c66c3a4d1cbf0664d7a654a30d');
INSERT INTO `power` VALUES ('754728082@qq.com', '_ga=GA1.2.1233219128.1662634776; _gid=GA1.2.1273891377.1662634776; koa:sess=eyJ1c2VySWQiOjIwMTY3OSwiX2V4cGlyZSI6MTY4ODU1NDc5OTM1OCwiX21heEFnZSI6MjU5MjAwMDAwMDB9; koa:sess.sig=GXsEilS3DAEzJywPr3FnfTXlitE', '72d48f40edeb46debc020ee3d65522a0');

SET FOREIGN_KEY_CHECKS = 1;
