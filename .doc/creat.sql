-- ------------------------------
-- 创建管理员帐号表t_admin
-- ----------------------------
CREATE TABLE `t_admin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `creatDate` datetime DEFAULT NULL COMMENT '创建时间',
  `username` varchar(20) NOT NULL COMMENT '用户名',
  `password` varchar(12) NOT NULL DEFAULT '' COMMENT '用户密码',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `desc` varchar(32) NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8


-- ----------------------------
-- 添加3个管理帐号
-- ----------------------------
INSERT INTO `t_admin` VALUES ('1', 'admin', 'admin', '');

-- ----------------------------
-- 创建权限表t_role
-- ----------------------------
CREATE TABLE `t_role` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(40) NOT NULL DEFAULT '',
  `descpt` VARCHAR(40) NOT NULL DEFAULT '' COMMENT '角色描述',
  `category` VARCHAR(40) NOT NULL DEFAULT '' COMMENT '分类',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 加入4个操作权限
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', 'ROLE_ADMIN', '系统管理员', '系统管理员');


-- ----------------------------
-- 创建权限组表
-- ----------------------------
CREATE TABLE `t_group` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupname` VARCHAR(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 添加2个权限组
-- ----------------------------
INSERT INTO `t_group` VALUES ('1', 'Administrator');


-- ----------------------------
-- 创建权限组对应权限表t_group_role
-- ----------------------------
CREATE TABLE `t_group_role` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `groupid` BIGINT(20) UNSIGNED NOT NULL,
  `roleid` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `groupid2` (`groupid`,`roleid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `t_group_role_ibfk_1` FOREIGN KEY (`groupid`) REFERENCES `t_group` (`id`),
  CONSTRAINT `t_group_role_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 加入权限组与权限的对应关系
-- ----------------------------
INSERT INTO `t_group_role` VALUES ('1', '1', '1');


-- ----------------------------
-- 创建管理员所属权限组表t_group_user
-- ----------------------------
CREATE TABLE `t_group_user` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` BIGINT(20) UNSIGNED NOT NULL,
  `groupid` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `groupid` (`groupid`),
  CONSTRAINT `t_group_user_ibfk_2` FOREIGN KEY (`groupid`) REFERENCES `t_group` (`id`),
  CONSTRAINT `t_group_user_ibfk_3` FOREIGN KEY (`userid`) REFERENCES `t_admin` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ----------------------------
-- 将管理员加入权限组
-- ----------------------------
INSERT INTO `t_group_user` VALUES ('1', '1', '1');
INSERT INTO `t_group_user` VALUES ('2', '4', '2');

-- ----------------------------
-- 创建管理员对应权限表t_user_role
-- 设置该表可跳过权限组，为管理员直接分配权限
-- ----------------------------
CREATE TABLE `t_user_role` (
  `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` BIGINT(20) UNSIGNED NOT NULL,
  `roleid` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `roleid` (`roleid`),
  CONSTRAINT `t_user_role_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `t_admin` (`id`),
  CONSTRAINT `t_user_role_ibfk_2` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`id`)
) ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

INSERT INTO `t_user_role` VALUES ('1', '1', '1');