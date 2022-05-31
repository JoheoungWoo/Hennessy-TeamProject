-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: game_schema
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board_table`
--

DROP TABLE IF EXISTS `board_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board_table` (
  `board_id` int NOT NULL AUTO_INCREMENT,
  `board_user` varchar(45) NOT NULL,
  `board_title` varchar(45) NOT NULL,
  `board_content` varchar(2048) NOT NULL,
  `board_tag` varchar(45) NOT NULL,
  `board_date` date NOT NULL,
  `board_comment` int NOT NULL,
  `board_view` int NOT NULL,
  `board_available` int NOT NULL,
  `board_filename` varchar(500) DEFAULT NULL,
  `board_filerealname` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  UNIQUE KEY `board_id_UNIQUE` (`board_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_table`
--

LOCK TABLES `board_table` WRITE;
/*!40000 ALTER TABLE `board_table` DISABLE KEYS */;
INSERT INTO `board_table` VALUES (1,'test02','공지사항입니다.','넵','공지사항','2022-05-22',0,14,1,NULL,NULL),(2,'test02','자유 게시판 테스트','넵','자유 게시판','2022-05-23',0,14,1,NULL,NULL),(3,'test09','테스트용','ㅋㅋ','질문 게시판','2022-05-24',0,5,1,NULL,NULL),(4,'test09','테스트하는중','ㅁㄴㅇㄹ','직업 게시판','2022-05-24',0,25,1,NULL,NULL),(5,'test02','공지사항입니다.','넵','공지사항','2022-05-22',0,19,1,NULL,NULL),(6,'test02','자유 게시판 테스트','넵','자유 게시판','2022-05-23',0,9,1,NULL,NULL),(7,'test01','자유게시판이용','네','자유 게시판','2022-05-27',0,5,1,'뭉탱이-케인.gif','뭉탱이-케인2.gif'),(8,'test01','자유 게시판','<span style=\"color: rgb(0, 158, 37); font-size: 36pt;\">﻿<b>가나다라마바사</b></span><br>','자유 게시판','2022-05-27',0,75,1,'ㅈㅅㅎㄴㄷ.gif','ㅈㅅㅎㄴㄷ1.gif'),(9,'test01','ㅋㅌㅌㅌㅋㅋ','ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ','자유 게시판','2022-05-27',0,5,1,NULL,NULL),(10,'test01','밑줄임 테스트으으으으으으으으으으으ㅡ으으으으으으으으으으으으으으으','ㅔ','자유 게시판','2022-05-27',0,37,1,NULL,NULL);
/*!40000 ALTER TABLE `board_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_table`
--

DROP TABLE IF EXISTS `comment_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_table` (
  `comment_id` int NOT NULL,
  `comment_board_id` int NOT NULL,
  `comment_user` varchar(45) NOT NULL,
  `comment_content` varchar(2048) NOT NULL,
  `comment_date` date NOT NULL,
  `comment_available` int NOT NULL,
  `comment_filename` varchar(500) DEFAULT NULL,
  `comment_filerealname` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_table`
--

LOCK TABLES `comment_table` WRITE;
/*!40000 ALTER TABLE `comment_table` DISABLE KEYS */;
INSERT INTO `comment_table` VALUES (1,14,'관리자','댓글 테스트','2022-05-24',1,NULL,NULL),(2,14,'관리자','ㅋㅋ','2022-05-24',1,'ㅈㅅㅎㄴㄷ.gif','ㅈㅅㅎㄴㄷ.gif'),(3,15,'관리자','ㅁㅁㅁ','2022-05-24',1,NULL,NULL),(4,14,'관리자','ㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ\r\nㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ','2022-05-24',1,NULL,NULL),(5,14,'test01','댓글 잘 되는 덧 ㅇ','2022-05-25',1,NULL,NULL),(6,14,'test01','이제 페이징 처리만 하면 끝남\r\nㅋㅋ','2022-05-25',1,NULL,NULL),(7,17,'관리자','asdf','2022-05-25',1,NULL,NULL),(8,16,'관리자','ㅇ에\r\n','2022-05-25',1,NULL,NULL),(9,46,'관리자','ㄽㄱ','2022-05-27',1,'22.png','22.png'),(10,2,'test01','ㅎㅇ','2022-05-27',1,NULL,NULL),(11,8,'test02','ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ','2022-05-27',1,NULL,NULL);
/*!40000 ALTER TABLE `comment_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_table`
--

DROP TABLE IF EXISTS `file_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `file_table` (
  `file_realname` varchar(500) NOT NULL,
  `file_name` varchar(500) NOT NULL,
  PRIMARY KEY (`file_realname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_table`
--

LOCK TABLES `file_table` WRITE;
/*!40000 ALTER TABLE `file_table` DISABLE KEYS */;
INSERT INTO `file_table` VALUES ('1632139136.png','1632139136.png'),('16321391361.png','1632139136.png'),('ㅈㅅㅎㄴㄷ5.gif','ㅈㅅㅎㄴㄷ.gif');
/*!40000 ALTER TABLE `file_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note_table`
--

DROP TABLE IF EXISTS `note_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note_table` (
  `note_id` int NOT NULL,
  `note_user` varchar(45) NOT NULL,
  `note_to_user` varchar(45) NOT NULL,
  `note_content` varchar(2048) NOT NULL,
  `note_date` date NOT NULL,
  `note_read_chk` int NOT NULL,
  `note_available` int NOT NULL,
  PRIMARY KEY (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note_table`
--

LOCK TABLES `note_table` WRITE;
/*!40000 ALTER TABLE `note_table` DISABLE KEYS */;
INSERT INTO `note_table` VALUES (1,'test01','test02','hello','2022-05-19',0,0),(2,'test02','test01','nice','2022-05-19',0,0);
/*!40000 ALTER TABLE `note_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_table`
--

DROP TABLE IF EXISTS `user_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_table` (
  `user_id_num` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) NOT NULL,
  `user_pw` varchar(45) NOT NULL,
  `user_nickname` varchar(45) NOT NULL,
  `user_name` varchar(45) NOT NULL,
  `user_gender` varchar(45) NOT NULL,
  `user_email` varchar(45) NOT NULL,
  `user_rank` int NOT NULL,
  `user_exp` int NOT NULL,
  `user_point` int NOT NULL,
  `is_admin` varchar(3) NOT NULL,
  `user_available` int NOT NULL,
  `user_joindate` date NOT NULL,
  `user_filename` varchar(500) DEFAULT NULL,
  `user_filerealname` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`user_id_num`,`user_id`,`is_admin`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_table`
--

LOCK TABLES `user_table` WRITE;
/*!40000 ALTER TABLE `user_table` DISABLE KEYS */;
INSERT INTO `user_table` VALUES (0,'관리자','12345','관리자','관리자','남자','#admin',0,0,95,'YES',1,'2000-00-00',NULL,NULL),(1,'test01','12345','비숍','박태희','남자','test01@gmail.com',1,0,10044,'NO',1,'2022-02-22',NULL,NULL),(2,'tester1','12345','코딩중','박태희','남자','tester1@gmail.com',1,0,0,'NO',1,'0000-00-00',NULL,NULL),(3,'test02','12345','비숍','박태희','남자','test02@gmail.com',1,0,15,'NO',1,'0000-00-00',NULL,NULL),(4,'test04','12345','패스파인더','조형우','남자','test03@gmail.com',1,0,0,'NO',1,'0000-00-00',NULL,NULL),(5,'test05','12345','테스트5','박태희','남자','test05@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(6,'test06','12345','테스트6','박태희','남자','test06@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(7,'test07','12345','테스트7','박태희','남자','test07@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(8,'test08','12345','테스트8','박태희','남자','test08@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(9,'test09','12345','테스트96','박태희','여자','test09@gmail.com',1,0,20,'NO',1,'2022-05-24',NULL,NULL),(10,'test10','12345','테스트10','박태희','남자','test10@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(11,'test11','12345','테스트11','박태희','남자','test11@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(12,'test12','12345','테스트12','박태희','남자','test12@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL),(13,'test13','12345','테스트13','박태희','남자','test13@gmail.com',1,0,0,'NO',1,'2022-05-24',NULL,NULL);
/*!40000 ALTER TABLE `user_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-27 21:16:41
