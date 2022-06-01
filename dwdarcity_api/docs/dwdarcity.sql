-- MySQL dump 10.13  Distrib 5.7.37, for Linux (x86_64)
--
-- Host: localhost    Database: dwdarcity
-- ------------------------------------------------------
-- Server version	5.7.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 轮播广告',6,'add_banner'),(22,'Can change 轮播广告',6,'change_banner'),(23,'Can delete 轮播广告',6,'delete_banner'),(24,'Can view 轮播广告',6,'view_banner'),(25,'Can add 导航菜单',7,'add_nav'),(26,'Can change 导航菜单',7,'change_nav'),(27,'Can delete 导航菜单',7,'delete_nav'),(28,'Can view 导航菜单',7,'view_nav'),(29,'Can add 用户信息',8,'add_user'),(30,'Can change 用户信息',8,'change_user'),(31,'Can delete 用户信息',8,'delete_user'),(32,'Can view 用户信息',8,'view_user'),(33,'Can add 积分记录',9,'add_credit'),(34,'Can change 积分记录',9,'change_credit'),(35,'Can delete 积分记录',9,'delete_credit'),(36,'Can view 积分记录',9,'view_credit'),(37,'Can add 课程购买记录',10,'add_usercourse'),(38,'Can change 课程购买记录',10,'change_usercourse'),(39,'Can delete 课程购买记录',10,'delete_usercourse'),(40,'Can view 课程购买记录',10,'view_usercourse'),(41,'Can add 专题课程',11,'add_course'),(42,'Can change 专题课程',11,'change_course'),(43,'Can delete 专题课程',11,'delete_course'),(44,'Can view 专题课程',11,'view_course'),(45,'Can add 课程分类',12,'add_coursecategory'),(46,'Can change 课程分类',12,'change_coursecategory'),(47,'Can delete 课程分类',12,'delete_coursecategory'),(48,'Can view 课程分类',12,'view_coursecategory'),(49,'Can add 课程章节',13,'add_coursechapter'),(50,'Can change 课程章节',13,'change_coursechapter'),(51,'Can delete 课程章节',13,'delete_coursechapter'),(52,'Can view 课程章节',13,'view_coursechapter'),(53,'Can add 讲师导师',14,'add_teacher'),(54,'Can change 讲师导师',14,'change_teacher'),(55,'Can delete 讲师导师',14,'delete_teacher'),(56,'Can view 讲师导师',14,'view_teacher'),(57,'Can add 课程课时',15,'add_courselesson'),(58,'Can change 课程课时',15,'change_courselesson'),(59,'Can delete 课程课时',15,'delete_courselesson'),(60,'Can view 课程课时',15,'view_courselesson'),(61,'Can add 商品活动',16,'add_activity'),(62,'Can change 商品活动',16,'change_activity'),(63,'Can delete 商品活动',16,'delete_activity'),(64,'Can view 商品活动',16,'view_activity'),(65,'Can add 价格优惠策略',17,'add_coursediscount'),(66,'Can change 价格优惠策略',17,'change_coursediscount'),(67,'Can delete 价格优惠策略',17,'delete_coursediscount'),(68,'Can view 价格优惠策略',17,'view_coursediscount'),(69,'Can add 课程优惠类型',18,'add_coursediscounttype'),(70,'Can change 课程优惠类型',18,'change_coursediscounttype'),(71,'Can delete 课程优惠类型',18,'delete_coursediscounttype'),(72,'Can view 课程优惠类型',18,'view_coursediscounttype'),(73,'Can add 课程与优惠策略的关系表',19,'add_coursepricediscount'),(74,'Can change 课程与优惠策略的关系表',19,'change_coursepricediscount'),(75,'Can delete 课程与优惠策略的关系表',19,'delete_coursepricediscount'),(76,'Can view 课程与优惠策略的关系表',19,'view_coursepricediscount'),(77,'Can add 课程有效期选项',20,'add_courseexpire'),(78,'Can change 课程有效期选项',20,'change_courseexpire'),(79,'Can delete 课程有效期选项',20,'delete_courseexpire'),(80,'Can view 课程有效期选项',20,'view_courseexpire'),(81,'Can add 订单记录',21,'add_order'),(82,'Can change 订单记录',21,'change_order'),(83,'Can delete 订单记录',21,'delete_order'),(84,'Can view 订单记录',21,'view_order'),(85,'Can add 订单详情',22,'add_orderdetail'),(86,'Can change 订单详情',22,'change_orderdetail'),(87,'Can delete 订单详情',22,'delete_orderdetail'),(88,'Can view 订单详情',22,'view_orderdetail'),(89,'Can add 优惠券',23,'add_coupon'),(90,'Can change 优惠券',23,'change_coupon'),(91,'Can delete 优惠券',23,'delete_coupon'),(92,'Can view 优惠券',23,'view_coupon'),(93,'Can add 用户的优惠券',24,'add_usercoupon'),(94,'Can change 用户的优惠券',24,'change_usercoupon'),(95,'Can delete 用户的优惠券',24,'delete_usercoupon'),(96,'Can view 用户的优惠券',24,'view_usercoupon');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_lu_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-05-24 16:30:13.590749','9','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى',1,'[{\"added\": {}}]',13,1),(2,'2022-05-24 16:30:55.880441','10','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript ورتاشا دەڭگەي',1,'[{\"added\": {}}]',13,1),(3,'2022-05-24 16:31:00.038636','9','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u663e\\u793a\"]}}]',13,1),(4,'2022-05-24 16:32:04.084304','14','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-JavaScript تىلىمەن تانىسۋ',1,'[{\"added\": {}}]',15,1),(5,'2022-05-24 16:33:03.657819','15','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-تى قولدانۋ جانە كود وڭدەۋ قۇرالدارى JavaScript-',1,'[{\"added\": {}}]',15,1),(6,'2022-05-24 16:34:02.639955','16','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-تۇسىنىكتەمە جانە اينىمالى شاما',1,'[{\"added\": {}}]',15,1),(7,'2022-05-24 16:35:01.714291','17','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-دەرەك تۇرلەرى جانە ەسەپتەۋ امالدارى',1,'[{\"added\": {}}]',15,1),(8,'2022-05-24 16:35:10.929669','14','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-JavaScript تىلىمەن تانىسۋ',2,'[{\"changed\": {\"fields\": [\"\\u89c6\\u9891\\u65f6\\u957f\"]}}]',15,1),(9,'2022-05-24 16:35:20.343509','15','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-تى قولدانۋ جانە كود وڭدەۋ قۇرالدارى JavaScript-',2,'[{\"changed\": {\"fields\": [\"\\u89c6\\u9891\\u65f6\\u957f\"]}}]',15,1),(10,'2022-05-24 16:35:29.517971','16','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن:(第1章)JavaScript نەگىزدىك بىلىمدەرى-تۇسىنىكتەمە جانە اينىمالى شاما',2,'[{\"changed\": {\"fields\": [\"\\u89c6\\u9891\\u65f6\\u957f\"]}}]',15,1),(11,'2022-05-24 16:48:58.666861','7','路飞学城购买课程,总价: 1815.00,实付: 1815.00',3,'',21,1),(12,'2022-05-24 16:48:58.669197','6','路飞学城购买课程,总价: 5900.00,实付: 5900.00',3,'',21,1),(13,'2022-05-24 16:48:58.671348','5','路飞学城购买课程,总价: 1815.00,实付: 1815.00',3,'',21,1),(14,'2022-05-24 16:48:58.673547','4','路飞学城购买课程,总价: 1800.00,实付: 1800.00',3,'',21,1),(15,'2022-05-24 16:48:58.676589','3','路飞学城购买课程,总价: 1800.00,实付: 1800.00',3,'',21,1),(16,'2022-05-24 16:48:58.679698','2','路飞学城购买课程,总价: 5900.00,实付: 5900.00',3,'',21,1),(17,'2022-05-24 16:48:58.681234','1','路飞学城购买课程,总价: 5900.00,实付: 5900.00',3,'',21,1),(18,'2022-05-24 18:41:21.513422','4','UserCourse object (4)',3,'',10,1),(19,'2022-05-24 18:41:21.518143','3','UserCourse object (3)',3,'',10,1),(20,'2022-05-24 18:41:21.520833','2','UserCourse object (2)',3,'',10,1),(21,'2022-05-24 18:41:21.523425','1','UserCourse object (1)',3,'',10,1),(22,'2022-05-30 11:57:02.208475','1','پايزون ءتىلى نەگىزدەرى',2,'[{\"changed\": {\"fields\": [\"\\u8bfe\\u7a0b\\u539f\\u4ef7\"]}}]',11,1),(23,'2022-05-30 12:32:59.586248','2','路飞学城购买课程,总价: 188.00,实付: 188.00',3,'',21,1),(24,'2022-05-30 12:32:59.600021','1','路飞学城购买课程,总价: 6500.00,实付: 6500.00',3,'',21,1),(25,'2022-05-30 12:44:07.131063','2','课程：Java نىڭ جىلىك مايى，优惠活动: مەرەكەلىك تيىمدىلىك,开始时间:2022-05-20 19:34:00,结束时间:2022-05-29 19:34:00',1,'[{\"added\": {}}]',19,1),(26,'2022-05-30 12:44:42.885704','1','مەرەكەلىك تيىمدىلىك',2,'[{\"changed\": {\"fields\": [\"\\u4f18\\u60e0\\u7b56\\u7565\\u7684\\u7ed3\\u675f\\u65f6\\u95f4\"]}}]',16,1),(27,'2022-05-30 19:34:00.527916','1','قۇربان ايتتىق بەلەت',1,'[{\"added\": {}}]',23,1),(28,'2022-05-30 19:35:18.245968','1','优惠券:قۇربان ايتتىق بەلەت,用户:13899653754',1,'[{\"added\": {}}]',24,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(23,'coupon','coupon'),(24,'coupon','usercoupon'),(16,'course','activity'),(11,'course','course'),(12,'course','coursecategory'),(13,'course','coursechapter'),(17,'course','coursediscount'),(18,'course','coursediscounttype'),(20,'course','courseexpire'),(15,'course','courselesson'),(19,'course','coursepricediscount'),(14,'course','teacher'),(6,'home','banner'),(7,'home','nav'),(21,'order','order'),(22,'order','orderdetail'),(5,'sessions','session'),(9,'user','credit'),(8,'user','user'),(10,'user','usercourse');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-05-23 15:45:46.056840'),(2,'contenttypes','0002_remove_content_type_name','2022-05-23 15:45:46.078178'),(3,'auth','0001_initial','2022-05-23 15:45:46.137326'),(4,'auth','0002_alter_permission_name_max_length','2022-05-23 15:45:46.153175'),(5,'auth','0003_alter_user_email_max_length','2022-05-23 15:45:46.157494'),(6,'auth','0004_alter_user_username_opts','2022-05-23 15:45:46.162720'),(7,'auth','0005_alter_user_last_login_null','2022-05-23 15:45:46.169468'),(8,'auth','0006_require_contenttypes_0002','2022-05-23 15:45:46.171392'),(9,'auth','0007_alter_validators_add_error_messages','2022-05-23 15:45:46.176199'),(10,'auth','0008_alter_user_username_max_length','2022-05-23 15:45:46.181946'),(11,'auth','0009_alter_user_last_name_max_length','2022-05-23 15:45:46.188126'),(12,'auth','0010_alter_group_name_max_length','2022-05-23 15:45:46.195163'),(13,'auth','0011_update_proxy_permissions','2022-05-23 15:45:46.201665'),(14,'auth','0012_alter_user_first_name_max_length','2022-05-23 15:45:46.210712'),(15,'user','0001_initial','2022-05-23 15:45:46.285397'),(16,'admin','0001_initial','2022-05-23 15:45:46.350838'),(17,'admin','0002_logentry_remove_auto_add','2022-05-23 15:45:46.357873'),(18,'admin','0003_logentry_add_action_flag_choices','2022-05-23 15:45:46.365730'),(19,'coupon','0001_initial','2022-05-23 15:45:46.415522'),(20,'course','0001_initial','2022-05-23 15:45:46.534304'),(21,'course','0002_auto_20220410_1604','2022-05-23 15:45:46.624609'),(22,'course','0003_auto_20220412_1918','2022-05-23 15:45:46.656666'),(23,'course','0004_auto_20220523_1545','2022-05-23 15:45:46.729224'),(24,'home','0001_initial','2022-05-23 15:45:46.751070'),(25,'order','0001_initial','2022-05-23 15:45:46.821685'),(26,'sessions','0001_initial','2022-05-23 15:45:46.833845'),(27,'user','0002_auto_20220428_1122','2022-05-23 15:45:46.893960'),(28,'user','0003_usercourse','2022-05-23 15:45:46.940366'),(29,'user','0004_alter_usercourse_buy_number','2022-05-23 15:45:46.960469'),(30,'user','0005_rename_buy_number_usercourse_trado_no','2022-05-23 15:45:46.980477'),(31,'user','0006_auto_20220523_1545','2022-05-23 15:45:47.028963');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_activity`
--

DROP TABLE IF EXISTS `dw_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(150) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `remark` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_activity`
--

LOCK TABLES `dw_activity` WRITE;
/*!40000 ALTER TABLE `dw_activity` DISABLE KEYS */;
INSERT INTO `dw_activity` VALUES (1,1,1,0,'2022-05-20 19:35:12.765701','2022-05-30 12:44:42.882747','مەرەكەلىك تيىمدىلىك','2022-05-20 19:34:00.000000','2022-10-30 19:34:00.000000','قۇربان ايتتىق قيمىل');
/*!40000 ALTER TABLE `dw_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_banner`
--

DROP TABLE IF EXISTS `dw_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_banner` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `title` varchar(500) NOT NULL,
  `link` varchar(512) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `remakr` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_banner`
--

LOCK TABLES `dw_banner` WRITE;
/*!40000 ALTER TABLE `dw_banner` DISABLE KEYS */;
INSERT INTO `dw_banner` VALUES (1,1,1,0,'2022-05-20 12:01:42.390049','2022-05-20 12:27:54.738432','dwdar老师9天训练营','http://dwdar.ke.qq.com','banner/lecturder.png','dwdar老师9天训练营'),(2,1,1,0,'2022-05-20 12:06:59.330665','2022-05-20 12:49:13.158541','编程学习方法指导','http://dwdar.ke.qq.com','banner/banner2_Gd8bzfh.png','编程学习方法指导');
/*!40000 ALTER TABLE `dw_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_coupon`
--

DROP TABLE IF EXISTS `dw_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(32) NOT NULL,
  `coupon_type` smallint(6) NOT NULL,
  `timer` int(11) NOT NULL,
  `condition` int(11) NOT NULL,
  `sale` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_coupon`
--

LOCK TABLES `dw_coupon` WRITE;
/*!40000 ALTER TABLE `dw_coupon` DISABLE KEYS */;
INSERT INTO `dw_coupon` VALUES (1,1,1,0,'2022-05-30 19:34:00.526937','2022-05-30 19:34:00.526958','قۇربان ايتتىق بەلەت',1,1000,0,'-50');
/*!40000 ALTER TABLE `dw_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course`
--

DROP TABLE IF EXISTS `dw_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(128) NOT NULL,
  `course_img` varchar(255) DEFAULT NULL,
  `course_video` varchar(100) DEFAULT NULL,
  `course_type` smallint(6) NOT NULL,
  `brief` longtext,
  `level` smallint(6) NOT NULL,
  `pub_date` date NOT NULL,
  `period` int(11) NOT NULL,
  `attachment_path` varchar(128) DEFAULT NULL,
  `status` smallint(6) NOT NULL,
  `students` int(11) NOT NULL,
  `lessons` int(11) NOT NULL,
  `pub_lessons` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `course_category_id` bigint(20) DEFAULT NULL,
  `teacher_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_course_category_id_0fae919c_fk_ly_course_category_id` (`course_category_id`),
  KEY `ly_course_teacher_id_1a7162ce_fk_ly_teacher_id` (`teacher_id`),
  CONSTRAINT `ly_course_course_category_id_0fae919c_fk_ly_course_category_id` FOREIGN KEY (`course_category_id`) REFERENCES `dw_course_category` (`id`),
  CONSTRAINT `ly_course_teacher_id_1a7162ce_fk_ly_teacher_id` FOREIGN KEY (`teacher_id`) REFERENCES `dw_teacher` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course`
--

LOCK TABLES `dw_course` WRITE;
/*!40000 ALTER TABLE `dw_course` DISABLE KEYS */;
INSERT INTO `dw_course` VALUES (1,1,1,0,'2022-05-20 17:08:21.775975','2022-05-30 12:36:21.006945','پايزون ءتىلى نەگىزدەرى','course/course-cover.png','video/day001-01-什么是编程语言.mp4',0,'',0,'2022-05-20',7,'',0,1892,12,12,2100.00,1,1),(2,1,2,0,'2022-05-20 19:02:21.744163','2022-05-20 19:11:42.831840','Html+Css+JavaScript العاش قادام','course/html_css_js.png','video/day001-01-什么是编程语言.mp4',0,'',0,'2022-05-20',7,'',0,815,33,12,312.00,4,2),(3,1,3,0,'2022-05-21 13:36:26.382977','2022-05-24 16:37:07.336931','JavaScript تىلىنە قادام باسۋدان ساۋاتتىلىققا دەيىن','course/JavaScript.png','video/day001-01-什么是编程语言.mp4',0,'',1,'2022-05-21',7,'',0,1290,128,120,1815.00,2,2),(4,1,4,0,'2022-05-21 16:34:15.743070','2022-05-23 19:24:37.445272','Java نىڭ جىلىك مايى','course/java.png','video/day001-01-什么是编程语言.mp4',0,'',1,'2022-05-21',50,'',1,201,1000,800,1800.00,3,4);
/*!40000 ALTER TABLE `dw_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_category`
--

DROP TABLE IF EXISTS `dw_course_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_category`
--

LOCK TABLES `dw_course_category` WRITE;
/*!40000 ALTER TABLE `dw_course_category` DISABLE KEYS */;
INSERT INTO `dw_course_category` VALUES (1,1,1,0,'2022-05-20 15:46:52.742369','2022-05-20 15:47:01.602293','Python'),(2,1,2,0,'2022-05-20 15:47:14.506416','2022-05-20 15:48:25.931232','JavaScript'),(3,1,3,0,'2022-05-20 15:47:22.517143','2022-05-20 15:47:22.517143','Java'),(4,1,1,0,'2022-05-20 15:47:39.147375','2022-05-20 15:48:39.733222','Html+css'),(5,1,4,0,'2022-05-20 15:49:12.267040','2022-05-20 15:49:12.267040','ءۇنحات شاعىن پروگرمماسى');
/*!40000 ALTER TABLE `dw_course_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_chapter`
--

DROP TABLE IF EXISTS `dw_course_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_chapter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `chapter` smallint(6) NOT NULL,
  `name` varchar(128) NOT NULL,
  `summary` longtext,
  `pub_date` date NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_chapter_course_id_e677b55c_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_course_chapter_course_id_e677b55c_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `dw_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_chapter`
--

LOCK TABLES `dw_course_chapter` WRITE;
/*!40000 ALTER TABLE `dw_course_chapter` DISABLE KEYS */;
INSERT INTO `dw_course_chapter` VALUES (1,1,1,0,'2022-05-21 23:59:10.323984','2022-05-21 23:59:10.323984',1,'اشۋ ورتاسىن قۇرۋ','','2022-05-21',1),(2,1,2,0,'2022-05-21 23:59:50.475983','2022-05-21 23:59:50.475983',2,'تابالدىرىقتان اتتاۋ','','2022-05-21',1),(3,1,3,0,'2022-05-22 00:00:56.082560','2022-05-22 00:00:56.082560',3,'Python  نەگىزدىك گرامماتيكاسى','','2022-05-22',1),(4,1,4,0,'2022-05-22 00:01:42.510962','2022-05-22 00:01:42.510962',4,'ساندار جۇيەسى جانە سيفرلاۋ','','2022-05-22',1),(5,1,5,0,'2022-05-22 00:02:16.089186','2022-05-22 00:02:16.089186',5,'دەرك تۇرلەرى(1)','','2022-05-22',1),(6,1,6,0,'2022-05-22 00:02:33.055039','2022-05-22 00:02:33.055039',6,'دەرك تۇرلەرى(2)','','2022-05-22',1),(7,1,7,0,'2022-05-22 00:02:50.862999','2022-05-22 00:02:50.862999',7,'دەرك تۇرلەرى(3)','','2022-05-22',1),(8,1,8,0,'2022-05-22 00:06:52.205029','2022-05-22 00:06:52.205029',8,'قورتىندى جانە ەمتيحان','','2022-05-22',1),(9,1,1,0,'2022-05-24 16:30:13.589179','2022-05-24 16:31:00.036953',1,'JavaScript نەگىزدىك بىلىمدەرى','','2022-05-24',3),(10,1,2,0,'2022-05-24 16:30:55.879419','2022-05-24 16:30:55.879448',1,'JavaScript ورتاشا دەڭگەي','','2022-05-24',3);
/*!40000 ALTER TABLE `dw_course_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_discount`
--

DROP TABLE IF EXISTS `dw_course_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_discount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `condition` int(11) NOT NULL,
  `sale` longtext,
  `discount_type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_discount_discount_type_id_b32ca11c_fk_ly_course` (`discount_type_id`),
  CONSTRAINT `ly_course_discount_discount_type_id_b32ca11c_fk_ly_course` FOREIGN KEY (`discount_type_id`) REFERENCES `dw_course_discount_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_discount`
--

LOCK TABLES `dw_course_discount` WRITE;
/*!40000 ALTER TABLE `dw_course_discount` DISABLE KEYS */;
INSERT INTO `dw_course_discount` VALUES (1,1,1,0,'2022-05-22 13:23:28.759264','2022-05-22 13:39:51.916464',0,'满5000-600\r\n满1000-180\r\n满500-80\r\n满400-40\r\n满300-20\r\n满200-10',1),(2,1,2,0,'2022-05-22 13:24:09.099695','2022-05-22 13:24:09.099695',0,'*0.82',3),(3,0,3,0,'2022-05-22 13:24:50.667334','2022-05-22 13:24:50.667334',0,'*0.75',3),(4,0,4,0,'2022-05-22 13:25:29.500820','2022-05-22 13:25:40.258329',10,'-10',2),(5,1,5,0,'2022-05-22 13:27:09.597379','2022-05-22 13:27:09.597379',0,'',4);
/*!40000 ALTER TABLE `dw_course_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_discount_type`
--

DROP TABLE IF EXISTS `dw_course_discount_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_discount_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(32) NOT NULL,
  `remark` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_discount_type`
--

LOCK TABLES `dw_course_discount_type` WRITE;
/*!40000 ALTER TABLE `dw_course_discount_type` DISABLE KEYS */;
INSERT INTO `dw_course_discount_type` VALUES (1,1,1,0,'2022-05-22 10:36:47.061883','2022-05-22 16:49:17.737148','تولسا كەمەيتۋ','جالپى سوما شارتقا تولسا جالپى سومادان كەمەيتىلەتىن تيىمدىلىك'),(2,1,2,0,'2022-05-22 10:38:21.913834','2022-05-22 13:33:15.521488','مەرزىمدىك كەمەيتۋ','مەرزىمدىك تيىمدىلىك نەمەسە تەگىندىك'),(3,1,3,0,'2022-05-22 10:39:17.842772','2022-05-22 13:33:41.522823','مەرزىمدىك ءتۇسىرۋ','مەرزىمدىك پايىزدىك جەڭىلدىك'),(4,1,4,0,'2022-05-22 10:39:51.395657','2022-05-22 13:33:50.579874','تەگىن مەرزىم','مەرزىمدىك تەگىن الۋ');
/*!40000 ALTER TABLE `dw_course_discount_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_expire`
--

DROP TABLE IF EXISTS `dw_course_expire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_expire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `expire_time` int(11) DEFAULT NULL,
  `expire_text` varchar(64) DEFAULT NULL,
  `price` decimal(6,2) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_expire_course_id_e843fad2_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_course_expire_course_id_e843fad2_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `dw_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_expire`
--

LOCK TABLES `dw_course_expire` WRITE;
/*!40000 ALTER TABLE `dw_course_expire` DISABLE KEYS */;
INSERT INTO `dw_course_expire` VALUES (1,1,1,0,'2022-05-22 13:28:27.963590','2022-05-22 18:44:19.327761',3,'3 كۇن',3.00,1),(2,1,2,0,'2022-05-22 13:28:57.087260','2022-05-22 18:44:31.580328',30,'ءبىر اي',188.00,1),(3,0,3,0,'2022-05-22 13:29:21.404214','2022-05-22 18:44:43.189584',60,'ءۇش اي',298.00,1),(4,0,4,0,'2022-05-22 13:30:05.301265','2022-05-22 18:44:50.202874',180,'جارىم جىل',1000.00,1);
/*!40000 ALTER TABLE `dw_course_expire` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_lesson`
--

DROP TABLE IF EXISTS `dw_course_lesson`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_lesson` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(128) NOT NULL,
  `section_type` smallint(6) NOT NULL,
  `section_link` varchar(255) DEFAULT NULL,
  `duration` varchar(32) DEFAULT NULL,
  `pub_date` datetime(6) NOT NULL,
  `free_trail` tinyint(1) NOT NULL,
  `is_show_list` tinyint(1) NOT NULL,
  `lesson` int(11) NOT NULL,
  `chapter_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_lesson_chapter_id_09ff8644_fk_ly_course_chapter_id` (`chapter_id`),
  KEY `ly_course_lesson_course_id_1e932817_fk_ly_course_id` (`course_id`),
  CONSTRAINT `ly_course_lesson_chapter_id_09ff8644_fk_ly_course_chapter_id` FOREIGN KEY (`chapter_id`) REFERENCES `dw_course_chapter` (`id`),
  CONSTRAINT `ly_course_lesson_course_id_1e932817_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `dw_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_lesson`
--

LOCK TABLES `dw_course_lesson` WRITE;
/*!40000 ALTER TABLE `dw_course_lesson` DISABLE KEYS */;
INSERT INTO `dw_course_lesson` VALUES (1,1,1,0,'2022-05-22 00:08:01.310000','2022-05-22 00:16:41.773683','كومپيۋتەردىڭ قۇرىلىمى',2,NULL,'15:00','2022-05-22 00:08:01.310000',1,1,1,1,1),(2,1,2,0,'2022-05-22 00:09:10.413096','2022-05-22 16:52:35.636213','Python تۋرالى باستاپقى ساۋات',2,NULL,'18:16','2022-05-22 00:09:10.413096',1,1,2,1,1),(3,1,3,0,'2022-05-22 00:09:37.879817','2022-05-22 16:52:42.364618','جۇمىس ورتاسىن قۇرۋ',2,NULL,'11:20','2022-05-22 00:09:37.879817',1,1,3,1,1),(4,0,4,0,'2022-05-22 00:10:00.652095','2022-05-22 00:21:04.575785','تاپسىرما تۋرالى',2,NULL,'18:21','2022-05-22 00:10:00.652095',1,1,4,1,1),(5,0,1,0,'2022-05-22 00:14:48.542823','2022-05-22 00:14:48.542823','سيفرلاۋ',2,NULL,'14:12','2022-05-22 00:14:48.542823',1,0,1,2,1),(6,1,2,0,'2022-05-22 00:15:34.539725','2022-05-22 00:15:34.539725','سالەم الەم',2,NULL,'14:21','2022-05-22 00:15:34.539725',1,0,2,2,1),(7,1,3,0,'2022-05-22 00:16:31.101619','2022-05-22 00:16:31.101619','شىعارۋ',2,NULL,'12:32','2022-05-22 00:16:31.101619',0,1,3,2,1),(8,0,4,0,'2022-05-22 00:22:07.021219','2022-05-22 00:22:07.021219','دەرەك تۇرلەرى str/int/bool',2,NULL,'18:21','2022-05-22 00:22:07.021219',1,0,4,2,1),(9,1,5,0,'2022-05-22 00:22:38.449252','2022-05-22 00:22:38.449252','اينىمالى شاما',2,NULL,'12:13','2022-05-22 00:22:38.449252',0,0,5,2,1),(10,0,6,0,'2022-05-22 00:23:04.220232','2022-05-22 00:23:04.220232','تۇسىنىكتەمە',2,NULL,'21:14','2022-05-22 00:23:04.220232',0,0,6,2,1),(11,1,7,0,'2022-05-22 00:23:27.954577','2022-05-22 00:23:27.954577','ەنگىزۋ',2,NULL,'11:14','2022-05-22 00:23:27.954577',0,0,7,2,1),(12,0,8,0,'2022-05-22 00:23:49.787220','2022-05-22 00:23:49.787220','شارتتى سويلەم',2,NULL,'21:14','2022-05-22 00:23:49.787220',0,0,8,2,1),(13,1,9,0,'2022-05-22 00:24:16.674302','2022-05-22 00:24:16.674302','تاپسىرما',2,NULL,'13:00','2022-05-22 00:24:16.674302',0,0,9,2,1),(14,1,1,0,'2022-05-24 16:32:04.082170','2022-05-24 16:35:10.927578','JavaScript تىلىمەن تانىسۋ',2,NULL,'05:12','2022-05-24 16:32:04.082216',1,1,1,9,3),(15,1,2,0,'2022-05-24 16:33:03.655106','2022-05-24 16:35:20.340652','تى قولدانۋ جانە كود وڭدەۋ قۇرالدارى JavaScript-',2,NULL,'10:02','2022-05-24 16:33:03.655156',1,0,2,9,3),(16,1,3,0,'2022-05-24 16:34:02.637275','2022-05-24 16:35:29.515784','تۇسىنىكتەمە جانە اينىمالى شاما',2,NULL,'08:12','2022-05-24 16:34:02.637321',1,1,3,9,3),(17,1,4,0,'2022-05-24 16:35:01.712064','2022-05-24 16:35:01.712089','دەرەك تۇرلەرى جانە ەسەپتەۋ امالدارى',2,NULL,'12:00','2022-05-24 16:35:01.712110',0,1,4,9,3);
/*!40000 ALTER TABLE `dw_course_lesson` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_course_price_dicount`
--

DROP TABLE IF EXISTS `dw_course_price_dicount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_course_price_dicount` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `active_id` bigint(20) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `discount_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_course_price_dicount_active_id_ef099c15_fk_ly_activity_id` (`active_id`),
  KEY `ly_course_price_dicount_course_id_e8675a4d_fk_ly_course_id` (`course_id`),
  KEY `ly_course_price_dico_discount_id_3e8b8e2b_fk_ly_course` (`discount_id`),
  CONSTRAINT `ly_course_price_dico_discount_id_3e8b8e2b_fk_ly_course` FOREIGN KEY (`discount_id`) REFERENCES `dw_course_discount` (`id`),
  CONSTRAINT `ly_course_price_dicount_active_id_ef099c15_fk_ly_activity_id` FOREIGN KEY (`active_id`) REFERENCES `dw_activity` (`id`),
  CONSTRAINT `ly_course_price_dicount_course_id_e8675a4d_fk_ly_course_id` FOREIGN KEY (`course_id`) REFERENCES `dw_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_course_price_dicount`
--

LOCK TABLES `dw_course_price_dicount` WRITE;
/*!40000 ALTER TABLE `dw_course_price_dicount` DISABLE KEYS */;
INSERT INTO `dw_course_price_dicount` VALUES (1,1,1,0,'2022-05-22 13:34:13.084784','2022-05-22 13:34:13.084784',1,1,1),(2,1,2,0,'2022-05-30 12:44:07.101384','2022-05-30 12:44:07.101471',1,4,2);
/*!40000 ALTER TABLE `dw_course_price_dicount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_credit`
--

DROP TABLE IF EXISTS `dw_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_credit` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `opera` smallint(6) NOT NULL,
  `number` smallint(6) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_credit_user_id_41bb3032_fk_lu_user_id` (`user_id`),
  CONSTRAINT `ly_credit_user_id_41bb3032_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_credit`
--

LOCK TABLES `dw_credit` WRITE;
/*!40000 ALTER TABLE `dw_credit` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_nav`
--

DROP TABLE IF EXISTS `dw_nav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_nav` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `title` varchar(32) NOT NULL,
  `link` varchar(500) NOT NULL,
  `position` int(11) NOT NULL,
  `is_site` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_nav`
--

LOCK TABLES `dw_nav` WRITE;
/*!40000 ALTER TABLE `dw_nav` DISABLE KEYS */;
INSERT INTO `dw_nav` VALUES (1,1,1,0,'2022-05-20 12:52:25.658955','2022-05-20 12:52:25.658955','بەينە ساباق','/course/',1,0),(2,1,2,0,'2022-05-20 12:54:07.128824','2022-05-20 15:40:57.054124','ونلايىن ساباق','/online/',1,0),(3,1,1,0,'2022-05-20 12:55:16.656757','2022-05-20 12:55:48.616682','تىڭشۇن','http://dwdar.ke.qq.com',2,1),(4,1,2,0,'2022-05-20 12:56:34.991719','2022-05-20 12:56:34.991719','قازاقسوفت','https://www.kazakhsoft.com',2,1);
/*!40000 ALTER TABLE `dw_nav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_order`
--

DROP TABLE IF EXISTS `dw_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `order_title` varchar(150) NOT NULL,
  `total_price` decimal(6,2) NOT NULL,
  `real_price` decimal(6,2) NOT NULL,
  `order_number` varchar(64) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `pay_type` smallint(6) NOT NULL,
  `credit` int(11) NOT NULL,
  `coupon` int(11) DEFAULT NULL,
  `order_desc` longtext,
  `pay_time` datetime(6) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dw_order_user_id_3528eed1_fk_lu_user_id` (`user_id`),
  CONSTRAINT `dw_order_user_id_3528eed1_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_order`
--

LOCK TABLES `dw_order` WRITE;
/*!40000 ALTER TABLE `dw_order` DISABLE KEYS */;
INSERT INTO `dw_order` VALUES (3,1,1,0,'2022-05-30 12:33:27.514668','2022-05-30 12:36:20.985053','路飞学城购买课程',188.00,188.00,'20220530123327000002000100',1,0,0,0,'','2022-05-30 12:36:20.984796',2);
/*!40000 ALTER TABLE `dw_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_order_detail`
--

DROP TABLE IF EXISTS `dw_order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_order_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `expire` int(11) NOT NULL,
  `price` decimal(6,2) NOT NULL,
  `real_price` decimal(6,2) NOT NULL,
  `discount_name` varchar(120) NOT NULL,
  `course_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dw_order_detail_course_id_69c541cf_fk_dw_course_id` (`course_id`),
  KEY `dw_order_detail_order_id_633e1f18_fk_dw_order_id` (`order_id`),
  CONSTRAINT `dw_order_detail_course_id_69c541cf_fk_dw_course_id` FOREIGN KEY (`course_id`) REFERENCES `dw_course` (`id`),
  CONSTRAINT `dw_order_detail_order_id_633e1f18_fk_dw_order_id` FOREIGN KEY (`order_id`) REFERENCES `dw_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_order_detail`
--

LOCK TABLES `dw_order_detail` WRITE;
/*!40000 ALTER TABLE `dw_order_detail` DISABLE KEYS */;
INSERT INTO `dw_order_detail` VALUES (3,1,1,0,'2022-05-30 12:33:27.603564','2022-05-30 12:33:27.603646',2,188.00,188.00,'',1,3);
/*!40000 ALTER TABLE `dw_order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_teacher`
--

DROP TABLE IF EXISTS `dw_teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_teacher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `name` varchar(32) NOT NULL,
  `role` smallint(6) NOT NULL,
  `title` varchar(64) NOT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `brief` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_teacher`
--

LOCK TABLES `dw_teacher` WRITE;
/*!40000 ALTER TABLE `dw_teacher` DISABLE KEYS */;
INSERT INTO `dw_teacher` VALUES (1,1,1,0,'2022-05-20 16:01:12.392322','2022-05-20 16:01:12.392322','ونەرحان مۇعالىم',0,'وقىتۋشى','ءبىلىم بىلگەن سايىن قىزىق','teacher/dwdar.JPG','ورتامەكتەپ it ءپانى وقىتۋشىسى'),(2,1,2,0,'2022-05-20 19:11:30.805213','2022-05-20 19:11:30.805213','اسەمبەك مۇعالىم',0,'جەتەكشى','كۇش بىرلىكتە','teacher/logo2x_tZ4Tdpf.png','ۇزدىك پروگرامميست'),(3,1,3,0,'2022-05-21 13:34:56.154608','2022-05-21 13:34:56.154608','جەمىسگۇل مۇعالىم',0,'ءونىم دەرەكتورى','اقىرىن ءجۇرىپ انىق باس','teacher/2022-05-21_133411.jpg','اقىرىن ءجۇرىپ انىق باس'),(4,1,4,0,'2022-05-21 16:32:01.790508','2022-05-21 16:32:01.790508','جاۆابەك مۇعالىم',0,'زەرتتەرمەن','وي جەتكەنگە قول جەتەدى','teacher/2022-05-21_163044.jpg','وي جەتكەنگە قول جەتەدى');
/*!40000 ALTER TABLE `dw_teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_user`
--

DROP TABLE IF EXISTS `dw_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `wxcaht` varchar(64) DEFAULT NULL,
  `credit` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_user`
--

LOCK TABLES `dw_user` WRITE;
/*!40000 ALTER TABLE `dw_user` DISABLE KEYS */;
INSERT INTO `dw_user` VALUES (1,'pbkdf2_sha256$260000$2ZVxh9BC340tPLFuEgPIKW$R6ODEx76qnokMSBQzAnQ3ZO0XTJGctT2kWpNEIyI23I=','2022-05-30 11:56:19.634567',1,'admin','','','dwdar@163.com',1,1,'2022-05-19 19:30:57.896445','','',NULL,0),(2,'pbkdf2_sha256$260000$clBu8jXNHGNxmBlhK3OUds$uA+etjqeJymIHKh3v1pX52oy/g8d3FuWSuHuPzfLH8o=',NULL,0,'13899653754','','','',0,1,'2022-05-21 17:51:46.129995','13899653754','',NULL,100);
/*!40000 ALTER TABLE `dw_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_user_coupon`
--

DROP TABLE IF EXISTS `dw_user_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_user_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `start_time` datetime(6) NOT NULL,
  `is_use` tinyint(1) NOT NULL,
  `coupon_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dw_user_coupon_coupon_id_355adf42_fk_dw_coupon_id` (`coupon_id`),
  KEY `dw_user_coupon_user_id_15271a3a_fk_lu_user_id` (`user_id`),
  CONSTRAINT `dw_user_coupon_coupon_id_355adf42_fk_dw_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `dw_coupon` (`id`),
  CONSTRAINT `dw_user_coupon_user_id_15271a3a_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_user_coupon`
--

LOCK TABLES `dw_user_coupon` WRITE;
/*!40000 ALTER TABLE `dw_user_coupon` DISABLE KEYS */;
INSERT INTO `dw_user_coupon` VALUES (1,1,1,0,'2022-05-30 19:35:18.244240','2022-05-30 19:35:18.244280','2022-05-30 19:35:00.000000',0,1,2);
/*!40000 ALTER TABLE `dw_user_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_user_course`
--

DROP TABLE IF EXISTS `dw_user_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_user_course` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `is_show` tinyint(1) NOT NULL,
  `orders` int(11) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `trado_no` varchar(128) DEFAULT NULL,
  `buy_type` smallint(6) NOT NULL,
  `pay_time` datetime(6) DEFAULT NULL,
  `out_time` datetime(6) DEFAULT NULL,
  `course_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ly_user_course_course_id_8643fef5_fk_dw_course_id` (`course_id`),
  KEY `ly_user_course_user_id_94018e47_fk_lu_user_id` (`user_id`),
  CONSTRAINT `ly_user_course_course_id_8643fef5_fk_dw_course_id` FOREIGN KEY (`course_id`) REFERENCES `dw_course` (`id`),
  CONSTRAINT `ly_user_course_user_id_94018e47_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_user_course`
--

LOCK TABLES `dw_user_course` WRITE;
/*!40000 ALTER TABLE `dw_user_course` DISABLE KEYS */;
INSERT INTO `dw_user_course` VALUES (1,1,1,0,'2022-05-30 12:36:21.013516','2022-05-30 12:36:21.013553','2022053022001496490502391153',1,'2022-05-30 12:36:20.984796','2022-06-29 12:36:20.984796',1,2);
/*!40000 ALTER TABLE `dw_user_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_user_groups`
--

DROP TABLE IF EXISTS `dw_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lu_user_groups_user_id_group_id_018d135b_uniq` (`user_id`,`group_id`),
  KEY `lu_user_groups_group_id_9a9b85b7_fk_auth_group_id` (`group_id`),
  CONSTRAINT `lu_user_groups_group_id_9a9b85b7_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `lu_user_groups_user_id_f18f72b2_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_user_groups`
--

LOCK TABLES `dw_user_groups` WRITE;
/*!40000 ALTER TABLE `dw_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dw_user_user_permissions`
--

DROP TABLE IF EXISTS `dw_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dw_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lu_user_user_permissions_user_id_permission_id_3af6c36b_uniq` (`user_id`,`permission_id`),
  KEY `lu_user_user_permiss_permission_id_cae36ece_fk_auth_perm` (`permission_id`),
  CONSTRAINT `lu_user_user_permiss_permission_id_cae36ece_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `lu_user_user_permissions_user_id_314b03e4_fk_lu_user_id` FOREIGN KEY (`user_id`) REFERENCES `dw_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dw_user_user_permissions`
--

LOCK TABLES `dw_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `dw_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `dw_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-30 19:46:57
