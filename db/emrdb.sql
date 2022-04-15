-- MySQL dump 10.13  Distrib 5.7.35, for osx10.16 (x86_64)
--
-- Host: localhost    Database: emrdb
-- ------------------------------------------------------
-- Server version	5.7.35

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
-- Table structure for table `condition`
--

DROP TABLE IF EXISTS `condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condition` (
  `condition_occurrence_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `condition_start_datetime` varchar(255) DEFAULT NULL,
  `condition_type_concept_id` varchar(255) DEFAULT NULL,
  `enc_id` int(11) DEFAULT NULL,
  `condition_system` varchar(255) DEFAULT NULL,
  `diagnosis_code` varchar(255) DEFAULT NULL,
  `condition_status` varchar(255) DEFAULT NULL,
  `display` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`condition_occurrence_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condition`
--

LOCK TABLES `condition` WRITE;
/*!40000 ALTER TABLE `condition` DISABLE KEYS */;
INSERT INTO `condition` VALUES (1,753951,'3/21/22 0:00','Admitting',2009,'ICD10','T80.59XA','Active ','Anaphylaxis, post vaccination'),(2,753951,'3/21/22 0:00','Admitting',2009,'SNOMED','112516014','Active ','Throat Closure'),(3,753951,'3/21/22 0:00','Admitting',2009,'ICD10','R07.9','Active ','Chest Pain'),(4,252369,'3/1/22 0:00','Admitting',2004,'ICD10','D64.9','Active ','Anemia'),(5,252369,'3/12/22 0:00','Final ',2004,'ICD10','D64.10','Active ','Anemia'),(6,252369,'3/12/22 0:00','Discharge',2004,'ICD10','T78.40XA','Resolved','Allergic Reaction');
/*!40000 ALTER TABLE `condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `demographics`
--

DROP TABLE IF EXISTS `demographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographics` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `year_of_birth` int(11) DEFAULT NULL,
  `month_of_birth` int(11) DEFAULT NULL,
  `day_of_birth` int(11) DEFAULT NULL,
  `birth_datetime` varchar(255) DEFAULT NULL,
  `gender_source_value` varchar(255) DEFAULT NULL,
  `race_source_value` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=753952 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `demographics`
--

LOCK TABLES `demographics` WRITE;
/*!40000 ALTER TABLE `demographics` DISABLE KEYS */;
INSERT INTO `demographics` VALUES (152652,1994,10,1,'10/1/94 0:00','Female','White','Jessica','Smith'),(252369,1981,1,8,'1/8/94 0:00','Male','Asian','John','Smith'),(369852,1972,11,25,'11/25/72 0:00','Female','African American','Sarah','Wilcox'),(478956,2001,5,11,'5/11/01 0:00','Female','Hispanic','Aviana','Denton'),(524789,1964,12,18,'12/18/64 0:00','Female','Hispanic','Henrietta','Palacios'),(652349,1978,8,15,'8/15/78 0:00','Female','White','Ameena','Carver'),(753951,1999,10,31,'10/31/99 0:00','Male','White','Kaleem','Davidson');
/*!40000 ALTER TABLE `demographics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugs` (
  `drug_exposure_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `datetime` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `visit_occurrence_id` int(11) DEFAULT NULL,
  `drug_value` varchar(255) DEFAULT NULL,
  `drug_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`drug_exposure_id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drugs`
--

LOCK TABLES `drugs` WRITE;
/*!40000 ALTER TABLE `drugs` DISABLE KEYS */;
INSERT INTO `drugs` VALUES (301,753951,'3/22/22 0:00','Epinephrine','Completed','medication','IM Right Thigh',2009,'RxNorm','349954'),(302,753951,'3/22/22 0:00','Methylprednisolone','Completed','medication','IV Push Right Arm',2009,'RxNorm','1358496'),(303,753951,'3/22/22 0:00','Methylprednisolone','Completed','medication','IV Push Left Lower Arm',2009,'RxNorm','1358496'),(304,753951,'3/21/22 0:00','Pfizer  Dose 1','Completed','immunization','Right Deltoid ',2009,'CPT','0001A'),(305,252369,'12/1/21 0:00','Pfizer  Dose 1','Completed','immunization','Right Deltoid ',2004,'CPT','0001A'),(306,252369,'1/1/22 0:00','Pfizer  Dose 2','Completed','immunization','Right Deltoid ',2004,'CPT','0001A'),(307,252369,'3/2/22 0:00','Benadryl','Completed','medication','Oral',2004,'RxNorm','355687'),(308,252370,'3/3/22 0:00','Epinephrine','Completed','medication','IM Right Thigh',2004,'RxNorm','349954');
/*!40000 ALTER TABLE `drugs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `enc_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `start_datetime` varchar(255) DEFAULT NULL,
  `end_datetime` varchar(255) DEFAULT NULL,
  `visit_source_value` varchar(255) DEFAULT NULL,
  `admitting_source_value` varchar(255) DEFAULT NULL,
  `discharge_to_source_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`enc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2011 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
INSERT INTO `encounter` VALUES (2003,152652,'1/6/22 0:00','1/6/22 0:00','Outpatient','',''),(2004,252369,'3/1/22 0:00','3/12/22 0:00','Inpatient','',''),(2005,369852,'4/15/22 0:00','4/16/22 0:00','Emergency','',''),(2006,478956,'2/2/22 0:00','2/2/22 0:00','Outpatient','',''),(2007,524789,'4/1/22 0:00','4/3/22 0:00','Outpatient','',''),(2008,652349,'2/6/22 0:00','2/10/22 0:00','Inpatient','',''),(2009,753951,'3/21/22 0:00','','Emergency','',''),(2010,152652,'4/6/22 0:00','','Inpatient','',NULL);
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observation`
--

DROP TABLE IF EXISTS `observation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `observation` (
  `observation_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `enc_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `observation_code` varchar(255) DEFAULT NULL,
  `display` varchar(255) DEFAULT NULL,
  `observation_coding_system` varchar(255) DEFAULT NULL,
  `observation_datetime` varchar(255) DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `ref_range` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`observation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observation`
--

LOCK TABLES `observation` WRITE;
/*!40000 ALTER TABLE `observation` DISABLE KEYS */;
INSERT INTO `observation` VALUES (401,753951,2009,'Verified','94309-2','COVID 19 PCR Test','LOINC','3/22/22 0:00','Negative',''),(402,252369,2004,'Verified','94309-2','COVID 19 PCR Test','LOINC','3/1/22 0:00','Negative',''),(403,369852,2005,'Verified','94309-2','COVID 19 PCR Test','LOINC','4/15/22 0:00','Negative',''),(404,478956,2006,'Verified','94309-2','COVID 19 PCR Test','LOINC','2/2/22 0:00','Negative',''),(405,524789,2007,'Verified','94309-2','COVID 19 PCR Test','LOINC','4/1/22 0:00','Negative',''),(406,652349,2008,'Verified','94309-2','COVID 19 PCR Test','LOINC','2/6/22 0:00','Detected',''),(407,152652,2010,'Verified','94309-2','COVID 19 PCR Test','LOINC','4/6/22 0:00','Detected',''),(408,753951,2009,'Performed','87345-1','Oxygen Delivery Device','LOINC','3/22/22 0:00','Ventilator',''),(409,753951,2009,'Performed','56783-4','Systolic BP','LOINC','3/22/22 0:00','157 mmHg','High'),(410,753951,2009,'Performed','56783-4','Diastolic BP','LOINC','3/22/22 0:00','95 mmHg','High'),(411,753951,2009,'Performed','78912-6','WBC','LOINC','3/22/22 0:00','6.8 k/uL',''),(412,753951,2009,'Performed','76432-1','Heartrate','LOINC','3/22/22 0:00','100 bpm','High'),(413,252369,2004,'Performed','56783-4','Systolic BP','LOINC','3/2/22 0:00','120 mmHg','Normal'),(414,252369,2004,'Performed','56783-4','Diastolic BP','LOINC','3/2/22 0:00','80 mmHg','Normal');
/*!40000 ALTER TABLE `observation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-15  0:10:36
