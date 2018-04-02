
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_item`;
CREATE TABLE `t_item` (
  `itemId` int(11) NOT NULL auto_increment COMMENT 'ItemId',
  `itemClassObj` int(11) NOT NULL COMMENT 'ItemClass',
  `pTitle` varchar(80) NOT NULL COMMENT 'ItemTitle',
  `itemPhoto` varchar(60) NOT NULL COMMENT 'ItemPhoto',
  `itemDesc` varchar(5000) NOT NULL COMMENT 'ItemDescription',
  `userObj` varchar(20) NOT NULL COMMENT 'Poster',
  `startPrice` float NOT NULL COMMENT 'StartPrice',
  `startTime` varchar(20) default NULL COMMENT 'StartTime',
  `endTime` varchar(20) default NULL COMMENT 'Endtime',
  PRIMARY KEY  (`itemId`),
  KEY `itemClassObj` (`itemClassObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_item_ibfk_1` FOREIGN KEY (`itemClassObj`) REFERENCES `t_itemclass` (`classId`),
  CONSTRAINT `t_item_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_item
-- ----------------------------
INSERT INTO `t_item` VALUES ('1', '1', 'Database System Concepts 6th Edition', 'upload/dbsc.jpg', 'Textbook for the course', 'user1', '30', '2017-12-14 15:09:35', '2017-12-17 15:14:35');
INSERT INTO `t_item` VALUES ('2', '1', 'Discrete Mathematics', 'upload/dm.jpg', 'A nice book for cs major starter', 'user1', '35', '2017-12-14 15:29:52', '2017-12-18 15:34:52');
INSERT INTO `t_item` VALUES ('3', '2', 'Toy Car', 'upload/toycar.jpg', 'A nice car with led lights', 'user1', '60', '2017-12-14 15:36:31', '2017-12-14 15:41:31');

-- ----------------------------
-- Table structure for `t_itemclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_itemclass`;
CREATE TABLE `t_itemclass` (
  `classId` int(11) NOT NULL auto_increment COMMENT 'ItemClassId',
  `className` varchar(50) NOT NULL COMMENT 'ClassName',
  `classDesc` varchar(2000) NOT NULL COMMENT 'ClassDescription',
  PRIMARY KEY  (`classId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_itemclass
-- ----------------------------
INSERT INTO `t_itemclass` VALUES ('1', 'Book', 'Including Hardcopy and E-books');
INSERT INTO `t_itemclass` VALUES ('2', 'Toys', 'For the children');
INSERT INTO `t_itemclass` VALUES ('3', 'Clothes', 'Fancy style');
INSERT INTO `t_itemclass` VALUES ('4', 'Electronics', 'Geeks favorite');
INSERT INTO `t_itemclass` VALUES ('5', 'Furniture', 'Tables and chairs');

-- ----------------------------
-- Table structure for `t_postinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_postinfo`;
CREATE TABLE `t_postinfo` (
  `postInfoId` int(11) NOT NULL auto_increment COMMENT 'PostId',
  `pTitle` varchar(80) NOT NULL COMMENT 'PostTitle',
  `content` varchar(5000) NOT NULL COMMENT 'PostContent',
  `userObj` varchar(20) NOT NULL COMMENT 'Poster',
  `addTime` varchar(20) default NULL COMMENT 'PostTime',
  `hitNum` int(11) NOT NULL COMMENT 'Views',
  PRIMARY KEY  (`postInfoId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_postinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_postinfo
-- ----------------------------
INSERT INTO `t_postinfo` VALUES ('1', 'Hello, World!', 'I like this website！', 'user1', '2017-12-14 15:16:36', '60');
INSERT INTO `t_postinfo` VALUES ('2', '2234', '2324', 'user2', '2017-12-15 16:32:32', '2');

-- ----------------------------
-- Table structure for `t_productbidding`
-- ----------------------------
DROP TABLE IF EXISTS `t_productbidding`;
CREATE TABLE `t_productbidding` (
  `biddingId` int(11) NOT NULL auto_increment COMMENT 'BiddingId',
  `itemObj` int(11) NOT NULL COMMENT 'Item',
  `userObj` varchar(20) NOT NULL COMMENT 'Bidder',
  `biddingTime` varchar(20) default NULL COMMENT 'BiddingTime',
  `biddingPrice` float NOT NULL COMMENT 'BiddingPrice',
  PRIMARY KEY  (`biddingId`),
  KEY `itemObj` (`itemObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_productbidding_ibfk_1` FOREIGN KEY (`itemObj`) REFERENCES `t_item` (`itemId`),
  CONSTRAINT `t_productbidding_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_productbidding
-- ----------------------------
INSERT INTO `t_productbidding` VALUES ('1', '1', 'user2', '2017-12-14 15:10:06', '3100');
INSERT INTO `t_productbidding` VALUES ('3', '1', 'user2', '2017-12-14 15:11:45', '3200');
INSERT INTO `t_productbidding` VALUES ('4', '1', 'user2', '2017-12-14 18:20:36', '3300');
INSERT INTO `t_productbidding` VALUES ('5', '1', 'user2', '2017-12-14 18:21:20', '3400');
INSERT INTO `t_productbidding` VALUES ('6', '2', 'user2', '2017-12-14 18:23:51', '3600');
INSERT INTO `t_productbidding` VALUES ('7', '1', 'user2', '2017-12-15 18:07:01', '3500');
INSERT INTO `t_productbidding` VALUES ('8', '1', 'user3', '2017-12-15 18:16:46', '3620');

-- ----------------------------
-- Table structure for `t_reply`
-- ----------------------------
DROP TABLE IF EXISTS `t_reply`;
CREATE TABLE `t_reply` (
  `replyId` int(11) NOT NULL auto_increment COMMENT 'ReplyId',
  `postInfoObj` int(11) NOT NULL COMMENT 'OriginalPost',
  `content` varchar(2000) NOT NULL COMMENT 'ReplyContent',
  `userObj` varchar(20) NOT NULL COMMENT 'Replier',
  `replyTime` varchar(20) default NULL COMMENT 'ReplyTime',
  PRIMARY KEY  (`replyId`),
  KEY `postInfoObj` (`postInfoObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_reply_ibfk_1` FOREIGN KEY (`postInfoObj`) REFERENCES `t_postinfo` (`postInfoId`),
  CONSTRAINT `t_reply_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_reply
-- ----------------------------
INSERT INTO `t_reply` VALUES ('1', '1', 'Hi! Nice to meet you!', 'user2', '2017-12-14 15:16:45');
INSERT INTO `t_reply` VALUES ('2', '1', 'Hi! Where are you from?', 'user1', '2017-12-15 17:29:03');

-- ----------------------------
-- Table structure for `t_userfollow`
-- ----------------------------
DROP TABLE IF EXISTS `t_userfollow`;
CREATE TABLE `t_userfollow` (
  `followId` int(11) NOT NULL auto_increment COMMENT 'FollowId',
  `userObj1` varchar(20) NOT NULL COMMENT 'Followed',
  `userObj2` varchar(20) NOT NULL COMMENT 'Follower',
  `followTime` varchar(20) default NULL COMMENT 'FollowTime',
  PRIMARY KEY  (`followId`),
  KEY `userObj1` (`userObj1`),
  KEY `userObj2` (`userObj2`),
  CONSTRAINT `t_userfollow_ibfk_1` FOREIGN KEY (`userObj1`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_userfollow_ibfk_2` FOREIGN KEY (`userObj2`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userfollow
-- ----------------------------
INSERT INTO `t_userfollow` VALUES ('7', 'user1', 'user2', '2017-12-15 18:06:33');
INSERT INTO `t_userfollow` VALUES ('8', 'user1', 'user3', '2017-12-15 18:17:06');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(20) NOT NULL COMMENT 'User_name',
  `password` varchar(20) NOT NULL COMMENT 'Password',
  `name` varchar(20) NOT NULL COMMENT 'Name',
  `gender` varchar(4) NOT NULL COMMENT 'Gender',
  `birthDate` varchar(20) default NULL COMMENT 'DOB',
  `userImage` varchar(60) NOT NULL COMMENT 'Photo',
  `telephone` varchar(20) NOT NULL COMMENT 'Phone',
  `city` varchar(20) NOT NULL COMMENT 'City',
  `address` varchar(80) NOT NULL COMMENT 'Address',
  `email` varchar(50) default NULL COMMENT 'Email',
  `paypalAccount` varchar(20) NOT NULL COMMENT 'paypalAccount',
  `createTime` varchar(20) default NULL COMMENT 'CreateTime',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', 'Xiaotian Bai', 'Male', '2017-12-06', 'upload/user1.jpg', '6178004198', 'New York', '2 MetroTech Center', 'xb306@nyu.edu', 'xb306@nyu.edu', '2017-12-14 15:04:12');
INSERT INTO `t_userinfo` VALUES ('user2', '123', 'Lily Wong', 'Fem', '2017-12-07', 'upload/user2.jpg', '1001112233', 'Boston', '515 Alpha St.', 'a@gmail.com', 'b@gmail.com', '2017-12-14 15:12:33');
INSERT INTO `t_userinfo` VALUES ('user3', '123', 'Mary', 'Fem', '2017-12-01', 'upload/user3.jpg', '1001112244', 'Miami', '10 CityCentral', 'c@gmail.com', 'd@gmail.com', '2017-12-15 18:16:20');
