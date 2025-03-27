/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : carmanage

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 27/03/2025 10:17:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cm_car
-- ----------------------------
DROP TABLE IF EXISTS `cm_car`;
CREATE TABLE `cm_car`  (
  `carid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `kind` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `year` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`carid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  CONSTRAINT `cm_car_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `cm_usr` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cm_car
-- ----------------------------
INSERT INTO `cm_car` VALUES ('重庆1', 1, '奔驰', '2025-03', '正常');
INSERT INTO `cm_car` VALUES ('重庆2', 1, '劳斯莱斯', '2025-03', '正常');
INSERT INTO `cm_car` VALUES ('重庆3', 1, '兰博基尼', '2024-01', '正常');
INSERT INTO `cm_car` VALUES ('重庆8', 1, '奔驰', '2000-5', '正常');

-- ----------------------------
-- Table structure for cm_order
-- ----------------------------
DROP TABLE IF EXISTS `cm_order`;
CREATE TABLE `cm_order`  (
  `orderid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `carid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `uid` int(11) NOT NULL,
  `money` int(255) NULL DEFAULT NULL,
  `starttime` datetime NULL DEFAULT NULL,
  `finishedtime` datetime(6) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `carid`(`carid`) USING BTREE,
  CONSTRAINT `cm_order_ibfk_1` FOREIGN KEY (`carid`) REFERENCES `cm_car` (`carid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cm_order_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `cm_usr` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cm_order
-- ----------------------------

-- ----------------------------
-- Table structure for cm_pic
-- ----------------------------
DROP TABLE IF EXISTS `cm_pic`;
CREATE TABLE `cm_pic`  (
  `picid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `subid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `filepath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`picid`) USING BTREE,
  INDEX `subid`(`subid`) USING BTREE,
  CONSTRAINT `cm_pic_ibfk_1` FOREIGN KEY (`subid`) REFERENCES `cm_sub` (`subid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cm_pic
-- ----------------------------
INSERT INTO `cm_pic` VALUES ('img1743039909573', 'SQ1743039909571', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743039909573_5d722d4fedbba.jpg');

-- ----------------------------
-- Table structure for cm_sub
-- ----------------------------
DROP TABLE IF EXISTS `cm_sub`;
CREATE TABLE `cm_sub`  (
  `subid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `carid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`subid`) USING BTREE,
  INDEX `uid`(`carid`) USING BTREE,
  INDEX `uid_2`(`uid`) USING BTREE,
  CONSTRAINT `cm_sub_ibfk_1` FOREIGN KEY (`carid`) REFERENCES `cm_car` (`carid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cm_sub_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `cm_usr` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cm_sub
-- ----------------------------
INSERT INTO `cm_sub` VALUES ('SQ1743039909571', 1, '重庆1', '车灯损坏', '已通过');

-- ----------------------------
-- Table structure for cm_usr
-- ----------------------------
DROP TABLE IF EXISTS `cm_usr`;
CREATE TABLE `cm_usr`  (
  `uid` int(11) NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `authority` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cm_usr
-- ----------------------------
INSERT INTO `cm_usr` VALUES (3, '3', '3', 3);
INSERT INTO `cm_usr` VALUES (1, 'admin', 'admin', 4);
INSERT INTO `cm_usr` VALUES (4, 'ceshi', '12345678a', 1);
INSERT INTO `cm_usr` VALUES (2, 'liuhua', 'liuhua', 2);

-- ----------------------------
-- Table structure for cm_workorder
-- ----------------------------
DROP TABLE IF EXISTS `cm_workorder`;
CREATE TABLE `cm_workorder`  (
  `workorderid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `cmuid` int(11) NULL DEFAULT NULL,
  `carid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `starttime` datetime NULL DEFAULT NULL,
  `finishedtime` datetime NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`workorderid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `cmuid`(`cmuid`) USING BTREE,
  INDEX `carid`(`carid`) USING BTREE,
  CONSTRAINT `cm_workorder_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `cm_usr` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cm_workorder_ibfk_2` FOREIGN KEY (`cmuid`) REFERENCES `cm_usr` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cm_workorder_ibfk_3` FOREIGN KEY (`carid`) REFERENCES `cm_car` (`carid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cm_workorder
-- ----------------------------
INSERT INTO `cm_workorder` VALUES ('GD1742998811575', 1, 3, NULL, '2025-03-26 22:20:12', NULL, '处理中');
INSERT INTO `cm_workorder` VALUES ('GD1743041283161', 1, 3, NULL, '2025-03-27 10:08:03', NULL, '处理中');

SET FOREIGN_KEY_CHECKS = 1;
