/*==============================================================*/

drop database if exists csystem;

create database csystem DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


USE `csystem`;

drop table if exists apply_exam_info;

drop table if exists book;

drop table if exists certificate;

drop table if exists course;

drop table if exists evidence;

drop table if exists exam_classroom;

drop table if exists exam_location;

drop table if exists exam_province;

drop table if exists free_exam_apply;

drop table if exists grade;

drop table if exists grade_retrial;

drop table if exists major;

drop table if exists school;

drop table if exists user;

drop table if exists violation;
drop table if exists permission;
drop table if exists role;
drop table if exists role_permission;
drop table if exists user_role;
drop table if exists notice;
CREATE TABLE `apply_exam_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `exam_classroom_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0涓烘湭鏀粯銆�1涓哄凡鏀粯',
  `result` int(11) NOT NULL DEFAULT '0' COMMENT '0涓烘姤鑰冧俊鎭棤鏁堛��1涓烘姤鑰冧俊鎭悎鏍�',
  `exam_number` varchar(20) NOT NULL DEFAULT '0000000000' COMMENT '寰呭垎閰�',
  `seat_number` int(11) NOT NULL DEFAULT '0' COMMENT '寰呭垎閰�',
  `location_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

create table permission(
id int auto_increment,
name varchar(20) not null,
remark varchar(50) not null,
url varchar(20) not null,
startdate date,
updatedate date,
primary key(id)
);

create table role(
id int auto_increment,
name varchar(20),
remark varchar(100),
startdate date,
updatedate date,
primary key(id)
);

create table user_role(
id int auto_increment,
uid int,
rid int,
primary key(id)
);

create table role_permission(
id int auto_increment,
rid int,
pid int,
primary key(id)
);

/*==============================================================*/
/* Table: book                                                  */
/*==============================================================*/
create table book
(
   id                   int not null,
   name                 varchar(20) not null default 'xxx',
   author               varchar(20) not null default 'xxx',
   house                varchar(20) not null default 'xxx',
   pdate                date not null default '1998-01-01',
   price                double not null default 0,
   primary key (id)
);

/*==============================================================*/
/* Table: course                                                */
/*==============================================================*/
create table course
(
   id                   int auto_increment,
   book_id              int,
   major_id             int,
   normal_credits       real not null default 0 comment '正常考试通过获得的学分',
   free_credits         real not null default 0 comment '免考申请成功后获得的学分',
   free_grade           real not null default 0 comment '免考申请成功后获得的成绩',
   status               int not null default 0 comment '课程启用（开考）为1、停用为0',
   type                 int not null default 0 comment '公共为0、基础为1、核心为2、实践为3',
   cost                 double not null default 0 comment '报考该课程费用',
   grade_proportion     real not null default 0.5 comment '平时分与考试成绩对总评的影响程度',
   start_time           datetime not null ,
   end_time             datetime not null ,
   exam_time            datetime not null ,
   course_name          varchar(20) not null ,
   primary key (id)
);

CREATE TABLE `user` (
  `name` varchar(50) NOT NULL,
  `password` varchar(50) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `wholename` varchar(50) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `updatedate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

create table grade
(
   id                   int not null,
   user_id              int,
   course_id            int,
   grade                real not null default 0,
   usual_grade          real not null default 0,
   final_grade          real not null default 0,
   remark               varchar(50) not null default '无备注',
   primary key (id)
);


create table major
(
   id             int auto_increment,
   name           varchar(50) not null,
   status         int not null comment '停用、启用状态
            true表示启用
            false表示停用',
   flag          int not null comment '标记该专业是否删除
            true表示已删除
            false表示没删除',
   area           varchar(50) not null comment '说明是哪个地区的专业',
   details              text,
   primary key (id)
);


/*codeforcity 城市的代号*/
DROP TABLE IF EXISTS `codeforcity`;

CREATE TABLE `codeforcity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `citycode` int(2) unsigned zerofill NOT NULL,
  `city_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `city_name_UNIQUE` (`city_name`),
  UNIQUE KEY `citycode_UNIQUE` (`citycode`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;


--
-- Dumping data for table `codeforcity`
--



INSERT INTO `codeforcity` VALUES (1,01,'成都市'),(2,03,'自贡市'),(3,04,'攀枝花市'),(4,05,'泸州市'),(5,06,'德阳市'),(6,07,'绵阳市'),(7,08,'广元市'),(8,09,'遂宁市'),(9,10,'内江市'),(10,11,'乐山市'),(11,13,'南充市'),(12,14,'眉山市'),(13,15,'宜宾市'),(14,16,'广安市'),(15,17,'达州市'),(16,18,'雅安市'),(17,19,'巴中市'),(18,20,'资阳市'),(19,32,'阿坝藏族羌族自治州'),(20,33,'甘孜藏族自治州'),(21,34,'凉山彝族自治州');




/*codefordistrict 区/县的代号*/
DROP TABLE IF EXISTS `codefordistrict`;

CREATE TABLE `codefordistrict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `districtcode` int(2) unsigned zerofill NOT NULL,
  `district_name` varchar(20) NOT NULL,
  `citycode` int(2) unsigned zerofill NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CITYID_idx` (`citycode`),
  CONSTRAINT `FK_CITYID` FOREIGN KEY (`citycode`) REFERENCES `codeforcity` (`citycode`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8;


--
-- Dumping data for table `codefordistrict`
--


INSERT INTO `codefordistrict` VALUES (1,04,'锦江区',01),(2,05,'青羊区',01),(3,06,'金牛区',01),(4,07,'武侯区',01),(5,08,'成华区',01),(6,12,'龙泉驿区',01),(7,13,'青白江区',01),(8,14,'新都区',01),(9,15,'温江区',01),(10,21,'金堂县',01),(11,22,'双流县',01),(12,24,'郫县',01),(13,29,'大邑县',01),(14,31,'蒲江县',01),(15,32,'新津县',01),(16,81,'都江堰市',01),(17,82,'彭州市',01),(18,83,'邛崃市',01),(19,84,'崇州市',01),(20,02,'自流井区',03),(21,03,'贡井区',03),(22,04,'大安区',03),(23,11,'沿滩区',03),(24,21,'荣县',03),(25,22,'富顺县',03),(26,02,'东区',04),(27,03,'西区',04),(28,11,'仁和区',04),(29,21,'米易县',04),(30,22,'盐边县',04),(31,02,'江阳区',05),(32,03,'纳溪区',05),(33,04,'龙马潭区',05),(34,21,'泸县',05),(35,22,'合江县',05),(36,24,'叙永县',05),(37,25,'古蔺县',05),(38,03,'旌阳区',06),(39,23,'中江县',06),(40,26,'罗江县',06),(41,81,'广汉市',06),(42,82,'什邡市',06),(43,83,'绵竹市',06),(44,03,'涪城区',07),(45,04,'游仙区',07),(46,22,'三台县',07),(47,23,'盐亭县',07),(48,24,'安县',07),(49,25,'梓潼县',07),(50,26,'北川羌族自治县',07),(51,27,'平武县',07),(52,81,'江油市',07),(53,02,'利州区',08),(54,11,'昭化区',08),(55,12,'朝天区',08),(56,21,'旺苍县',08),(57,22,'青川县',08),(58,23,'剑阁县',08),(59,24,'苍溪县',08),(60,03,'船山区',09),(61,04,'安居区',09),(62,21,'蓬溪县',09),(63,22,'射洪县',09),(64,23,'大英县',09),(65,02,'市中区',10),(66,11,'东兴区',10),(67,24,'威远县',10),(68,25,'资中县',10),(69,28,'隆昌县',10),(70,02,'市中区',11),(71,11,'沙湾区',11),(72,12,'五通桥区',11),(73,13,'金口河区',11),(74,23,'犍为县',11),(75,24,'井研县',11),(76,26,'夹江县',11),(77,29,'沐川县',11),(78,32,'峨边彝族自治县',11),(79,33,'马边彝族自治县',11),(80,81,'峨眉山市',11),(81,02,'顺庆区',13),(82,03,'高坪区',13),(83,04,'嘉陵区',13),(84,21,'南部县',13),(85,22,'营山县',13),(86,23,'蓬安县',13),(87,24,'仪陇县',13),(88,25,'西充县',13),(89,81,'阆中市',13),(90,02,'东坡区',14),(91,03,'彭山区',14),(92,21,'仁寿县',14),(93,23,'洪雅县',14),(94,24,'丹棱县',14),(95,25,'青神县',14),(96,02,'翠屏区',15),(97,03,'南溪区',15),(98,21,'宜宾县',15),(99,23,'江安县',15),(100,24,'长宁县',15),(101,25,'高县',15),(102,26,'珙县',15),(103,27,'筠连县',15),(104,28,'兴文县',15),(105,29,'屏山县',15),(106,02,'广安区',16),(107,03,'前锋区',16),(108,21,'岳池县',16),(109,22,'武胜县',16),(110,23,'邻水县',16),(111,81,'华蓥市',16),(112,02,'通川区',17),(113,03,'达川区',17),(114,22,'宣汉县',17),(115,23,'开江县',17),(116,24,'大竹县',17),(117,25,'渠县',17),(118,81,'万源市',17),(119,02,'雨城区',18),(120,03,'名山区',18),(121,22,'荥经县',18),(122,23,'汉源县',18),(123,24,'石棉县',18),(124,25,'天全县',18),(125,26,'芦山县',18),(126,27,'宝兴县',18),(127,02,'巴州区',19),(128,03,'恩阳区',19),(129,21,'通江县',19),(130,22,'南江县',19),(131,23,'平昌县',19),(132,02,'雁江区',20),(133,21,'安岳县',20),(134,22,'乐至县',20),(135,81,'简阳市',20),(136,21,'汶川县',32),(137,22,'理县',32),(138,23,'茂县',32),(139,24,'松潘县',32),(140,25,'九寨沟县',32),(141,26,'金川县',32),(142,27,'小金县',32),(143,28,'黑水县',32),(144,29,'马尔康县',32),(145,30,'壤塘县',32),(146,31,'阿坝县',32),(147,32,'若尔盖县',32),(148,33,'红原县',32),(149,01,'康定市',33),(150,22,'泸定县',33),(151,23,'丹巴县',33),(152,24,'九龙县',33),(153,25,'雅江县',33),(154,26,'道孚县',33),(155,27,'炉霍县',33),(156,28,'甘孜县',33),(157,29,'新龙县',33),(158,30,'德格县',33),(159,31,'白玉县',33),(160,32,'石渠县',33),(161,33,'色达县',33),(162,34,'理塘县',33),(163,35,'巴塘县',33),(164,36,'乡城县',33),(165,37,'稻城县',33),(166,38,'得荣县',33),(167,01,'西昌市',34),(168,22,'木里藏族自治县',34),(169,23,'盐源县',34),(170,24,'德昌县',34),(171,25,'会理县',34),(172,26,'会东县',34),(173,27,'宁南县',34),(174,28,'普格县',34),(175,29,'布拖县',34),(176,30,'金阳县',34),(177,31,'昭觉县',34),(178,32,'喜德县',34),(179,33,'冕宁县',34),(180,34,'越西县',34),(181,35,'甘洛县',34),(182,36,'美姑县',34),(183,37,'雷波县',34);



/*examlocation*/
DROP TABLE IF EXISTS `exam_location`;

CREATE TABLE `exam_location` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `location` varchar(100) NOT NULL DEFAULT '四川大学',
  `location_status` int(11) NOT NULL DEFAULT '0' COMMENT '1为启用、0为停用',
  `citycode` int(2) unsigned zerofill NOT NULL,
  `districtcode` int(2) unsigned zerofill NOT NULL,
  `majorid` int(10) unsigned zerofill DEFAULT NULL,
  `capacity` int(2) NOT NULL,
  `totalcapacity` int(11) DEFAULT NULL,
  `code` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `majorid_UNIQUE` (`majorid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='可理解为某个学校的地点';



/*exam_classroom*/
DROP TABLE IF EXISTS `exam_classroom`;

CREATE TABLE `exam_classroom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_location_id` int(11) DEFAULT NULL,
  `teaching_building` varchar(20) NOT NULL DEFAULT '第一教学楼',
  `classroom` varchar(20) NOT NULL DEFAULT '101',
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_location_id` (`exam_location_id`,`teaching_building`,`classroom`)
) ENGINE=InnoDB AUTO_INCREMENT=475 DEFAULT CHARSET=utf8 COMMENT='可理解为教室地址';





insert into permission(name,remark,url) values("major:add","添加专业","/major/majorInsert");
insert into permission(name,remark,url) values("major:delete","删除专业","/major/majorDelete");
insert into permission(name,remark,url) values("major:update","修改专业","/major/majorUpdate");
insert into permission(name,remark,url) values("major:search","查看专业","/major/majorSearch");
insert into permission(name,remark,url) values("major:select","专业管理","/major/selectMajor");
insert into permission(name,remark,url) values("major:start","启动专业","/major/majorStart");
insert into permission(name,remark,url) values("major:upload","导入专业","/major/majorUpload");
insert into permission(name,remark,url) values("course:add","添加课程","/course/courseInsert");
insert into permission(name,remark,url) values("course:delete","删除课程","/course/courseDelete");
insert into permission(name,remark,url) values("user:select","用户管理","/user/selectUser");
insert into permission(name,remark,url) values("role:select","角色管理","/role/selectRole");
insert into permission(name,remark,url) values("perm:select","权限管理","/permission/selectPermission");




insert into role(name,remark) values("超级管理员","权力是最大的");
insert into role(name,remark) values("普通管理员","权限次于超级管理员");
insert into role(name,remark) values("老师","老师具有管理成绩的功能");
insert into role(name,remark) values("学生","学生的权限是最低的");
insert into role(name,remark) values("未定义","没有分配角色");

insert into User(name,password) values("sadmin","123");
insert into User(name,password) values("admin1","123");
insert into User(name,password) values("stu1","123");
insert into User(name,password) values("stu2","123");

insert into user_role(uid,rid) values(1,1);
insert into user_role(uid,rid) values(2,2);
insert into user_role(uid,rid) values(3,4);
insert into user_role(uid,rid) values(4,4);

insert into role_permission(rid,pid) values (1,1);
insert into role_permission(rid,pid) values (1,2);
insert into role_permission(rid,pid) values (1,3);
insert into role_permission(rid,pid) values (1,4);
insert into role_permission(rid,pid) values (1,5);
insert into role_permission(rid,pid) values (1,6);
insert into role_permission(rid,pid) values (1,7);
insert into role_permission(rid,pid) values (1,8);
insert into role_permission(rid,pid) values (1,9);
insert into role_permission(rid,pid) values (1,10);
insert into role_permission(rid,pid) values (1,11);
insert into role_permission(rid,pid) values (1,12);



-- ----------------------------
-- Records of apply_exam_info
-- ----------------------------
INSERT INTO `apply_exam_info` VALUES ('41', '124', '2', '3', '0', '1', '0124002003001', '1', '1');
INSERT INTO `apply_exam_info` VALUES ('42', '125', '2', '3', '0', '1', '0125002003002', '2', '1');
INSERT INTO `apply_exam_info` VALUES ('43', '126', '2', '3', '0', '1', '0126002003003', '3', '1');
INSERT INTO `apply_exam_info` VALUES ('44', '127', '2', '3', '0', '0', '0127002003004', '4', '1');
INSERT INTO `apply_exam_info` VALUES ('45', '128', '2', '3', '0', '0', '0128002003005', '5', '1');
INSERT INTO `apply_exam_info` VALUES ('46', '129', '2', '3', '0', '0', '0129002003006', '6', '1');
INSERT INTO `apply_exam_info` VALUES ('47', '130', '2', '3', '0', '0', '0130002003007', '7', '1');
INSERT INTO `apply_exam_info` VALUES ('48', '131', '2', '3', '0', '0', '0131002003008', '8', '1');
INSERT INTO `apply_exam_info` VALUES ('49', '132', '2', '3', '0', '0', '0132002003009', '9', '1');
INSERT INTO `apply_exam_info` VALUES ('50', '133', '2', '3', '0', '0', '0133002003010', '10', '1');
INSERT INTO `apply_exam_info` VALUES ('51', '134', '2', '3', '0', '0', '0134002003011', '11', '1');
INSERT INTO `apply_exam_info` VALUES ('52', '135', '2', '3', '0', '0', '0135002003012', '12', '1');
INSERT INTO `apply_exam_info` VALUES ('53', '136', '2', '3', '0', '0', '0136002003013', '13', '1');
INSERT INTO `apply_exam_info` VALUES ('54', '126', '1', '2', '0', '0', '000000000', '10', '1');
INSERT INTO `apply_exam_info` VALUES ('55', '128', '1', '2', '0', '0', '000000000', '10', '1');
INSERT INTO `apply_exam_info` VALUES ('56', '1', '0', '0', '0', '0', '000000000', '0', '1');
INSERT INTO `apply_exam_info` VALUES ('57', '1', '2', '0', '0', '0', '000000000', '0', '1');
INSERT INTO `apply_exam_info` VALUES ('58', '1', '1', '0', '0', '0', '000000000', '0', '1');
INSERT INTO `apply_exam_info` VALUES ('59', '1', '1', '0', '0', '0', '000000000', '0', '1');
INSERT INTO `apply_exam_info` VALUES ('60', '1', '1', '0', '0', '0', '000000000', '0', '1');
INSERT INTO `apply_exam_info` VALUES ('61', '1', '0', '0', '0', '0', '000000000', '0', '1');
INSERT INTO `apply_exam_info` VALUES ('1', '1', '1', '0', '0', '0', '0000000000', '0', '11');
INSERT INTO `apply_exam_info` VALUES ('62', '1', '1', '0', '0', '0', '000000000', '0', '1');

create table notice(
    id int(11) NOT NULL AUTO_INCREMENT comment "主键ID",
	gstate int(11) not null,
    astate int(11) not null,
    primary key(id)
);

insert into notice values(1,0,0);

/*视图*/
USE `csystem`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    SQL SECURITY DEFINER
VIEW `max_locationid` AS
    SELECT 
        MAX(`exam_location`.`id`) AS `id`
    FROM
        `exam_location`;

/*存储过程*/
USE `csystem`;
DROP procedure IF EXISTS `updateLocationTotalCapacity`;

DELIMITER $$
USE `csystem`$$
CREATE  PROCEDURE `updateLocationTotalCapacity`(
in _id int
)
BEGIN
DECLARE _count int;
	select count(*) into _count from exam_classroom WHERE exam_location_id=_id;
	update exam_location
    set totalcapacity=capacity*_count
    where id=_id;
END$$

DELIMITER ;



INSERT INTO book (id, name)VALUES (1, '高等数学');
INSERT INTO book (id, name)VALUES (2, '数据库系统设计');
INSERT INTO book (id, name)VALUES (3, '操作系统');
INSERT INTO book (id, name)VALUES (4, '离散数学');
INSERT INTO book (id, name)VALUES (5, '大学英语');
INSERT INTO book (id, name)VALUES (6, '计算机网络');