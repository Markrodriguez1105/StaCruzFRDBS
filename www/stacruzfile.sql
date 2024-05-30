-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 30, 2024 at 10:20 PM
-- Server version: 8.3.0
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stacruzfile`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `adminId` int NOT NULL AUTO_INCREMENT,
  `adminFirstName` varchar(50) NOT NULL,
  `adminMiddleName` varchar(50) DEFAULT NULL,
  `adminLastName` varchar(50) NOT NULL,
  `adminStatus` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `adminUsername` varchar(50) NOT NULL,
  `adminPass` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminId`, `adminFirstName`, `adminMiddleName`, `adminLastName`, `adminStatus`, `adminUsername`, `adminPass`) VALUES
(1, 'Juan', 'Cruz', 'Del Pillar', 'ACTIVE', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `dvNo` varchar(50) NOT NULL,
  `chequeNo` varchar(50) NOT NULL,
  `chequeDate` date NOT NULL,
  `accountCode` varchar(50) NOT NULL,
  `gross` double NOT NULL,
  `D1` double DEFAULT NULL,
  `D2` double DEFAULT NULL,
  `D3` double DEFAULT NULL,
  `D5` double DEFAULT NULL,
  `DPhil` double DEFAULT NULL,
  `DPag` double DEFAULT NULL,
  `payeeName` varchar(50) NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `prepDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `archive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12353 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`log_id`, `dvNo`, `chequeNo`, `chequeDate`, `accountCode`, `gross`, `D1`, `D2`, `D3`, `D5`, `DPhil`, `DPag`, `payeeName`, `reason`, `prepDate`, `archive`) VALUES
(3, 'DV003', 'CH003', '2024-05-31', 'AC003', 2000, 200, 300, 400, 600, 70, 35, 'Eve Johnson', 'Payment for rent', '2024-05-31 12:00:00', 1),
(4, 'DV004', 'CH004', '2024-06-01', 'AC004', 2500, 25, 50, 75, 125, 125, 50, 'Charlie White', 'Payment for utilitie', '2024-06-01 01:00:00', 0),
(5, 'DV005', 'CH005', '2024-06-02', 'AC005', 3000, 30, 60, 90, 150, 150, 60, 'David Wilso', 'Payment for maintenance', '2024-06-02 02:00:00', 0),
(12347, '233223', '343434', '2012-02-12', '232423', 23234, 0, 0, 697.02, 1161.7, 1161.7, 0, 'Mark Rodriguez', 'qwsqws', '2024-05-31 02:34:46', 0),
(12348, 'DV006', '22424', '0000-00-00', '232323', 2324, 0, 46.48, 69.72, 0, 116.2, 46.48, 'ewcnejcnewc', 'icwencunewucew', '2024-05-31 02:34:56', 1),
(12350, '2024-5-3', '32323', '2024-12-31', '232323', 232323, NULL, NULL, NULL, 11616.15, NULL, NULL, 'incewhcbewc', 'cewcew', '2024-05-31 05:48:28', 0),
(12351, '2024-5-4', '87267332', '2024-05-12', '78782373', 8276332, 82763.32, 165526.64, 248289.96, 413816.6, 413816.6, 165526.64, 'Joshua Miranda', 'Electricity', '2024-05-31 06:06:52', 1),
(12352, '2024-5-5', '76732', '2023-02-23', '2323', 2332, NULL, NULL, NULL, NULL, NULL, NULL, 'c', 'c', '2024-05-31 06:12:33', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
