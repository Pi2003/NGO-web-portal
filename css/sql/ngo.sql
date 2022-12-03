-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 05, 2022 at 07:02 PM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ngo`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `phone` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `name`, `email`, `city_id`, `phone`) VALUES
(3, 'Sarthak ', 'sarthak.monga2020@vitstudent.ac.in', 1, 2355796923),
(4, 'Pinak Tendulkar', 'pdtendulkar140203@gmail.com', 1, 9999999999);

-- --------------------------------------------------------

--
-- Table structure for table `admin_login`
--

DROP TABLE IF EXISTS `admin_login`;
CREATE TABLE IF NOT EXISTS `admin_login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(25) NOT NULL,
  `admin_id` int(11) NOT NULL,
  PRIMARY KEY (`login_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_login`
--

INSERT INTO `admin_login` (`login_id`, `email`, `password`, `admin_id`) VALUES
(3, 'sarthak.monga2020@vitstudent.ac.in', '12345', 3),
(4, 'pdtendulkar140203@gmail.com', 'awds', 4);

-- --------------------------------------------------------

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(100) NOT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `city`
--

INSERT INTO `city` (`city_id`, `cname`) VALUES
(1, 'WOMEN POWER NGO'),
(2, 'PLANET WATER NGO'),
(3, 'BEHETER SAMAJ NGO'),
(4, 'ACTION AGAINST HUNGER NGO');

-- --------------------------------------------------------

--
-- Table structure for table `donor`
--

DROP TABLE IF EXISTS `donor`;
CREATE TABLE IF NOT EXISTS `donor` (
  `donor_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `phone` bigint(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`donor_id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donor`
--

INSERT INTO `donor` (`donor_id`, `email`, `address`, `city_id`, `phone`, `name`) VALUES
(13, 'sp@gmail.com', 'Chennai', 1, 1000000005, 'Sunil Prakash'),
(14, 'ga@gmail.com', 'Chennai', 2, 1000000006, 'Giri Aakash');

-- --------------------------------------------------------

--
-- Table structure for table `donor_login`
--

DROP TABLE IF EXISTS `donor_login`;
CREATE TABLE IF NOT EXISTS `donor_login` (
  `email` varchar(255) NOT NULL,
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(25) NOT NULL,
  `donor_id` int(11) NOT NULL,
  PRIMARY KEY (`login_id`),
  KEY `donor_id` (`donor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donor_login`
--

INSERT INTO `donor_login` (`email`, `login_id`, `password`, `donor_id`) VALUES
('sp@gmail.com', 8, '123456', 13),
('ga@gmail.com', 9, '123456', 14);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `Item_id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(255) NOT NULL,
  `donor_id` int(11) DEFAULT NULL,
  `quantity` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Item_id`),
  KEY `donor_id` (`donor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`Item_id`, `item`, `donor_id`, `quantity`) VALUES
(3, 'clothes', 13, '8'),
(4, 'books', 14, '9'),
(5, 'shoes', 14, '3');

-- --------------------------------------------------------

--
-- Table structure for table `ngo_account`
--

DROP TABLE IF EXISTS `ngo_account`;
CREATE TABLE IF NOT EXISTS `ngo_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bank` varchar(255) NOT NULL,
  `ifsc_code` varchar(255) NOT NULL,
  `acount` text NOT NULL,
  `donor_id` int(11) DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `donationS` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  KEY `donor_id` (`donor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ngo_account`
--

INSERT INTO `ngo_account` (`id`, `bank`, `ifsc_code`, `acount`, `donor_id`, `city_id`, `donationS`) VALUES
(2, 'HDFC', 'HDFC0000128', '0112345678 ', 13, 1, 1500),
(3, 'HDFC', 'HDFC0000179', '0112345479', 14, 2, 1472);

--
-- Triggers `ngo_account`
--
DROP TRIGGER IF EXISTS `transaction`;
DELIMITER $$
CREATE TRIGGER `transaction` AFTER UPDATE ON `ngo_account` FOR EACH ROW INSERT into transaction(donor_id,tdate,amount) VALUES(new.donor_id,NOW(),(new.donationS-old.donationS))
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `task_id` int(11) NOT NULL AUTO_INCREMENT,
  `task` varchar(255) NOT NULL,
  `volunteer_id` int(11) NOT NULL,
  PRIMARY KEY (`task_id`),
  KEY `volunteer_id` (`volunteer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `task`
--

INSERT INTO `task` (`task_id`, `task`, `volunteer_id`) VALUES
(31, 'cooking', 12),
(32, 'driving', 12),
(33, 'cleaning', 12),
(34, 'maunfacturing', 13),
(35, 'Teaching(Maths)', 13),
(36, 'Teaching(English)', 13),
(37, 'cleaning', 14),
(38, 'TEACHING PHYSICS', 14),
(39, 'cooking', 15),
(40, 'Teaching general Knowledge', 15),
(41, 'Sweeping', 15),
(42, 'driving', 16),
(43, 'maunfacturing', 16),
(44, 'Teaching English', 16);

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `donor_id` int(11) DEFAULT NULL,
  `tdate` datetime DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `donor_id` (`donor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`id`, `donor_id`, `tdate`, `amount`) VALUES
(9, 13, '2022-11-05 22:45:55', 1500),
(10, 14, '2022-11-05 22:49:17', 546),
(11, 14, '2022-11-05 22:49:23', 926);

-- --------------------------------------------------------

--
-- Table structure for table `volunteer`
--

DROP TABLE IF EXISTS `volunteer`;
CREATE TABLE IF NOT EXISTS `volunteer` (
  `volunteer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `intrests` varchar(255) DEFAULT NULL,
  `dob` date NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  `phone` bigint(11) DEFAULT NULL,
  `crime` varchar(30) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `STATUS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`volunteer_id`),
  KEY `city_id` (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `volunteer`
--

INSERT INTO `volunteer` (`volunteer_id`, `name`, `email`, `intrests`, `dob`, `city_id`, `phone`, `crime`, `month`, `STATUS`) VALUES
(12, 'Om Mishra', 'om@gmail.com', 'Hyderabad', '1995-10-11', 1, 1000000000, 'NONE', '3', 'employeed'),
(13, 'prakash raj', 'pr@gmail.com', 'Banglore', '1991-09-11', 2, 1000000001, 'NONE', '4', 'employeed'),
(14, 'Rajesh Pratap', 'rp@gmail.com', 'Mumbai', '1986-05-07', 3, 1000000002, 'NONE', '2', 'unemployeed'),
(15, 'Ram Raj', 'rr@gmail.com', 'Khadakpur', '1992-03-06', 4, 1000000003, 'NONE', '7', 'unemployeed'),
(16, 'Jason Roy', 'jr@gmail.com', 'Navimumbai', '1999-12-10', 3, 1000000004, 'Robbery', '2', 'community service');

-- --------------------------------------------------------

--
-- Table structure for table `volunteer_login`
--

DROP TABLE IF EXISTS `volunteer_login`;
CREATE TABLE IF NOT EXISTS `volunteer_login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password` varchar(25) DEFAULT NULL,
  `volunteer_id` int(11) NOT NULL,
  PRIMARY KEY (`login_id`),
  UNIQUE KEY `username` (`email`),
  KEY `volunteer_id` (`volunteer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `volunteer_login`
--

INSERT INTO `volunteer_login` (`login_id`, `email`, `password`, `volunteer_id`) VALUES
(12, 'om@gmail.com', '123456', 12),
(13, 'pr@gmail.com', '123456', 13),
(14, 'rp@gmail.com', '123456', 14),
(15, 'rr@gmail.com', '123456', 15),
(16, 'jr@gmail.com', '123456', 16);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `admin_login`
--
ALTER TABLE `admin_login`
  ADD CONSTRAINT `admin_login_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `donor`
--
ALTER TABLE `donor`
  ADD CONSTRAINT `donor_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `donor_login`
--
ALTER TABLE `donor_login`
  ADD CONSTRAINT `donor_login_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ngo_account`
--
ALTER TABLE `ngo_account`
  ADD CONSTRAINT `ngo_account_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`),
  ADD CONSTRAINT `ngo_account_ibfk_2` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `task`
--
ALTER TABLE `task`
  ADD CONSTRAINT `task_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteer` (`volunteer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donor` (`donor_id`);

--
-- Constraints for table `volunteer`
--
ALTER TABLE `volunteer`
  ADD CONSTRAINT `volunteer_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`);

--
-- Constraints for table `volunteer_login`
--
ALTER TABLE `volunteer_login`
  ADD CONSTRAINT `volunteer_login_ibfk_1` FOREIGN KEY (`volunteer_id`) REFERENCES `volunteer` (`volunteer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
