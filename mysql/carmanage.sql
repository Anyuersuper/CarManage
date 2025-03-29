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

 Date: 29/03/2025 04:38:26
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
INSERT INTO `cm_car` VALUES ('京A9999', 1, '兰博基尼', '2024-05', '正常');
INSERT INTO `cm_car` VALUES ('川A6666', 1, '奔驰', '2025-03', '正常');
INSERT INTO `cm_car` VALUES ('广A5555', 1, '劳斯莱斯', '2025-05', '正常');
INSERT INTO `cm_car` VALUES ('重A1234', 1, '长安福特1', '2025-01', '正常');

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
INSERT INTO `cm_order` VALUES ('OD1743191715268', NULL, 1, 355, '2025-03-29 19:48:16', '2025-03-29 03:55:21.289000', '已完成');

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
INSERT INTO `cm_pic` VALUES ('img1743191274429', 'SQ1743191274419', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743191274429_1_broken.png');
INSERT INTO `cm_pic` VALUES ('img1743192083446', 'SQ1743192083441', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743192083446_4_broken.png');
INSERT INTO `cm_pic` VALUES ('img1743192083457', 'SQ1743192083441', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743192083457_3_broken.png');
INSERT INTO `cm_pic` VALUES ('img1743192083462', 'SQ1743192083441', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743192083462_2_broken.png');
INSERT INTO `cm_pic` VALUES ('img1743193309978', 'SQ1743193309973', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743193309978_4_broken.png');
INSERT INTO `cm_pic` VALUES ('img1743193309984', 'SQ1743193309973', 'C:/Users/Yuer/Documents/workspace-spring-tool-suite-4-4.22.1.RELEASE/carmanage/src/main/resources/static/image/img1743193309984_3_broken.png');

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
INSERT INTO `cm_sub` VALUES ('SQ1743191274419', 1, '京A9999', '车灯损坏', '已通过');
INSERT INTO `cm_sub` VALUES ('SQ1743192083441', 1, '川A6666', '后视镜损坏', '已通过');
INSERT INTO `cm_sub` VALUES ('SQ1743193309973', 1, '广A5555', '车灯损坏', '审批中');
INSERT INTO `cm_sub` VALUES ('SQ1743193341748', 1, '重A1234', '座椅损坏', '审批中');

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
INSERT INTO `cm_usr` VALUES (1, 'admin', 'admin', 4);
INSERT INTO `cm_usr` VALUES (4, 'liuhua', '1', 1);
INSERT INTO `cm_usr` VALUES (2, 'shenpi', '1', 2);
INSERT INTO `cm_usr` VALUES (3, 'weixiu', '1', 3);
INSERT INTO `cm_usr` VALUES (5, 'weixiu1', '1', 3);

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
INSERT INTO `cm_workorder` VALUES ('GD1743191295959', 1, 3, '京A9999', '2025-03-29 19:48:16', '2025-03-29 03:55:15', '已完成');
INSERT INTO `cm_workorder` VALUES ('GD1743192520182', 1, 3, '川A6666', '2025-03-29 04:08:40', NULL, '处理中');

SET FOREIGN_KEY_CHECKS = 1;