-- phpMyAdmin SQL Dump
-- version 4.4.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 24, 2017 at 10:51 AM
-- Server version: 5.5.33-log
-- PHP Version: 5.5.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `z_teachers`
--

-- --------------------------------------------------------

--
-- Table structure for table `add_limits`
--

CREATE TABLE IF NOT EXISTS `add_limits` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `upto_limit` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `add_limits`
--

INSERT INTO `add_limits` (`id`, `user_id`, `type`, `upto_limit`, `created`, `modified`) VALUES
(1, 27, 'area', 2, '2016-06-30 06:34:41', '2016-06-30 06:34:41'),
(2, 27, 'student', 40, '2016-06-30 06:34:41', '2016-06-30 06:34:41'),
(3, 27, 'subscription', 30, '2016-06-30 06:34:41', '2016-06-30 06:34:41');

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE IF NOT EXISTS `areas` (
  `id` int(20) NOT NULL,
  `object_id` varchar(10) DEFAULT NULL,
  `area_type` enum('1','2') NOT NULL DEFAULT '1' COMMENT '1=Primary, 2=Elementry',
  `title` varchar(512) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `order_no` int(11) DEFAULT NULL,
  `area_color` varchar(10) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `timestamp` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `object_id`, `area_type`, `title`, `description`, `status`, `order_no`, `area_color`, `user_id`, `created`, `modified`, `timestamp`) VALUES
(1, '7Aiebzp2oi', '1', 'Language', 'null', 1, 2, '#c9daf8', 1, '2016-01-27 10:35:25', '2016-05-10 05:26:37', 0),
(2, 'A1XjHyZH1A', '1', 'Sensorial', 'null', 1, 1, '#f4cccc', 1, '2016-01-27 10:35:25', '2016-05-10 05:26:37', 0),
(3, 'FNE0QHj03l', '1', 'Practical Life', 'null', 1, 0, '#fff2cc', 1, '2016-01-27 10:35:25', '2016-05-10 05:26:37', 0),
(4, 'tMKiro56QB', '1', 'Mathematics', 'null', 1, 3, '#d9d2e9', 1, '2016-01-27 10:35:25', '2016-05-10 05:26:37', 0),
(5, 'BuRTkYEVdT', '2', 'History', 'null', 1, 0, '#fff2cc', 1, '2016-01-27 10:39:17', '2016-06-03 03:41:59', 0),
(6, 'F2XiAhTMnx', '2', 'Geometry', 'null', 1, 5, '#e6b8af', 1, '2016-01-27 10:39:17', '2016-06-03 03:42:14', 0),
(7, 'JXljdqubVI', '2', 'Language', 'null', 1, 2, '#c9daf8', 1, '2016-01-27 10:39:18', '2016-06-03 03:42:07', 0),
(8, 'cAsm3GnIOn', '2', 'Geography', 'Geography', 1, 1, '#e8baba', 1, '2016-01-27 10:39:18', '2016-06-06 09:25:09', 0),
(9, 'fLcPryUYhV', '2', 'Biology', 'null', 1, 4, '#d9ead3', 1, '2016-01-27 10:39:18', '2016-06-03 03:42:14', 0),
(10, 'khPP7jZdcL', '2', 'Mathematics', 'null', 1, 3, '#d9d2e9', 1, '2016-01-27 10:39:18', '2016-06-03 03:42:10', 0),
(11, 'paN9ggDLyY', '2', 'Music', 'null', 1, 6, '#ffffff', 1, '2016-01-27 10:39:18', '2016-06-13 07:48:45', 0),
(12, 'r8sRZBJDLl', '1', 'Area', NULL, 1, 7, '#ff9bb38f', 41, '2016-07-05 03:41:31', '2016-07-05 03:41:31', 0);

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE IF NOT EXISTS `chapters` (
  `id` int(11) NOT NULL,
  `object_id` varchar(10) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `order_no` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `timestamp` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`id`, `object_id`, `title`, `description`, `status`, `order_no`, `user_id`, `area_id`, `created`, `modified`, `timestamp`) VALUES
(1, '1uGb8XdOT4', 'Spoken Language', 'null', 1, 0, 1, 1, '2016-01-27 10:35:34', '2016-04-24 00:56:37', 0),
(2, '2jK47vWJal', 'Reading Analysis', 'null', 1, 6, 1, 1, '2016-01-27 10:35:34', '2016-06-09 22:45:05', 0),
(3, '3hSqBsvcj8', 'Numbers 1 - 10', 'null', 1, 0, 1, 4, '2016-01-27 10:35:34', '2016-04-23 20:17:47', 0),
(4, '4FLPKpWPoJ', 'Writing Numerals', 'null', 1, 3, 1, 4, '2016-01-27 10:35:34', '2016-06-10 13:15:36', 0),
(5, '57NvrTmwzV', 'Memorization', 'null', 1, 4, 1, 4, '2016-01-27 10:35:34', '2016-06-10 13:15:39', 0),
(6, '6HcPI9ogli', 'Bells', 'null', 1, 7, 1, 2, '2016-01-27 10:35:34', '2016-04-23 20:16:57', 0),
(7, '6W5VVuCQkG', 'Preliminary Exercises', 'null', 1, 0, 1, 3, '2016-01-27 10:35:34', '2016-04-23 19:57:42', 0),
(8, '8Q3I04zN3y', 'Decimal System ', 'null', 1, 1, 1, 4, '2016-01-27 10:35:34', '2016-04-23 20:17:47', 0),
(9, '8lTCikmB4e', 'Food Preparation', 'null', 1, 3, 1, 3, '2016-01-27 10:35:34', '2016-04-23 20:15:32', 0),
(10, 'C9fKgtrFrc', 'Art Activities', 'null', 1, 6, 1, 3, '2016-01-27 10:35:35', '2016-04-23 20:15:41', 0),
(11, 'CccfEUzHgW', 'Musical Expression', 'null', 1, 2, 1, 1, '2016-01-27 10:35:35', '2016-06-09 22:45:05', 0),
(12, 'J6zcDQoNBo', 'Passage to Abstaction', 'null', 1, 5, 1, 4, '2016-01-27 10:35:35', '2016-06-10 13:15:47', 0),
(13, 'KPquzqcBXQ', 'Olfactory Sense', 'null', 1, 5, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:49', 0),
(14, 'N6JjtxxnFh', 'Function of Words', 'null', 1, 4, 1, 1, '2016-01-27 10:35:35', '2016-06-09 22:45:05', 0),
(15, 'NA7mSxOgyJ', 'Counting', 'null', 1, 2, 1, 4, '2016-01-27 10:35:35', '2016-06-10 13:15:30', 0),
(16, 'NgQbcM4eQj', 'Fractions', 'null', 1, 6, 1, 4, '2016-01-27 10:35:35', '2016-06-10 13:16:03', 0),
(17, 'PJII5DP2Mr', 'Grace and Courtesy', 'null', 1, 4, 1, 3, '2016-01-27 10:35:35', '2016-04-23 20:15:32', 0),
(18, 'QR5Vy9IgzR', 'Auditory Sense', 'null', 1, 6, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:57', 0),
(19, 'RMLWUqTtFC', 'Work Bench', 'null', 1, 7, 1, 3, '2016-01-27 10:35:35', '2016-04-23 20:15:41', 0),
(20, 'Sd5DJx17JO', 'Reading', 'null', 1, 3, 1, 1, '2016-01-27 10:35:35', '2016-06-09 22:45:05', 0),
(21, 'UlT40d32b4', 'Care of Self', 'null', 1, 1, 1, 3, '2016-01-27 10:35:35', '2016-04-23 20:15:23', 0),
(22, 'WbgJdfFzBu', 'Visual Sense', 'null', 1, 0, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:11', 0),
(23, 'dcqNM7z0Eo', 'Word Study', 'null', 1, 5, 1, 1, '2016-01-27 10:35:35', '2016-06-09 22:45:05', 0),
(24, 'iACpN4ljgi', 'Stereognostic Sense', 'null', 1, 8, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:47', 0),
(25, 'ivQ0xWVB7M', 'Care of Environment', 'null', 1, 2, 1, 3, '2016-01-27 10:35:35', '2016-04-23 20:15:26', 0),
(26, 'kyhsazFlG1', 'Gustatory Sense', 'null', 1, 4, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:47', 0),
(27, 'lxnWLQcxu2', 'Thermic Sense', 'null', 1, 3, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:34', 0),
(28, 'pLNYHOvDer', 'Control of Movement', 'null', 1, 5, 1, 3, '2016-01-27 10:35:35', '2016-04-23 20:15:41', 0),
(29, 'qDnNy6tgDD', 'Tactile Sense', 'null', 1, 1, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:23', 0),
(30, 'rqOv2rC0tx', 'Aspects of the World', 'null', 1, 9, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:32', 0),
(31, 'wENQ7MRG1G', 'Baric Sense', 'null', 1, 2, 1, 2, '2016-01-27 10:35:35', '2016-04-23 20:16:32', 0),
(32, 'xxsoxEUZXo', 'Writing', 'null', 1, 1, 1, 1, '2016-01-27 10:35:35', '2016-06-09 22:45:05', 0),
(33, '0hjgzy3VIp', 'Movement', 'null', 1, 4, 1, 11, '2016-01-27 10:39:31', '2016-04-23 20:13:46', 0),
(34, '0tBirYQj84', 'Classification', 'null', 1, 12, 1, 9, '2016-01-27 10:39:31', '2016-04-23 20:08:24', 0),
(35, '1eu2T1K0HG', 'Literature', 'null', 1, 7, 1, 7, '2016-01-27 10:39:31', '2016-04-23 20:13:06', 0),
(36, '1muyDZhSA6', 'Logical Analysis', 'null', 1, 4, 1, 7, '2016-01-27 10:39:31', '2016-04-23 20:12:55', 0),
(37, '2F7JhmzlVP', 'Equivalence', 'null', 1, 2, 1, 6, '2016-01-27 09:24:02', '2016-06-03 05:51:14', 0),
(38, '2szx6kbznQ', 'The Seed', 'null', 1, 6, 1, 9, '2016-01-27 10:39:31', '2016-04-23 20:07:32', 0),
(39, '3ceivnH8tc', 'Singing', 'null', 1, 2, 1, 11, '2016-01-27 10:39:31', '2016-04-23 20:13:46', 0),
(40, '3wuTjaG69r', 'History of Language', 'null', 1, 1, 1, 7, '2016-01-27 10:39:31', '2016-04-23 20:12:35', 0),
(41, '40SByrA25P', 'Tree of Classification', 'null', 1, 14, 1, 9, '2016-01-27 10:39:31', '2016-04-23 20:08:11', 0),
(42, '56Surx25Ql', 'Listening', 'null', 1, 3, 1, 11, '2016-01-27 10:39:31', '2016-04-23 20:13:46', 0),
(43, '6Khrb9oVmH', 'History Question Charts', 'null', 1, 7, 1, 5, '2016-01-27 10:39:31', '2016-04-23 20:09:43', 0),
(44, '7DxNSoYjdo', 'Polyhedra', 'null', 1, 15, 1, 6, '2016-01-27 09:24:02', '2016-06-13 05:05:48', 0),
(45, '8OXO1J406o', 'Story of the Coming of Life', 'null', 1, 0, 1, 5, '2016-01-27 10:39:31', '2016-04-23 20:08:58', 0),
(46, '8a2ckn9n0w', 'Signed Numbers', 'null', 1, 10, 1, 10, '2016-01-27 10:39:31', '2016-04-23 20:03:30', 0),
(47, '95n4pZd5se', 'Needs of the Plant', 'null', 1, 0, 1, 9, '2016-01-27 10:39:31', '2016-04-23 20:07:03', 0),
(48, '9rgdcnwCfj', 'Story of the Coming of Human Beings', 'null', 1, 2, 1, 5, '2016-01-27 10:39:32', '2016-06-13 05:36:41', 0),
(49, '9yijmSEhbu', 'Long Multiplication', 'null', 1, 2, 1, 10, '2016-01-27 10:39:32', '2016-04-23 20:01:15', 0),
(50, 'AfSLwZvEMV', 'Story of Numbers', 'null', 1, 0, 1, 10, '2016-01-27 10:39:32', '2016-04-23 20:01:01', 0),
(51, 'B17c66F02E', 'Congruency, Similarity and Equivalency', 'Congruency, Similarity and Equivalency', 1, 1, 1, 6, '2016-01-27 09:24:03', '2016-06-03 06:23:26', 0),
(52, 'B5LIaXvDob', 'First River Civilizations of the Old World', 'null', 1, 11, 1, 5, '2016-01-27 10:39:32', '2016-06-13 05:35:00', 0),
(53, 'C67QAer01c', 'Ratio and Proportion', 'null', 1, 12, 1, 10, '2016-01-27 10:39:32', '2016-04-23 20:03:30', 0),
(54, 'EFMofGJ2UZ', 'Theorem of Pythagoras', 'null', 1, 6, 1, 6, '2016-01-27 09:24:03', '2016-06-03 05:51:40', 0),
(55, 'FDr0OI415K', 'Iron Insets (deriving the formula)', 'null', 1, 12, 1, 6, '2016-01-27 09:24:03', '2016-06-13 05:05:57', 0),
(56, 'FQYfb7Fk6W', 'Story Material', 'null', 1, 9, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:08:23', 0),
(57, 'HwllFyXzfJ', 'Equivalence with the Iron Material', 'null', 1, 10, 1, 6, '2016-01-27 09:24:03', '2016-06-03 06:05:04', 0),
(58, 'K6GbKjR6ih', 'Decimal Fractions', 'null', 1, 7, 1, 10, '2016-01-27 10:39:32', '2016-04-23 20:03:30', 0),
(59, 'KEgKSKvRO1', 'Early Civilizations of the New World', 'null', 1, 12, 1, 5, '2016-01-27 10:39:32', '2016-04-23 20:11:02', 0),
(60, 'LdLr4aZK8x', 'Nature of Elements', 'null', 1, 1, 1, 8, '2016-01-27 09:24:03', '2016-06-03 03:43:45', 0),
(61, 'MRARf9wn41', 'Squaring and Cubing', 'null', 1, 5, 1, 10, '2016-01-27 10:39:32', '2016-04-23 20:01:51', 0),
(62, 'MZvonptibI', 'Geometry Nomenclature', 'null', 1, 18, 1, 6, '2016-01-27 09:24:03', '2016-06-13 05:05:48', 0),
(63, 'NACOdghW7Q', 'Grammar and Syntax', 'null', 1, 2, 1, 7, '2016-01-27 10:39:32', '2016-04-23 20:12:39', 0),
(64, 'OMUgwcdryW', 'Circle', 'null', 1, 13, 1, 6, '2016-01-27 09:24:03', '2016-06-13 05:05:48', 0),
(65, 'P3X9dKzWzT', 'Three Phases in History', 'null', 1, 9, 1, 5, '2016-01-27 10:39:32', '2016-04-23 20:11:02', 0),
(66, 'QPRZ3Fhi2U', 'Animal Classification', 'null', 1, 15, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:08:11', 0),
(67, 'QyvTPU6NwE', 'Other Number Bases', 'null', 1, 13, 1, 10, '2016-01-27 10:39:32', '2016-04-23 20:03:30', 0),
(68, 'RC5ByWyHin', 'Spoken Language ', 'null', 1, 6, 1, 7, '2016-01-27 10:39:32', '2016-04-23 20:13:06', 0),
(69, 'Ry4E4O0ftk', 'Ecology', 'null', 1, 16, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:08:12', 0),
(70, 'ShEvReqNML', 'The Flower', 'null', 1, 4, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:07:29', 0),
(71, 'TLs9o4ZKGs', 'The Fruit', 'null', 1, 5, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:07:31', 0),
(72, 'UcXawyXAGG', 'Time/Calendar/Scale', 'null', 1, 13, 1, 5, '2016-01-27 10:39:32', '2016-04-23 20:11:02', 0),
(73, 'UnpBfpXK7e', 'Botany Command Cards', 'null', 1, 8, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:07:47', 0),
(74, 'VcmKrQwCFh', 'Geometry Commands', 'null', 1, 17, 1, 6, '2016-01-27 09:24:04', '2016-06-13 05:05:48', 0),
(75, 'VkJXDGwY9V', 'Clock of Eras', 'null', 1, 4, 1, 5, '2016-01-27 10:39:32', '2016-04-23 20:09:14', 0),
(76, 'WfYQ6SQ62p', 'Tone Bars', 'null', 1, 6, 1, 11, '2016-01-27 09:24:04', '2016-06-09 22:49:30', 0),
(77, 'Y7wxEXcFXK', 'The Root', 'null', 1, 2, 1, 9, '2016-01-27 10:39:32', '2016-04-23 20:07:17', 0),
(78, 'Zbm70OiCbi', 'Rhythm', 'null', 1, 5, 1, 11, '2016-01-27 10:39:33', '2016-04-23 20:13:54', 0),
(79, 'aggycyu7Mr', 'Black Strip', 'null', 1, 1, 1, 5, '2016-01-27 10:39:33', '2016-04-23 20:09:05', 0),
(80, 'cjt2yCXXf6', 'Genealogy', 'null', 1, 13, 1, 9, '2016-01-27 10:39:33', '2016-04-23 20:08:24', 0),
(81, 'cu2kiC8b3Q', 'Hand Chart', 'null', 1, 3, 1, 5, '2016-01-27 10:39:33', '2016-04-23 20:09:12', 0),
(82, 'daIMtOD1sj', 'Bells: Sensorial', 'null', 1, 0, 1, 11, '2016-01-27 10:39:33', '2016-04-23 20:13:32', 0),
(83, 'dqEcAQDfRg', 'Geometry Story', 'null', 1, 0, 1, 6, '2016-01-27 09:24:04', '2016-01-27 09:24:04', 0),
(84, 'eUdBFajfnS', 'Human Society', 'null', 1, 5, 1, 8, '2016-01-27 09:24:04', '2016-06-03 03:44:07', 0),
(85, 'eeNlBvKyMA', 'Work of Water', 'null', 1, 4, 1, 8, '2016-01-27 09:24:04', '2016-06-03 03:44:07', 0),
(86, 'eyfaQEwsdt', 'Activities to Prepare for Body Function', 'null', 1, 10, 1, 9, '2016-01-27 10:39:33', '2016-04-23 20:08:23', 0),
(87, 'f5eGsDlt19', 'Sun and the Earth', 'null', 1, 2, 1, 8, '2016-01-27 09:24:04', '2016-06-03 03:43:58', 0),
(88, 'fNK9DfPpy9', 'Introduction to Algebra', 'Introduction to Algebra', 1, 9, 1, 10, '2016-01-27 10:39:33', '2016-06-13 07:14:22', 0),
(89, 'fw1CP4Z8no', 'Solid Geometry', 'null', 1, 14, 1, 6, '2016-01-27 09:24:04', '2016-06-13 05:05:48', 0),
(90, 'fzqltP9h6R', 'Powers of Numbers', 'null', 1, 8, 1, 10, '2016-01-27 10:39:33', '2016-04-23 20:03:30', 0),
(91, 'h7K2vlfIbb', 'Botany Nomenclature', 'null', 1, 7, 1, 9, '2016-01-27 10:39:33', '2016-04-23 20:07:41', 0),
(92, 'jP9MSC0dVh', 'Fractions', 'null', 1, 6, 1, 10, '2016-01-27 10:39:33', '2016-04-23 20:03:30', 0),
(93, 'jkaOOX51vn', 'Wooden Hierarchical Material', 'null', 1, 1, 1, 10, '2016-01-27 10:39:33', '2016-04-23 20:01:09', 0),
(94, 'jyAKoH0GCq', 'Angles', 'null', 1, 4, 1, 6, '2016-01-27 09:24:05', '2016-06-03 05:51:31', 0),
(95, 'm2NunCDGap', 'The Leaf', 'null', 1, 1, 1, 9, '2016-01-27 10:39:33', '2016-04-23 20:07:10', 0),
(96, 'mcJOQAeYXw', 'Creation of the Universe', 'null', 1, 0, 1, 8, '2016-01-27 09:24:05', '2016-01-27 09:24:05', 0),
(97, 'meqbKXUq33', 'Aspects of the Verb', 'null', 1, 3, 1, 7, '2016-01-27 10:39:33', '2016-04-23 20:12:49', 0),
(98, 'nOkOOivgfl', 'Written Composition', 'null', 1, 5, 1, 7, '2016-01-27 10:39:33', '2016-04-23 20:13:04', 0),
(99, 'ohSZtc3pUi', 'Area of Plane Figures', 'null', 1, 11, 1, 6, '2016-01-27 09:24:05', '2016-06-13 05:05:47', 0),
(100, 'oi7E0VOoXV', 'Bell: Notation', 'null', 1, 1, 1, 11, '2016-01-27 10:39:33', '2016-04-23 20:13:39', 0),
(101, 'ptJkAxkbm2', '1st Timeline of Human Beings', 'null', 1, 5, 1, 5, '2016-01-27 10:39:33', '2016-04-23 20:09:46', 0),
(102, 'pxv3on3Zv0', 'Nomenclature of Polygons', 'null', 1, 8, 1, 6, '2016-01-27 09:24:05', '2016-06-03 05:51:53', 0),
(103, 'rCGzLegKT0', '2nd Timeline of Human Beings', 'null', 1, 10, 1, 5, '2016-01-27 10:39:33', '2016-04-23 20:11:02', 0),
(104, 'rlozVR8zpB', 'Communication in Signs', 'null', 1, 0, 1, 7, '2016-01-27 10:39:33', '2016-04-23 20:12:24', 0),
(105, 'sQEA0DxEGp', 'Lines', 'null', 1, 5, 1, 6, '2016-01-27 09:24:05', '2016-06-03 05:51:36', 0),
(106, 'sqr1tTOZaX', 'Body Function Material', 'null', 1, 11, 1, 9, '2016-01-27 10:39:33', '2016-04-23 20:08:23', 0),
(107, 'tqO5Jv00vj', 'Work of Air', 'null', 1, 3, 1, 8, '2016-01-27 09:24:05', '2016-06-03 03:44:03', 0),
(108, 'trOhcC27DL', 'Migration Charts', 'null', 1, 8, 1, 5, '2016-01-27 10:39:33', '2016-04-23 20:10:07', 0),
(109, 'trxyZeviAP', 'Needs of Human', 'null', 1, 6, 1, 5, '2016-01-27 10:39:33', '2016-04-23 20:09:47', 0),
(110, 'uc9j9tROc3', 'Word Problems', 'null', 1, 11, 1, 10, '2016-01-27 10:39:33', '2016-04-23 20:03:30', 0),
(111, 'vj3w01vM6O', 'Euclidian Plate', 'null', 1, 7, 1, 6, '2016-01-27 09:24:05', '2016-06-03 05:51:47', 0),
(112, 'wL0MteE6VH', 'Measurement', 'null', 1, 3, 1, 10, '2016-01-27 10:39:33', '2016-04-23 20:01:41', 0),
(113, 'wTLx0VcbvX', 'Polygons', 'null', 1, 3, 1, 6, '2016-01-27 09:24:06', '2016-06-03 05:51:22', 0),
(114, 'xx1gCwOmYi', 'Sum of Angles of Plane Figures', 'null', 1, 9, 1, 6, '2016-01-27 09:24:06', '2016-06-03 06:05:01', 0),
(115, 'ymC07lFFdP', 'The Stem', 'null', 1, 3, 1, 9, '2016-01-27 10:39:34', '2016-04-23 20:07:20', 0),
(116, 'z42tGOlLhn', 'Geometry Charts', 'null', 1, 16, 1, 6, '2016-01-27 09:24:06', '2016-06-13 05:05:48', 0),
(117, 'zw9sP5B2jv', 'Division', 'null', 1, 4, 1, 10, '2016-01-27 10:39:34', '2016-04-23 20:01:41', 0),
(118, 'UuJZfKwkPu', 'Chapter', NULL, 1, 19, 41, 3, '2016-07-05 03:41:15', '2016-07-05 03:41:15', 0),
(119, '17elCGhnW4', 'Meditation', NULL, 1, 20, 66, 5, '2016-07-11 05:14:41', '2016-07-11 05:14:41', 0);

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) unsigned NOT NULL,
  `country` varchar(64) DEFAULT NULL,
  `country_code` char(2) DEFAULT NULL,
  `country_code_iso3` char(3) DEFAULT NULL,
  `is_publish` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `country`, `country_code`, `country_code_iso3`, `is_publish`) VALUES
(1, 'Afghanistan', 'AF', 'AFG', 1),
(2, 'Albania', 'AL', 'ALB', 1),
(3, 'Algeria', 'DZ', 'DZA', 1),
(4, 'American Samoa', 'AS', 'ASM', 1),
(5, 'Andorra', 'AD', 'AND', 1),
(6, 'Angola', 'AO', 'AGO', 1),
(7, 'Anguilla', 'AI', 'AIA', 1),
(8, 'Antarctica', 'AQ', 'ATA', 1),
(9, 'Antigua and Barbuda', 'AG', 'ATG', 1),
(10, 'Argentina', 'AR', 'ARG', 1),
(11, 'Armenia', 'AM', 'ARM', 1),
(12, 'Aruba', 'AW', 'ABW', 1),
(13, 'Australia', 'AU', 'AUS', 1),
(14, 'Austria', 'AT', 'AUT', 1),
(15, 'Azerbaijan', 'AZ', 'AZE', 1),
(16, 'Bahamas', 'BS', 'BHS', 1),
(17, 'Bahrain', 'BH', 'BHR', 1),
(18, 'Bangladesh', 'BD', 'BGD', 1),
(19, 'Barbados', 'BB', 'BRB', 1),
(20, 'Belarus', 'BY', 'BLR', 1),
(21, 'Belgium', 'BE', 'BEL', 1),
(22, 'Belize', 'BZ', 'BLZ', 1),
(23, 'Benin', 'BJ', 'BEN', 1),
(24, 'Bermuda', 'BM', 'BMU', 1),
(25, 'Bhutan', 'BT', 'BTN', 1),
(26, 'Bolivia', 'BO', 'BOL', 1),
(27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1),
(28, 'Botswana', 'BW', 'BWA', 1),
(29, 'Bouvet Island', 'BV', 'BVT', 1),
(30, 'Brazil', 'BR', 'BRA', 1),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', 1),
(32, 'Brunei Darussalam', 'BN', 'BRN', 1),
(33, 'Bulgaria', 'BG', 'BGR', 1),
(34, 'Burkina Faso', 'BF', 'BFA', 1),
(35, 'Burundi', 'BI', 'BDI', 1),
(36, 'Cambodia', 'KH', 'KHM', 1),
(37, 'Cameroon', 'CM', 'CMR', 1),
(38, 'Canada', 'CA', 'CAN', 1),
(39, 'Cape Verde', 'CV', 'CPV', 1),
(40, 'Cayman Islands', 'KY', 'CYM', 1),
(41, 'Central African Republic', 'CF', 'CAF', 1),
(42, 'Chad', 'TD', 'TCD', 1),
(43, 'Chile', 'CL', 'CHL', 1),
(44, 'China', 'CN', 'CHN', 1),
(45, 'Christmas Island', 'CX', 'CXR', 1),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1),
(47, 'Colombia', 'CO', 'COL', 1),
(48, 'Comoros', 'KM', 'COM', 1),
(49, 'Congo', 'CG', 'COG', 1),
(50, 'Cook Islands', 'CK', 'COK', 1),
(51, 'Costa Rica', 'CR', 'CRI', 1),
(52, 'Cote D''Ivoire', 'CI', 'CIV', 1),
(53, 'Croatia', 'HR', 'HRV', 1),
(54, 'Cuba', 'CU', 'CUB', 1),
(55, 'Cyprus', 'CY', 'CYP', 1),
(56, 'Czech Republic', 'CZ', 'CZE', 1),
(57, 'Denmark', 'DK', 'DNK', 1),
(58, 'Djibouti', 'DJ', 'DJI', 1),
(59, 'Dominica', 'DM', 'DMA', 1),
(60, 'Dominican Republic', 'DO', 'DOM', 1),
(61, 'East Timor', 'TP', 'TMP', 1),
(62, 'Ecuador', 'EC', 'ECU', 1),
(63, 'Egypt', 'EG', 'EGY', 1),
(64, 'El Salvador', 'SV', 'SLV', 1),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', 1),
(66, 'Eritrea', 'ER', 'ERI', 1),
(67, 'Estonia', 'EE', 'EST', 1),
(68, 'Ethiopia', 'ET', 'ETH', 1),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1),
(70, 'Faroe Islands', 'FO', 'FRO', 1),
(71, 'Fiji', 'FJ', 'FJI', 1),
(72, 'Finland', 'FI', 'FIN', 1),
(73, 'France', 'FR', 'FRA', 1),
(74, 'France, Metropolitan', 'FX', 'FXX', 1),
(75, 'French Guiana', 'GF', 'GUF', 1),
(76, 'French Polynesia', 'PF', 'PYF', 1),
(77, 'French Southern Territories', 'TF', 'ATF', 1),
(78, 'Gabon', 'GA', 'GAB', 1),
(79, 'Gambia', 'GM', 'GMB', 1),
(80, 'Georgia', 'GE', 'GEO', 1),
(81, 'Germany', 'DE', 'DEU', 1),
(82, 'Ghana', 'GH', 'GHA', 1),
(83, 'Gibraltar', 'GI', 'GIB', 1),
(84, 'Greece', 'GR', 'GRC', 1),
(85, 'Greenland', 'GL', 'GRL', 1),
(86, 'Grenada', 'GD', 'GRD', 1),
(87, 'Guadeloupe', 'GP', 'GLP', 1),
(88, 'Guam', 'GU', 'GUM', 1),
(89, 'Guatemala', 'GT', 'GTM', 1),
(90, 'Guinea', 'GN', 'GIN', 1),
(91, 'Guinea-bissau', 'GW', 'GNB', 1),
(92, 'Guyana', 'GY', 'GUY', 1),
(93, 'Haiti', 'HT', 'HTI', 1),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1),
(95, 'Honduras', 'HN', 'HND', 1),
(96, 'Hong Kong', 'HK', 'HKG', 1),
(97, 'Hungary', 'HU', 'HUN', 1),
(98, 'Iceland', 'IS', 'ISL', 1),
(99, 'India', 'IN', 'IND', 1),
(100, 'Indonesia', 'ID', 'IDN', 1),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1),
(102, 'Iraq', 'IQ', 'IRQ', 1),
(103, 'Ireland', 'IE', 'IRL', 1),
(104, 'Israel', 'IL', 'ISR', 1),
(105, 'Italy', 'IT', 'ITA', 1),
(106, 'Jamaica', 'JM', 'JAM', 1),
(107, 'Japan', 'JP', 'JPN', 1),
(108, 'Jordan', 'JO', 'JOR', 1),
(109, 'Kazakhstan', 'KZ', 'KAZ', 1),
(110, 'Kenya', 'KE', 'KEN', 1),
(111, 'Kiribati', 'KI', 'KIR', 1),
(112, 'Korea, Democratic People''s Republic of', 'KP', 'PRK', 1),
(113, 'Korea, Republic of', 'KR', 'KOR', 1),
(114, 'Kuwait', 'KW', 'KWT', 1),
(115, 'Kyrgyzstan', 'KG', 'KGZ', 1),
(116, 'Lao People''s Democratic Republic', 'LA', 'LAO', 1),
(117, 'Latvia', 'LV', 'LVA', 1),
(118, 'Lebanon', 'LB', 'LBN', 1),
(119, 'Lesotho', 'LS', 'LSO', 1),
(120, 'Liberia', 'LR', 'LBR', 1),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1),
(122, 'Liechtenstein', 'LI', 'LIE', 1),
(123, 'Lithuania', 'LT', 'LTU', 1),
(124, 'Luxembourg', 'LU', 'LUX', 1),
(125, 'Macau', 'MO', 'MAC', 1),
(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1),
(127, 'Madagascar', 'MG', 'MDG', 1),
(128, 'Malawi', 'MW', 'MWI', 1),
(129, 'Malaysia', 'MY', 'MYS', 1),
(130, 'Maldives', 'MV', 'MDV', 1),
(131, 'Mali', 'ML', 'MLI', 1),
(132, 'Malta', 'MT', 'MLT', 1),
(133, 'Marshall Islands', 'MH', 'MHL', 1),
(134, 'Martinique', 'MQ', 'MTQ', 1),
(135, 'Mauritania', 'MR', 'MRT', 1),
(136, 'Mauritius', 'MU', 'MUS', 1),
(137, 'Mayotte', 'YT', 'MYT', 1),
(138, 'Mexico', 'MX', 'MEX', 1),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', 1),
(140, 'Moldova, Republic of', 'MD', 'MDA', 1),
(141, 'Monaco', 'MC', 'MCO', 1),
(142, 'Mongolia', 'MN', 'MNG', 1),
(143, 'Montserrat', 'MS', 'MSR', 1),
(144, 'Morocco', 'MA', 'MAR', 1),
(145, 'Mozambique', 'MZ', 'MOZ', 1),
(146, 'Myanmar', 'MM', 'MMR', 1),
(147, 'Namibia', 'NA', 'NAM', 1),
(148, 'Nauru', 'NR', 'NRU', 1),
(149, 'Nepal', 'NP', 'NPL', 1),
(150, 'Netherlands', 'NL', 'NLD', 1),
(151, 'Netherlands Antilles', 'AN', 'ANT', 1),
(152, 'New Caledonia', 'NC', 'NCL', 1),
(153, 'New Zealand', 'NZ', 'NZL', 1),
(154, 'Nicaragua', 'NI', 'NIC', 1),
(155, 'Niger', 'NE', 'NER', 1),
(156, 'Nigeria', 'NG', 'NGA', 1),
(157, 'Niue', 'NU', 'NIU', 1),
(158, 'Norfolk Island', 'NF', 'NFK', 1),
(159, 'Northern Mariana Islands', 'MP', 'MNP', 1),
(160, 'Norway', 'NO', 'NOR', 1),
(161, 'Oman', 'OM', 'OMN', 1),
(162, 'Pakistan', 'PK', 'PAK', 1),
(163, 'Palau', 'PW', 'PLW', 1),
(164, 'Panama', 'PA', 'PAN', 1),
(165, 'Papua New Guinea', 'PG', 'PNG', 1),
(166, 'Paraguay', 'PY', 'PRY', 1),
(167, 'Peru', 'PE', 'PER', 1),
(168, 'Philippines', 'PH', 'PHL', 1),
(169, 'Pitcairn', 'PN', 'PCN', 1),
(170, 'Poland', 'PL', 'POL', 1),
(171, 'Portugal', 'PT', 'PRT', 1),
(172, 'Puerto Rico', 'PR', 'PRI', 1),
(173, 'Qatar', 'QA', 'QAT', 1),
(174, 'Reunion', 'RE', 'REU', 1),
(175, 'Romania', 'RO', 'ROM', 1),
(176, 'Russian Federation', 'RU', 'RUS', 1),
(177, 'Rwanda', 'RW', 'RWA', 1),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1),
(179, 'Saint Lucia', 'LC', 'LCA', 1),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1),
(181, 'Samoa', 'WS', 'WSM', 1),
(182, 'San Marino', 'SM', 'SMR', 1),
(183, 'Sao Tome and Principe', 'ST', 'STP', 1),
(184, 'Saudi Arabia', 'SA', 'SAU', 1),
(185, 'Senegal', 'SN', 'SEN', 1),
(186, 'Seychelles', 'SC', 'SYC', 1),
(187, 'Sierra Leone', 'SL', 'SLE', 1),
(188, 'Singapore', 'SG', 'SGP', 1),
(189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1),
(190, 'Slovenia', 'SI', 'SVN', 1),
(191, 'Solomon Islands', 'SB', 'SLB', 1),
(192, 'Somalia', 'SO', 'SOM', 1),
(193, 'South Africa', 'ZA', 'ZAF', 1),
(194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1),
(195, 'Spain', 'ES', 'ESP', 1),
(196, 'Sri Lanka', 'LK', 'LKA', 1),
(197, 'St. Helena', 'SH', 'SHN', 1),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1),
(199, 'Sudan', 'SD', 'SDN', 1),
(200, 'Suriname', 'SR', 'SUR', 1),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1),
(202, 'Swaziland', 'SZ', 'SWZ', 1),
(203, 'Sweden', 'SE', 'SWE', 1),
(204, 'Switzerland', 'CH', 'CHE', 1),
(205, 'Syrian Arab Republic', 'SY', 'SYR', 1),
(206, 'Taiwan', 'TW', 'TWN', 1),
(207, 'Tajikistan', 'TJ', 'TJK', 1),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1),
(209, 'Thailand', 'TH', 'THA', 1),
(210, 'Togo', 'TG', 'TGO', 1),
(211, 'Tokelau', 'TK', 'TKL', 1),
(212, 'Tonga', 'TO', 'TON', 1),
(213, 'Trinidad and Tobago', 'TT', 'TTO', 1),
(214, 'Tunisia', 'TN', 'TUN', 1),
(215, 'Turkey', 'TR', 'TUR', 1),
(216, 'Turkmenistan', 'TM', 'TKM', 1),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', 1),
(218, 'Tuvalu', 'TV', 'TUV', 1),
(219, 'Uganda', 'UG', 'UGA', 1),
(220, 'Ukraine', 'UA', 'UKR', 1),
(221, 'United Arab Emirates', 'AE', 'ARE', 1),
(222, 'United Kingdom', 'GB', 'GBR', 1),
(223, 'United States', 'US', 'USA', 1),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1),
(225, 'Uruguay', 'UY', 'URY', 1),
(226, 'Uzbekistan', 'UZ', 'UZB', 1),
(227, 'Vanuatu', 'VU', 'VUT', 1),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1),
(229, 'Venezuela', 'VE', 'VEN', 1),
(230, 'Viet Nam', 'VN', 'VNM', 1),
(231, 'Virgin Islands (British)', 'VG', 'VGB', 1),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1),
(234, 'Western Sahara', 'EH', 'ESH', 1),
(235, 'Yemen', 'YE', 'YEM', 1),
(236, 'Yugoslavia', 'YU', 'YUG', 1),
(237, 'Zaire', 'ZR', 'ZAR', 1),
(238, 'Zambia', 'ZM', 'ZMB', 1),
(239, 'Zimbabwe', 'ZW', 'ZWE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE IF NOT EXISTS `email_templates` (
  `id` int(3) NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(300) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `from_email` varchar(255) NOT NULL,
  `reply_to` varchar(255) NOT NULL,
  `reply_name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `template_info` text,
  `status_id` int(1) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `title`, `slug`, `subject`, `from_name`, `from_email`, `reply_to`, `reply_name`, `content`, `template_info`, `status_id`, `created`, `modified`) VALUES
(8, 'Forgot Password Link', 'forgot-password', 'Forgot Password Link', '', 'noreply@teacherstraining.com', 'noreply@teacherstraining.com', '', '<p>\r\n	&nbsp;</p>\r\n<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:100%!important; margin:0; padding:0; width:100%!important">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table style="border-collapse:collapse; margin:auto; max-width:600px; min-width:320px">\r\n					<tbody>\r\n						<tr>\r\n							<td style="padding:0 20px">\r\n								<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; border-radius:3px; color:#545454; font-family:.">\r\n									<tbody>\r\n										<tr>\r\n											<td>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-radius:3px 3px 0 0; border:1px solid #113d65; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background:#F281AF;border-top-style:solid;border-top-width:1px;color:#fff;font-family:''Helvetica Neue'',Arial,sans-serif;font-size:24px;font-weight:bold;line-height:40px;padding:13px 0 12px;text-align:center">\r\n																Montessori Notes</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-color:#8c8c8c; border-radius:0 0 3px 3px; border-style:solid; border-width:0 1px 1px; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background: none repeat scroll 0 0 #FFECCB; padding:15px; border-radius:0 0 3px 3px;">\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nHi {{name}},</pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nOops did you forget your password? No problem, tap on the link below and we&#39;ll send you a brand new one!</pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\n{{forget_url}}\r\n\r\n</pre>\r\n																<pre style="word-wrap: break-word; white-space: pre-wrap;">\r\nDidn&#39;t request this? No need to worry, your account is completely safe and there&#39;s no need for you to do anything. Any problems, please contact our support team by clicking here.\r\n\r\n</pre>\r\n																<pre style="word-wrap: break-word; white-space: pre-wrap;">\r\nHealthiest regards,\r\n\r\nMontessori Notes</pre>\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	&nbsp;</p>\r\n															</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n											</td>\r\n										</tr>\r\n									</tbody>\r\n								</table>\r\n							</td>\r\n						</tr>\r\n						<tr>\r\n							<td>\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', '', 1, '2014-10-13 05:20:24', '2016-02-29 12:14:55'),
(15, 'Forgot Username', 'forgot-username', 'Forgot Username', '', 'noreply@teacherstraining.com', 'noreply@teacherstraining.com', '', '<p>\r\n	&nbsp;</p>\r\n<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:100%!important; margin:0; padding:0; width:100%!important">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table style="border-collapse:collapse; margin:auto; max-width:600px; min-width:500px">\r\n					<tbody>\r\n						<tr>\r\n							<td style="padding:0 20px">\r\n								<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; border-radius:3px; color:#545454; font-family:.">\r\n									<tbody>\r\n										<tr>\r\n											<td>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-radius:3px 3px 0 0; border:1px solid #113d65; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background:#F281AF;border-top-style:solid;border-top-width:1px;color:#fff;font-family:''Helvetica Neue'',Arial,sans-serif;font-size:24px;font-weight:bold;line-height:40px;padding:13px 0 12px;text-align:center">\r\n																Montessori Notes</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-color:#8c8c8c; border-radius:0 0 3px 3px; border-style:solid; border-width:0 1px 1px; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background: none repeat scroll 0 0 #FFECCB; padding:15px; border-radius:0 0 3px 3px;">\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nHi {{name}},</pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nYour username is <strong>{{username}}.</strong></pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\n</pre>\r\n																<pre style="word-wrap: break-word; white-space: pre-wrap;">\r\n\r\n\r\n</pre>\r\n																<pre style="word-wrap: break-word; white-space: pre-wrap;">\r\nHealthiest regards,\r\n\r\nMontessori Notes</pre>\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	&nbsp;</p>\r\n															</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n											</td>\r\n										</tr>\r\n									</tbody>\r\n								</table>\r\n							</td>\r\n						</tr>\r\n						<tr>\r\n							<td>\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', '{{name}}\r\n{{email}}\r\n{{username}}', 1, '2016-03-01 09:28:35', '2016-03-01 09:39:18'),
(16, 'Plan email', 'plan-email', 'Plan email', 'Unections', 'noreply@teacherstraining.com', 'noreply@teacherstraining.com', '', '<p>\r\n	&nbsp;</p>\r\n<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:100%!important; margin:0; padding:0; width:100%!important">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table style="border-collapse:collapse; margin:auto; max-width:600px; min-width:320px">\r\n					<tbody>\r\n						<tr>\r\n							<td style="padding:0 20px">\r\n								<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; border-radius:3px; color:#545454; font-family:.">\r\n									<tbody>\r\n										<tr>\r\n											<td>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-radius:3px 3px 0 0; border:1px solid #113d65; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background:#F281AF;border-top-style:solid;border-top-width:1px;color:#fff;font-family:''Helvetica Neue'',Arial,sans-serif;font-size:24px;font-weight:bold;line-height:40px;padding:13px 0 12px;text-align:center">\r\n																Montessori Notes</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-color:#8c8c8c; border-radius:0 0 3px 3px; border-style:solid; border-width:0 1px 1px; width:100%">\r\n													<tbody style="background: none repeat scroll 0 0 #FFECCB; padding:15px; border-radius:0 0 3px 3px;font-family:''.">\r\n														<tr>\r\n															<td style="border-radius:0 0 3px 3px;color:#545454;font-family:''.">\r\n																<p style="margin:20px 0">\r\n																	Hey {{teacher_name}},</p>\r\n																<p style="margin:20px 0">\r\n																	You have created {{plan_type}}. To find plan detail find the attachment.&nbsp;</p>\r\n																<div>\r\n																	Plan Title &nbsp; &nbsp; &nbsp; &nbsp;:&nbsp;<span style="line-height: 100%;">{{plan_title}}</span></div>\r\n																<div>\r\n																	&nbsp;</div>\r\n																<div>\r\n																	&nbsp;</div>\r\n																<div>\r\n																	&nbsp;</div>\r\n																<div>\r\n																	&nbsp;</div>\r\n																<div>\r\n																	Healthiest regards</div>\r\n																<div>\r\n																	Montessori Notes</div>\r\n															</td>\r\n														</tr>\r\n														<tr>\r\n															<td style="border-radius:0 0 3px 3px;color:#545454;font-family:''.">\r\n																&nbsp;</td>\r\n														</tr>\r\n														<tr>\r\n															<td style="border-radius:0 0 3px 3px;color:#545454;font-family:''.">\r\n																&nbsp;</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n											</td>\r\n										</tr>\r\n									</tbody>\r\n								</table>\r\n							</td>\r\n						</tr>\r\n						<tr>\r\n							<td>\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', '{{teacher_name}}\r\n{{plan_type}}\r\n{{plan_title}}', 1, '2016-04-01 10:14:21', '2016-04-06 09:30:59'),
(12, 'Signup confirmation', 'account-verify', 'Signup confirmation', 'Lacart', 'noreply@teacherstraining.com', 'noreply@teacherstraining.com', '', '<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:100%!important; margin:0; padding:0; width:100%!important">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table style="border-collapse:collapse; margin:auto; max-width:600px; min-width:320px">\r\n					<tbody>\r\n						<tr>\r\n							<td style="padding:0 20px">\r\n								<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; border-radius:3px; color:#545454; font-family:.">\r\n									<tbody>\r\n										<tr>\r\n											<td>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-radius:3px 3px 0 0; border:1px solid #113d65; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background:#F281AF;border-top-style:solid;border-top-width:1px;color:#fff;font-family:''Helvetica Neue'',Arial,sans-serif;font-size:24px;font-weight:bold;line-height:40px;padding:13px 0 12px;text-align:center">\r\n																<samp>Montessori Notes</samp></td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-color:#8c8c8c; border-radius:0 0 3px 3px; border-style:solid; border-width:0 1px 1px; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background: none repeat scroll 0 0 #FFECCB; padding:15px; border-radius:0 0 3px 3px;font-family:''.">\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	<samp>Dear {{user}},</samp></p>\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	<samp>Thank you for creating an account with&nbsp;<span style="line-height: 12.96px;">Montessori Notes</span>! This email confirms that you have verified your phone number with&nbsp;<span style="line-height: 12.96px;">Montessori Notes</span>&nbsp;and are ready to get started.</samp></p>\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	<samp>Team Montessori Notes&nbsp;</samp></p>\r\n															</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n											</td>\r\n										</tr>\r\n									</tbody>\r\n								</table>\r\n							</td>\r\n						</tr>\r\n						<tr>\r\n							<td>\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', '', 1, '2014-10-13 05:20:24', '2016-02-29 12:20:40'),
(13, 'Verification Email', 'verify-email', 'Verification email', 'Lacart', 'noreply@teacherstraining.com', 'noreply@teacherstraining.com', '', '<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:100%!important; margin:0; padding:0; width:100%!important">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table style="border-collapse:collapse; margin:auto; max-width:600px; min-width:320px">\r\n					<tbody>\r\n						<tr>\r\n							<td style="padding:0 20px">\r\n								<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; border-radius:3px; color:#545454; font-family:.">\r\n									<tbody>\r\n										<tr>\r\n											<td>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-radius:3px 3px 0 0; border:1px solid #113d65; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background:#F281AF;border-top-style:solid;border-top-width:1px;color:#fff;font-family:''Helvetica Neue'',Arial,sans-serif;font-size:24px;font-weight:bold;line-height:40px;padding:13px 0 12px;text-align:center">\r\n																Montessori Notes</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-color:#8c8c8c; border-radius:0 0 3px 3px; border-style:solid; border-width:0 1px 1px; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background: none repeat scroll 0 0 #FFECCB; padding:15px; border-radius:0 0 3px 3px;">\r\n																<p style="margin:20px 0">\r\n																	Dear {{name}},</p>\r\n																<p>\r\n																	Please click on the given url to confirm your email. To activate your account <a href="{{activation_url}}">Click here</a>.</p>\r\n																<p>\r\n																	If the above link doen&#39;t work, copy and paste the below link on your browser.</p>\r\n																<p>\r\n																	{{activation_url}}</p>\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	&nbsp;</p>\r\n																<p style="margin-bottom: 0.28cm; line-height: 108%">\r\n																	Team Montessori Notes,</p>\r\n															</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n											</td>\r\n										</tr>\r\n									</tbody>\r\n								</table>\r\n							</td>\r\n						</tr>\r\n						<tr>\r\n							<td>\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', '', 1, '2014-10-13 05:20:24', '2016-02-29 12:09:16'),
(14, 'Reset Password', 'reset-password-link', 'Reset Password', '', 'noreply@teacherstraining.com', 'noreply@teacherstraining.com', '', '<p>\r\n	&nbsp;</p>\r\n<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; line-height:100%!important; margin:0; padding:0; width:100%!important">\r\n	<tbody>\r\n		<tr>\r\n			<td>\r\n				<table style="border-collapse:collapse; margin:auto; max-width:600px; min-width:320px">\r\n					<tbody>\r\n						<tr>\r\n							<td style="padding:0 20px">\r\n								<table align="center" border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse; border-radius:3px; color:#545454; font-family:.">\r\n									<tbody>\r\n										<tr>\r\n											<td>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-radius:3px 3px 0 0; border:1px solid #113d65; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background:#F281AF;border-top-style:solid;border-top-width:1px;color:#fff;font-family:''Helvetica Neue'',Arial,sans-serif;font-size:24px;font-weight:bold;line-height:40px;padding:13px 0 12px;text-align:center">\r\n																Montessori Notes</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n												<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:separate; border-color:#8c8c8c; border-radius:0 0 3px 3px; border-style:solid; border-width:0 1px 1px; width:100%">\r\n													<tbody>\r\n														<tr>\r\n															<td style="background: none repeat scroll 0 0 #FFECCB; padding:15px; border-radius:0 0 3px 3px;">\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nHi {{name}},</pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\n</pre>\r\n																<pre style="word-wrap: break-word; white-space: pre-wrap;">\r\nThanks for confirming, here&#39;s a new password for you to use:</pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nPassword: {{password}}\r\n\r\n</pre>\r\n																<pre style="word-wrap: break-word; white-space: pre-wrap;">\r\n</pre>\r\n																<pre style="color: rgb(0, 0, 0); word-wrap: break-word; white-space: pre-wrap;">\r\nJust sign into Montessori Notes in the normal way, but use the above instead.\r\n\r\nAny problems at all, get in touch with us here.\r\n\r\nHealthiest regards,\r\n\r\nMontessori Notes</pre>\r\n															</td>\r\n														</tr>\r\n													</tbody>\r\n												</table>\r\n											</td>\r\n										</tr>\r\n									</tbody>\r\n								</table>\r\n							</td>\r\n						</tr>\r\n						<tr>\r\n							<td>\r\n								&nbsp;</td>\r\n						</tr>\r\n					</tbody>\r\n				</table>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n<p>\r\n	&nbsp;</p>\r\n', '', 1, '2014-10-13 05:20:24', '2016-02-29 12:21:18');

-- --------------------------------------------------------

--
-- Table structure for table `exercises`
--

CREATE TABLE IF NOT EXISTS `exercises` (
  `id` int(11) NOT NULL,
  `object_id` varchar(10) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `description` varchar(512) NOT NULL,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `order_no` int(11) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `timestamp` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1156 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exercises`
--

INSERT INTO `exercises` (`id`, `object_id`, `title`, `description`, `user_id`, `area_id`, `chapter_id`, `lesson_id`, `status`, `order_no`, `created`, `modified`, `timestamp`) VALUES
(1, '07OFQAURg1', 'Part A Social Cards', 'null', 1, 1, 20, 49, 1, 5, '2016-01-27 10:38:43', '2016-04-24 01:25:19', 0),
(2, '0IfrgePeF9', 'Collage', 'null', 1, 3, 10, 120, 1, 0, '2016-01-27 10:38:43', '2016-04-23 23:58:27', 0),
(3, '0TYKO4cQ87', 'Ext.3-Test of Hearing', 'Ext.3-Test of Hearing', 1, 3, 28, 7, 1, 5, '2016-01-27 10:38:43', '2016-06-13 09:09:15', 0),
(4, '0V6Dj6qylh', 'Dancing Free', 'null', 1, 3, 28, 100, 1, 24, '2016-01-27 10:38:43', '2016-06-13 09:06:29', 0),
(6, '0cnthBpKon', 'Ex6 Compound Towers', 'null', 1, 2, 22, 54, 1, 5, '2016-01-27 10:38:43', '2016-06-10 12:23:51', 0),
(7, '0exALYCdxF', 'Ex2 Combinations of a Number', 'null', 1, 4, 5, 140, 1, 1, '2016-01-27 10:38:43', '2016-04-24 02:11:36', 0),
(8, '0vx84z44XX', 'Dictate Randomly', 'null', 1, 4, 15, 78, 1, 0, '2016-01-27 10:38:43', '2016-04-24 02:04:51', 0),
(9, '115AmBEqMs', 'F G4 EnviroGame', 'null', 1, 2, 29, 244, 1, 4, '2016-01-27 10:38:43', '2016-06-22 15:18:29', 0),
(10, '1BwVizewdt', 'St. 5 Body Movement- No Line', 'null', 1, 3, 28, 100, 1, 21, '2016-01-27 10:38:43', '2016-06-13 09:06:29', 0),
(11, '1C4kqMzfWu', 'BotC Presentation Part A', 'null', 1, 2, 22, 269, 1, 0, '2016-01-27 10:38:43', '2016-06-22 16:40:02', 0),
(12, '1DZHp9A62b', 'GBM Ex2 Identify Quantity', 'null', 1, 4, 8, 228, 1, 1, '2016-01-27 10:38:43', '2016-06-22 17:14:46', 0),
(13, '1LQrLT5mdU', 'Ext1 Scale', 'null', 1, 2, 31, 129, 1, 2, '2016-01-27 10:38:43', '2016-06-22 15:25:26', 0),
(14, '1dhWphHhq4', 'BotCards Part B Find the Card', 'null', 1, 2, 22, 189, 1, 1, '2016-01-27 10:38:43', '2016-06-22 16:43:28', 0),
(15, '1e6WKqRwBc', 'Vertebrates/Invertebrates', 'null', 1, 1, 2, 45, 1, 2, '2016-01-27 10:38:43', '2016-04-24 01:08:59', 0),
(16, '1g0PPBQkeJ', 'Ex2 Tasting Fruits & Vegs', 'null', 1, 2, 26, 34, 1, 0, '2016-01-27 10:38:43', '2016-01-27 10:38:43', 0),
(17, '1hBh584CuW', 'Living/Non-living', 'null', 1, 1, 2, 45, 1, 0, '2016-01-27 10:38:43', '2016-04-24 01:08:58', 0),
(18, '1pCeqZXarV', 'Ex2 Past Tense', 'null', 1, 1, 14, 240, 1, 1, '2016-01-27 10:38:43', '2016-04-24 01:29:09', 0),
(19, '1qCOuG8kpZ', 'G3 8 Children Grade Scale', 'null', 1, 2, 6, 241, 1, 6, '2016-01-27 10:38:43', '2016-04-24 00:51:48', 0),
(20, '1wKuGgkA51', 'Objects w/Positive Qualities', 'null', 1, 1, 1, 272, 1, 1, '2016-01-27 10:38:43', '2016-04-24 01:15:03', 0),
(21, '1xLOGNEjmX', 'Adverbial Extensions', 'null', 1, 1, 2, 19, 1, 0, '2016-01-27 10:38:43', '2016-04-24 01:31:45', 0),
(22, '1zRo9jd0Qh', 'SG 3-digit divisor w/zero in units', 'null', 1, 4, 8, 103, 1, 5, '2016-01-27 10:38:43', '2016-06-22 17:16:37', 0),
(23, '25lZUPyYfT', 'G5 Sounding Out Words', 'null', 1, 1, 32, 234, 1, 4, '2016-01-27 10:38:43', '2016-04-24 00:58:21', 0),
(24, '298JMxJm8x', 'Clothes-Fall', 'null', 1, 1, 2, 48, 1, 4, '2016-01-27 10:38:43', '2016-06-10 13:09:55', 0),
(25, '2X19zxi49N', 'Objects that remain Constant', 'null', 1, 2, 22, 99, 1, 0, '2016-01-27 10:38:43', '2016-04-24 00:12:54', 0),
(26, '2fvaxEU62g', 'Prs3 TC w/two Objects', 'null', 1, 1, 14, 11, 1, 2, '2016-01-27 10:38:43', '2016-04-24 01:29:37', 0),
(27, '2mDVl3CiZo', 'Parts of a Fish', 'null', 1, 1, 2, 221, 1, 1, '2016-01-27 10:38:43', '2016-06-13 09:59:55', 0),
(28, '38nm901kRn', 'Prs.4 Listen for Lowest Bell', 'null', 1, 2, 6, 138, 1, 4, '2016-01-27 10:38:43', '2016-06-10 12:50:49', 0),
(29, '3CuMFbAc2t', 'Punctuation B- many objects', 'null', 1, 1, 2, 175, 1, 3, '2016-01-27 10:38:43', '2016-04-24 01:31:23', 0),
(30, '3Qeo0YtZ9b', 'G9 High & Low Vocab', 'null', 1, 2, 6, 31, 1, 8, '2016-01-27 10:38:43', '2016-04-24 00:52:48', 0),
(31, '3bMTPLzyhZ', 'LBF Notation one: wo zeroes', 'null', 1, 4, 12, 115, 1, 1, '2016-01-27 10:38:44', '2016-06-22 17:50:36', 0),
(32, '3eKPOxhWbP', 'BT Ex1 Less Contrasting Sets', 'null', 1, 2, 31, 129, 1, 0, '2016-01-27 10:38:44', '2016-06-22 15:24:31', 0),
(33, '3eNJ6Sldl5', 'G1 Prepared Slips', 'null', 1, 1, 23, 230, 1, 0, '2016-01-27 10:38:44', '2016-01-27 10:38:44', 0),
(34, '3nUiZJnw88', 'BotC G2 Distance Matching V', 'null', 1, 2, 22, 269, 1, 5, '2016-01-27 10:38:44', '2016-06-22 16:41:48', 0),
(35, '3rxUyykXUp', 'Bird', 'null', 1, 1, 2, 168, 1, 1, '2016-01-27 10:38:44', '2016-04-24 01:32:51', 0),
(36, '3trBzGSn5c', 'BotC G4 Stereognostic Game', 'null', 1, 2, 22, 269, 1, 7, '2016-01-27 10:38:44', '2016-06-22 16:42:24', 0),
(37, '3vjCC85XVO', 'Ex3 Describe the Environment', 'null', 1, 1, 14, 36, 1, 2, '2016-01-27 10:38:44', '2016-02-17 04:23:02', 0),
(38, '42s7PGV4G4', 'Dictate Randomly', 'null', 1, 4, 15, 220, 1, 0, '2016-01-27 10:38:44', '2016-01-27 10:38:44', 0),
(39, '4MQ8ulTRJW', 'St3 Four-lined Board', 'null', 1, 1, 32, 46, 1, 4, '2016-01-27 10:38:44', '2016-04-24 01:20:31', 0),
(40, '4RrJiHDDLJ', 'Paper Material', 'null', 1, 1, 32, 46, 1, 5, '2016-01-27 10:38:44', '2016-04-24 01:20:31', 0),
(41, '4SyLjosVro', 'Part B: Division tables', 'null', 1, 4, 5, 181, 1, 1, '2016-01-27 10:38:44', '2016-06-22 21:06:10', 0),
(42, '4Yzt9TMEuj', 'St3 Magic Slide Formation', 'null', 1, 4, 8, 18, 1, 2, '2016-01-27 10:38:44', '2016-04-24 01:44:40', 0),
(43, '4crPqimQ9i', 'Cultural Folders', 'null', 1, 1, 1, 142, 1, 4, '2016-01-27 10:38:44', '2016-04-24 01:16:00', 0),
(44, '4jjT9hFN7X', 'Advanced Cutting', 'null', 1, 3, 10, 172, 1, 3, '2016-01-27 10:38:44', '2016-06-10 12:03:29', 0),
(45, '4lA6j6kMi6', 'Ex2 Identify Quantity', 'null', 1, 4, 8, 247, 1, 1, '2016-01-27 10:38:44', '2016-04-24 01:44:14', 0),
(46, '4mG1ixX82a', 'St11 Shading', 'null', 1, 1, 32, 94, 1, 10, '2016-01-27 10:38:44', '2016-06-13 09:53:24', 0),
(47, '560aICIvLd', 'G1 Whole Step/Half Step', 'null', 1, 1, 11, 177, 1, 0, '2016-01-27 10:38:44', '2016-01-27 10:38:44', 0),
(48, '5DHE9J6760', 'SBF Static Addition', 'null', 1, 4, 12, 249, 1, 7, '2016-01-27 10:38:44', '2016-06-21 21:51:20', 0),
(49, '5bAdn2pOUp', 'Conversation', 'null', 1, 1, 1, 142, 1, 3, '2016-01-27 10:38:44', '2016-04-24 01:16:00', 0),
(50, '5cvV8ChZKN', 'Ex1 Rec Bars by Sight', 'null', 1, 4, 5, 162, 1, 0, '2016-01-27 10:38:44', '2016-04-24 02:11:11', 0),
(51, '5eWTVH4k8Z', 'Ex4 Description Cards', 'null', 1, 1, 11, 173, 1, 3, '2016-01-27 10:38:44', '2016-04-24 01:22:47', 0),
(52, '5gviHz7AUd', 'RR G4 Language Refinement', 'null', 1, 2, 22, 255, 1, 7, '2016-01-27 10:38:44', '2016-06-22 14:50:46', 0),
(53, '5iz7EtDSNe', 'Ex5 Spelling', 'null', 1, 1, 20, 139, 1, 4, '2016-01-27 10:38:44', '2016-04-24 01:24:03', 0),
(54, '5oBA0dwqds', 'RR G1 Distance Grading', 'null', 1, 2, 22, 255, 1, 4, '2016-01-27 10:38:44', '2016-06-22 14:49:49', 0),
(55, '5vkGQJRS21', 'Dictate Randomly', 'null', 1, 4, 15, 51, 1, 0, '2016-01-27 10:38:44', '2016-01-27 10:38:44', 0),
(56, '61q5LMWWPG', 'G2 Hand Motions', 'null', 1, 2, 6, 31, 1, 1, '2016-01-27 10:38:44', '2016-04-24 00:52:29', 0),
(57, '63Du1Ostro', 'St2 Labeling Picture Cards', 'null', 1, 1, 20, 49, 1, 4, '2016-01-27 10:38:44', '2016-04-24 01:25:19', 0),
(58, '6CH7glGDgv', 'Ext2 Small Group Practice', 'null', 1, 1, 32, 21, 1, 1, '2016-01-27 10:38:44', '2016-04-24 01:17:43', 0),
(59, '6Hi9XL4gl5', 'CT2 G4 Environment Match- Variation', 'null', 1, 2, 22, 12, 1, 3, '2016-01-27 10:38:44', '2016-06-22 16:24:01', 0),
(60, '6VZQWtCXS5', 'Charcoal', 'null', 1, 3, 10, 267, 1, 2, '2016-01-27 10:38:45', '2016-06-10 12:03:50', 0),
(61, '6f5K1D913u', 'Plant', 'null', 1, 1, 2, 168, 1, 6, '2016-01-27 10:38:45', '2016-04-24 01:33:08', 0),
(62, '6fiNOZKt9R', 'Black Crayon', 'null', 1, 3, 10, 267, 1, 0, '2016-01-27 10:38:45', '2016-04-23 23:59:53', 0),
(63, '6gcQnAObxh', 'Ex2 Random then Build', 'null', 1, 2, 30, 67, 1, 1, '2016-01-27 10:38:45', '2016-04-24 00:55:32', 0),
(64, '6ym1a8npe9', 'A Builds/C Indentifies', 'null', 1, 4, 15, 220, 1, 0, '2016-01-27 10:38:45', '2016-01-27 10:38:45', 0),
(65, '75t8puLnBq', 'St5 Illustrated Words', 'null', 1, 1, 32, 46, 1, 10, '2016-01-27 10:38:45', '2016-04-24 01:21:11', 0),
(66, '786r8cioUw', 'LogAdj Ex1 Exploration', 'null', 1, 1, 14, 207, 1, 0, '2016-01-27 10:38:45', '2016-06-22 17:09:19', 0),
(67, '7BbnrCo6ka', 'Ex1 Comparative/Superlative', 'null', 1, 1, 20, 49, 1, 3, '2016-01-27 10:38:45', '2016-04-24 01:25:03', 0),
(68, '7F79ZgmqIY', 'Prs1 Regular Formation', 'null', 1, 1, 23, 133, 1, 0, '2016-01-27 10:38:45', '2016-01-27 10:38:45', 0),
(69, '7K7cORs2iC', 'Ex1 Build Outside Frame', 'null', 1, 2, 30, 112, 1, 0, '2016-01-27 10:38:45', '2016-04-24 00:55:50', 0),
(70, '7KMbWM2kys', 'Ex1 Two Colors/Same Shape', 'null', 1, 2, 22, 38, 1, 0, '2016-01-27 10:38:45', '2016-01-27 10:38:45', 0),
(71, '7SfGxHtTdM', 'Ex2 Compare Three Sets', 'null', 1, 2, 22, 54, 1, 1, '2016-01-27 10:38:45', '2016-04-24 00:38:32', 0),
(72, '7f3DEK1X3A', 'Numbered Staff Board', 'null', 1, 1, 11, 148, 1, 0, '2016-01-27 10:38:45', '2016-04-24 01:22:17', 0),
(73, '7gIEu2U47R', 'St1 Sandpaper Letter', 'null', 1, 1, 32, 46, 1, 6, '2016-01-27 10:38:45', '2016-04-24 01:20:50', 0),
(74, '7uZeM2JIjl', 'Weaving', 'null', 1, 3, 10, 120, 1, 6, '2016-01-27 10:38:45', '2016-04-23 23:58:42', 0),
(75, '8E7mvt9Iwm', 'CT3 G2 Distance Grading- Scattered', 'null', 1, 2, 22, 251, 1, 5, '2016-01-27 10:38:45', '2016-06-22 16:26:14', 0),
(76, '8MOSDCQrUk', 'LogAdv Ex1 Exploration', 'null', 1, 1, 14, 116, 1, 0, '2016-01-27 10:38:45', '2016-06-22 17:09:50', 0),
(77, '8V017pDEpG', 'SmB Ex2 Blindfold Walk', 'null', 1, 2, 13, 174, 1, 1, '2016-01-27 10:38:45', '2016-06-22 16:17:43', 0),
(78, '8aTq2eSzwN', 'G3 Pitch Played/Raised Hand', 'null', 1, 1, 11, 88, 1, 2, '2016-01-27 10:38:45', '2016-04-24 01:21:54', 0),
(79, '8jGp54zHCB', 'St3 Connect 2 Letters', 'null', 1, 1, 32, 46, 1, 8, '2016-01-27 10:38:45', '2016-04-24 01:21:05', 0),
(80, '8lSwsRIUAj', 'Straight/Wavy/Zig-Zags Lines', 'null', 1, 3, 10, 172, 1, 2, '2016-01-27 10:38:45', '2016-04-23 23:59:32', 0),
(81, '8rCANfSfgm', 'St9 Construction Paper', 'null', 1, 1, 32, 94, 1, 8, '2016-01-27 10:38:45', '2016-06-13 09:53:24', 0),
(82, '9EknVYqd4h', 'LBF Static Addition', 'null', 1, 4, 12, 115, 1, 7, '2016-01-27 10:38:46', '2016-06-21 21:55:40', 0),
(83, '9FXVtCZohU', 'Bi Ex3 Build Blindfold', 'null', 1, 2, 22, 268, 1, 4, '2016-01-27 10:38:46', '2016-06-22 16:47:08', 0),
(84, '9TCOyBzl53', 'G5 Match 16 Children', 'null', 1, 2, 6, 113, 1, 8, '2016-01-27 10:38:46', '2016-06-10 12:47:30', 0),
(86, '9hJ2qD00Xl', 'Ex 3 Square Formation', 'null', 1, 2, 22, 108, 1, 2, '2016-01-27 10:38:46', '2016-04-24 00:08:37', 0),
(87, '9tt3OrKSn9', 'St3 Short Unrelated Sent', 'null', 1, 1, 32, 70, 1, 2, '2016-01-27 10:38:46', '2016-04-24 01:18:07', 0),
(88, 'A4IZXhkqtz', 'LDB St2 3-digit divisor', 'null', 1, 4, 8, 111, 1, 0, '2016-01-27 10:38:46', '2016-06-21 22:15:46', 0),
(89, 'A4leMXaSS5', 'St8 Illustrated Poem', 'null', 1, 1, 32, 46, 1, 13, '2016-01-27 10:38:46', '2016-04-24 01:21:18', 0),
(90, 'A5m2xd4FNk', 'bay and cape', 'null', 1, 3, 7, 157, 1, 1, '2016-01-27 10:38:46', '2016-04-23 23:55:12', 0),
(91, 'A8EPBxIvyK', 'St7 Illustrated Short Story', 'null', 1, 1, 32, 46, 1, 12, '2016-01-27 10:38:46', '2016-04-24 01:21:16', 0),
(92, 'AKEE8ppyzJ', 'Ver. Combinations of 10', 'null', 1, 4, 5, 84, 1, 0, '2016-01-27 10:38:46', '2016-01-27 10:38:46', 0),
(93, 'AMegCX8AEN', 'Quilling', 'null', 1, 3, 10, 120, 1, 10, '2016-01-27 10:38:46', '2016-06-10 12:03:09', 0),
(94, 'AMz5Q6gs0e', 'Clay Sculpture', 'null', 1, 3, 10, 120, 1, 2, '2016-01-27 10:38:46', '2016-04-23 23:58:27', 0),
(95, 'ANKs5flFaC', 'St1 Waves 1" apart', 'null', 1, 1, 32, 94, 1, 0, '2016-01-27 10:38:46', '2016-04-24 01:18:42', 0),
(96, 'AToheRAMGW', 'SBF Dynamic Addition', 'null', 1, 4, 12, 249, 1, 8, '2016-01-27 10:38:46', '2016-06-21 22:12:36', 0),
(97, 'AWSaBPEAL9', 'Parts of an Object', 'null', 1, 1, 1, 186, 1, 4, '2016-01-27 10:38:46', '2016-04-24 01:13:54', 0),
(98, 'AXi8EGDYyb', 'SG St2 Making & Linking Numbers', 'null', 1, 4, 8, 105, 1, 1, '2016-01-27 10:38:46', '2016-06-22 17:15:35', 0),
(99, 'Ac1wotzoBr', 'Ex2 Dictate Phons/same', 'null', 1, 1, 20, 144, 1, 1, '2016-01-27 10:38:46', '2016-06-22 16:53:09', 0),
(100, 'Anf7y8QywG', 'Along the Street', 'null', 1, 1, 2, 48, 1, 0, '2016-01-27 10:38:46', '2016-04-24 01:05:25', 0),
(101, 'AqzWKPwHCB', 'Pillow Sewing', 'null', 1, 3, 10, 242, 1, 4, '2016-01-27 10:38:46', '2016-06-13 09:14:29', 0),
(102, 'AuElc1Enkw', 'BotCards Part A Find the Shape', 'null', 1, 2, 22, 189, 1, 0, '2016-01-27 10:38:46', '2016-06-22 16:43:01', 0),
(103, 'Aw4Racivyx', 'Birds of Prey', 'null', 1, 1, 2, 48, 1, 2, '2016-01-27 10:38:46', '2016-06-10 13:09:43', 0),
(104, 'B2PiNwvp8n', 'LBF St3 C Writes & Builds', 'null', 1, 4, 12, 115, 1, 5, '2016-01-27 10:38:46', '2016-06-22 17:52:16', 0),
(105, 'B4HouomxYO', 'Ver 2 Group Same Colors', 'null', 1, 4, 5, 162, 1, 3, '2016-01-27 10:38:46', '2016-04-24 02:11:14', 0),
(106, 'B60M6TJ4jl', 'SBF St2 A Writes/C Builds', 'null', 1, 4, 12, 249, 1, 4, '2016-01-27 10:38:46', '2016-06-22 17:42:03', 0),
(107, 'BBJKaemhQD', 'Ex3: Control Chart', 'null', 1, 4, 5, 181, 1, 4, '2016-01-27 10:38:46', '2016-06-13 10:06:40', 0),
(108, 'BFsw5yQ6mv', 'Parts of a Horse', 'null', 1, 1, 2, 221, 1, 6, '2016-01-27 10:38:46', '2016-06-13 10:00:00', 0),
(109, 'BS0rlrSpfq', 'Ext Hum It, Play It, Write It', 'null', 1, 1, 11, 128, 1, 0, '2016-01-27 10:38:46', '2016-01-27 10:38:46', 0),
(110, 'BX2sh4ra0o', 'St2 Short Phrases', 'null', 1, 1, 32, 70, 1, 1, '2016-01-27 10:38:46', '2016-04-24 01:18:06', 0),
(111, 'BdMZKAAtoh', 'Parts of a Leaf', 'null', 1, 1, 2, 221, 1, 3, '2016-01-27 10:38:46', '2016-06-13 09:59:57', 0),
(112, 'BhD3Fi7sbz', 'Parts of a Flower', 'null', 1, 1, 2, 221, 1, 2, '2016-01-27 10:38:46', '2016-06-13 09:59:56', 0),
(113, 'BsPMuIRDLO', 'G1 Whose Tune Is It', 'null', 1, 1, 11, 92, 1, 0, '2016-01-27 10:38:46', '2016-01-27 10:38:46', 0),
(114, 'ByM8yqBskD', 'Ex2 Count 2 Bars at a time', 'null', 1, 4, 5, 162, 1, 1, '2016-01-27 10:38:46', '2016-04-24 02:11:14', 0),
(115, 'C3XpR1uwdj', 'St1 Label the Environment', 'null', 1, 1, 20, 49, 1, 0, '2016-01-27 10:38:46', '2016-04-24 01:24:41', 0),
(116, 'C8B2ojOQgV', 'Prs.2 Basket w/Cover', 'null', 1, 2, 24, 224, 1, 1, '2016-01-27 10:38:46', '2016-04-24 00:54:15', 0),
(117, 'CBK8a5Iks8', 'G4 Singing to the Scale', 'null', 1, 2, 6, 31, 1, 3, '2016-01-27 10:38:46', '2016-04-24 00:52:42', 0),
(118, 'CVxP2yq4my', 'TaB G1 Distance Matching', 'null', 1, 2, 26, 34, 1, 0, '2016-01-27 10:38:46', '2016-06-22 15:41:27', 0),
(119, 'CXX9J7TyV9', 'Rectangular Box A', 'null', 1, 2, 22, 212, 1, 0, '2016-01-27 10:38:47', '2016-04-24 00:17:52', 0),
(120, 'CdHgNdem4u', 'Snipping', 'null', 1, 3, 10, 172, 1, 0, '2016-01-27 10:38:47', '2016-04-23 23:59:26', 0),
(121, 'ClKuioKAHh', 'PT G5 Environment Match', 'null', 1, 2, 22, 243, 1, 10, '2016-01-27 10:38:47', '2016-06-22 14:42:42', 0),
(122, 'D3TlfV5BwC', 'GeoSol G2 Environment Game', 'null', 1, 2, 24, 224, 1, 7, '2016-01-27 10:38:47', '2016-06-22 16:50:13', 0),
(123, 'D87N5m6iYD', 'Sub Static', 'null', 1, 4, 8, 218, 1, 0, '2016-01-27 10:38:47', '2016-06-21 21:47:22', 0),
(124, 'DEdvcRyJu3', 'Plants/Animals', 'null', 1, 1, 2, 45, 1, 1, '2016-01-27 10:38:47', '2016-04-24 01:08:59', 0),
(125, 'DLmPfI5bQn', 'Ext.2-Identification', 'Ext.2-Identification', 1, 3, 28, 7, 1, 4, '2016-01-27 10:38:47', '2016-06-13 09:09:08', 0),
(126, 'DR5k2VeM8O', 'Ex1 Include Younger Children', 'null', 1, 4, 3, 183, 1, 0, '2016-01-27 10:38:47', '2016-01-27 10:38:47', 0),
(127, 'Dfk2Bw2hcP', 'G3 14 Child Grade Scale', 'null', 1, 2, 6, 138, 1, 10, '2016-01-27 10:38:47', '2016-06-10 12:51:37', 0),
(128, 'DovLoNVWXQ', 'SG Mult Dynamic', 'null', 1, 4, 8, 47, 1, 0, '2016-01-27 10:38:47', '2016-06-21 21:57:23', 0),
(129, 'E1MkQ2s0Bo', 'Bookmaking', 'null', 1, 3, 10, 120, 1, 4, '2016-01-27 10:38:47', '2016-04-23 23:58:33', 0),
(130, 'E3LSTaJ7BJ', 'Objects that remain Constant', 'null', 1, 1, 1, 272, 1, 0, '2016-01-27 10:38:47', '2016-04-24 01:14:59', 0),
(131, 'E40mnQQRPX', 'GeoC Ex2 Many Drawers', 'null', 1, 2, 22, 55, 1, 4, '2016-01-27 10:38:47', '2016-06-22 16:30:19', 0),
(132, 'E6IvcQKPxk', 'Part B Scientific', 'null', 1, 1, 20, 49, 1, 6, '2016-01-27 10:38:47', '2016-04-24 01:24:55', 0),
(133, 'E7ubvukwJk', 'CB G1 Distance Matching OE', 'G.1-Distance Matching-OE', 1, 2, 22, 108, 1, 9, '2016-01-27 10:38:47', '2016-06-22 15:07:22', 0),
(134, 'E9IkfRSvrH', 'Biological Classifications', 'null', 1, 1, 1, 142, 1, 12, '2016-01-27 10:38:47', '2016-04-24 01:16:42', 0),
(135, 'EJPyAJEQfp', '1 sub/1 pred/1 direct obj.', 'null', 1, 1, 2, 182, 1, 2, '2016-01-27 10:38:47', '2016-04-24 01:30:49', 0),
(136, 'EKieC32sEP', 'TT G2 Distance Matching', 'null', 1, 2, 29, 118, 1, 2, '2016-01-27 10:38:47', '2016-06-22 15:11:23', 0),
(137, 'ETyqoJK69F', 'GBM Ex1 Single Category', 'null', 1, 4, 8, 228, 1, 0, '2016-01-27 10:38:47', '2016-06-22 17:13:24', 0),
(138, 'EZg3xckBMm', 'F G1 Guiding a Child', 'null', 1, 2, 29, 244, 1, 1, '2016-01-27 10:38:47', '2016-06-22 15:19:27', 0),
(139, 'EkIoy1xCBn', 'First Chart', 'null', 1, 1, 2, 175, 1, 1, '2016-01-27 10:38:47', '2016-04-24 01:31:23', 0),
(140, 'ElXyVnFquY', 'lake and island', 'null', 1, 3, 7, 157, 1, 0, '2016-01-27 10:38:47', '2016-04-23 23:55:12', 0),
(141, 'EqdrrT707P', '2 subjects/2 actions', 'null', 1, 1, 2, 182, 1, 1, '2016-01-27 10:38:47', '2016-04-24 01:30:40', 0),
(142, 'Es9AGrkrSG', 'Bookmaking', 'null', 1, 1, 32, 94, 1, 11, '2016-01-27 10:38:47', '2016-06-13 09:53:24', 0),
(143, 'F1X2rvZHF3', 'Board C', 'null', 1, 2, 29, 178, 1, 1, '2016-01-27 10:38:47', '2016-04-24 00:39:12', 0),
(144, 'F6FJYPVTcD', 'Appositives', 'null', 1, 1, 2, 19, 1, 4, '2016-01-27 10:38:47', '2016-04-24 01:31:51', 0),
(145, 'FBForh4UtW', 'St10 Dividing in Half', 'null', 1, 1, 32, 94, 1, 9, '2016-01-27 10:38:47', '2016-06-13 09:53:24', 0),
(146, 'FCPYxmrUl9', 'Ex5 NR Subtraction', 'null', 1, 4, 3, 254, 1, 4, '2016-01-27 10:38:47', '2016-06-22 17:12:40', 0),
(147, 'FMgPpjeUw7', 'Description/Definition Game', 'null', 1, 1, 1, 186, 1, 8, '2016-01-27 10:38:47', '2016-06-13 09:45:53', 0),
(148, 'FNU1sYwMQ8', 'G1 Distance Grading', 'null', 1, 2, 6, 241, 1, 4, '2016-01-27 10:38:47', '2016-04-24 00:51:46', 0),
(149, 'FPjBnVM894', '1 subject/2 actions', 'null', 1, 1, 2, 182, 1, 0, '2016-01-27 10:38:47', '2016-04-24 01:30:38', 0),
(150, 'FWSh26JoWi', 'Prs1 Adding ''s''', 'null', 1, 1, 23, 149, 1, 0, '2016-01-27 10:38:48', '2016-01-27 10:38:48', 0),
(151, 'Fbj02oc2VL', 'PT Ex3 Remove and Hide', 'null', 1, 2, 22, 243, 1, 2, '2016-01-27 10:38:48', '2016-06-22 14:39:32', 0),
(152, 'FbpVQMMKoz', ' GeoCards Part A-Find the Shape', 'null', 1, 2, 22, 62, 1, 0, '2016-01-27 10:38:48', '2016-06-22 16:35:20', 0),
(153, 'FdYdrWrqim', 'G6 Do Re Mi...', 'null', 1, 2, 6, 31, 1, 5, '2016-01-27 10:38:48', '2016-04-24 00:52:48', 0),
(154, 'Fjg8BTop5F', 'Objects w/Superlative Qualities', 'null', 1, 1, 1, 272, 1, 3, '2016-01-27 10:38:48', '2016-04-24 01:14:59', 0),
(155, 'Fla1xwKfDr', 'G2 Sing Next Bell', 'null', 1, 2, 6, 241, 1, 5, '2016-01-27 10:38:48', '2016-04-24 00:51:48', 0),
(156, 'FnMqVGThHl', 'BotC G3 Environment Game', 'null', 1, 2, 22, 269, 1, 6, '2016-01-27 10:38:48', '2016-06-22 16:42:07', 0),
(157, 'FotwE1sgY7', 'Ex2 Write Own Phrases', 'null', 1, 1, 14, 95, 1, 0, '2016-01-27 10:38:48', '2016-01-27 10:38:48', 0),
(158, 'FsloDu0DNo', 'Ex1 Dictate Phons/Different', 'null', 1, 1, 20, 144, 1, 0, '2016-01-27 10:38:48', '2016-04-24 01:23:14', 0),
(159, 'Ft5CWS3ma0', 'Ex3 Comparison of Tables', 'null', 1, 4, 5, 159, 1, 2, '2016-01-27 10:38:48', '2016-04-24 02:12:00', 0),
(160, 'G7oLf7vf8h', 'Kitchen Appliances', 'null', 1, 1, 2, 48, 1, 12, '2016-01-27 10:38:48', '2016-06-10 13:11:03', 0),
(161, 'G8Rux2JfhU', 'St6 3 insets/3 colors', 'null', 1, 1, 32, 94, 1, 5, '2016-01-27 10:38:48', '2016-06-13 09:53:24', 0),
(162, 'GG5sq8z1X6', 'Tri Ex1 Build Outside the Box', 'null', 1, 2, 22, 131, 1, 2, '2016-01-27 10:38:48', '2016-06-22 16:48:02', 0),
(163, 'GW59bLkC9I', 'St2 Entire World Map', 'null', 1, 1, 32, 239, 1, 0, '2016-01-27 10:38:48', '2016-01-27 10:38:48', 0),
(164, 'GXyfXivQcw', 'Clothes-Spring', 'null', 1, 1, 2, 48, 1, 6, '2016-01-27 10:38:48', '2016-06-10 13:10:02', 0),
(165, 'GaJCobNGq8', 'CT3 G1 Distance Grading', 'null', 1, 2, 22, 251, 1, 4, '2016-01-27 10:38:48', '2016-06-22 16:25:42', 0),
(166, 'GnL2ld0SuP', 'SBF Subtraction w Many Zeroes', 'null', 1, 4, 12, 249, 1, 12, '2016-01-27 10:38:48', '2016-06-22 17:43:56', 0),
(167, 'GsQuL9Is0p', 'SBF St1 A: Writes & Builds', 'null', 1, 4, 12, 249, 1, 3, '2016-01-27 10:38:48', '2016-06-22 17:41:37', 0),
(168, 'GsUCM0V2M8', 'archipelago', 'null', 1, 3, 7, 157, 1, 5, '2016-01-27 10:38:48', '2016-04-23 23:55:28', 0),
(169, 'GuirJZwnXj', 'Beginning Sewing Activities', 'null', 1, 3, 10, 242, 1, 0, '2016-01-27 10:38:48', '2016-04-24 00:00:56', 0),
(170, 'GujHcOCrw1', 'Dictate in Order', 'null', 1, 4, 15, 78, 1, 2, '2016-01-27 10:38:48', '2016-04-24 02:04:51', 0),
(171, 'HD59Jx1DJi', 'St6 Illustrated Phrases/Sent.', 'null', 1, 1, 32, 46, 1, 11, '2016-01-27 10:38:48', '2016-04-24 01:21:14', 0),
(172, 'HGCtTAJntn', 'Second Chart', 'null', 1, 1, 2, 19, 1, 2, '2016-01-27 10:38:48', '2016-04-24 01:31:51', 0),
(173, 'HGGaCK7lD5', 'straight and isthmus', 'null', 1, 3, 7, 157, 1, 3, '2016-01-27 10:38:48', '2016-04-23 23:55:28', 0),
(174, 'HTaHXYFuNf', 'BotC Presentation Part B', 'null', 1, 2, 22, 269, 1, 1, '2016-01-27 10:38:48', '2016-06-22 16:40:39', 0),
(175, 'HYei3hQqyN', 'St2 Equidistant Lined Board', 'null', 1, 1, 32, 46, 1, 3, '2016-01-27 10:38:48', '2016-04-24 01:20:31', 0),
(176, 'HYloqOwK8Z', 'G11 Movement- picking Fruit', 'null', 1, 2, 6, 31, 1, 10, '2016-01-27 10:38:48', '2016-04-24 00:52:24', 0),
(177, 'Hb6qEmqsCb', 'RR Ex1 Unit of Measurement ', 'null', 1, 2, 22, 255, 1, 0, '2016-01-27 10:38:48', '2016-06-22 14:48:26', 0),
(178, 'HcKtHpYZqB', 'Objects w/Superlative Qualities', 'null', 1, 2, 22, 99, 1, 3, '2016-01-27 10:38:48', '2016-04-24 00:12:55', 0),
(179, 'HcTT6A8beO', 'BotCards Ex1 Thick Lined Cards', 'null', 1, 2, 22, 189, 1, 2, '2016-01-27 10:38:48', '2016-06-22 16:43:45', 0),
(180, 'HjmfFg867l', 'Bi Ex2 Build in Layers', 'null', 1, 2, 22, 268, 1, 3, '2016-01-27 10:38:48', '2016-06-22 16:46:53', 0),
(181, 'HzwB4Y50oZ', 'Tip Toes', 'null', 1, 3, 28, 100, 1, 22, '2016-01-27 10:38:48', '2016-06-13 09:06:29', 0),
(182, 'IGUm5GoS79', 'Snake', 'null', 1, 1, 2, 168, 1, 3, '2016-01-27 10:38:48', '2016-04-24 01:33:01', 0),
(183, 'IPzvMIXNB5', 'Ex1 Box 2', 'null', 1, 2, 29, 244, 1, 0, '2016-01-27 10:38:48', '2016-04-24 00:40:07', 0),
(184, 'IZJBJUJvTn', 'Color Mixing', 'null', 1, 3, 10, 120, 1, 11, '2016-01-27 10:38:48', '2016-06-10 12:03:09', 0),
(185, 'IaNHvHh8iu', 'St1 Build Table to Paper', 'null', 1, 1, 32, 213, 1, 0, '2016-01-27 10:38:48', '2016-01-27 10:38:48', 0),
(186, 'IaswsDTUsA', 'Parts of a Flag', 'null', 1, 1, 2, 221, 1, 7, '2016-01-27 10:38:48', '2016-06-13 09:59:56', 0),
(187, 'IleUet5w8Z', 'GeoC Presentation Part B', 'null', 1, 2, 22, 55, 1, 2, '2016-01-27 10:38:49', '2016-06-22 16:29:26', 0),
(188, 'J7pKoZSBx7', 'ThB G1 Distance Matching', 'null', 1, 2, 27, 215, 1, 1, '2016-01-27 10:38:49', '2016-06-22 15:26:47', 0),
(190, 'JN4LVXEWIh', 'RR Ex3 Remove and Hide', 'null', 1, 2, 22, 255, 1, 2, '2016-01-27 10:38:49', '2016-06-22 14:49:10', 0),
(191, 'JNNk8UKHgz', 'St2 Waves Close Together', 'null', 1, 1, 32, 94, 1, 1, '2016-01-27 10:38:49', '2016-04-24 01:18:45', 0),
(192, 'JNZ7uqkcIi', 'Ex1 Odd or Even', 'null', 1, 4, 3, 252, 1, 0, '2016-01-27 10:38:49', '2016-01-27 10:38:49', 0),
(193, 'JPcai6aiYc', 'St2 Design on Paper', 'null', 1, 1, 32, 213, 1, 0, '2016-01-27 10:38:49', '2016-01-27 10:38:49', 0),
(194, 'JaCJb8NPJv', 'Tempera (solid)', 'null', 1, 3, 10, 16, 1, 0, '2016-01-27 10:38:49', '2016-04-24 00:01:38', 0),
(195, 'JtfXuYx8uc', 'Amphibians', 'null', 1, 1, 2, 45, 1, 7, '2016-01-27 10:38:49', '2016-06-13 09:58:40', 0),
(196, 'K1rAZGZ6VW', '1 sub/1 pred/ 2 direct obj.', 'null', 1, 1, 2, 182, 1, 3, '2016-01-27 10:38:49', '2016-04-24 01:30:55', 0),
(197, 'K5rIV5R3zg', 'Ex1 Transitive Verbs', 'null', 1, 1, 14, 240, 1, 0, '2016-01-27 10:38:49', '2016-04-24 01:29:06', 0),
(198, 'K9oTmO39UL', 'BotCards G3 Cards Only', 'null', 1, 2, 22, 189, 1, 6, '2016-01-27 10:38:49', '2016-06-22 16:44:50', 0),
(199, 'KBvq7ThwS5', 'GeoCards G2 Distance Matching 3 Hidden', 'null', 1, 2, 22, 62, 1, 5, '2016-01-27 10:38:49', '2016-06-22 16:37:51', 0),
(200, 'KEu87EyHZB', 'Add Static', 'null', 1, 4, 8, 2, 1, 0, '2016-01-27 10:38:49', '2016-06-21 21:50:59', 0),
(201, 'KcFkgVUz0n', 'Sub Dynamic', 'null', 1, 4, 8, 218, 1, 1, '2016-01-27 10:38:49', '2016-06-21 22:07:36', 0),
(202, 'KhtxeBERzl', 'DetAdj Ex1 Prepared Labels', 'null', 1, 1, 14, 110, 1, 0, '2016-01-27 10:38:49', '2016-06-22 16:56:33', 0),
(203, 'Kq5NVe28g0', 'SmB G1 Distance Matching', 'null', 1, 2, 13, 174, 1, 4, '2016-01-27 10:38:49', '2016-06-22 16:18:03', 0),
(204, 'Kz7U240fld', 'Ex7 Stereognostic Building', 'null', 1, 2, 22, 54, 1, 6, '2016-01-27 10:38:49', '2016-06-10 12:23:51', 0),
(205, 'LHEerFUVQg', 'Small Hexagonal Box', 'null', 1, 2, 22, 212, 1, 3, '2016-01-27 10:38:49', '2016-04-24 00:18:02', 0),
(206, 'LWECdbaJI4', 'Prs3 Changing Form', 'null', 1, 1, 23, 149, 1, 0, '2016-01-27 10:38:49', '2016-01-27 10:38:49', 0),
(207, 'LX7BmtOhr5', 'St1 Beads/Cards', 'null', 1, 4, 8, 18, 1, 0, '2016-01-27 10:38:49', '2016-04-24 01:44:40', 0),
(208, 'LjLvjDMmGy', 'ThB G4 Dist Language Refinement', 'null', 1, 2, 27, 215, 1, 4, '2016-01-27 10:38:49', '2016-06-22 15:28:00', 0),
(209, 'LkwiRfKBDP', 'Ex3 Non-movement', 'null', 1, 1, 14, 240, 1, 2, '2016-01-27 10:38:49', '2016-04-24 01:29:11', 0),
(210, 'M4HrHaTfDL', 'RR G6 Environment Match-Variation', 'null', 1, 2, 22, 255, 1, 9, '2016-01-27 10:38:49', '2016-06-22 14:51:13', 0),
(211, 'MKnci2rkli', 'Ex1 Match Cards w/Bells', 'null', 1, 1, 11, 173, 1, 0, '2016-01-27 10:38:49', '2016-04-24 01:22:47', 0),
(212, 'MMVoJwdNdI', 'G1 Name Pitch', 'null', 1, 1, 11, 88, 1, 0, '2016-01-27 10:38:49', '2016-04-24 01:21:53', 0),
(213, 'MWND1uaPA1', 'G2 Go Fish', 'null', 1, 1, 23, 230, 1, 0, '2016-01-27 10:38:49', '2016-01-27 10:38:49', 0),
(214, 'MnAg1hzSIl', 'Part A Complete Definitions', 'null', 1, 1, 20, 49, 1, 8, '2016-01-27 10:38:49', '2016-04-24 01:25:35', 0),
(216, 'Mr3ygTK4rn', 'Orientation Game', 'null', 1, 1, 1, 186, 1, 0, '2016-01-27 10:38:49', '2016-04-24 01:13:35', 0),
(217, 'Mw2JYFIpnq', 'Prs1 Two Commands', 'null', 1, 1, 14, 11, 1, 0, '2016-01-27 10:38:49', '2016-04-24 01:29:37', 0),
(218, 'N7XQUdGYDg', 'Tri Ex3 Build Blindfold', 'null', 1, 2, 22, 131, 1, 4, '2016-01-27 10:38:50', '2016-06-22 16:48:31', 0),
(219, 'NFaEIbuPoQ', 'Ex2 Explore w/Base Cards', 'null', 1, 2, 24, 224, 1, 5, '2016-01-27 10:38:50', '2016-04-24 00:54:39', 0),
(220, 'NderEmtmVx', 'SG St3 Making & Linking Numbers in Columns', 'null', 1, 4, 8, 105, 1, 2, '2016-01-27 10:38:50', '2016-06-22 17:15:56', 0),
(221, 'NdgScgDRtS', 'How to remove/return a drawer', 'null', 1, 2, 22, 55, 1, 0, '2016-01-27 10:38:50', '2016-04-24 00:15:39', 0),
(222, 'Nlk6sldikk', 'BT Ex2 All Three Sets', 'null', 1, 2, 31, 129, 1, 1, '2016-01-27 10:38:50', '2016-06-22 15:24:50', 0),
(223, 'Nu41U2kPbb', 'G6 Use Sandpaper Letter Letters', 'null', 1, 1, 32, 234, 1, 5, '2016-01-27 10:38:50', '2016-04-24 00:58:16', 0),
(224, 'NuAXubzDII', 'GeoCards Ex2 Thin Lined Cards', 'null', 1, 2, 22, 62, 1, 3, '2016-01-27 10:38:50', '2016-06-22 16:37:12', 0),
(225, 'O0NSrXpKwQ', 'BS G7 Stereognostic Game', 'null', 1, 2, 22, 15, 1, 12, '2016-01-27 10:38:50', '2016-06-22 14:47:39', 0),
(226, 'O4YsHUnDcS', 'Prepared Plate', 'null', 1, 3, 10, 68, 1, 0, '2016-01-27 10:38:50', '2016-06-10 12:04:24', 0),
(228, 'OZPBCWhFV2', 'CT2 G1 Distance Matching', 'null', 1, 2, 22, 12, 1, 0, '2016-01-27 10:38:50', '2016-06-22 16:22:46', 0),
(229, 'ObXmYkadrW', 'SBF Introduction', 'null', 1, 4, 12, 249, 1, 0, '2016-01-27 10:38:50', '2016-06-21 22:16:24', 0),
(230, 'OcpLN5Fa1q', 'Vegeatables', 'null', 1, 1, 2, 48, 1, 22, '2016-01-27 10:38:50', '2016-06-10 13:10:42', 0),
(231, 'OdrPu28AOm', 'GeoCards Ex1 Thick Lined Cards', 'null', 1, 2, 22, 62, 1, 2, '2016-01-27 10:38:50', '2016-06-22 16:36:36', 0),
(232, 'OfLXKqyF2P', 'Ex1 Single Category', 'null', 1, 4, 8, 247, 1, 0, '2016-01-27 10:38:50', '2016-04-24 01:44:14', 0),
(233, 'Ola5CtFhfQ', 'GeoCards Part B-Find the Card', 'null', 1, 2, 22, 62, 1, 1, '2016-01-27 10:38:50', '2016-06-22 16:36:08', 0),
(235, 'Ov5a6RN3n2', 'BS Ex3 Remove and Hide', 'null', 1, 2, 22, 15, 1, 2, '2016-01-27 10:38:50', '2016-06-22 14:44:58', 0),
(236, 'P35YPtHVJT', 'Wooden Arrows & Circles', 'null', 1, 1, 2, 175, 1, 0, '2016-01-27 10:38:50', '2016-04-24 01:31:19', 0),
(237, 'PEutzXrkeP', 'St4 Connect 3 Letters', 'null', 1, 1, 32, 46, 1, 9, '2016-01-27 10:38:50', '2016-04-24 01:21:07', 0),
(238, 'PJC2c1T05E', 'Ex1 Compare Two Sets', 'null', 1, 2, 22, 54, 1, 0, '2016-01-27 10:38:50', '2016-04-24 00:38:30', 0),
(239, 'PT2ZkNBvdR', 'CT3 G3 Language Comparative', 'null', 1, 2, 22, 251, 1, 6, '2016-01-27 10:38:50', '2016-06-22 16:26:30', 0),
(240, 'PZJO9grGDp', 'Bi A- Keep Layers Sep', 'null', 1, 2, 22, 268, 1, 0, '2016-01-27 10:38:50', '2016-06-22 16:46:08', 0),
(241, 'Q03K8NQC9b', 'SBF Subtraction w Zero in Minuend', 'null', 1, 4, 12, 249, 1, 11, '2016-01-27 10:38:50', '2016-06-22 17:43:14', 0),
(242, 'Q4qO77Wdi1', 'Ex 1 V Formation', 'null', 1, 2, 22, 108, 1, 0, '2016-01-27 10:38:50', '2016-04-24 00:08:35', 0),
(243, 'QDpFv2Shmp', 'st1 10-90 (wo cards)', 'null', 1, 4, 15, 109, 1, 0, '2016-01-27 10:38:50', '2016-04-24 02:10:54', 0),
(244, 'QQtHPQyb7Q', 'CT2 G2 Distance Matching- Scattered', 'null', 1, 2, 22, 12, 1, 1, '2016-01-27 10:38:50', '2016-06-22 16:23:21', 0),
(245, 'QXeNK4pKdh', 'Land and Water Forms', 'null', 1, 1, 2, 48, 1, 13, '2016-01-27 10:38:50', '2016-06-10 13:11:03', 0),
(246, 'QZyQIbPp16', 'CB G5 Stereognostic Game', 'null', 1, 2, 22, 108, 1, 13, '2016-01-27 10:38:50', '2016-06-22 15:10:05', 0),
(247, 'QkBnLLXqH0', 'SBF St4 C Builds & Writes', 'null', 1, 4, 12, 249, 1, 6, '2016-01-27 10:38:50', '2016-06-22 17:42:57', 0),
(248, 'Qno5IiXVge', 'Ext1 Review', 'null', 1, 1, 32, 21, 1, 0, '2016-01-27 10:38:50', '2016-04-24 01:17:43', 0),
(249, 'QxaFlEV0GS', 'BS G5 Environment Match', 'null', 1, 2, 22, 15, 1, 10, '2016-01-27 10:38:50', '2016-06-22 14:46:57', 0),
(250, 'R2uC7FEdCO', 'Part A Introduce Sharps(brown)', 'null', 1, 2, 6, 113, 1, 1, '2016-01-27 10:38:50', '2016-06-10 12:47:30', 0),
(251, 'REB14QErg6', 'Prs4 Same Word', 'null', 1, 1, 23, 149, 1, 0, '2016-01-27 10:38:51', '2016-01-27 10:38:51', 0),
(252, 'RZizsjcWlo', 'Part B Introduce Flats (black)', 'null', 1, 2, 6, 113, 1, 2, '2016-01-27 10:38:51', '2016-06-10 12:47:30', 0),
(253, 'RfeKDCyahL', 'Paper Making', 'null', 1, 3, 10, 120, 1, 5, '2016-01-27 10:38:51', '2016-04-23 23:58:42', 0),
(254, 'RiDklNjcVV', 'Mammals', 'null', 1, 1, 2, 45, 1, 3, '2016-01-27 10:38:51', '2016-04-24 01:09:05', 0),
(255, 'RpKTMKikRw', 'Part A Objects in the Environment', 'null', 1, 1, 20, 49, 1, 1, '2016-01-27 10:38:51', '2016-04-24 01:24:50', 0),
(256, 'RrjAYUfthu', 'Parts of a Bird', 'null', 1, 1, 2, 221, 1, 0, '2016-01-27 10:38:51', '2016-01-27 10:38:51', 0),
(257, 'RthvkDlWKx', 'Ex1 Use Noseplugs', 'null', 1, 2, 26, 34, 1, 0, '2016-01-27 10:38:51', '2016-01-27 10:38:51', 0),
(258, 'S3ySlUO3Vm', 'SG Add Static', 'null', 1, 4, 8, 96, 1, 0, '2016-01-27 10:38:51', '2016-06-21 21:40:34', 0),
(259, 'S5iArk2S6K', 'Ex1 Finding a Rod at Random', 'null', 1, 4, 3, 28, 1, 0, '2016-01-27 10:38:51', '2016-01-27 10:38:51', 0),
(260, 'SEJnYh5W3z', 'Snowflake', 'null', 1, 3, 10, 172, 1, 4, '2016-01-27 10:38:51', '2016-06-10 12:03:29', 0),
(261, 'SHgxPnAzyR', 'Mult Dynamic', 'null', 1, 4, 8, 223, 1, 1, '2016-01-27 10:38:51', '2016-06-21 22:02:47', 0),
(263, 'SLnoV4gqLP', 'GeoSol G1 Memory Game', 'null', 1, 2, 24, 224, 1, 6, '2016-01-27 10:38:51', '2016-06-22 16:49:54', 0),
(264, 'SMr53h9bZ1', 'SBF St3 C Writes & Builds', 'null', 1, 4, 12, 249, 1, 5, '2016-01-27 10:38:51', '2016-06-22 17:42:30', 0),
(265, 'SN5ZYBqUZM', 'Practical Life Objects', 'null', 1, 1, 1, 186, 1, 3, '2016-01-27 10:38:51', '2016-04-24 01:13:45', 0),
(266, 'SNEQLPshaY', 'Orchestra Instruments', 'null', 1, 1, 2, 48, 1, 17, '2016-01-27 10:38:51', '2016-06-10 13:10:39', 0),
(267, 'SQaB6oIqzO', 'Flowers', 'null', 1, 1, 2, 48, 1, 8, '2016-01-27 10:38:51', '2016-06-10 13:10:02', 0),
(268, 'STFx07hYrV', 'St8 Pencil & Paper ruler design', 'null', 1, 1, 32, 94, 1, 7, '2016-01-27 10:38:51', '2016-06-13 09:53:24', 0),
(269, 'SnlyoNpgaj', 'Ex2 Comb to make a Product', 'null', 1, 4, 5, 159, 1, 1, '2016-01-27 10:38:51', '2016-04-24 02:12:00', 0),
(270, 'SoS8aPIcvO', 'Printmaking', 'null', 1, 3, 10, 120, 1, 1, '2016-01-27 10:38:51', '2016-04-23 23:58:27', 0),
(271, 'SxvETeJchK', 'LBF St2 A writes/C builds', 'null', 1, 4, 12, 115, 1, 4, '2016-01-27 10:38:51', '2016-06-22 17:51:48', 0),
(272, 'T6FJs9XHX2', 'St4 Related Sentences', 'null', 1, 1, 32, 70, 1, 3, '2016-01-27 10:38:51', '2016-04-24 01:18:07', 0),
(273, 'TNuJBECoHV', 'St7 1 inset/3 colors', 'null', 1, 1, 32, 94, 1, 6, '2016-01-27 10:38:51', '2016-06-13 09:53:24', 0),
(274, 'TYFYqzpFP3', 'Clothes-Summer', 'null', 1, 1, 2, 48, 1, 3, '2016-01-27 10:38:51', '2016-06-10 13:09:51', 0),
(275, 'Tf7faaJ7cJ', 'PT Ex1 Align Sides and Measure', 'null', 1, 2, 22, 243, 1, 0, '2016-01-27 10:38:51', '2016-06-22 14:38:52', 0),
(276, 'TfVfcVUN9K', 'Rectangular Box B', 'null', 1, 2, 22, 212, 1, 1, '2016-01-27 10:38:51', '2016-04-24 00:17:54', 0),
(277, 'TffINxyg9h', 'Attributes', 'null', 1, 1, 2, 19, 1, 3, '2016-01-27 10:38:51', '2016-04-24 01:31:51', 0),
(278, 'TkyrjxEPtb', 'G1 Distance Match(simple)', 'null', 1, 2, 6, 113, 1, 3, '2016-01-27 10:38:51', '2016-06-10 12:47:30', 0),
(279, 'Tl7qf1O3ne', 'G3 Whole Body Motions', 'null', 1, 2, 6, 31, 1, 2, '2016-01-27 10:38:51', '2016-04-24 00:52:36', 0),
(280, 'TpL5YcCtOa', 'Ex2: Link to Multiplication', 'null', 1, 4, 5, 181, 1, 3, '2016-01-27 10:38:51', '2016-06-13 10:06:40', 0),
(281, 'UHorfoF9TG', 'Tri B- Mix & Scatter Layers', 'null', 1, 2, 22, 131, 1, 1, '2016-01-27 10:38:51', '2016-06-22 16:47:48', 0),
(282, 'UaBxAuQUzF', 'Ex 5 Build Tri Base 10', 'null', 1, 2, 22, 29, 1, 5, '2016-01-27 10:38:51', '2016-04-24 00:37:46', 0),
(283, 'Ufc2WeY8gm', 'DotG Ex1 Each category', 'null', 1, 4, 8, 73, 1, 0, '2016-01-27 10:38:51', '2016-06-22 17:17:57', 0),
(284, 'UhjzsB06zP', 'BotC Ex1 One Drawer', 'null', 1, 2, 22, 269, 1, 2, '2016-01-27 10:38:51', '2016-06-22 16:40:56', 0),
(285, 'Ukxwgoyozd', 'SG Mult Static', 'null', 1, 4, 8, 47, 1, 0, '2016-01-27 10:38:52', '2016-06-21 21:43:01', 0),
(286, 'UlQPbm0o5f', 'Punctuation A- many actions', 'null', 1, 1, 2, 175, 1, 2, '2016-01-27 10:38:52', '2016-04-24 01:31:23', 0),
(287, 'Umn6Cr3FMz', 'St. 1 Walking Naturally', 'null', 1, 3, 28, 100, 1, 3, '2016-01-27 10:38:52', '2016-06-10 12:00:49', 0),
(288, 'Up2HCRM4GP', 'SG Sub Dynamic', 'null', 1, 4, 8, 203, 1, 1, '2016-01-27 10:38:52', '2016-06-21 22:03:32', 0),
(289, 'V2KjNiPlHk', 'Unmarked Staff Board', 'null', 1, 1, 11, 148, 1, 1, '2016-01-27 10:38:52', '2016-04-24 01:22:17', 0),
(290, 'V8dxFfUp40', 'Ex4b Build Bi Other Bases', 'null', 1, 2, 22, 29, 1, 4, '2016-01-27 10:38:52', '2016-04-24 00:37:46', 0),
(291, 'VD9AVmMHRF', 'SG 4-digit divisor/group division', 'null', 1, 4, 8, 103, 1, 6, '2016-01-27 10:38:52', '2016-06-22 17:16:58', 0),
(292, 'VdiFTTzio9', 'G5 Singing Names', 'null', 1, 2, 6, 31, 1, 4, '2016-01-27 10:38:52', '2016-04-24 00:52:44', 0),
(293, 'Vf7XdyY77Q', 'PT G1 Distance Grading', 'null', 1, 2, 22, 243, 1, 3, '2016-01-27 10:38:52', '2016-06-22 14:39:54', 0),
(295, 'VoxoGUGZWm', 'TT G5 Lang- Refinement', 'null', 1, 2, 29, 118, 1, 5, '2016-01-27 10:38:52', '2016-06-22 15:13:29', 0),
(296, 'VwHCkDpMdg', 'LBF St4 C Builds & Writes', 'null', 1, 4, 12, 115, 1, 6, '2016-01-27 10:38:52', '2016-06-22 17:52:42', 0),
(297, 'W1MbbTao3I', 'Ex1 Write Own Labels', 'null', 1, 1, 14, 36, 1, 0, '2016-01-27 10:38:52', '2016-02-17 04:23:02', 0),
(298, 'W24JWjOTqw', 'CT3 Ex3 Remove and Hide', 'null', 1, 2, 22, 251, 1, 2, '2016-01-27 10:38:52', '2016-06-22 16:25:21', 0),
(299, 'W6hHZTMoTl', 'Ex4 Sunburst', 'null', 1, 2, 22, 251, 1, 3, '2016-01-27 10:38:52', '2016-04-24 00:12:16', 0),
(300, 'W8JVP8bpWe', 'CT3 Ex1 Grading Many Sets', 'null', 1, 2, 22, 251, 1, 0, '2016-01-27 10:38:52', '2016-06-22 16:24:40', 0),
(301, 'WUlDS6eQYz', 'A Builds/C Identifies', 'null', 1, 4, 15, 78, 1, 1, '2016-01-27 10:38:52', '2016-04-24 02:04:51', 0),
(302, 'WZxFSskVO1', 'Ex1 Pairing Sachets', 'null', 1, 2, 13, 174, 1, 0, '2016-01-27 10:38:52', '2016-04-24 00:44:33', 0),
(303, 'Wf8yxsd5Ad', 'Transportation', 'null', 1, 1, 2, 48, 1, 21, '2016-01-27 10:38:52', '2016-06-10 13:10:47', 0),
(304, 'X0akPS0f2H', 'LDB St1 2-digit divisor', 'null', 1, 4, 8, 111, 1, 0, '2016-01-27 10:38:52', '2016-06-21 22:15:05', 0),
(305, 'X0yKgtAAkY', 'Checkbook', 'null', 1, 4, 8, 218, 1, 2, '2016-01-27 10:38:52', '2016-04-24 01:45:15', 0),
(306, 'X85YG2IJC7', 'LBF Dynamic Addition', 'null', 1, 4, 12, 115, 1, 8, '2016-01-27 10:38:52', '2016-06-21 22:12:07', 0),
(307, 'XJECmsVVHc', 'BotC Ex2 Many Drawers', 'null', 1, 2, 22, 269, 1, 3, '2016-01-27 10:38:52', '2016-06-22 16:41:14', 0),
(308, 'XOwAlmcMqW', 'SBF Notation One: wo zeros', 'null', 1, 4, 12, 249, 1, 1, '2016-01-27 10:38:52', '2016-06-22 17:40:32', 0),
(309, 'XPARMynSSw', 'GeoCards G3 Cards Only', 'null', 1, 2, 22, 62, 1, 6, '2016-01-27 10:38:52', '2016-06-22 16:38:08', 0),
(310, 'XRKyg75zdH', 'Prep Ex1 Prepared Labels/Farm', 'null', 1, 1, 14, 95, 1, 0, '2016-01-27 10:38:52', '2016-06-22 16:55:23', 0),
(311, 'XYFDOArv2s', 'Prs.2 Match C grade rest', 'null', 1, 2, 6, 138, 1, 2, '2016-01-27 10:38:52', '2016-06-10 12:50:28', 0),
(312, 'XYMUDqV1Bb', 'TT G4 Lang- Comparative', 'null', 1, 2, 29, 118, 1, 4, '2016-01-27 10:38:52', '2016-06-22 15:13:07', 0),
(313, 'XmytJU0JuG', 'Domesticated Animals- Pets', 'null', 1, 1, 2, 48, 1, 7, '2016-01-27 10:38:52', '2016-06-10 13:10:02', 0),
(314, 'XqmrWk9xmH', 'ThT G1 Distance Matching', 'null', 1, 2, 27, 164, 1, 0, '2016-01-27 10:38:52', '2016-06-22 15:38:53', 0),
(315, 'Xzy6PWvUbm', 'Indirect Objects', 'null', 1, 1, 2, 19, 1, 1, '2016-01-27 10:38:53', '2016-04-24 01:31:45', 0),
(316, 'YEKfZzmiYB', 'Pastels', 'null', 1, 3, 10, 267, 1, 3, '2016-01-27 10:38:53', '2016-06-10 12:03:44', 0),
(317, 'YP4Tsq4FvG', 'CB G3 Distance Matching Scattered', 'null', 1, 2, 22, 108, 1, 11, '2016-01-27 10:38:53', '2016-06-22 15:08:36', 0),
(318, 'YVt1pTGRwM', 'Ex3 Grinding Spices', 'null', 1, 2, 13, 174, 1, 2, '2016-01-27 10:38:53', '2016-04-24 00:44:33', 0),
(319, 'Yai1Ltp6ng', 'Clothes-Winter', 'null', 1, 1, 2, 48, 1, 5, '2016-01-27 10:38:53', '2016-06-10 13:10:01', 0),
(320, 'YgzF4q2Cec', 'Ex2 Other Conjunctions', 'null', 1, 1, 14, 216, 1, 0, '2016-01-27 10:38:54', '2016-01-27 10:38:54', 0),
(321, 'YsFoUYMSOU', 'Objects w/Comparative Qualities', 'null', 1, 1, 1, 272, 1, 2, '2016-01-27 10:38:54', '2016-04-24 01:15:03', 0),
(322, 'Z4dsfs1t0W', 'Ex4 Superimpose Two Sets', 'null', 1, 2, 22, 54, 1, 3, '2016-01-27 10:38:54', '2016-04-24 00:38:35', 0),
(323, 'ZBmMyPtq7k', 'Prs.1 Individual', 'null', 1, 1, 20, 256, 1, 0, '2016-01-27 10:38:54', '2016-01-27 10:38:54', 0),
(324, 'ZMFX1m8jB0', 'G3 Short Conversation', 'null', 1, 2, 6, 113, 1, 6, '2016-01-27 10:38:54', '2016-06-10 12:47:30', 0),
(325, 'ZYtho64poO', 'Fish', 'null', 1, 1, 2, 168, 1, 2, '2016-01-27 10:38:54', '2016-04-24 01:32:59', 0),
(326, 'ZmZuR0ZKcO', 'Animal Babies', 'null', 1, 1, 2, 48, 1, 1, '2016-01-27 10:38:54', '2016-04-24 01:05:53', 0),
(327, 'ZrdgIoRBqS', 'St9 Regular Lined Paper', 'null', 1, 1, 32, 46, 1, 14, '2016-01-27 10:38:54', '2016-04-24 01:21:19', 0),
(328, 'Zye2gysfrN', 'RR Ex2 Remove and Show', 'null', 1, 2, 22, 255, 1, 1, '2016-01-27 10:38:54', '2016-06-22 14:48:43', 0),
(329, 'a0i92m615w', 'BotCards G1 Distance Matching', 'null', 1, 2, 22, 189, 1, 4, '2016-01-27 10:38:54', '2016-06-22 16:44:20', 0),
(331, 'a1uJnM7PjP', 'Parts of a Frog', 'null', 1, 1, 2, 221, 1, 5, '2016-01-27 10:38:54', '2016-06-13 10:00:00', 0),
(332, 'aGgIN1ELft', 'GeoC G3 Environment Game', 'null', 1, 2, 22, 55, 1, 7, '2016-01-27 10:38:54', '2016-06-22 16:31:26', 0),
(333, 'aHmbc5QYKL', 'LBF Multiplication', 'null', 1, 4, 12, 115, 1, 13, '2016-01-27 10:38:54', '2016-06-22 17:53:53', 0),
(334, 'b0hcTIdt2t', 'Ex1 Build Outside Frame', 'null', 1, 2, 30, 67, 1, 0, '2016-01-27 10:38:54', '2016-04-24 00:55:32', 0),
(335, 'b2kCXZ2tbK', 'SG  Div Dynamic 1-digit divisor', 'null', 1, 4, 8, 103, 1, 1, '2016-01-27 10:38:54', '2016-06-21 22:05:18', 0),
(336, 'bCIY8ueCEv', 'Power Tools', 'null', 1, 1, 2, 48, 1, 18, '2016-01-27 10:38:54', '2016-06-10 13:10:39', 0),
(338, 'bJV27MutRo', 'Running Stitch', 'null', 1, 3, 10, 242, 1, 2, '2016-01-27 10:38:54', '2016-06-10 12:04:52', 0),
(339, 'bOTbJns1ni', 'BS G2 Distance Grading- Scattered', 'null', 1, 2, 22, 15, 1, 4, '2016-01-27 10:38:54', '2016-06-22 14:45:52', 0),
(340, 'ba8f2EGQk5', 'PR.1-Still Body Bit by Bit', 'PR.1-Still Body Bit by Bitnull', 1, 3, 28, 7, 1, 0, '2016-01-27 10:38:54', '2016-06-13 09:08:38', 0),
(341, 'bfJvRp3Ybm', 'SBF Static Subtraction', 'null', 1, 4, 12, 249, 1, 9, '2016-01-27 10:38:54', '2016-06-21 21:56:09', 0),
(342, 'bmuD1WeBtf', 'Tri A- Keep Layers Separate', 'null', 1, 2, 22, 131, 1, 0, '2016-01-27 10:38:54', '2016-06-22 16:47:28', 0),
(343, 'btG75IxcfK', 'G4 Using Sounds in a Word', 'null', 1, 1, 32, 234, 1, 3, '2016-01-27 10:38:54', '2016-04-24 00:58:21', 0),
(344, 'c4obNXFtXh', 'SBF Notation Two: w zeroes', 'null', 1, 4, 12, 249, 1, 2, '2016-01-27 10:38:54', '2016-06-22 17:41:02', 0),
(345, 'c8G37f024y', 'LBF St1 A writes & Builds', 'null', 1, 4, 12, 115, 1, 3, '2016-01-27 10:38:54', '2016-06-22 17:51:27', 0),
(346, 'cQ51f0BrCg', 'Add Dynamic', 'null', 1, 4, 8, 2, 1, 1, '2016-01-27 10:38:54', '2016-06-21 22:06:28', 0),
(347, 'cV2olWMeKB', 'Ex1 Show Card/Find Rod', 'null', 1, 4, 3, 254, 1, 0, '2016-01-27 10:38:54', '2016-04-24 01:43:25', 0),
(348, 'cecyJIR6DG', 'Natural Wonders of US', 'null', 1, 1, 2, 48, 1, 15, '2016-01-27 10:38:54', '2016-06-10 13:10:39', 0),
(349, 'cuuMgoYGiv', 'GeoC Ex1 One Drawer', 'null', 1, 2, 22, 55, 1, 3, '2016-01-27 10:38:54', '2016-06-22 16:29:59', 0),
(350, 'cwQnMiwdGX', 'Tri Ex2 Build in Layers', 'null', 1, 2, 22, 131, 1, 3, '2016-01-27 10:38:54', '2016-06-22 16:48:16', 0),
(351, 'd17aZRxUZY', 'Dog Breeds', 'null', 1, 1, 2, 48, 1, 25, '2016-01-27 10:38:54', '2016-06-10 13:10:26', 0),
(352, 'd3ODzmi1uA', 'Var1 Adult Names Solid', 'null', 1, 2, 24, 224, 1, 2, '2016-01-27 10:38:54', '2016-04-24 00:54:28', 0),
(353, 'd4Q9AoY6sy', 'Ex1 Ending Sounds', 'null', 1, 1, 20, 53, 1, 0, '2016-01-27 10:38:54', '2016-01-27 10:38:54', 0),
(354, 'd6JMLMhYo9', 'Ex2 Initial Sounds', 'null', 1, 1, 20, 53, 1, 0, '2016-01-27 10:38:54', '2016-01-27 10:38:54', 0),
(355, 'd6vcrpsedB', 'TT G1 Guiding a Child', 'null', 1, 2, 29, 118, 1, 1, '2016-01-27 10:38:54', '2016-06-22 15:11:03', 0),
(356, 'd7NXqeAIQJ', 'Watercolors', 'null', 1, 3, 10, 16, 1, 1, '2016-01-27 10:38:55', '2016-04-24 00:01:39', 0),
(357, 'd7suLuisRC', 'CT3 Ex2 Remove and Show', 'null', 1, 2, 22, 251, 1, 1, '2016-01-27 10:38:55', '2016-06-22 16:25:01', 0),
(358, 'd9nprQo5Zk', 'Ex3 Compare All Sets', 'null', 1, 2, 22, 54, 1, 2, '2016-01-27 10:38:55', '2016-04-24 00:38:33', 0),
(359, 'dCQFlCLMm5', 'Ex4 Words in Books', 'null', 1, 1, 20, 139, 1, 3, '2016-01-27 10:38:55', '2016-04-24 01:24:03', 0),
(360, 'dDyvsNeWco', 'Ex2 Nomenclature Cards', 'null', 1, 1, 11, 173, 1, 1, '2016-01-27 10:38:55', '2016-04-24 01:22:47', 0),
(361, 'dEXJdxJN68', 'Ex3 Grading', 'null', 1, 1, 11, 173, 1, 2, '2016-01-27 10:38:55', '2016-04-24 01:22:47', 0),
(362, 'dFKgtGl2Ht', 'Board D', 'null', 1, 2, 29, 178, 1, 2, '2016-01-27 10:38:55', '2016-04-24 00:39:12', 0),
(363, 'dHYnd3gHrI', 'Blindfolds', 'null', 1, 2, 29, 178, 1, 3, '2016-01-27 10:38:55', '2016-04-24 00:39:12', 0),
(364, 'dQdq29SXUQ', 'LBF Static Subtraction', 'null', 1, 4, 12, 115, 1, 9, '2016-01-27 10:38:55', '2016-06-21 21:56:49', 0),
(365, 'dbaB3QQ3gL', 'GeoC G4 Stereognostic Game', 'null', 1, 2, 22, 55, 1, 8, '2016-01-27 10:38:55', '2016-06-22 16:31:45', 0),
(366, 'dc82Sd0xXg', 'Prs 1-Mounting the Line', 'null', 1, 3, 28, 100, 1, 0, '2016-01-27 10:38:55', '2016-04-23 23:56:03', 0),
(367, 'e1XfIis632', 'Ex1: Essential Combinations', 'null', 1, 4, 5, 181, 1, 2, '2016-01-27 10:38:55', '2016-06-13 10:06:40', 0),
(368, 'e3qiJC0HPg', 'Ex5 Simple Towers', 'null', 1, 2, 22, 54, 1, 4, '2016-01-27 10:38:55', '2016-04-24 00:38:37', 0),
(369, 'eDt0NiRiAu', 'LBF Subtraction w Zero in Minuend', 'null', 1, 4, 12, 115, 1, 11, '2016-01-27 10:38:55', '2016-06-22 17:53:09', 0),
(370, 'eHsMZRUAqt', 'Wonders of US', 'null', 1, 1, 2, 48, 1, 23, '2016-01-27 10:38:55', '2016-06-10 13:10:42', 0),
(371, 'eNmQQXPaGi', 'Sewing a Button', 'null', 1, 3, 10, 242, 1, 1, '2016-01-27 10:38:55', '2016-06-10 12:04:46', 0),
(372, 'eNsAkI6HEz', 'Ex2 Description Labels', 'null', 1, 1, 14, 207, 1, 0, '2016-01-27 10:38:55', '2016-01-27 10:38:55', 0),
(373, 'eOylA72IHQ', 'Ex3 Rods & Cards in Sequence', 'null', 1, 4, 3, 254, 1, 2, '2016-01-27 10:38:55', '2016-04-24 01:43:26', 0),
(374, 'eRQtrbIVlV', 'Origami', 'null', 1, 3, 10, 120, 1, 9, '2016-01-27 10:38:55', '2016-04-23 23:59:00', 0),
(375, 'eSNeDFR2QD', 'Musical Instruments', 'null', 1, 1, 2, 48, 1, 14, '2016-01-27 10:38:55', '2016-06-10 13:10:39', 0),
(376, 'eSxQOcjAuz', 'system of lakes', 'null', 1, 3, 7, 157, 1, 4, '2016-01-27 10:38:55', '2016-04-23 23:55:28', 0),
(377, 'eVMwC8rjps', 'Naming Objects', 'null', 1, 1, 1, 186, 1, 1, '2016-01-27 10:38:55', '2016-04-24 01:13:43', 0),
(378, 'ebf64saRJG', 'Ex6 Alphabetizing', 'null', 1, 1, 20, 139, 1, 5, '2016-01-27 10:38:55', '2016-04-24 01:24:02', 0),
(379, 'epALA2mA4u', 'Hand Tools', 'null', 1, 1, 2, 48, 1, 10, '2016-01-27 10:38:55', '2016-06-10 13:10:38', 0),
(381, 'f7gMs4gI2N', 'SBF Dynamic Subtraction', 'null', 1, 4, 12, 249, 1, 10, '2016-01-27 10:38:55', '2016-06-21 22:13:04', 0),
(382, 'fADsdSHpBs', 'Mult Static', 'null', 1, 4, 8, 223, 1, 0, '2016-01-27 10:38:55', '2016-06-21 21:47:48', 0),
(383, 'fQATfKQxsZ', 'Natural Wonders of World', 'null', 1, 1, 2, 48, 1, 16, '2016-01-27 10:38:55', '2016-06-10 13:10:39', 0),
(384, 'fSUZINYh9h', 'SG St1 Making Numbers', 'null', 1, 4, 8, 105, 1, 0, '2016-01-27 10:38:56', '2016-06-22 17:15:09', 0),
(386, 'fY1osZuBKH', 'Dictate in Order', 'null', 1, 4, 15, 220, 1, 0, '2016-01-27 10:38:56', '2016-01-27 10:38:56', 0),
(387, 'fgKlbiCWhD', 'Wonders of World', 'null', 1, 1, 2, 48, 1, 24, '2016-01-27 10:38:56', '2016-06-10 13:10:26', 0),
(388, 'fmpCmwozBB', 'Prs 2-Making Space on Line', 'null', 1, 3, 28, 100, 1, 1, '2016-01-27 10:38:56', '2016-04-23 23:56:07', 0),
(389, 'g76mbXHtDl', 'PT G2 Distance Grading- Scattered', 'null', 1, 2, 22, 243, 1, 4, '2016-01-27 10:38:56', '2016-06-22 14:40:09', 0),
(390, 'gAl4tD3i4k', 'PT Ex2 Remove and Show', 'null', 1, 2, 22, 243, 1, 1, '2016-01-27 10:38:56', '2016-06-22 14:39:13', 0),
(391, 'gEduMYGEoC', 'Board B', 'null', 1, 2, 29, 178, 1, 0, '2016-01-27 10:38:56', '2016-04-24 00:39:12', 0),
(392, 'gKNCK88cn2', 'Initial Strokes w SPL', 'null', 1, 1, 32, 46, 1, 16, '2016-01-27 10:38:56', '2016-04-24 01:21:14', 0),
(393, 'gN9O4KJsik', 'St4 2 insets/2 colors', 'null', 1, 1, 32, 94, 1, 3, '2016-01-27 10:38:56', '2016-06-13 09:49:50', 0),
(395, 'gi89mQycHX', 'Bi B- Mix/Scatter Layers', 'null', 1, 2, 22, 268, 1, 1, '2016-01-27 10:38:56', '2016-06-22 16:46:24', 0),
(396, 'gjMktAwnz6', 'Chalkboards', 'null', 1, 1, 32, 46, 1, 1, '2016-01-27 10:38:56', '2016-04-24 01:20:31', 0),
(397, 'gp1Fz1fUFx', 'GeoCards G1 Distance Matching', 'null', 1, 2, 22, 62, 1, 4, '2016-01-27 10:38:56', '2016-06-22 16:37:31', 0),
(398, 'gtUDvyPSbz', 'Dictate in Order', 'null', 1, 4, 15, 51, 1, 0, '2016-01-27 10:38:56', '2016-01-27 10:38:56', 0),
(399, 'hFZihVnDet', 'Biome Folders', 'null', 1, 1, 1, 142, 1, 10, '2016-01-27 10:38:56', '2016-04-24 01:16:29', 0),
(400, 'hPhDWJqbBc', 'Var2 Child Thinks of Solid', 'null', 1, 2, 24, 224, 1, 3, '2016-01-27 10:38:56', '2016-04-24 00:54:30', 0),
(401, 'hQjmiuleef', 'Exploration of Form', 'null', 1, 3, 10, 120, 1, 7, '2016-01-27 10:38:56', '2016-04-23 23:58:51', 0),
(402, 'hRBNi3riQo', 'Ex2 Write and Act Out', 'null', 1, 1, 14, 116, 1, 0, '2016-01-27 10:38:56', '2016-01-27 10:38:56', 0),
(403, 'hRX59lNgpX', 'Land and Water Forms Maps', 'null', 1, 1, 1, 142, 1, 9, '2016-01-27 10:38:56', '2016-04-24 01:16:23', 0),
(404, 'hXw7985Mzq', 'Prs.2- 2 3 4 5 6 7 8', 'null', 1, 2, 24, 209, 1, 1, '2016-01-27 10:38:56', '2016-06-13 09:42:28', 0),
(405, 'hgvzos7jfo', 'G2 Other Names for Pitch', 'null', 1, 1, 11, 88, 1, 1, '2016-01-27 10:38:56', '2016-04-24 01:21:53', 0),
(406, 'hlOU8v5VL2', 'PT G7 Stereognostic Game', 'null', 1, 2, 22, 243, 1, 12, '2016-01-27 10:38:56', '2016-06-22 14:43:51', 0),
(407, 'hoMjLVbWlp', 'St. 3 Walking with Objects', 'null', 1, 3, 28, 100, 1, 5, '2016-01-27 10:38:56', '2016-06-10 12:00:49', 0),
(408, 'hsmdjNiP1S', 'G1 Initial Sound', 'null', 1, 1, 32, 234, 1, 0, '2016-01-27 10:38:56', '2016-04-24 00:58:16', 0),
(409, 'hwZJPHatnf', 'Cutting Lines', 'null', 1, 3, 10, 172, 1, 1, '2016-01-27 10:38:56', '2016-04-23 23:59:32', 0),
(410, 'i1hbE2EnYL', 'BotCards Ex2 Thin Lined Cards', 'null', 1, 2, 22, 189, 1, 3, '2016-01-27 10:38:56', '2016-06-22 16:44:00', 0),
(411, 'iIfB2qPLv9', 'Books,Poems, and Rhymes', 'null', 1, 1, 1, 142, 1, 1, '2016-01-27 10:38:56', '2016-04-24 01:15:39', 0),
(412, 'iMcLy0cg6N', 'Ex1 Small Move Alph', 'null', 1, 1, 20, 139, 1, 0, '2016-01-27 10:38:56', '2016-04-24 01:23:54', 0),
(413, 'iNxaOK3yaL', 'TT G3 Distance Grading', 'null', 1, 2, 29, 118, 1, 3, '2016-01-27 10:38:56', '2016-06-22 15:12:15', 0),
(414, 'iTjzt878Ma', 'BS G6 Environment Match-Variation', 'null', 1, 2, 22, 15, 1, 11, '2016-01-27 10:38:56', '2016-06-22 14:47:14', 0),
(415, 'iWYTR7pHol', 'gulf and peninsula', 'null', 1, 3, 7, 157, 1, 2, '2016-01-27 10:38:56', '2016-04-23 23:55:21', 0),
(416, 'iZW9hhLz66', 'Prs3 Irregular Formation', 'null', 1, 1, 23, 133, 1, 2, '2016-01-27 10:38:56', '2016-06-22 19:15:45', 0),
(417, 'ifDndXM5mx', 'Exploration of Space', 'null', 1, 3, 10, 120, 1, 8, '2016-01-27 10:38:56', '2016-04-23 23:58:53', 0),
(418, 'ik6sFdt8g0', 'St1 With Child', 'null', 1, 1, 32, 70, 1, 0, '2016-01-27 10:38:56', '2016-04-24 01:18:04', 0),
(419, 'ioaeoAPgZq', 'Ex2 P/P Adult Dictates', 'null', 1, 1, 20, 139, 1, 1, '2016-01-27 10:38:56', '2016-04-24 01:23:59', 0),
(420, 'ir24mF87sO', 'Ex1 Show Object/Find Slip', 'null', 1, 1, 20, 50, 1, 0, '2016-01-27 10:38:57', '2016-01-27 10:38:57', 0),
(421, 'ivd12HKSkm', 'Birds', 'null', 1, 1, 2, 45, 1, 4, '2016-01-27 10:38:57', '2016-04-24 01:09:05', 0),
(422, 'j7BBRjbbM2', 'Part C Definitions in Phrases', 'null', 1, 1, 20, 49, 1, 10, '2016-01-27 10:38:57', '2016-04-24 01:25:36', 0),
(423, 'j9qrF5Q43o', 'Ex3 Building Squares', 'null', 1, 2, 22, 29, 1, 2, '2016-01-27 10:38:57', '2016-04-24 00:37:43', 0),
(424, 'jj5ftJzaBw', 'Sports', 'null', 1, 1, 2, 48, 1, 20, '2016-01-27 10:38:57', '2016-06-10 13:10:51', 0),
(425, 'jj9SAQmLvS', 'St5 Stories(SMA)', 'null', 1, 1, 32, 70, 1, 4, '2016-01-27 10:38:57', '2016-04-24 01:18:04', 0);
INSERT INTO `exercises` (`id`, `object_id`, `title`, `description`, `user_id`, `area_id`, `chapter_id`, `lesson_id`, `status`, `order_no`, `created`, `modified`, `timestamp`) VALUES
(426, 'jy1Ht1jeY2', 'GeoC G2 Distance Matching V', 'null', 1, 2, 22, 55, 1, 6, '2016-01-27 10:38:57', '2016-06-22 16:31:05', 0),
(427, 'k1bEZUjRGD', 'Part B Sensorial Quals of the Env', 'null', 1, 1, 20, 49, 1, 2, '2016-01-27 10:38:57', '2016-04-24 01:24:54', 0),
(428, 'k4wnJ32FAV', 'SG Dynamic 3-digit divisor', 'null', 1, 4, 8, 103, 1, 3, '2016-01-27 10:38:57', '2016-06-21 22:11:50', 0),
(429, 'kMOtzof8rs', 'Part B Complete Defs- No name', 'null', 1, 1, 20, 49, 1, 9, '2016-01-27 10:38:57', '2016-04-24 01:25:36', 0),
(430, 'kMziP8UVyT', 'SG Static 1-digit divisor', 'null', 1, 4, 8, 103, 1, 0, '2016-01-27 10:38:57', '2016-06-21 21:48:21', 0),
(431, 'kMzmt73got', 'Ex2 Identify Quantity at Random', 'null', 1, 4, 3, 28, 1, 0, '2016-01-27 10:38:57', '2016-01-27 10:38:57', 0),
(432, 'kPNhsXWu1s', 'Parts of a Tree', 'null', 1, 1, 2, 221, 1, 4, '2016-01-27 10:38:57', '2016-06-13 10:00:00', 0),
(433, 'kPUCDwebaG', 'RR G5 Environment Match', 'null', 1, 2, 22, 255, 1, 8, '2016-01-27 10:38:57', '2016-06-22 14:51:00', 0),
(434, 'kRnfaCxHCO', 'G1 Distance Grading', 'null', 1, 2, 6, 138, 1, 8, '2016-01-27 10:38:57', '2016-06-10 12:51:03', 0),
(435, 'kXU6OUkoYx', 'Ext.1-Listening Activity', 'Ext.1-Listening Activity', 1, 3, 28, 7, 1, 3, '2016-01-27 10:38:57', '2016-06-13 09:09:01', 0),
(436, 'ksxLP5bvX3', 'Ex1 Multiply by 10', 'null', 1, 4, 5, 159, 1, 0, '2016-01-27 10:38:57', '2016-04-24 02:12:00', 0),
(437, 'l47PaKWwfO', 'Sensorial Material Properties', 'null', 1, 1, 1, 186, 1, 5, '2016-01-27 10:38:57', '2016-04-24 01:13:59', 0),
(438, 'lFQheZVQdX', 'Question Game', 'null', 1, 1, 1, 142, 1, 2, '2016-01-27 10:38:57', '2016-04-24 01:15:45', 0),
(439, 'lLcbF73cbf', 'PT G6 Environment Match-Variation', 'null', 1, 2, 22, 243, 1, 11, '2016-01-27 10:38:57', '2016-06-22 14:43:18', 0),
(440, 'lUJty4lqbq', 'Fish', 'null', 1, 1, 2, 45, 1, 5, '2016-01-27 10:38:57', '2016-06-13 09:58:40', 0),
(441, 'lhMJpK7CWy', 'PT G4 Language- Refinement', 'null', 1, 2, 22, 243, 1, 9, '2016-01-27 10:38:57', '2016-06-22 14:41:37', 0),
(442, 'liajVk2h7M', 'G3 Middle Sounds', 'null', 1, 1, 32, 234, 1, 2, '2016-01-27 10:38:57', '2016-04-24 00:58:19', 0),
(443, 'ljZSD8DcTX', 'Art Ex1 Prepared Labels', 'null', 1, 1, 14, 119, 1, 0, '2016-01-27 10:38:57', '2016-06-22 16:56:13', 0),
(444, 'm0zCwEgoRv', 'LBF Introduction', 'null', 1, 4, 12, 115, 1, 0, '2016-01-27 10:38:57', '2016-06-21 22:04:12', 0),
(445, 'mMjfeXLXp5', 'Insects', 'Insects', 1, 1, 2, 45, 1, 8, '2016-01-27 10:38:57', '2016-06-13 09:59:22', 0),
(446, 'mR1QFsqWvR', 'Prs.1 Match C/D Grade Rest', 'null', 1, 2, 6, 241, 1, 0, '2016-01-27 10:38:57', '2016-04-24 00:51:29', 0),
(447, 'mkeKzYOEf3', 'Ex3 Fetching Open Ended', 'null', 1, 4, 3, 28, 1, 0, '2016-01-27 10:38:57', '2016-01-27 10:38:57', 0),
(448, 'mlI2rG5h4Z', 'Ex1 More than One Artist', 'null', 1, 1, 1, 142, 1, 6, '2016-01-27 10:38:57', '2016-04-24 01:16:13', 0),
(449, 'mv23LHK9Pu', 'LBF Subtraction w many zeroes', 'null', 1, 4, 12, 115, 1, 12, '2016-01-27 10:38:57', '2016-06-22 17:53:29', 0),
(450, 'myAStYX3vU', 'St.3 Definitions', 'null', 1, 1, 20, 49, 1, 7, '2016-01-27 10:38:58', '2016-04-24 01:25:33', 0),
(451, 'mybfRlgqgO', 'F G3 Match w/o Distance', 'null', 1, 2, 29, 244, 1, 3, '2016-01-27 10:38:58', '2016-06-22 15:18:02', 0),
(452, 'nEp5GVON6H', 'Prs2 Adding ''es''', 'null', 1, 1, 23, 149, 1, 0, '2016-01-27 10:38:58', '2016-01-27 10:38:58', 0),
(453, 'nEvPz9K3ic', 'CT3 G5 Environment Match', 'null', 1, 2, 22, 251, 1, 8, '2016-01-27 10:38:58', '2016-06-22 16:27:05', 0),
(454, 'nWQqZIOmpI', 'GeoC Presentation Part A', 'null', 1, 2, 22, 55, 1, 1, '2016-01-27 10:38:58', '2016-06-22 16:29:05', 0),
(455, 'nYFTy53lh3', 'Ex2 Show Rod/Find Card', 'null', 1, 4, 3, 254, 1, 1, '2016-01-27 10:38:58', '2016-04-24 01:43:26', 0),
(456, 'ngZiTVTpAC', 'Triangular Box', 'null', 1, 2, 22, 212, 1, 2, '2016-01-27 10:38:58', '2016-04-24 00:18:02', 0),
(457, 'njJRvXcwBp', 'Ex4 NR Addition', 'null', 1, 4, 3, 254, 1, 3, '2016-01-27 10:38:58', '2016-06-22 17:12:05', 0),
(458, 'nl13F6QnOt', 'St3 Group Design', 'null', 1, 1, 32, 213, 1, 0, '2016-01-27 10:38:58', '2016-01-27 10:38:58', 0),
(459, 'noQlwv1ucE', 'ThB Ex1 Grading', 'null', 1, 2, 27, 215, 1, 0, '2016-01-27 10:38:58', '2016-06-22 15:26:17', 0),
(460, 'o5iiFa56FM', 'BS Ex1 Unit of Measurement', 'null', 1, 2, 22, 15, 1, 0, '2016-01-27 10:38:58', '2016-06-22 14:44:16', 0),
(461, 'o9xpK7sGm4', 'Ex2 2 Colors/Different Shapes', 'null', 1, 2, 22, 38, 1, 0, '2016-01-27 10:38:58', '2016-01-27 10:38:58', 0),
(462, 'oBVlkaiaos', 'LBF Dynamic Subtraction', 'null', 1, 4, 12, 115, 1, 10, '2016-01-27 10:38:58', '2016-06-21 22:13:23', 0),
(463, 'oHI9E3sJvr', 'RR Ex4 Special Exercise', 'null', 1, 2, 22, 255, 1, 3, '2016-01-27 10:38:58', '2016-06-22 14:49:29', 0),
(464, 'oU9xggSo3z', 'CT3 G6 Environment Match-Variation', 'null', 1, 2, 22, 251, 1, 9, '2016-01-27 10:38:58', '2016-06-22 16:27:24', 0),
(465, 'oaer65MVkn', 'SG Dynamic 2-digit divisor', 'null', 1, 4, 8, 103, 1, 2, '2016-01-27 10:38:58', '2016-06-21 22:11:13', 0),
(466, 'oeQFEi3ffd', 'PT G3 Language-Comparative', 'null', 1, 2, 22, 243, 1, 5, '2016-01-27 10:38:58', '2016-06-22 14:40:36', 0),
(467, 'oefjVM0YXR', 'Objects w/Postive Qualities', 'null', 1, 2, 22, 99, 1, 1, '2016-01-27 10:38:58', '2016-04-24 00:12:54', 0),
(468, 'p2zDgVgSH4', 'Frog', 'null', 1, 1, 2, 168, 1, 4, '2016-01-27 10:38:58', '2016-04-24 01:33:07', 0),
(469, 'p7fNYTkrnf', 'SG Add Dynamic', 'null', 1, 4, 8, 96, 1, 0, '2016-01-27 10:38:58', '2016-06-21 21:58:18', 0),
(470, 'pKHfjjXq56', 'St2 Cards/Beads', 'null', 1, 4, 8, 18, 1, 1, '2016-01-27 10:38:58', '2016-04-24 01:44:40', 0),
(471, 'pY8fveTVua', 'G2 Last Sound', 'null', 1, 1, 32, 234, 1, 1, '2016-01-27 10:38:58', '2016-04-24 00:58:17', 0),
(472, 'plclbKgz6X', 'St. 2 Walking Heel to Toe', 'null', 1, 3, 28, 100, 1, 4, '2016-01-27 10:38:58', '2016-06-10 12:00:49', 0),
(473, 'pnzE0A3hGO', 'Small Group Story', 'null', 1, 4, 8, 225, 1, 0, '2016-01-27 10:38:58', '2016-04-24 02:03:48', 0),
(474, 'pzTxPaNh8W', 'Ex4 Taste w/wo noseplugs', 'null', 1, 2, 13, 174, 1, 3, '2016-01-27 10:38:58', '2016-04-24 00:44:35', 0),
(475, 'q3e6yR0019', 'Classified Pictures-Social', 'null', 1, 1, 1, 186, 1, 6, '2016-01-27 10:38:58', '2016-04-24 01:14:08', 0),
(476, 'qBrutZ62yS', 'Ex1 Use Base Cards', 'null', 1, 2, 24, 224, 1, 4, '2016-01-27 10:38:58', '2016-04-24 00:54:37', 0),
(477, 'qI9vk8BBze', 'Ex2 Remove Adjacent Colors', 'null', 1, 2, 22, 29, 1, 1, '2016-01-27 10:38:58', '2016-04-24 00:37:41', 0),
(478, 'qJsV1mz0fm', 'LBF Multiplication exercise', 'null', 1, 4, 12, 115, 1, 14, '2016-01-27 10:38:58', '2016-06-22 19:24:03', 0),
(479, 'qOMaRTVzEF', 'ThT G2 Environment Game', 'null', 1, 2, 27, 164, 1, 0, '2016-01-27 10:38:58', '2016-06-22 15:39:23', 0),
(481, 'qTVcQiDwO1', 'My State', 'null', 1, 1, 1, 142, 1, 11, '2016-01-27 10:38:58', '2016-04-24 01:16:36', 0),
(482, 'qV9a8pkJDF', 'Prs.1 Name Lesson', 'null', 1, 2, 24, 224, 1, 0, '2016-01-27 10:38:58', '2016-04-24 00:54:13', 0),
(483, 'qY9NNuQUGY', 'Prs.3 Grade by Comparison', 'null', 1, 2, 6, 241, 1, 2, '2016-01-27 10:38:58', '2016-04-24 00:51:32', 0),
(484, 'qeAOHTqtC0', 'CB G4 Distance Grading CE', 'null', 1, 2, 22, 108, 1, 12, '2016-01-27 10:38:58', '2016-06-22 15:09:33', 0),
(485, 'qf87h08wHG', 'St2 Banded/Lined Paper', 'null', 1, 1, 32, 46, 1, 7, '2016-01-27 10:38:58', '2016-04-24 01:21:02', 0),
(486, 'qgkZeReftM', 'Collecting Classified Objects', 'null', 1, 1, 1, 186, 1, 2, '2016-01-27 10:38:58', '2016-04-24 01:13:45', 0),
(487, 'qhShY9UwCz', 'Storytelling', 'null', 1, 1, 1, 142, 1, 0, '2016-01-27 10:38:58', '2016-04-24 01:15:30', 0),
(488, 'qj74VRgBYT', 'Aphonic Whisper', 'null', 1, 3, 28, 7, 1, 2, '2016-01-27 10:38:58', '2016-04-23 23:57:57', 0),
(489, 'qkzvTHVTNa', 'Prs.4 Listen for Lowest Bell', 'null', 1, 2, 6, 241, 1, 3, '2016-01-27 10:38:59', '2016-04-24 00:51:43', 0),
(490, 'qq63tuFuHb', 'Part A: random equations', 'null', 1, 4, 5, 181, 1, 0, '2016-01-27 10:38:59', '2016-06-13 10:06:38', 0),
(491, 'qvtSC9EjwL', 'Ex4a Build Bi Base 10', 'null', 1, 2, 22, 29, 1, 3, '2016-01-27 10:38:59', '2016-04-24 00:37:45', 0),
(492, 'qwFgUTMKcq', 'Prs.1 Bag 1 Pairing', 'null', 1, 2, 24, 209, 1, 0, '2016-01-27 10:38:59', '2016-04-24 00:55:13', 0),
(493, 'r3M52U5acW', 'Land and Water Forms Folders', 'null', 1, 1, 1, 142, 1, 8, '2016-01-27 10:38:59', '2016-04-24 01:16:22', 0),
(494, 'rnXCxuqVHF', 'Introduction to the pronoun', 'null', 1, 1, 2, 182, 1, 5, '2016-01-27 10:38:59', '2016-04-24 01:30:38', 0),
(495, 'rqQCKTfhFC', 'G2 Walking Around Room', 'null', 1, 2, 6, 113, 1, 5, '2016-01-27 10:38:59', '2016-06-10 12:47:30', 0),
(497, 's3LJFp9AXh', 'ThB G2 Distance Grading', 'null', 1, 2, 27, 215, 1, 2, '2016-01-27 10:38:59', '2016-06-22 15:27:20', 0),
(498, 'sK2BtSnCn7', 'Ex 2 Triangle Formation', 'null', 1, 2, 22, 108, 1, 1, '2016-01-27 10:38:59', '2016-04-24 00:08:37', 0),
(499, 'sTHi6LoaRD', 'St4 Beads/Cards Together', 'null', 1, 4, 8, 18, 1, 3, '2016-01-27 10:38:59', '2016-04-24 01:44:41', 0),
(500, 'sUgOLJmqRK', 'Ex1 Subs out of Add', 'null', 1, 4, 5, 32, 1, 0, '2016-01-27 10:38:59', '2016-01-27 10:38:59', 0),
(502, 'sZuHG4Iwb9', 'F G2 Distance Matching', 'null', 1, 2, 29, 244, 1, 2, '2016-01-27 10:38:59', '2016-06-22 15:18:57', 0),
(503, 'sc5xiu3JAj', 'SG 3-digit divisor w/zero in tens', 'null', 1, 4, 8, 103, 1, 4, '2016-01-27 10:38:59', '2016-06-22 17:16:20', 0),
(504, 'sdkNuBDZw7', 'BS G4 Language- Refinement', 'null', 1, 2, 22, 15, 1, 9, '2016-01-27 10:38:59', '2016-06-22 14:46:31', 0),
(505, 'sgdswUkCT0', 'Reptiles', 'null', 1, 1, 2, 45, 1, 6, '2016-01-27 10:38:59', '2016-06-13 09:58:40', 0),
(506, 'sy5jf6vMq4', 'Sand Tray', 'null', 1, 1, 32, 46, 1, 0, '2016-01-27 10:38:59', '2016-04-24 01:20:25', 0),
(507, 'tATBgZaE8b', 'Prs.3 Grade by Comparison', 'null', 1, 2, 6, 138, 1, 3, '2016-01-27 10:38:59', '2016-06-10 12:50:43', 0),
(508, 'tDKMusI935', 'Butterfly', 'null', 1, 1, 2, 168, 1, 5, '2016-01-27 10:38:59', '2016-04-24 01:33:08', 0),
(509, 'tQaXJecxH0', 'Art Folders', 'null', 1, 1, 1, 142, 1, 5, '2016-01-27 10:38:59', '2016-04-24 01:16:06', 0),
(510, 'tQdf0dctkF', 'Invertebrates', 'null', 1, 1, 2, 48, 1, 11, '2016-01-27 10:38:59', '2016-06-10 13:10:39', 0),
(511, 'tRPcWhLrNp', 'Ex3 P/P Child Dictates', 'null', 1, 1, 20, 139, 1, 2, '2016-01-27 10:38:59', '2016-04-24 01:24:02', 0),
(512, 'teutjhV7Rc', 'Color Pencils', 'null', 1, 3, 10, 267, 1, 1, '2016-01-27 10:38:59', '2016-06-10 12:03:50', 0),
(513, 'tkeAxmb5Kd', 'Prs2 Positive(more/most)', 'null', 1, 1, 23, 133, 1, 1, '2016-01-27 10:38:59', '2016-06-22 19:15:45', 0),
(514, 'tlM9NuNLdS', 'Scavengers', 'null', 1, 1, 2, 48, 1, 19, '2016-01-27 10:38:59', '2016-06-10 13:10:51', 0),
(515, 'to4EDml439', 'BS Ex2 Remove and Show', 'null', 1, 2, 22, 15, 1, 1, '2016-01-27 10:38:59', '2016-06-22 14:44:38', 0),
(516, 'tq4f9Hcr0y', 'Ex4 Elimination of Duplicates', 'null', 1, 4, 5, 140, 1, 3, '2016-01-27 10:38:59', '2016-04-24 02:11:37', 0),
(517, 'tvUrxWKga1', 'Ex1 Random Equations', 'null', 1, 4, 5, 140, 1, 0, '2016-01-27 10:38:59', '2016-04-24 02:11:34', 0),
(518, 'txvVeMLli0', 'Ex2 Words in Books', 'null', 1, 1, 14, 36, 1, 1, '2016-01-27 10:38:59', '2016-02-17 04:23:02', 0),
(519, 'ty1YvLYkkT', 'St1 Continent', 'null', 1, 1, 32, 239, 1, 0, '2016-01-27 10:38:59', '2016-01-27 10:38:59', 0),
(520, 'u6U2nrq2b4', 'G8 What''s the Next Note', 'null', 1, 2, 6, 31, 1, 7, '2016-01-27 10:38:59', '2016-04-24 00:52:51', 0),
(521, 'u89UJxga4G', 'Prs2 TC w/one Object', 'null', 1, 1, 14, 11, 1, 1, '2016-01-27 10:39:00', '2016-04-24 01:29:37', 0),
(522, 'uDWAba2g1x', 'BotCards G2 Distance Matching 3 Hidden', 'null', 1, 2, 22, 189, 1, 5, '2016-01-27 10:39:00', '2016-06-22 16:44:35', 0),
(523, 'uLNqIDojpG', 'PR.2-Posing Silently', 'PR.2-Posing Silently', 1, 3, 28, 7, 1, 1, '2016-01-27 10:39:00', '2016-06-13 09:08:49', 0),
(524, 'ukTdjXN3HK', 'Prs.2 Match C Grade Rest', 'null', 1, 2, 6, 241, 1, 1, '2016-01-27 10:39:00', '2016-04-24 00:51:29', 0),
(525, 'ummq66VfTJ', 'Ver 1 Combinations of ten', 'null', 1, 4, 5, 162, 1, 2, '2016-01-27 10:39:00', '2016-04-24 02:11:14', 0),
(526, 'uvdPj4ngH5', 'Large Hexagonal Box', 'null', 1, 2, 22, 212, 1, 4, '2016-01-27 10:39:00', '2016-04-24 00:18:02', 0),
(527, 'vLKwYZOZdd', 'G7 Singing a Verse', 'null', 1, 2, 6, 31, 1, 6, '2016-01-27 10:39:00', '2016-04-24 00:52:51', 0),
(528, 'vUvYfsfDSR', 'St. 4 Rhythmic Walking', 'null', 1, 3, 28, 100, 1, 15, '2016-01-27 10:39:00', '2016-06-13 09:06:29', 0),
(529, 'vjQqDPHsBM', 'Ex5 Action w or w/o Objects', 'null', 1, 1, 14, 240, 1, 4, '2016-01-27 10:39:00', '2016-04-24 01:29:14', 0),
(530, 'vlhqAlTkbv', 'GeoC G1 Distance Matching', 'null', 1, 2, 22, 55, 1, 5, '2016-01-27 10:39:00', '2016-06-22 16:30:40', 0),
(531, 'vo2ZjX470n', 'RR G2 Distance Grading- Scattered', 'null', 1, 2, 22, 255, 1, 5, '2016-01-27 10:39:00', '2016-06-22 14:50:03', 0),
(532, 'vvtrtP4iTf', 'CT3 G4 Language Refinement', 'null', 1, 2, 22, 251, 1, 7, '2016-01-27 10:39:00', '2016-06-22 16:26:50', 0),
(533, 'vz8D9DEcCb', 'WP Read Prepared Cards', 'null', 1, 4, 8, 225, 1, 1, '2016-01-27 10:39:00', '2016-06-22 17:18:22', 0),
(534, 'wGFuokezFP', 'St2 11-99 (w cards)', 'null', 1, 4, 15, 109, 1, 1, '2016-01-27 10:39:00', '2016-06-22 14:37:22', 0),
(535, 'wHOP4ZhEXR', 'St3 Waves Almost Touching', 'null', 1, 1, 32, 94, 1, 2, '2016-01-27 10:39:00', '2016-06-13 09:49:39', 0),
(536, 'wHSTGeZpGz', 'ThB G3 Dist Language Comparative', 'null', 1, 2, 27, 215, 1, 3, '2016-01-27 10:39:00', '2016-06-22 15:27:44', 0),
(537, 'wQqP9R2SuL', '2 sub/2 pred/ 2 direct obj', 'null', 1, 1, 2, 182, 1, 4, '2016-01-27 10:39:00', '2016-04-24 01:30:55', 0),
(538, 'wVKE1FXZbH', 'G2 Sing Next Bell', 'null', 1, 2, 6, 138, 1, 9, '2016-01-27 10:39:00', '2016-06-10 12:51:37', 0),
(539, 'wcnzBIcVOh', 'Sorting Exercise', 'null', 1, 1, 1, 186, 1, 9, '2016-01-27 10:39:00', '2016-06-13 09:45:53', 0),
(540, 'wfbKZ8v3GW', 'CT2 G3 Environment Matching', 'null', 1, 2, 22, 12, 1, 2, '2016-01-27 10:39:00', '2016-06-22 16:23:41', 0),
(541, 'wjcLQmaaWF', 'Ex3 Combinations of 10', 'null', 1, 4, 5, 140, 1, 2, '2016-01-27 10:39:00', '2016-04-24 02:11:37', 0),
(542, 'wq56qFCZAG', 'BotC G1 Distance Matching', 'null', 1, 2, 22, 269, 1, 4, '2016-01-27 10:39:00', '2016-06-22 16:41:33', 0),
(544, 'x5OLPDylAL', 'G1 Singing Up & Down', 'null', 1, 2, 6, 31, 1, 0, '2016-01-27 10:39:00', '2016-04-24 00:52:24', 0),
(545, 'x65A2PICyt', 'Life Cycles', 'null', 1, 1, 1, 142, 1, 13, '2016-01-27 10:39:00', '2016-04-24 01:16:42', 0),
(546, 'xBapLrlGku', 'St1 Unlined', 'null', 1, 1, 32, 46, 1, 2, '2016-01-27 10:39:00', '2016-04-24 01:20:31', 0),
(547, 'xEUON0jU4q', 'Ex4 Double Function of Words', 'null', 1, 1, 14, 240, 1, 3, '2016-01-27 10:39:00', '2016-04-24 01:29:14', 0),
(548, 'xIFbTcMyiJ', 'Sun Prints', 'null', 1, 3, 10, 120, 1, 3, '2016-01-27 10:39:00', '2016-04-23 23:58:27', 0),
(549, 'xJCTRTnNth', 'G10 Singing on Pitch', 'null', 1, 2, 6, 31, 1, 9, '2016-01-27 10:39:00', '2016-04-24 00:52:48', 0),
(550, 'xWPXy4wr9c', 'Ex2 More than One Period', 'null', 1, 1, 1, 142, 1, 7, '2016-01-27 10:39:00', '2016-04-24 01:16:15', 0),
(551, 'xaOByOAMfv', 'BS G3 Language-Comparative', 'null', 1, 2, 22, 15, 1, 5, '2016-01-27 10:39:00', '2016-06-22 14:46:08', 0),
(553, 'y50EqKF1Bl', 'LBF Notation two: w zeroes', 'null', 1, 4, 12, 115, 1, 2, '2016-01-27 10:39:00', '2016-06-22 17:51:00', 0),
(554, 'yDWKQT21rX', 'St10 Ink Fountain Pen', 'null', 1, 1, 32, 46, 1, 15, '2016-01-27 10:39:00', '2016-04-24 01:21:19', 0),
(555, 'ySMTWdLG3h', 'SG Sub Static', 'null', 1, 4, 8, 203, 1, 0, '2016-01-27 10:39:00', '2016-06-21 21:43:44', 0),
(556, 'yTStPJ2hQA', 'RR G3 Stereognostic Game', 'null', 1, 2, 22, 255, 1, 6, '2016-01-27 10:39:00', '2016-06-22 14:50:25', 0),
(557, 'yiy3WLYCqa', 'Bi Ex1 Build Outside Box', 'null', 1, 2, 22, 268, 1, 2, '2016-01-27 10:39:00', '2016-06-22 16:46:38', 0),
(558, 'ykqIoUlKOT', 'BS G1 Distance Grading', 'null', 1, 2, 22, 15, 1, 3, '2016-01-27 10:39:01', '2016-06-22 14:45:33', 0),
(559, 'ymXEi4wK5I', 'Fruits', 'null', 1, 1, 2, 48, 1, 9, '2016-01-27 10:39:01', '2016-06-10 13:10:38', 0),
(560, 'yrCZtulae5', 'Prs 3-Turning on Line', 'null', 1, 3, 28, 100, 1, 2, '2016-01-27 10:39:01', '2016-04-23 23:56:09', 0),
(561, 'yvmzr7n0YS', 'G4 Play All Bells First', 'null', 1, 2, 6, 113, 1, 7, '2016-01-27 10:39:01', '2016-06-10 12:47:30', 0),
(562, 'yzJjmZ0dF5', 'TT Ex1 Grading', 'null', 1, 2, 29, 118, 1, 0, '2016-01-27 10:39:01', '2016-06-22 15:12:50', 0),
(563, 'zFdkO2DimE', 'Objects w/Comp Qualities', 'null', 1, 2, 22, 99, 1, 2, '2016-01-27 10:39:01', '2016-04-24 00:12:55', 0),
(564, 'zMv9hlZctW', 'Human', 'null', 1, 1, 2, 168, 1, 0, '2016-01-27 10:39:01', '2016-04-24 01:32:51', 0),
(565, 'zTNfJwhvls', 'Ex1 Remove One Color', 'null', 1, 2, 22, 29, 1, 0, '2016-01-27 10:39:01', '2016-04-24 00:37:39', 0),
(566, 'zWRBE3Vycj', 'Conj Ex1 Prepared Labels/Farm', 'null', 1, 1, 14, 216, 1, 0, '2016-01-27 10:39:01', '2016-06-22 16:55:56', 0),
(567, 'zdCbRVPa0k', 'Nomenclature Cards- Scientific', 'null', 1, 1, 1, 186, 1, 7, '2016-01-27 10:39:01', '2016-04-24 01:14:14', 0),
(568, 'ziCLKSo1LE', 'Ex2 Random,then build', 'null', 1, 2, 30, 112, 1, 1, '2016-01-27 10:39:01', '2016-04-24 00:55:50', 0),
(569, '0690mIhSzq', 'Lid to express formula', 'null', 1, 10, 61, 460, 1, 13, '2016-01-27 10:40:45', '2016-06-13 07:37:20', 0),
(570, '0HFfab0VOb', 'HCF using Table C', 'null', 1, 10, 49, 666, 1, 3, '2016-01-27 10:40:45', '2016-04-23 22:35:00', 0),
(571, 'MpXQ9xoZZG', 'Prs.1 Match C/C# Grade Rest', 'null', 1, 2, 6, 138, 1, 1, '2016-01-27 10:15:18', '2016-06-13 09:37:54', 0),
(573, 'Mw2JYFIpnq', 'Prs1 Two Commands', 'null', 1, 1, 14, 423, 1, 0, '2016-01-27 10:15:18', '2016-01-27 10:15:18', 0),
(574, '1D9Tnz9UK3', 'article and noun', 'null', 1, 7, 63, 572, 1, 0, '2016-01-27 10:40:45', '2016-04-23 23:30:12', 0),
(575, '1H9MuriOHu', 'CM: 3rd Ex; Part B 3 digit x 3 digit', 'null', 1, 10, 49, 394, 1, 6, '2016-01-27 10:40:45', '2016-04-23 22:32:45', 0),
(577, '1QmwlR3kmY', 'Writing Squares and Cubes on Paper', 'null', 1, 10, 61, 432, 1, 2, '2016-01-27 10:40:45', '2016-04-23 22:38:37', 0),
(580, '26fmcpBws1', 'Build binomial by Layers', 'null', 1, 10, 61, 460, 1, 1, '2016-01-27 10:40:45', '2016-06-13 07:37:19', 0),
(582, '2CX9NbG93a', 'Converting DF to CF', 'null', 1, 10, 58, 652, 1, 2, '2016-01-27 10:40:45', '2016-04-23 22:46:29', 0),
(583, 'O6XeqzeBCF', 'Dynamic with a Remainder', 'Dynamic with a Remainder', 1, 4, 8, 487, 1, 2, '2016-01-27 10:15:18', '2016-06-13 10:04:00', 0),
(584, '2TmUAPCDwC', 'LCM b', 'null', 1, 10, 49, 440, 1, 6, '2016-01-27 10:40:45', '2016-04-23 22:34:26', 0),
(587, '2juTeIAPPl', '1.find V', 'null', 1, 10, 110, 659, 1, 2, '2016-01-27 10:40:45', '2016-04-23 22:51:38', 0),
(588, 'OfLXKqyF2P', 'Ex1 Single Category', 'null', 1, 4, 8, 659, 1, 0, '2016-01-27 10:15:18', '2016-01-27 10:15:18', 0),
(589, '3DqFYEUxVx', 'BG2: 3-digit multiplier', 'null', 1, 10, 49, 282, 1, 0, '2016-01-27 10:40:45', '2016-01-27 10:40:45', 0),
(592, '41lXxHHax1', 'EN: Div >1', 'null', 1, 10, 90, 381, 1, 6, '2016-01-27 10:40:45', '2016-04-23 22:49:35', 0),
(593, '4EFEID1Ryd', 'Cb Rt 3 Digit', 'null', 1, 10, 61, 618, 1, 6, '2016-01-27 10:40:45', '2016-04-23 22:44:43', 0),
(595, '4cPHZCICLm', 'GFM: variation', 'null', 1, 10, 49, 586, 1, 0, '2016-01-27 10:40:45', '2016-01-27 10:40:45', 0),
(596, '4cUb0zmkBm', 'GD: 1 digit divisor', 'null', 1, 10, 117, 604, 1, 0, '2016-01-27 10:40:45', '2016-04-23 22:36:24', 0),
(597, '4hzI1Iew1g', 'DC: DF x DF', 'null', 1, 10, 58, 667, 1, 2, '2016-01-27 10:40:45', '2016-04-23 22:47:32', 0),
(599, '5AV7Y7PJHi', 'Notation of a cube 1', 'null', 1, 10, 61, 292, 1, 2, '2016-01-27 10:40:45', '2016-04-23 22:38:14', 0),
(600, '5tMEnVXnGJ', 'Power of 10', 'null', 1, 10, 90, 364, 1, 7, '2016-01-27 10:40:45', '2016-06-13 07:11:21', 0),
(601, '5v67vI1mNq', '2nd DF x DF partial products', 'null', 1, 10, 58, 327, 1, 0, '2016-01-27 10:40:45', '2016-01-27 10:40:45', 0),
(603, '61vHun2lMd', 'FBF: Abstract Multiplication', 'null', 1, 10, 49, 346, 1, 3, '2016-01-27 10:40:46', '2016-04-23 22:27:59', 0),
(604, '62UE1vK4Xk', 'Powers of 5', 'null', 1, 10, 90, 364, 1, 4, '2016-01-27 10:40:46', '2016-06-13 07:11:20', 0),
(605, '62gI5QxAwC', 'DF S Mult', 'null', 1, 10, 58, 455, 1, 2, '2016-01-27 10:40:46', '2016-04-23 22:45:54', 0),
(608, '7zNjYqGTMS', 'Div 4', 'null', 1, 10, 117, 679, 1, 4, '2016-01-27 10:40:46', '2016-04-23 22:37:14', 0),
(609, '8GRrP4bkFY', 'Squaring a binomial w peg board', 'null', 1, 10, 61, 354, 1, 1, '2016-01-27 10:40:46', '2016-04-23 22:41:39', 0),
(611, '8NmukGrtqq', 'Synonyms', 'null', 1, 7, 63, 597, 1, 5, '2016-01-27 10:40:46', '2016-04-23 23:05:00', 0),
(614, '90A4EBDOUg', 'CM: 1st Ex 2 digit x 2 digit', 'null', 1, 10, 49, 394, 1, 0, '2016-01-27 10:40:46', '2016-04-23 22:32:32', 0),
(616, '9Hc9lHLVON', 'RS: Mult 3: DF > 1 x DF > 1', 'null', 1, 10, 58, 681, 1, 2, '2016-01-27 10:40:46', '2016-04-23 22:48:08', 0),
(617, '9LLRElIbCd', 'SN:Mult Rule', 'null', 1, 10, 46, 308, 1, 0, '2016-01-27 10:40:46', '2016-01-27 10:40:46', 0),
(620, '9hOYSBeBsM', 'EN: Addition and Subtraction', 'null', 1, 10, 90, 381, 1, 1, '2016-01-27 10:40:46', '2016-04-23 22:49:21', 0),
(623, 'ABa3CrCUtX', 'ONB: Sub', 'null', 1, 10, 67, 549, 1, 1, '2016-01-27 10:40:46', '2016-04-23 22:55:22', 0),
(624, 'AC2m8sWIEh', 'R Arithmetic', 'null', 1, 10, 110, 478, 1, 0, '2016-01-27 10:40:46', '2016-01-27 10:40:46', 0),
(625, 'ADgLT95v7i', 'Verb and Nominal Predicates', 'null', 1, 7, 36, 650, 1, 0, '2016-01-27 10:40:46', '2016-04-23 23:32:40', 0),
(626, 'SoS8aPIcvO', 'Printmaking', 'null', 1, 3, 10, 532, 1, 0, '2016-01-27 10:15:20', '2016-01-27 10:15:20', 0),
(628, 'AOJFUGlfPT', 'Intro Prime Factors', 'null', 1, 10, 49, 666, 1, 0, '2016-01-27 10:40:47', '2016-04-23 22:34:52', 0),
(629, 'AYW9uIzJPB', 'comparison of adjectives', 'null', 1, 7, 63, 658, 1, 2, '2016-01-27 10:40:47', '2016-04-23 23:31:45', 0),
(631, 'AkX79xaNUt', 'Suffixes', 'null', 1, 7, 63, 597, 1, 1, '2016-01-27 10:40:47', '2016-04-23 23:04:52', 0),
(632, 'Al2cRRJpNo', 'LCM a', 'null', 1, 10, 49, 440, 1, 5, '2016-01-27 10:40:47', '2016-04-23 22:34:26', 0),
(634, 'B3cGKqFEbV', 'Unit can be any size', 'null', 1, 10, 90, 364, 1, 5, '2016-01-27 10:40:47', '2016-06-13 07:11:20', 0),
(637, 'BZGzO6yRV0', 'EN: Div:CF', 'null', 1, 10, 90, 381, 1, 5, '2016-01-27 10:40:47', '2016-04-23 22:49:35', 0),
(638, 'BaNobHOTxg', 'Order of Sentences', 'null', 1, 7, 36, 650, 1, 2, '2016-01-27 10:40:47', '2016-04-23 23:33:06', 0),
(640, 'CCqJBZDToM', 'Table B', 'null', 1, 10, 49, 440, 1, 3, '2016-01-27 10:40:47', '2016-04-23 22:34:24', 0),
(641, 'Cu2aHOyUXr', 'Algebraic- Binomial', 'null', 1, 10, 61, 529, 1, 3, '2016-01-27 10:40:47', '2016-04-23 22:40:55', 0),
(643, 'D1IPGn7WPT', 'Div by a Power of 10', 'null', 1, 10, 58, 380, 1, 1, '2016-01-27 10:40:47', '2016-04-23 22:46:54', 0),
(645, 'V2KjNiPlHk', 'Unmarked Staff Board', 'null', 1, 1, 11, 560, 1, 0, '2016-01-27 10:15:21', '2016-01-27 10:15:21', 0),
(646, 'DHFt95GSGD', 'Consolidation and Intro of Common Mulitiples', 'null', 1, 10, 49, 440, 1, 0, '2016-01-27 10:40:47', '2016-04-23 22:34:11', 0),
(647, 'DLvJSWZWPK', 'Backtracking', 'null', 1, 10, 61, 618, 1, 5, '2016-01-27 10:40:47', '2016-04-23 22:44:36', 0),
(648, 'DP3XbyYqtX', 'R Formula', 'null', 1, 10, 110, 478, 1, 0, '2016-01-27 10:40:47', '2016-01-27 10:40:47', 0),
(649, 'DUvtT7ht0N', 'DF Formation of > 10', 'null', 1, 10, 58, 420, 1, 4, '2016-01-27 10:40:47', '2016-04-23 22:45:22', 0),
(650, 'DaksDwPPPs', 'RT: Calculating and Recording', 'null', 1, 10, 117, 511, 1, 3, '2016-01-27 10:40:47', '2016-04-23 22:35:49', 0),
(651, 'Dn6mfmAHh6', 'CB: Using Bead Bards', 'null', 1, 10, 49, 555, 1, 1, '2016-01-27 10:40:47', '2016-04-23 22:31:57', 0),
(652, 'Dp7vc0xk2C', '10 algebraically- binomial', 'null', 1, 10, 61, 275, 1, 4, '2016-01-27 10:40:47', '2016-04-23 22:40:06', 0),
(653, 'E7aMg6jacN', 'I Formula', 'null', 1, 10, 110, 518, 1, 2, '2016-01-27 10:40:47', '2016-04-23 22:52:54', 0),
(655, 'ER4c10T46k', 'GD fractions', 'null', 1, 10, 117, 604, 1, 3, '2016-01-27 10:40:47', '2016-04-23 22:36:24', 0),
(656, 'EkVPtygffv', 'Cb Rt Abstraction', 'null', 1, 10, 61, 618, 1, 7, '2016-01-27 10:40:47', '2016-04-23 22:44:44', 0),
(657, 'Etp7s4jv21', 'Divisibility Chart', 'null', 1, 10, 117, 679, 1, 3, '2016-01-27 10:40:47', '2016-04-23 22:37:07', 0),
(658, 'WZxFSskVO1', 'Ex1 Pairing Sachets', 'null', 1, 2, 13, 586, 2, 0, '2016-01-27 10:15:22', '2016-06-13 07:24:44', 0),
(660, 'FOnSJmQzsc', 'DF S Add', 'null', 1, 10, 58, 455, 1, 0, '2016-01-27 10:40:47', '2016-04-23 22:45:52', 0),
(661, 'FhwCFX6Dl7', 'CM: 3rd Ex; Part B 2 digit x 2 digit', 'null', 1, 10, 49, 394, 1, 5, '2016-01-27 10:40:47', '2016-04-23 22:32:45', 0),
(662, 'FpeL61mOIC', 'Active and Passive Voice', 'null', 1, 7, 36, 650, 1, 3, '2016-01-27 10:40:47', '2016-04-23 23:33:10', 0),
(664, 'G0J2wpgvUd', 'Compound Words', 'null', 1, 7, 63, 597, 1, 3, '2016-01-27 10:40:48', '2016-04-23 23:04:59', 0),
(665, 'G1baPYF6Wy', 'Table A', 'null', 1, 10, 49, 440, 1, 2, '2016-01-27 10:40:48', '2016-04-23 22:34:22', 0),
(666, 'G6wvxnvjRJ', 'All Successive Squares', 'null', 1, 10, 61, 529, 1, 1, '2016-01-27 10:40:48', '2016-04-23 22:40:44', 0),
(667, 'G9EhYMfcdG', 'proportion: cross multiplication', 'null', 1, 10, 53, 462, 1, 0, '2016-01-27 10:40:48', '2016-04-23 22:54:59', 0),
(672, 'Ghya2dlbhY', 'concrete and abstract', 'null', 1, 7, 63, 572, 1, 7, '2016-01-27 10:40:48', '2016-04-23 23:30:42', 0),
(673, 'GkNAwCwkJO', 'Intro to Distributive', 'null', 1, 10, 49, 627, 1, 1, '2016-01-27 10:40:48', '2016-04-23 22:33:22', 0),
(674, 'YVt1pTGRwM', 'Ex3 Grinding Spices', 'null', 1, 2, 13, 586, 2, 0, '2016-01-27 10:15:22', '2016-06-13 07:24:44', 0),
(675, 'GtySfvb0jY', 'P Arithmetic', 'null', 1, 10, 110, 635, 1, 1, '2016-01-27 10:40:48', '2016-04-23 22:53:53', 0),
(676, 'H22fB9Giyj', 'Indirect Object Clause', 'null', 1, 7, 36, 552, 1, 3, '2016-01-27 10:40:48', '2016-04-23 23:33:42', 0),
(677, 'H2SmL8booj', '1.find T', 'null', 1, 10, 110, 659, 1, 1, '2016-01-27 10:40:48', '2016-04-23 22:51:38', 0),
(678, 'HHjiuMpsoX', '2. find D', 'null', 1, 10, 110, 610, 1, 0, '2016-01-27 10:40:48', '2016-04-23 22:51:59', 0),
(679, 'HQL3RpqGbf', 'Div 7', 'null', 1, 10, 117, 679, 1, 10, '2016-01-27 10:40:48', '2016-04-23 22:37:32', 0),
(680, 'I499KZx9xy', '2. find V', 'null', 1, 10, 110, 610, 1, 1, '2016-01-27 10:40:48', '2016-04-23 22:51:59', 0),
(681, 'IGfq36VFq6', 'RT: Final Answer: 3 digit', 'null', 1, 10, 117, 511, 1, 1, '2016-01-27 10:40:48', '2016-04-23 22:35:40', 0),
(682, 'IHzFv5lR1i', 'T Sensorial', 'null', 1, 10, 110, 482, 1, 0, '2016-01-27 10:40:48', '2016-01-27 10:40:48', 0),
(683, 'ILEh78OXOl', 'Algebraic Cubing of a Trinomial', 'null', 1, 10, 61, 521, 1, 0, '2016-01-27 10:40:48', '2016-01-27 10:40:48', 0),
(684, 'ILXtmZbEof', 'Div 6', 'null', 1, 10, 117, 679, 1, 9, '2016-01-27 10:40:48', '2016-04-23 22:37:31', 0),
(685, 'Ibc7Zr1FNG', 'Powers of 3', 'null', 1, 10, 90, 364, 1, 3, '2016-01-27 10:40:48', '2016-06-13 07:11:20', 0),
(687, 'IjjstYAQuj', 'CM: 3rd Ex: Part A ', 'null', 1, 10, 49, 394, 1, 4, '2016-01-27 10:40:49', '2016-04-23 22:32:43', 0),
(688, 'Ip879j6TL8', 'Powers of 2: value', 'null', 1, 10, 90, 364, 1, 1, '2016-01-27 10:40:49', '2016-04-23 22:48:34', 0),
(689, 'aHmbc5QYKL', 'Multiplication', 'null', 1, 4, 12, 527, 1, 0, '2016-01-27 10:15:23', '2016-01-27 10:15:23', 0),
(690, 'J9I5lxIIbM', 'Distributive Law in Decimal System A', 'null', 1, 10, 49, 627, 1, 5, '2016-01-27 10:40:49', '2016-04-23 22:33:40', 0),
(693, 'K0999Kzwpu', 'FBF: 3 digit multiplier', 'null', 1, 10, 49, 346, 1, 1, '2016-01-27 10:40:49', '2016-04-23 22:27:59', 0),
(694, 'K0xsKhP7DO', 'LCM Abstraction', 'null', 1, 10, 49, 666, 1, 4, '2016-01-27 10:40:49', '2016-04-23 22:35:13', 0),
(695, 'K6bMuIozAk', 'CM: 2nd Ex 3 digit x 3 digit', 'null', 1, 10, 49, 394, 1, 3, '2016-01-27 10:40:49', '2016-04-23 22:32:39', 0),
(697, 'KhEQH7k921', 'Finding Prime Numbers', 'null', 1, 10, 49, 666, 1, 1, '2016-01-27 10:40:49', '2016-04-23 22:35:00', 0),
(700, 'L8fkZJBcKJ', 'I Sensorial', 'null', 1, 10, 110, 518, 1, 0, '2016-01-27 10:40:49', '2016-04-23 22:52:52', 0),
(701, 'LA3LK86lXm', 'Distributive Law in Decimal System B', 'null', 1, 10, 49, 627, 1, 6, '2016-01-27 10:40:49', '2016-04-23 22:33:41', 0),
(702, 'LAJGvUrvQv', 'BG1: 3-digit multiplier', 'null', 1, 10, 49, 458, 1, 0, '2016-01-27 10:40:49', '2016-01-27 10:40:49', 0),
(704, 'LUmARuWXXe', 'Decanomial on paper', 'null', 1, 10, 61, 293, 1, 1, '2016-01-27 10:40:49', '2016-04-23 22:39:13', 0),
(708, 'M5zqMS3Mpi', 'RT: 2nd Stage', 'null', 1, 10, 117, 511, 1, 4, '2016-01-27 10:40:49', '2016-04-23 22:35:50', 0),
(709, 'MMv7hF6B3E', 'masculine and feminine', 'null', 1, 7, 63, 572, 1, 4, '2016-01-27 10:40:49', '2016-04-23 23:30:26', 0),
(711, 'MkO4FK946m', 'CB: Introduction', 'null', 1, 10, 49, 555, 1, 0, '2016-01-27 10:40:49', '2016-04-23 22:31:56', 0),
(712, 'MvCMWFAuA7', 'Follow-ups', 'null', 1, 5, 48, 295, 1, 0, '2016-01-27 10:40:49', '2016-01-27 10:40:49', 0),
(715, 'NF6w6sN8zU', '3. find T', 'null', 1, 10, 110, 470, 1, 0, '2016-01-27 10:40:50', '2016-01-27 10:40:50', 0),
(717, 'NGkKRqJcyw', 'Powers of 2: notation', 'null', 1, 10, 90, 364, 1, 0, '2016-01-27 10:40:50', '2016-04-23 22:48:32', 0),
(719, 'NJjxk5iIFp', '10 into binomial', 'null', 1, 10, 61, 275, 1, 0, '2016-01-27 10:40:50', '2016-04-23 22:39:51', 0),
(720, 'NLgd3xuaDK', 'Compound and Complex Sentences', 'null', 1, 7, 36, 552, 1, 5, '2016-01-27 10:40:50', '2016-04-23 23:33:33', 0),
(721, 'NQTXk2oXfn', 'perfect tenses', 'null', 1, 7, 97, 287, 1, 2, '2016-01-27 10:40:50', '2016-04-23 23:26:52', 0),
(722, 'NSmKK9EqEP', 'Notation of a square 2', 'null', 1, 10, 61, 292, 1, 1, '2016-01-27 10:40:50', '2016-04-23 22:38:14', 0),
(724, 'NbH3ySENJE', 'Rounding Numbers', 'null', 1, 10, 58, 652, 1, 1, '2016-01-27 10:40:50', '2016-04-23 22:46:29', 0),
(725, 'NcXAP7i4eJ', 'Div 8', 'null', 1, 10, 117, 679, 1, 5, '2016-01-27 10:40:50', '2016-04-23 22:37:16', 0),
(727, 'O09aEbb9tr', 'DF Formation of #s', 'null', 1, 10, 58, 420, 1, 3, '2016-01-27 10:40:50', '2016-04-23 22:45:22', 0),
(728, 'O2AFsu8UNP', 'Cb Rt 2 Digit B', 'null', 1, 10, 61, 618, 1, 4, '2016-01-27 10:40:50', '2016-04-23 22:44:29', 0),
(729, 'O3J8BaJxaT', 'EN: Mult on paper', 'null', 1, 10, 90, 381, 1, 3, '2016-01-27 10:40:50', '2016-04-23 22:49:28', 0),
(730, 'eRQtrbIVlV', 'Origami', 'null', 1, 3, 10, 532, 1, 0, '2016-01-27 10:15:25', '2016-01-27 10:15:25', 0),
(731, 'OM0IL7PTeI', '10 algebraically- trinomial', 'null', 1, 10, 61, 275, 1, 5, '2016-01-27 10:40:50', '2016-04-23 22:40:07', 0),
(733, 'OO8ym6N1Bs', 'Sq Rt remainder', 'null', 1, 10, 61, 427, 1, 3, '2016-01-27 10:40:50', '2016-04-23 22:43:14', 0),
(734, 'PFcLOCAmFB', 'classification of nouns', 'null', 1, 7, 63, 572, 1, 9, '2016-01-27 10:40:50', '2016-04-23 23:30:40', 0),
(736, 'PVcACk6fIY', 'Squaring Decanomial Algebraically', 'null', 1, 10, 61, 293, 1, 2, '2016-01-27 10:40:50', '2016-04-23 22:39:16', 0),
(738, 'PtWpAlB0RW', 'Golden Bead Material', 'null', 1, 10, 61, 354, 1, 0, '2016-01-27 10:40:50', '2016-04-23 22:41:29', 0),
(739, 'Q99CD118Kr', 'FBF: 2 digit multiplier', 'null', 1, 10, 49, 346, 1, 0, '2016-01-27 10:40:50', '2016-04-23 22:27:57', 0),
(740, 'QDxHKKgCDu', 'Extraction Rules for squaring', 'null', 1, 10, 61, 354, 1, 5, '2016-01-27 10:40:50', '2016-04-23 22:42:01', 0),
(742, 'QnLPp9wp8V', 'DF S Div', 'null', 1, 10, 58, 455, 1, 3, '2016-01-27 10:40:50', '2016-04-23 22:45:52', 0),
(743, 'QyRAT817ox', 'DC: Parital Product', 'null', 1, 10, 58, 667, 1, 4, '2016-01-27 10:40:50', '2016-04-23 22:47:39', 0),
(744, 'R3fyCEJyVT', 'EPN: Add', 'null', 1, 10, 90, 522, 1, 0, '2016-01-27 10:40:50', '2016-04-23 22:50:06', 0),
(745, 'RNf2BXsApD', 'Sq Rt Cat by Cat peg board', 'null', 1, 10, 61, 427, 1, 2, '2016-01-27 10:40:50', '2016-04-23 22:43:14', 0),
(747, 'RWsU2Ykqyn', 'Word Families', 'null', 1, 7, 63, 597, 1, 4, '2016-01-27 10:40:50', '2016-04-23 23:05:00', 0),
(748, 'Rd2e5YWZi8', 'ONB: Mult', 'null', 1, 10, 67, 549, 1, 2, '2016-01-27 10:40:50', '2016-04-23 22:55:24', 0),
(749, 'Rdb6ltztjT', 'Distributive Law in Decimal System D', 'null', 1, 10, 49, 627, 1, 8, '2016-01-27 10:40:51', '2016-04-23 22:33:34', 0),
(751, 'T1hJYwW08G', '4 Operation w Squares and Cubes', 'null', 1, 10, 61, 293, 1, 4, '2016-01-27 10:40:51', '2016-04-23 22:39:11', 0),
(752, 'TH5t1OpeEX', 'Sum by Sum', 'null', 1, 10, 49, 627, 1, 2, '2016-01-27 10:40:51', '2016-04-23 22:33:32', 0),
(754, 'TIR8M5Rw1S', 'SN:Div Rule', 'null', 1, 10, 46, 320, 1, 0, '2016-01-27 10:40:51', '2016-01-27 10:40:51', 0),
(755, 'TJcz0MXWLj', 'Square on paper', 'null', 1, 10, 61, 275, 1, 2, '2016-01-27 10:40:51', '2016-04-23 22:39:58', 0),
(757, 'ToHjSxxef8', 'DC: WN x WN', 'null', 1, 10, 58, 667, 1, 3, '2016-01-27 10:40:51', '2016-04-23 22:47:39', 0),
(759, 'UBzVtCT2aF', 'Abstraction Part A', 'null', 1, 10, 49, 627, 1, 3, '2016-01-27 10:40:51', '2016-04-23 22:33:34', 0),
(760, 'UGAdsDPIUY', 'I Arithmetic', 'null', 1, 10, 110, 518, 1, 1, '2016-01-27 10:40:51', '2016-04-23 22:52:54', 0),
(762, 'V2ipRIzjMm', 'Mult by a Power of 10', 'null', 1, 10, 58, 380, 1, 0, '2016-01-27 10:40:51', '2016-04-23 22:46:54', 0),
(763, 'V54bI4m0P0', 'common and proper', 'null', 1, 7, 63, 572, 1, 6, '2016-01-27 10:40:51', '2016-04-23 23:30:40', 0),
(764, 'VGcJOg8RtY', 'EPN: Mult', 'null', 1, 10, 90, 522, 1, 2, '2016-01-27 10:40:51', '2016-04-23 22:50:07', 0),
(765, 'VN5gAdl8Pd', 'simple tenses', 'null', 1, 7, 97, 287, 1, 0, '2016-01-27 10:40:51', '2016-04-23 23:26:52', 0),
(767, 'ViYfSXtCo1', 'Quadronomial on graph paper', 'null', 1, 10, 61, 354, 1, 4, '2016-01-27 10:40:51', '2016-04-23 22:41:55', 0),
(769, 'WGwgUHv7Ul', 'CB: Using Facts', 'null', 1, 10, 49, 555, 1, 2, '2016-01-27 10:40:51', '2016-04-23 22:31:57', 0),
(770, 'WU4KUm0i0b', 'DC: Shows its Value', 'null', 1, 10, 58, 423, 1, 0, '2016-01-27 10:40:51', '2016-01-27 10:40:51', 0),
(772, 'WbS3m0vd3L', 'RS Mult 1: DF x WN', 'null', 1, 10, 58, 681, 1, 1, '2016-01-27 10:40:51', '2016-04-23 22:48:08', 0),
(774, 'WtRNtqZopm', 'EN: Mult w materia', 'null', 1, 10, 90, 381, 1, 2, '2016-01-27 10:40:51', '2016-04-23 22:49:21', 0),
(775, 'X26jNwM5qG', 'T Arithmetic', 'null', 1, 10, 110, 482, 1, 1, '2016-01-27 10:40:51', '2016-06-13 07:18:02', 0),
(776, 'X9CkFkfVgN', 'RS Div 1', 'null', 1, 10, 58, 341, 1, 0, '2016-01-27 10:40:51', '2016-01-27 10:40:51', 0),
(777, 'XC0sOlPqua', 'BG2: 2-digit multiplier', 'null', 1, 10, 49, 282, 1, 0, '2016-01-27 10:40:51', '2016-01-27 10:40:51', 0),
(778, 'XHlpUVyWTV', 'EPN: Sub', 'null', 1, 10, 90, 522, 1, 1, '2016-01-27 10:40:51', '2016-04-23 22:50:06', 0),
(781, 'Y6uf0I27zt', 'auxiliary tenses', 'null', 1, 7, 97, 287, 1, 1, '2016-01-27 10:40:52', '2016-04-23 23:26:52', 0),
(783, 'YrkPt9Dw1N', 'SN:Add: Checking results', 'null', 1, 10, 46, 461, 1, 1, '2016-01-27 10:40:52', '2016-04-23 22:50:55', 0),
(784, 'YyUfNWvqQy', 'Prime Factors', 'null', 1, 10, 117, 679, 1, 8, '2016-01-27 10:40:52', '2016-04-23 22:37:19', 0),
(785, 'Z977YuTsHJ', 'Decanomial Basic Layout', 'null', 1, 10, 61, 293, 1, 0, '2016-01-27 10:40:52', '2016-04-23 22:39:11', 0),
(787, 'ZKM8AMCbdT', 'T Formula', 'null', 1, 10, 110, 482, 1, 2, '2016-01-27 10:40:52', '2016-06-13 07:18:02', 0),
(788, 'ZSvZt0SUJq', '1 Successive Square', 'null', 1, 10, 61, 529, 1, 0, '2016-01-27 10:40:52', '2016-04-23 22:40:44', 0),
(789, 'ZYOTsT5Nkj', 'Paper Decanomial', 'null', 1, 10, 61, 293, 1, 3, '2016-01-27 10:40:52', '2016-04-23 22:39:16', 0),
(791, 'Zes7xYOLxx', 'Abstraction Part B', 'null', 1, 10, 49, 627, 1, 4, '2016-01-27 10:40:52', '2016-04-23 22:33:34', 0),
(792, 'Zn0oaI8Bf4', 'LBF: Composition of large numbers', 'null', 1, 10, 49, 331, 1, 1, '2016-01-27 10:40:52', '2016-06-22 19:40:15', 0),
(793, 'ZrqvtOuBoK', 'DF/DF repeating number', 'null', 1, 10, 58, 433, 1, 0, '2016-01-27 10:40:52', '2016-01-27 10:40:52', 0),
(794, 'ZvLKJO4IK3', 'P Sensorial', 'null', 1, 10, 110, 635, 1, 0, '2016-01-27 10:40:52', '2016-04-23 22:53:53', 0),
(795, 'acc1Dz9lh2', 'classification of adjectives', 'null', 1, 7, 63, 658, 1, 1, '2016-01-27 10:40:52', '2016-04-23 23:31:45', 0),
(796, 'apd81Q85PB', 'Notation of a square 1', 'null', 1, 10, 61, 292, 1, 0, '2016-01-27 10:40:52', '2016-04-23 22:38:14', 0),
(798, 'b6QHX6E5ZE', 'Algebraic Cubing of a Quadranomial', 'null', 1, 10, 61, 521, 1, 0, '2016-01-27 10:40:52', '2016-01-27 10:40:52', 0),
(799, 'bKEOTpX324', 'Sq Rt More than 1 digit', 'null', 1, 10, 61, 427, 1, 1, '2016-01-27 10:40:52', '2016-04-23 22:43:41', 0),
(800, 'bS81IO1vRE', 'EN: Addition', 'null', 1, 10, 90, 381, 1, 0, '2016-01-27 10:40:52', '2016-04-23 22:49:19', 0),
(801, 'bomDxFJ62T', 'Prefixes', 'null', 1, 7, 63, 597, 1, 2, '2016-01-27 10:40:52', '2016-04-23 23:04:52', 0),
(802, 'bq6FYz8I6L', 'Intro HCF', 'null', 1, 10, 49, 666, 1, 2, '2016-01-27 10:40:52', '2016-04-23 22:35:00', 0),
(803, 'c4x5YbXUnm', 'Powers of 2: writing factors', 'null', 1, 10, 90, 364, 1, 2, '2016-01-27 10:40:52', '2016-04-23 22:48:34', 0),
(804, 'cRSKp9Z6KZ', '2. find T', 'null', 1, 10, 110, 610, 1, 2, '2016-01-27 10:40:52', '2016-04-23 22:51:59', 0),
(805, 'cnOQ2qALwp', 'grammar box for adjective', 'null', 1, 7, 63, 658, 1, 0, '2016-01-27 10:40:52', '2016-04-23 23:31:45', 0),
(807, 'cwrNGKjWSP', 'ONB: Div', 'null', 1, 10, 67, 549, 1, 3, '2016-01-27 10:40:52', '2016-04-23 22:55:24', 0),
(808, 'd0i9hDNdaO', 'P Formula', 'null', 1, 10, 110, 635, 1, 2, '2016-01-27 10:40:52', '2016-04-23 22:53:53', 0),
(811, 'dISoDZeF2n', 'GD: 2+ digit divisors', 'null', 1, 10, 117, 604, 1, 1, '2016-01-27 10:40:52', '2016-04-23 22:36:24', 0),
(812, 'dL3Mu5E30B', 'FBF: Record Final Products', 'null', 1, 10, 49, 346, 1, 2, '2016-01-27 10:40:52', '2016-04-23 22:27:59', 0),
(813, 'dLANwYBDm7', 'EN: Div', 'null', 1, 10, 90, 381, 1, 4, '2016-01-27 10:40:52', '2016-04-23 22:49:28', 0),
(814, 'dNlUFTbcqj', 'CM: 2nd Ex 2 digit x 2 digit', 'null', 1, 10, 49, 394, 1, 2, '2016-01-27 10:40:52', '2016-04-23 22:32:35', 0),
(817, 'dsC2KILEYl', 'Laying the 9 Tables', 'null', 1, 10, 61, 432, 1, 1, '2016-01-27 10:40:53', '2016-04-23 22:38:37', 0),
(818, 'dxd4csq2Ba', 'Cubing a trinomial with a numeric value', 'null', 1, 10, 61, 521, 1, 0, '2016-01-27 10:40:53', '2016-01-27 10:40:53', 0),
(819, 'oHI9E3sJvr', 'Ex4 Special Exercise', 'null', 1, 2, 22, 667, 1, 0, '2016-01-27 10:15:29', '2016-01-27 10:15:29', 0),
(822, 'egy5iiuRbw', 'DF both sides of the unit', 'null', 1, 10, 58, 420, 1, 0, '2016-01-27 10:40:53', '2016-04-23 22:45:15', 0),
(823, 'eyUTCOe1XI', 'BG1: 2-digit multiplier', 'null', 1, 10, 49, 458, 1, 0, '2016-01-27 10:40:53', '2016-01-27 10:40:53', 0),
(825, 'fCrI3O4F54', 'LBF: Long Multiplication: answer only', 'null', 1, 10, 49, 331, 1, 4, '2016-01-27 10:40:53', '2016-04-23 22:26:56', 0),
(826, 'ficc26pqwy', '3. find D', 'null', 1, 10, 110, 470, 1, 0, '2016-01-27 10:40:53', '2016-01-27 10:40:53', 0),
(827, 'gmi9JQYJ2F', 'Table C', 'null', 1, 10, 49, 440, 1, 4, '2016-01-27 10:40:53', '2016-04-23 22:34:24', 0),
(828, 'gnw0NntyWn', 'Converting CF to DF: no material', 'null', 1, 10, 58, 652, 1, 0, '2016-01-27 10:40:53', '2016-04-23 22:46:29', 0),
(830, 'hiXCIX6ZnY', 'Div 11', 'null', 1, 10, 117, 679, 1, 11, '2016-01-27 10:40:53', '2016-04-23 22:37:32', 0),
(832, 'hwlvqsbKR1', 'material and collective', 'null', 1, 7, 63, 572, 1, 8, '2016-01-27 10:40:53', '2016-04-23 23:30:42', 0),
(834, 'icTRMfbwMZ', 'Introduction to Affixes', 'null', 1, 7, 63, 597, 1, 0, '2016-01-27 10:40:53', '2016-04-23 23:04:49', 0),
(835, 'iiUD5D2Rxl', 'LBF: Writing', 'null', 1, 10, 49, 331, 1, 2, '2016-01-27 10:40:53', '2016-04-23 22:26:46', 0),
(836, 'ipzjaZL4Lz', 'Sq Rt Concept and Notation', 'null', 1, 10, 61, 427, 1, 0, '2016-01-27 10:40:53', '2016-04-23 22:43:05', 0),
(839, 'jNArACJy6H', 'RS Mult 2: DF x DF', 'null', 1, 10, 58, 681, 1, 0, '2016-01-27 10:40:53', '2016-04-23 22:48:08', 0),
(840, 'jWM4n9xr5n', 'Direct Object Clause', 'null', 1, 7, 36, 552, 1, 2, '2016-01-27 10:40:53', '2016-04-23 23:33:35', 0),
(841, 'jfuUDJRD2l', 'Rule for Extraction of Cb Rt', 'null', 1, 10, 61, 618, 1, 8, '2016-01-27 10:40:53', '2016-04-23 22:44:44', 0),
(843, 'jqVRhQqN26', 'N N3 Chart', 'null', 1, 10, 61, 618, 1, 2, '2016-01-27 10:40:53', '2016-04-23 22:44:23', 0),
(845, 'kGPV67wUTO', '10 into trinomial', 'null', 1, 10, 61, 275, 1, 1, '2016-01-27 10:40:53', '2016-04-23 22:39:51', 0),
(847, 'kRG0iT2rFB', 'Square on graph paper', 'null', 1, 10, 61, 275, 1, 3, '2016-01-27 10:40:54', '2016-04-23 22:39:58', 0),
(848, 'knB37ur4cK', 'DC:DF X WN', 'null', 1, 10, 58, 667, 1, 0, '2016-01-27 10:40:54', '2016-04-23 22:47:32', 0),
(849, 'kyvsVyYb2M', 'Div 25', 'null', 1, 10, 117, 679, 1, 2, '2016-01-27 10:40:54', '2016-04-23 22:37:01', 0),
(850, 'l4xOmrIVuF', 'Algebraic- Trinomial', 'null', 1, 10, 61, 529, 1, 5, '2016-01-27 10:40:54', '2016-04-23 22:40:57', 0),
(852, 'lm90NotWd0', 'Distributive Law in Decimal System C', 'null', 1, 10, 49, 627, 1, 7, '2016-01-27 10:40:54', '2016-04-23 22:33:41', 0),
(854, 'ltZpui6WH4', 'definite and indefinite article', 'null', 1, 7, 63, 572, 1, 1, '2016-01-27 10:40:54', '2016-04-23 23:30:12', 0),
(855, 'mH62uDO7Ix', 'LBF: Writing Complex Numbers', 'null', 1, 10, 49, 331, 1, 3, '2016-01-27 10:40:54', '2016-04-23 22:26:55', 0),
(859, 'nqh4oHKFZW', 'Algebraic Exp w Cubing Material', 'null', 1, 10, 61, 460, 1, 12, '2016-01-27 10:40:54', '2016-06-13 07:37:20', 0),
(860, 'oDSSSGeiqq', 'Square of a Sum-binomial', 'null', 1, 10, 61, 529, 1, 4, '2016-01-27 10:40:54', '2016-04-23 22:40:57', 0),
(861, 'oEWhJ23L7i', 'Square of a Sum', 'null', 1, 10, 61, 275, 1, 6, '2016-01-27 10:40:54', '2016-04-23 22:40:07', 0),
(862, 'oVVbZMyvcU', 'Transitive and Intransitive', 'null', 1, 7, 36, 650, 1, 4, '2016-01-27 10:40:54', '2016-04-23 23:33:10', 0),
(863, 'oeMIVIwZt0', 'Hierarchical Square', 'null', 1, 10, 61, 354, 1, 2, '2016-01-27 10:40:54', '2016-04-23 22:41:39', 0),
(864, 'pcY79Cn8pv', 'SN:Add: negative 10 bar', 'null', 1, 10, 46, 461, 1, 0, '2016-01-27 10:40:54', '2016-04-23 22:50:55', 0),
(865, 'pmt3ozqbpQ', 'SN:Add: Rule', 'null', 1, 10, 46, 461, 1, 2, '2016-01-27 10:40:54', '2016-04-23 22:50:55', 0),
(866, 'q0OYYb0YER', 'Multiples Forms', 'null', 1, 10, 49, 440, 1, 1, '2016-01-27 10:40:54', '2016-04-23 22:34:18', 0),
(867, 'qVHQ5jYU64', 'Div 5', 'null', 1, 10, 117, 679, 1, 1, '2016-01-27 10:40:54', '2016-04-23 22:36:59', 0),
(868, 'qgUjvmhxVz', 'Elliptical Sentences', 'null', 1, 7, 36, 650, 1, 1, '2016-01-27 10:40:54', '2016-04-23 23:32:53', 0),
(870, 'rGllJax6R0', 'Powers Pattern', 'null', 1, 10, 90, 364, 1, 6, '2016-01-27 10:40:54', '2016-06-13 07:11:21', 0),
(871, 'reJ77BlEet', 'Cb Rt 2 Digit A', 'null', 1, 10, 61, 618, 1, 3, '2016-01-27 10:40:54', '2016-04-23 22:44:27', 0),
(872, 'rt8asLNAZv', 'number in noun (singular and plural)', 'null', 1, 7, 63, 572, 1, 2, '2016-01-27 10:40:54', '2016-04-23 23:30:18', 0),
(873, 's1Xlwl7KCA', 'LBF: Writing Partial Products', 'null', 1, 10, 49, 331, 1, 5, '2016-01-27 10:40:54', '2016-04-23 22:26:44', 0),
(874, 's6uwgQvAH8', 'Trinomial Verbalization', 'null', 1, 10, 61, 354, 1, 6, '2016-01-27 10:40:54', '2016-04-23 22:42:01', 0),
(875, 's9b5ssEIRz', 'DF S Sub', 'null', 1, 10, 58, 455, 1, 1, '2016-01-27 10:40:54', '2016-04-23 22:45:53', 0),
(877, 'u89UJxga4G', 'Prs2 TC w/one Object', 'null', 1, 1, 14, 423, 1, 0, '2016-01-27 10:15:32', '2016-01-27 10:15:32', 0),
(878, 'sjUezX8fyb', 'Non-successive squares', 'null', 1, 10, 61, 529, 1, 2, '2016-01-27 10:40:54', '2016-04-23 22:40:46', 0),
(879, 'skOZiHbfRH', 'R Sensorial', 'null', 1, 10, 110, 478, 1, 0, '2016-01-27 10:40:54', '2016-01-27 10:40:54', 0),
(881, 'ummq66VfTJ', 'Ver 1 Combinations of ten', 'null', 1, 4, 5, 574, 1, 0, '2016-01-27 10:15:32', '2016-01-27 10:15:32', 0),
(884, 'uCdTRKEWT3', '3. find V', 'null', 1, 10, 110, 470, 1, 0, '2016-01-27 10:40:55', '2016-01-27 10:40:55', 0),
(885, 'uTiwPyLFmR', 'SN: Sub: Rule', 'null', 1, 10, 46, 301, 1, 0, '2016-01-27 10:40:55', '2016-01-27 10:40:55', 0),
(886, 'uTznQseSHA', 'CM: 1st Ex 3 digit x 3 digit', 'null', 1, 10, 49, 394, 1, 1, '2016-01-27 10:40:55', '2016-04-23 22:32:35', 0),
(887, 'udvc6uCom0', 'Reflexive Quality', 'null', 1, 7, 36, 650, 1, 5, '2016-01-27 10:40:55', '2016-04-23 23:33:06', 0),
(889, 'uo87bQAEZd', 'Start w cube of 1st Term', 'null', 1, 10, 61, 460, 1, 11, '2016-01-27 10:40:56', '2016-06-13 07:37:20', 0),
(890, 'uyS0Z89TqN', 'proportion: finding unknowns', 'null', 1, 10, 53, 462, 1, 1, '2016-01-27 10:40:56', '2016-04-23 22:54:59', 0),
(891, 'vCg2eEIru7', 'Subject Clause', 'null', 1, 7, 36, 552, 1, 4, '2016-01-27 10:40:56', '2016-04-23 23:33:42', 0),
(892, 'vae8KGuWrj', 'ONB: Add', 'null', 1, 10, 67, 549, 1, 0, '2016-01-27 10:40:56', '2016-04-23 22:55:20', 0),
(894, 'vnsdp1xf3l', 'common gender', 'null', 1, 7, 63, 572, 1, 5, '2016-01-27 10:40:56', '2016-04-23 23:30:32', 0),
(895, 'vqHctfX9qc', 'RT: 3rd Stage', 'null', 1, 10, 117, 511, 1, 5, '2016-01-27 10:40:56', '2016-04-23 22:35:50', 0),
(897, 'w42J2h9TVw', 'Notation of a cube 2', 'null', 1, 10, 61, 292, 1, 3, '2016-01-27 10:40:56', '2016-04-23 22:38:14', 0),
(898, 'wC5gtRtKdQ', 'Adjectival Clauses', 'null', 1, 7, 36, 552, 1, 0, '2016-01-27 10:40:56', '2016-04-23 23:34:10', 0),
(899, 'x2kOhASpOM', 'Div Dynamic', 'null', 1, 4, 8, 487, 1, 1, '2016-01-27 10:15:33', '2016-06-21 22:06:57', 0),
(900, 'wf3lPT5AYw', 'Pyramid and Tower', 'null', 1, 10, 61, 432, 1, 0, '2016-01-27 10:40:56', '2016-04-23 22:38:37', 0),
(901, 'wjj64rcWFr', 'EPN: Div', 'null', 1, 10, 90, 522, 1, 3, '2016-01-27 10:40:56', '2016-04-23 22:50:08', 0),
(902, 'wk8Fb2PZ3T', 'RT: Intermediate Remainders', 'null', 1, 10, 117, 511, 1, 2, '2016-01-27 10:40:56', '2016-04-23 22:35:47', 0),
(903, 'wqBoQvZiYs', 'Squaring a trinomial w Peg board', 'null', 1, 10, 61, 354, 1, 3, '2016-01-27 10:40:56', '2016-04-23 22:41:46', 0),
(904, 'wupGWhtNpt', 'DF Decimal Board', 'null', 1, 10, 58, 420, 1, 2, '2016-01-27 10:40:56', '2016-04-23 22:45:17', 0),
(905, 'wwcr5QdtVa', 'Cb Rt 1 Digit', 'null', 1, 10, 61, 618, 1, 1, '2016-01-27 10:40:56', '2016-04-23 22:44:16', 0),
(906, 'xBGwppRIEB', 'Div 2', 'null', 1, 10, 117, 679, 1, 0, '2016-01-27 10:40:56', '2016-04-23 22:36:58', 0),
(907, 'xFdRz2ylKS', 'DF Quantity and Symbol', 'null', 1, 10, 58, 420, 1, 1, '2016-01-27 10:40:56', '2016-04-23 22:45:17', 0),
(908, 'xGWUZUa1dh', 'GD on paper', 'null', 1, 10, 117, 604, 1, 2, '2016-01-27 10:40:56', '2016-04-23 22:36:24', 0),
(909, 'y50EqKF1Bl', 'Notation two: w zeroes', 'null', 1, 4, 12, 527, 1, 0, '2016-01-27 10:15:33', '2016-01-27 10:15:33', 0),
(910, 'xn7P1WzjyP', 'RS Div 2', 'null', 1, 10, 58, 341, 1, 0, '2016-01-27 10:40:56', '2016-01-27 10:40:56', 0),
(911, 'xpMWMM509x', 'RT: Final Answer: 2 digit', 'null', 1, 10, 117, 511, 1, 0, '2016-01-27 10:40:56', '2016-04-23 22:35:38', 0),
(912, 'xpZMJriun0', 'Cb Rt Concept and Notation', 'null', 1, 10, 61, 618, 1, 0, '2016-01-27 10:40:56', '2016-04-23 22:44:10', 0),
(915, 'ypnOQ0NZ6S', 'Div 9', 'null', 1, 10, 117, 679, 1, 7, '2016-01-27 10:40:56', '2016-04-23 22:37:19', 0),
(916, 'yreo2GT9IU', 'Intro to Commutative', 'null', 1, 10, 49, 627, 1, 0, '2016-01-27 10:40:57', '2016-04-23 22:33:20', 0),
(917, 'yxrCXQCgKX', '1.find D', 'null', 1, 10, 110, 659, 1, 0, '2016-01-27 10:40:57', '2016-04-23 22:51:38', 0),
(919, 'zGjZtCdEYG', 'LBF: Counting', 'null', 1, 10, 49, 331, 1, 0, '2016-01-27 10:40:57', '2016-04-23 22:26:44', 0),
(920, 'zPz2oTXmXE', 'Adverbial Clauses', 'null', 1, 7, 36, 552, 1, 1, '2016-01-27 10:40:57', '2016-04-23 23:33:35', 0),
(921, 'zhavyDjMKm', 'Div 3', 'null', 1, 10, 117, 679, 1, 6, '2016-01-27 10:40:57', '2016-04-23 22:37:18', 0),
(922, 'zktoHNkXqe', 'DC: WN X DF', 'null', 1, 10, 58, 667, 1, 1, '2016-01-27 10:40:57', '2016-04-23 22:47:32', 0),
(923, 'zrJjBkJf6d', 'gender', 'null', 1, 7, 63, 572, 1, 3, '2016-01-27 10:40:57', '2016-04-23 23:30:25', 0),
(924, 'zw9foxFWCf', 'LM on paper', 'null', 1, 10, 49, 666, 1, 5, '2016-01-27 10:40:57', '2016-04-23 22:35:13', 0),
(926, 'J6Ppz2LUmV', 'SCy Ex1 Grading', '', 1, 2, 18, 63, 1, 0, '2016-04-24 00:49:43', '2016-06-22 16:18:47', 0),
(927, 'M7bt6VyTc7', 'SCy G1 Distance Matching', '', 1, 2, 18, 63, 1, 0, '2016-04-24 00:50:18', '2016-06-22 16:19:13', 0),
(928, 'qKRaROzmrp', 'SCy G2 Distance Grading', '', 1, 2, 18, 63, 1, 0, '2016-04-24 00:50:48', '2016-06-22 16:19:31', 0),
(947, 'ZS0iT5bJn9', 'Follow-ups to the Story', 'Follow-ups to the Story', 1, 8, 96, 706, 1, 0, '2016-06-03 04:49:53', '2016-06-13 03:39:14', 0),
(948, 'mPxeL1CJ0b', 'Demonstrations', 'Demonstrations', 1, 8, 96, 706, 1, 1, '2016-06-03 04:50:36', '2016-06-13 03:39:14', 0),
(949, 'wSttF4Y5rk', 'Plates', 'Plates', 1, 8, 96, 711, 1, 0, '2016-06-03 04:51:55', '2016-06-03 04:51:55', 0),
(950, '06XmzBNwTh', 'Mountain Formation', 'Mountain Formation', 1, 8, 96, 711, 1, 1, '2016-06-03 04:52:04', '2016-06-03 05:46:27', 0),
(951, 'cw4SWE7tgU', 'Volcano Mountains', 'volcano mountains', 1, 8, 96, 711, 1, 2, '2016-06-03 04:52:14', '2016-06-22 21:24:12', 0),
(952, 'ujOfmxto55', 'Fold Mountains', 'fold mountains', 1, 8, 96, 711, 1, 3, '2016-06-03 04:52:23', '2016-06-22 21:24:45', 0),
(953, 'bwLvUBuG8Y', 'Kinds of Faults', 'kinds of faults', 1, 8, 96, 711, 1, 4, '2016-06-03 04:52:39', '2016-06-22 21:25:11', 0),
(954, 'xK0Jal89DO', 'Block Mountains/Rift Valleys', 'block mountains/rift valleys', 1, 8, 96, 711, 1, 5, '2016-06-03 04:52:53', '2016-06-22 21:25:51', 0),
(955, 'GdUfGJapIR', 'Force Affects', 'Force Affects', 1, 8, 60, 712, 1, 1, '2016-06-03 04:53:47', '2016-06-03 05:46:42', 0),
(956, 'LEcQqKx3oL', 'Different Shapes', 'Different Shapes', 1, 8, 60, 712, 1, 0, '2016-06-03 04:53:59', '2016-06-03 04:53:59', 0),
(957, '0PgJpUdriM', 'Air Occupies Space', 'Air Occupies Space', 1, 8, 107, 749, 1, 0, '2016-06-03 05:01:29', '2016-06-03 05:46:56', 0),
(958, 'O6y88cT9nI', 'Hot Air Rises', 'Hot Air Rises', 1, 8, 107, 749, 1, 1, '2016-06-03 05:02:10', '2016-06-03 05:46:56', 0),
(959, 'c7Jl5vkUJr', 'Names of Winds', 'Names of Winds', 1, 8, 107, 750, 1, 0, '2016-06-03 05:06:00', '2016-06-03 05:06:00', 0),
(960, '9TaG6zrP7m', 'Steady and Variable Winds', 'Steady and Variable Winds', 1, 8, 107, 750, 1, 1, '2016-06-03 05:06:10', '2016-06-03 05:47:18', 0),
(961, 'fvG0BYbyKN', 'Easterlies and Westerlies', 'Easterlies and Westerlies', 1, 8, 107, 750, 1, 2, '2016-06-03 05:06:18', '2016-06-03 05:47:18', 0),
(962, 'zJQOkySU5J', 'Doldrums and Horse Latitudes', 'Doldrums and Horse Latitudes', 1, 8, 107, 750, 1, 3, '2016-06-03 05:06:34', '2016-06-03 05:47:18', 0),
(963, '7YbGpV45aN', 'Land and Sea Breezes', 'Land and Sea Breezes', 1, 8, 107, 750, 1, 4, '2016-06-03 05:06:46', '2016-06-03 05:47:18', 0),
(964, 'JIV0P9wF8Z', 'Winds Caused by Seasons', 'Winds Caused by Seasons', 1, 8, 107, 750, 1, 5, '2016-06-03 05:06:56', '2016-06-03 05:47:18', 0),
(965, 'Mt5B2NxOPD', 'Steady and Variable Winds', 'Steady and Variable Winds', 1, 8, 107, 750, 1, 6, '2016-06-03 05:07:09', '2016-06-03 05:47:18', 0);
INSERT INTO `exercises` (`id`, `object_id`, `title`, `description`, `user_id`, `area_id`, `chapter_id`, `lesson_id`, `status`, `order_no`, `created`, `modified`, `timestamp`) VALUES
(966, 'jY31uGUp5R', 'Rains', 'Rains', 1, 8, 107, 750, 1, 7, '2016-06-03 05:07:26', '2016-06-03 05:47:18', 0),
(967, 'pIuLbQjfPt', 'Work Chart of the Winds', 'Work Chart of the Winds', 1, 8, 107, 750, 1, 8, '2016-06-03 05:07:34', '2016-06-03 05:47:18', 0),
(968, 'GMjPXMx54U', 'Ocean Currents', 'Ocean Currents', 1, 8, 107, 750, 1, 9, '2016-06-03 05:07:45', '2016-06-03 05:47:19', 0),
(969, 'nG09UcZUtv', 'Wind as a Sculptor', 'Wind as a Sculptor', 1, 8, 107, 750, 1, 10, '2016-06-03 05:07:53', '2016-06-03 05:47:19', 0),
(970, 'JZUIPGZ4aI', 'Highlands and Lowlands', 'Highlands and Lowlands', 1, 8, 85, 751, 1, 0, '2016-06-03 05:09:26', '2016-06-03 05:09:26', 0),
(971, 'gSewmnzCRn', 'Flow of the River', 'Flow of the River', 1, 8, 85, 751, 1, 1, '2016-06-03 05:09:35', '2016-06-03 05:47:38', 0),
(972, 'AhKkXjoE6x', 'Other Sources for Rivers', 'Other Sources for Rivers', 1, 8, 85, 751, 1, 2, '2016-06-03 05:09:48', '2016-06-03 05:47:38', 0),
(973, '4GMAnNblZK', 'Town and Cites Around Rivers', 'Town and Cites Around Rivers', 1, 8, 85, 751, 1, 3, '2016-06-03 05:10:03', '2016-06-03 05:47:38', 0),
(974, 'XADabO1zgm', 'V-shaped Valleys', 'V-shaped Valleys', 1, 8, 85, 751, 1, 4, '2016-06-03 05:10:18', '2016-06-03 05:47:39', 0),
(975, 'k5nkJpeafq', 'Canyons', 'Canyons', 1, 8, 85, 751, 1, 5, '2016-06-03 05:10:30', '2016-06-03 05:47:39', 0),
(976, '0PBReosf7z', 'Three Zones: People', 'Three Zones: People', 1, 8, 85, 757, 1, 0, '2016-06-03 05:11:14', '2016-06-03 05:11:14', 0),
(977, 'o6WcwCHfZl', 'Where do we get our food? ', 'Where do we get our food? ', 1, 8, 84, 758, 1, 0, '2016-06-03 05:12:53', '2016-06-03 05:12:53', 0),
(978, 'iKyrhq1SMp', 'Who depends on the farmer?', 'Who depends on the farmer?', 1, 8, 84, 758, 1, 1, '2016-06-03 05:13:50', '2016-06-03 05:48:33', 0),
(979, 'ZO0Gz1KLTX', 'Who does the farmer need?', 'Who does the farmer need?', 1, 8, 84, 758, 1, 2, '2016-06-03 05:14:03', '2016-06-03 05:48:33', 0),
(980, 'A8DtW5zFbL', 'How do people need each other?', 'How do people need each other?', 1, 8, 84, 758, 1, 3, '2016-06-03 05:14:17', '2016-06-03 05:48:33', 0),
(981, 'qMEkc9Xwkp', 'Taxes', 'Taxes', 1, 8, 84, 758, 1, 4, '2016-06-03 05:14:27', '2016-06-13 03:49:23', 0),
(982, 'nuaPYzMIVd', 'What happens to taxes?', 'What happens to taxes?', 1, 8, 84, 758, 1, 5, '2016-06-03 05:14:40', '2016-06-13 03:49:23', 0),
(983, 'qFxr8GBHEe', 'what is produced and where?', 'what is produced and where?', 1, 8, 84, 759, 1, 0, '2016-06-03 05:20:16', '2016-06-03 05:20:16', 0),
(984, 'gqCKshaoYM', 'what else do we produce?', 'what else do we produce?', 1, 8, 84, 759, 1, 1, '2016-06-03 05:20:24', '2016-06-03 05:48:55', 0),
(985, 'lHIpV19vSC', 'how much do we produce?', 'how much do we produce?', 1, 8, 84, 759, 1, 2, '2016-06-03 05:20:43', '2016-06-03 05:48:56', 0),
(986, 'wbXtXaAHsK', 'Parts of a mountain', 'Parts of a mountain', 1, 8, 84, 764, 1, 0, '2016-06-03 05:25:16', '2016-06-03 05:25:16', 0),
(987, 'gDBT6geXFs', 'Mountain formation', 'Mountain formation', 1, 8, 84, 764, 1, 1, '2016-06-03 05:25:26', '2016-06-03 05:49:33', 0),
(988, 'uJGyJUfoyB', 'Plate tectonics', 'Plate tectonics', 1, 8, 84, 764, 1, 2, '2016-06-03 05:25:43', '2016-06-03 05:49:33', 0),
(989, 'PtZ7l8Z2Pm', 'Use of fractions', 'Use of fractions', 1, 6, 37, 768, 1, 0, '2016-06-03 06:33:23', '2016-06-03 07:10:49', 0),
(990, 'kFQyr1RyDR', 'Equivalence with non-geometric shapes', 'Equivalence with non-geometric shapes', 1, 6, 37, 768, 1, 1, '2016-06-03 06:33:40', '2016-06-03 07:10:49', 0),
(991, 'k46k0pFtXA', 'Triangular box', 'Triangular box', 1, 6, 37, 768, 1, 2, '2016-06-03 06:34:33', '2016-06-03 07:09:35', 0),
(992, 'oBVnfq3XTV', 'Small hexagonal box', 'Small hexagonal box', 1, 6, 37, 768, 1, 3, '2016-06-03 06:34:45', '2016-06-03 07:09:35', 0),
(993, 'dK2VJiIOQQ', 'Equivalence between the green equilateral and the red isosceles triangle', 'Equivalence between the green equilateral and the red isosceles triangle', 1, 6, 37, 768, 1, 4, '2016-06-03 06:34:58', '2016-06-03 07:09:35', 0),
(994, 'iYEDJlG3Dq', 'Combining boxes', 'Combining boxes', 1, 6, 37, 768, 1, 6, '2016-06-03 06:35:17', '2016-06-03 07:09:36', 0),
(995, '8d7AuWBl9v', 'Small hexagonal box and the triangular box', 'Small hexagonal box and the triangular box', 1, 6, 37, 768, 1, 7, '2016-06-03 06:35:32', '2016-06-03 07:09:36', 0),
(996, 'OCPsHqZS6O', 'Box of 12 blue scalene', 'Box of 12 blue scalene', 1, 6, 37, 768, 1, 8, '2016-06-03 06:35:49', '2016-06-03 07:09:36', 0),
(997, 'Z9x4ilt7Im', 'Large hexagonal box', 'Large hexagonal box', 1, 6, 37, 768, 1, 5, '2016-06-03 06:36:24', '2016-06-03 07:09:35', 0),
(998, '8wGu8HNw2S', 'Complete or whole angle', 'Complete or whole angle', 1, 6, 94, 773, 1, 0, '2016-06-03 06:37:25', '2016-06-03 06:37:25', 0),
(999, 'aH1y2HpDhb', 'Straight angle', 'Straight angle', 1, 6, 94, 773, 1, 0, '2016-06-03 06:37:40', '2016-06-03 06:37:40', 0),
(1000, 'vo2kgnP9Pf', 'Right angle', 'Right angle', 1, 6, 94, 773, 1, 0, '2016-06-03 06:37:53', '2016-06-03 06:37:53', 0),
(1001, 'W3oJFbhCwo', 'Obtuse angle', 'Obtuse angle', 1, 6, 94, 773, 1, 0, '2016-06-03 06:38:03', '2016-06-03 06:38:03', 0),
(1002, 'Unz47fOVHG', 'Acute angle', 'Acute angle', 1, 6, 94, 773, 1, 0, '2016-06-03 06:38:18', '2016-06-03 06:38:18', 0),
(1003, 'fqubODgzZn', 'Acute angle triangle', 'Acute angle triangle', 1, 6, 94, 774, 1, 0, '2016-06-03 06:39:19', '2016-06-03 06:39:19', 0),
(1004, 'favxRZzLnM', 'Right angle triangle', 'Right angle triangle', 1, 6, 94, 774, 1, 0, '2016-06-03 06:39:29', '2016-06-03 06:39:29', 0),
(1005, 'ZRV1vF2cW9', 'Obtuse angle triangle', 'Obtuse angle triangle', 1, 6, 94, 774, 1, 0, '2016-06-03 06:39:43', '2016-06-03 06:39:43', 0),
(1006, 'PNxNBt2p0r', 'Scalene triangle', 'Scalene triangle', 1, 6, 94, 775, 1, 0, '2016-06-03 06:40:54', '2016-06-03 06:40:54', 0),
(1007, '1LP731lhon', 'Isosceles triangle', 'Isosceles triangle', 1, 6, 94, 775, 1, 0, '2016-06-03 06:41:01', '2016-06-03 06:41:01', 0),
(1008, 'p8PDGitfRm', 'Equilateral triangle', 'Equilateral triangle', 1, 6, 94, 775, 1, 0, '2016-06-03 06:41:13', '2016-06-03 06:41:13', 0),
(1009, 'dchygviVBI', 'Parts of an angle', 'Parts of an angle', 1, 6, 94, 776, 1, 0, '2016-06-03 06:42:39', '2016-06-03 06:42:39', 0),
(1010, 'rEb68zMvKu', 'Measure angles', 'Measure angles', 1, 6, 94, 776, 1, 1, '2016-06-03 06:42:52', '2016-06-03 07:11:49', 0),
(1011, 'jLOE1s0w5e', 'Four functions of angles', 'Four functions of angles', 1, 6, 94, 776, 1, 2, '2016-06-03 06:43:04', '2016-06-03 07:11:49', 0),
(1012, 'yVk94VEEAO', 'Protractor', 'Protractor', 1, 6, 94, 776, 1, 3, '2016-06-03 06:43:17', '2016-06-03 07:11:49', 0),
(1013, '3LKsXGN8WV', 'Measuring random angles', 'Measuring random angles', 1, 6, 94, 776, 1, 4, '2016-06-03 06:43:34', '2016-06-03 07:12:03', 0),
(1014, '9VgE3i2zif', 'Measuring fixed angles', 'Measuring fixed angles', 1, 6, 94, 776, 1, 5, '2016-06-03 06:43:52', '2016-06-03 07:12:03', 0),
(1015, 'Vk94VEEAOJ', 'Relationship Between Pairs of Angles', 'Relationship Between Pairs of Angles', 1, 6, 94, 777, 1, 0, '2016-06-03 06:45:02', '2016-06-03 06:45:02', 0),
(1016, 'bUgpIfUYeX', 'Adjacent angles', 'Adjacent angles', 1, 6, 94, 777, 1, 0, '2016-06-03 06:45:24', '2016-06-03 06:45:24', 0),
(1017, 'weI9wUD9h1', 'Linear pair', 'Linear pair', 1, 6, 94, 777, 1, 0, '2016-06-03 06:45:34', '2016-06-03 06:45:34', 0),
(1018, 'Mao8phiXHJ', 'Complementary and supplementary angles', 'Complementary and supplementary angles', 1, 6, 94, 777, 1, 0, '2016-06-03 06:45:48', '2016-06-03 06:45:48', 0),
(1019, 'RlxjOKNlCR', 'Vertically opposite angles', 'Vertically opposite angles', 1, 6, 94, 777, 1, 0, '2016-06-03 06:46:10', '2016-06-03 06:46:10', 0),
(1020, '9IK2PrJOtt', 'Transversal', 'Transversal', 1, 6, 94, 778, 1, 0, '2016-06-03 06:47:33', '2016-06-03 06:47:33', 0),
(1021, 'CbK6CrdTIj', 'Interior and exterior space', 'Interior and exterior space', 1, 6, 94, 778, 1, 1, '2016-06-03 06:47:43', '2016-06-03 07:12:47', 0),
(1022, 'PibDf73TR9', 'Alternate interior space', 'Alternate interior space', 1, 6, 94, 778, 1, 2, '2016-06-03 06:47:54', '2016-06-03 07:12:47', 0),
(1023, '3ptR5lXEbA', 'Alternate exterior space', 'Alternate exterior space', 1, 6, 94, 778, 1, 3, '2016-06-03 06:48:15', '2016-06-03 07:12:47', 0),
(1024, 'NqEvGyuVvO', 'Corresponding angles', 'Corresponding angles', 1, 6, 94, 778, 1, 4, '2016-06-03 06:48:27', '2016-06-03 07:12:47', 0),
(1025, 'XLxtWPenT8', 'Straight lines', 'Straight lines', 1, 6, 105, 782, 1, 0, '2016-06-03 06:50:44', '2016-06-03 06:50:44', 0),
(1026, 'C4J3ue0PYE', 'Curved lines', 'Curved lines', 1, 6, 105, 782, 1, 0, '2016-06-03 06:50:53', '2016-06-03 06:50:53', 0),
(1027, 'BWmfBl08Pw', 'Ray', 'Ray', 1, 6, 105, 781, 1, 0, '2016-06-03 06:51:19', '2016-06-03 06:51:19', 0),
(1028, 'daKhV2YL0g', 'Point of origin', 'Point of origin', 1, 6, 105, 781, 1, 0, '2016-06-03 06:51:31', '2016-06-03 06:51:31', 0),
(1029, 'yw6SgyxBOx', 'Line segment', 'Line segment', 1, 6, 105, 781, 1, 0, '2016-06-03 06:51:42', '2016-06-03 06:51:42', 0),
(1030, 'B32K8YSsd2', 'End points', 'End points', 1, 6, 105, 781, 1, 0, '2016-06-03 06:51:59', '2016-06-03 06:51:59', 0),
(1031, 'ltDz6AW3TG', 'Vertical lines', 'Vertical lines', 1, 6, 105, 390, 1, 0, '2016-06-03 06:52:15', '2016-06-03 06:52:15', 0),
(1032, 'buslyJPCAb', 'Horizontal line', 'Horizontal line', 1, 6, 105, 390, 1, 0, '2016-06-03 06:52:26', '2016-06-03 06:52:26', 0),
(1033, 'x1p2RQb2Zx', 'Oblique line', 'Oblique line', 1, 6, 105, 390, 1, 0, '2016-06-03 06:52:41', '2016-06-03 06:52:41', 0),
(1034, 'XMqupG9eWC', 'Parallel lines', 'Parallel lines', 1, 6, 105, 780, 1, 0, '2016-06-03 06:52:59', '2016-06-03 06:52:59', 0),
(1035, 'thWlbfh20m', 'Divergent lines', 'Divergent lines', 1, 6, 105, 780, 1, 0, '2016-06-03 06:53:23', '2016-06-03 06:53:23', 0),
(1036, '76j4fas5gj', 'Convergent lines', 'Convergent lines', 1, 6, 105, 780, 1, 0, '2016-06-03 06:53:34', '2016-06-03 06:53:34', 0),
(1037, 'Ar1MQKNH2L', 'Intersecting lines', 'Intersecting lines', 1, 6, 105, 780, 1, 0, '2016-06-03 06:53:47', '2016-06-03 06:53:47', 0),
(1038, 'wa8kJUJQTa', 'Perpendicular lines', 'Perpendicular lines', 1, 6, 105, 780, 1, 0, '2016-06-03 06:54:01', '2016-06-03 06:54:01', 0),
(1039, 'p03lrVbvGx', 'Beads on a String', 'Beads on a String', 1, 3, 28, 100, 1, 7, '2016-06-10 11:34:19', '2016-06-10 12:01:00', 0),
(1040, '1qUqdBadWx', 'Glasses Filled with Water', '', 1, 3, 28, 100, 1, 8, '2016-06-10 11:36:25', '2016-06-13 09:06:12', 0),
(1041, 'NW3tjOsLm5', 'Tray or Basket', '', 1, 3, 28, 100, 1, 9, '2016-06-10 11:36:33', '2016-06-13 09:06:29', 0),
(1042, 'SabF7BZPny', 'Pink Tower Cubes', '', 1, 3, 28, 100, 1, 10, '2016-06-10 11:36:42', '2016-06-13 09:06:29', 0),
(1043, 'HSf5yofOik', 'Small Object on a Spoon', '', 1, 3, 28, 100, 1, 11, '2016-06-10 11:36:54', '2016-06-13 09:06:29', 0),
(1044, 'NwiA2aJpTr', 'Bell on a String', '', 1, 3, 28, 100, 1, 12, '2016-06-10 11:37:07', '2016-06-13 09:06:29', 0),
(1045, 'FeyrnSKlpG', 'Bowls Filled with Water', '', 1, 3, 28, 100, 1, 13, '2016-06-10 11:37:22', '2016-06-13 09:06:29', 0),
(1046, 'Usg437Xlv3', 'Objects on Head', '', 1, 3, 28, 100, 1, 14, '2016-06-10 11:37:30', '2016-06-13 09:06:29', 0),
(1048, 'C37w7UOKIJ', 'Marching', '', 1, 3, 28, 100, 1, 16, '2016-06-10 11:37:45', '2016-06-13 09:06:29', 0),
(1049, '1FFjtcmVjt', 'Skipping', '', 1, 3, 28, 100, 1, 17, '2016-06-10 11:37:52', '2016-06-13 09:06:29', 0),
(1050, 'kecM7YDIsS', 'Running', '', 1, 3, 28, 100, 1, 18, '2016-06-10 11:38:02', '2016-06-13 09:06:29', 0),
(1051, 'Cp8ubDrrbD', 'Galloping', '', 1, 3, 28, 100, 1, 19, '2016-06-10 11:38:31', '2016-06-13 09:06:29', 0),
(1052, 'dIJ03Uhx8v', 'Dirge', '', 1, 3, 28, 100, 1, 20, '2016-06-10 11:38:41', '2016-06-13 09:06:29', 0),
(1053, 'ZmbowE3JEz', 'Rhythmic Leaping', '', 1, 3, 28, 100, 1, 23, '2016-06-10 11:38:51', '2016-06-13 09:06:29', 0),
(1055, 'NyjsmCwSmm', 'Waltz', '', 1, 3, 28, 100, 1, 26, '2016-06-10 11:41:53', '2016-06-13 09:06:29', 0),
(1056, 'ybzJefnitb', 'Balance Beam', '', 1, 3, 28, 100, 1, 27, '2016-06-10 11:42:01', '2016-06-13 09:06:29', 0),
(1057, 'gVpNcRY9Jc', 'Exercise/Yoga Activities', '', 1, 3, 28, 100, 1, 29, '2016-06-10 11:42:08', '2016-06-13 09:06:29', 0),
(1058, '2zHkrnc2Ne', 'Flags', 'Flags', 1, 3, 28, 100, 1, 6, '2016-06-10 11:59:57', '2016-06-10 12:01:00', 0),
(1065, 'AHOCWnsB5Y', 'SCy G3 Lang Comparative', '', 1, 2, 18, 63, 1, 32, '2016-06-10 12:40:58', '2016-06-22 16:20:12', 0),
(1066, 'LxWAXd62gg', 'SCy G4 Lang Refinement', '', 1, 2, 18, 63, 1, 33, '2016-06-10 12:41:06', '2016-06-22 16:20:52', 0),
(1067, 'aeNrlUHxlH', 'SCy G5 Bell Game', '', 1, 2, 18, 63, 1, 34, '2016-06-10 12:41:17', '2016-06-22 16:21:16', 0),
(1068, '9FC6diOYDo', 'SCy G6 Rattlesnake Game', '', 1, 2, 18, 63, 1, 35, '2016-06-10 12:41:31', '2016-06-22 16:21:38', 0),
(1069, 'Fqeolbz7IB', 'Prs.1-Carry/Strike Bell', '', 1, 2, 6, 126, 1, 36, '2016-06-10 12:45:00', '2016-06-10 12:45:00', 0),
(1070, 'uzJOxEz6GD', 'Prs.2-Using the Damper', '', 1, 2, 6, 126, 1, 37, '2016-06-10 12:45:13', '2016-06-10 12:45:13', 0),
(1071, 'MzqXKS67l9', 'Prs.3-Matching Bells', '', 1, 2, 6, 126, 1, 38, '2016-06-10 12:45:21', '2016-06-10 12:45:21', 0),
(1072, 'gaU3EJO1Zy', 'G.1-Distance Match(simple)', '', 1, 2, 6, 126, 1, 39, '2016-06-10 12:45:29', '2016-06-10 12:45:29', 0),
(1073, 'bvWwaz0eog', 'G.2-Walking Around Room', '', 1, 2, 6, 126, 1, 40, '2016-06-10 12:45:37', '2016-06-10 12:45:37', 0),
(1074, 'JyHLMzQroB', 'G.3-Short Conversation', '', 1, 2, 6, 126, 1, 41, '2016-06-10 12:45:46', '2016-06-10 12:45:46', 0),
(1075, 'OEw8prLBXc', 'G.4-Play All Bells First', '', 1, 2, 6, 126, 1, 42, '2016-06-10 12:45:55', '2016-06-10 12:45:55', 0),
(1076, 'KPFbumhkhy', 'G.5-Match sixteen children', '', 1, 2, 6, 126, 1, 43, '2016-06-10 12:46:05', '2016-06-10 12:46:05', 0),
(1077, 'E0vq7ac4uy', 'Triangle and rectangle', 'Triangle and rectangle', 1, 6, 57, 798, 1, 44, '2016-06-13 04:06:49', '2016-06-13 04:06:49', 0),
(1078, 'lN0SS4lNWT', 'Rhombus and rectangle', 'Rhombus and rectangle', 1, 6, 57, 798, 1, 45, '2016-06-13 04:07:10', '2016-06-13 04:07:10', 0),
(1079, 'N0BthmcS44', 'Triangle and rectangle', 'Triangle and rectangle', 1, 6, 57, 799, 1, 46, '2016-06-13 04:11:07', '2016-06-13 04:11:07', 0),
(1080, 'COZnzx5lVn', 'Rhombus and rectangle', 'Rhombus and rectangle', 1, 6, 57, 799, 1, 47, '2016-06-13 04:11:21', '2016-06-13 04:11:21', 0),
(1081, 'uGYJPdlLiv', 'TR Stage One', 'Stage One', 1, 6, 57, 800, 1, 48, '2016-06-13 04:12:03', '2016-06-22 15:20:36', 0),
(1082, 'ZRsRiAtLrD', 'TR Stage Two', 'Stage Two', 1, 6, 57, 800, 1, 49, '2016-06-13 04:12:22', '2016-06-22 15:20:51', 0),
(1083, 'nPmoEqVQF4', 'Set 1: 1 solid decagon', 'Set 1: 1 solid decagon', 1, 6, 57, 801, 1, 50, '2016-06-13 04:14:02', '2016-06-13 04:14:02', 0),
(1084, '413MSDX9UB', '1 divided into 10 pieces', '1 divided into 10 pieces', 1, 6, 57, 801, 1, 51, '2016-06-13 04:14:13', '2016-06-13 04:14:13', 0),
(1085, 'byq7aUCiRA', 'Rectangle divided into 2 rectangles', 'rectangle divided into 2 rectangles', 1, 6, 57, 801, 1, 52, '2016-06-13 04:16:19', '2016-06-13 04:16:19', 0),
(1086, 'sbeOM6TmWy', 'Set 2: 1 solid decagon', 'Set 2: 1 solid decagon', 1, 6, 57, 801, 1, 53, '2016-06-13 04:16:28', '2016-06-13 04:16:28', 0),
(1087, '8LotSWGp6Z', 'Rectangle divided into 10 trapezoids and 11 triangles', 'rectangle divided into 10 trapezoids and 11 triangles', 1, 6, 57, 801, 1, 54, '2016-06-13 04:16:46', '2016-06-13 04:16:46', 0),
(1088, 'Gpw27mu8GG', 'Dec St2 Set 2', '', 1, 6, 57, 802, 1, 55, '2016-06-13 04:18:40', '2016-06-22 15:35:15', 0),
(1089, 'tH1TWAqqV8', 'Dec St2 Set 1', '', 1, 6, 57, 802, 1, 56, '2016-06-13 04:19:00', '2016-06-22 15:35:36', 0),
(1090, 'zAitfRdSfj', 'C AA Double the triangle', 'Double the triangle', 1, 6, 99, 805, 1, 57, '2016-06-13 04:32:04', '2016-06-22 15:58:16', 0),
(1091, 'lPWIpfY9Rn', 'C AA Bisect the base', 'Bisect the base', 1, 6, 99, 805, 1, 58, '2016-06-13 04:32:19', '2016-06-22 15:58:34', 0),
(1092, 'NHebYxjooC', 'C AA Bisect the height', 'Bisect the height', 1, 6, 99, 805, 1, 59, '2016-06-13 04:32:38', '2016-06-22 15:58:56', 0),
(1093, 'QPf8dMIbOg', 'C RA Double the triangle', 'Double the triangle', 1, 6, 99, 806, 1, 60, '2016-06-13 04:33:23', '2016-06-22 15:59:29', 0),
(1094, 'OuyEGlS8SA', 'C RA Bisect the base', 'Bisect the base', 1, 6, 99, 806, 1, 61, '2016-06-13 04:33:36', '2016-06-22 15:59:52', 0),
(1095, 'H33nC0gS3c', 'C RA Bisect the height', 'Bisect the height', 1, 6, 99, 806, 1, 62, '2016-06-13 04:33:51', '2016-06-22 16:00:22', 0),
(1096, 'aladHTiEwW', 'C OA Double the triangle', 'Double the triangle', 1, 6, 99, 807, 1, 63, '2016-06-13 04:34:45', '2016-06-22 16:08:35', 0),
(1097, 'X8L787R286', 'C OA Bisect the base', 'Bisect the base', 1, 6, 99, 807, 1, 64, '2016-06-13 04:35:14', '2016-06-22 16:08:57', 0),
(1098, 't3696m8DRZ', 'F AA Double the triangle', 'Double the triangle', 1, 6, 99, 810, 1, 65, '2016-06-13 04:36:19', '2016-06-22 16:02:06', 0),
(1099, 'zmDLt5aDTM', 'F AA Bisect the base', 'Bisect the base', 1, 6, 99, 810, 1, 66, '2016-06-13 04:36:43', '2016-06-22 16:02:35', 0),
(1100, '33vsjD2DT2', 'F AA Bisect the height', 'Bisect the height', 1, 6, 99, 810, 1, 67, '2016-06-13 04:37:01', '2016-06-22 16:03:06', 0),
(1101, 'e6WNhiFkiI', 'F RA Double the triangle', 'Double the triangle', 1, 6, 99, 811, 1, 68, '2016-06-13 04:38:19', '2016-06-22 16:03:36', 0),
(1103, 'Y737M6JoUC', 'F RA Bisect the height', 'Bisect the height', 1, 6, 99, 811, 1, 70, '2016-06-13 04:38:37', '2016-06-22 16:04:12', 0),
(1104, 'te1q9O8QSb', 'C OA Bisect the height', 'Bisect the height', 1, 6, 99, 807, 1, 71, '2016-06-13 04:39:27', '2016-06-22 16:09:46', 0),
(1105, '0eASGNTttG', 'F OA Bisect the base', 'Bisect the base', 1, 6, 99, 812, 1, 1, '2016-06-13 04:40:22', '2016-06-22 16:08:00', 0),
(1106, 'ZXJu9bIQNU', 'F OA Bisect the height', 'Bisect the height', 1, 6, 99, 812, 1, 2, '2016-06-13 04:40:33', '2016-06-22 16:08:15', 0),
(1107, 'Hfl4hkeQat', 'F RA Bisect the height', 'Bisect the height', 1, 6, 99, 811, 1, 74, '2016-06-13 04:57:22', '2016-06-22 16:05:10', 0),
(1108, 'QAQV2PxKYF', 'F OA Double the triangle', 'Double the triangle', 1, 6, 99, 812, 1, 0, '2016-06-13 05:00:56', '2016-06-22 16:07:33', 0),
(1109, 'hPm8yNPOCn', 'Rhombus in conventional position', 'Rhombus in conventional position', 1, 6, 55, 813, 1, 75, '2016-06-13 05:10:47', '2016-06-13 05:10:47', 0),
(1110, 'tohcmNIk0D', 'Divide major diagonal/2', 'Divide major diagonal/2', 1, 6, 55, 813, 1, 76, '2016-06-13 05:10:53', '2016-06-13 05:10:53', 0),
(1111, 'xJwdiphcih', 'Divide minor diagonal/2', 'Divide minor diagonal/2', 1, 6, 55, 813, 1, 77, '2016-06-13 05:11:04', '2016-06-13 05:11:04', 0),
(1112, 'ng66BgrpCf', 'Double the rhombus', 'Double the rhombus', 1, 6, 55, 813, 1, 78, '2016-06-13 05:11:11', '2016-06-13 05:11:11', 0),
(1113, 'rlTPlhcEdd', 'Finding area of a polygon by dividing perimeter in half', 'Finding area of a polygon by dividing perimeter in half', 1, 6, 55, 357, 1, 79, '2016-06-13 05:12:03', '2016-06-13 05:12:03', 0),
(1114, 'PXSG5EsAp9', 'Double the rectangle to find the area', 'Double the rectangle to find the area', 1, 6, 55, 357, 1, 80, '2016-06-13 05:12:22', '2016-06-13 05:12:22', 0),
(1115, 'S2exlDK0kO', 'Finding area by dividing the apothem in half', 'Finding area by dividing the apothem in half', 1, 6, 55, 357, 1, 81, '2016-06-13 05:12:24', '2016-06-13 05:12:24', 0),
(1116, 'QgmEe5QzV5', 'Tangent', 'Tangent', 1, 6, 64, 817, 1, 82, '2016-06-13 05:18:20', '2016-06-13 05:18:20', 0),
(1117, 'OL0zrX6lIt', 'Secant', 'Secant', 1, 6, 64, 817, 1, 83, '2016-06-13 05:18:40', '2016-06-13 05:18:40', 0),
(1118, 'aX3qTwQYMg', 'External', 'External', 1, 6, 64, 817, 1, 84, '2016-06-13 05:18:48', '2016-06-13 05:18:48', 0),
(1119, 'r58rr8yJhL', 'E Rhomboidal prism', 'Rhomboidal prism', 1, 6, 89, 828, 1, 85, '2016-06-13 05:22:26', '2016-06-22 19:28:05', 0),
(1120, 'ocDeyUqc8D', 'E Hexagonal prism', 'Hexagonal prism', 1, 6, 89, 828, 1, 86, '2016-06-13 05:22:39', '2016-06-22 19:30:29', 0),
(1121, 'UOWcpBl1h2', 'D Rhomboidal prism', 'Rhomboidal prism', 1, 6, 89, 829, 1, 87, '2016-06-13 05:23:26', '2016-06-22 19:29:42', 0),
(1122, 'wcfia404nE', 'D Hexagonal prism', 'Hexagonal prism', 1, 6, 89, 829, 1, 88, '2016-06-13 05:23:48', '2016-06-22 19:31:04', 0),
(1123, 'Pf23HWDao5', 'Cone', 'Cone', 1, 6, 89, 830, 1, 89, '2016-06-13 05:25:10', '2016-06-13 05:25:10', 0),
(1124, 'ljiVXN4Qri', 'Cylinder', 'Cylinder', 1, 6, 89, 830, 1, 90, '2016-06-13 05:25:20', '2016-06-13 05:25:20', 0),
(1125, 'BAM5NiJQGm', 'Pyramid and rectangular prism', 'pyramid and rectangular prism', 1, 6, 89, 831, 1, 91, '2016-06-13 05:26:21', '2016-06-13 05:26:21', 0),
(1126, 'mSLxIuvvNg', 'Small rectangular prism and pyramid', 'small rectangular prism and pyramid', 1, 6, 89, 831, 1, 92, '2016-06-13 05:26:32', '2016-06-13 05:26:32', 0),
(1127, 'PK1JPg7Ptj', 'Cylinder and cone', 'Cylinder and cone', 1, 6, 89, 831, 1, 93, '2016-06-13 05:26:42', '2016-06-13 05:26:42', 0),
(1128, 'qOKNysORof', 'slant height', 'slant height', 1, 6, 44, 833, 1, 94, '2016-06-13 05:29:33', '2016-06-13 05:29:33', 0),
(1129, 'n6RskdlUOb', 'rectangular prism', 'rectangular prism', 1, 6, 44, 834, 1, 95, '2016-06-13 05:30:19', '2016-06-13 05:30:19', 0),
(1130, '5f5zMFQgcA', 'triangular prism', 'triangular prism', 1, 6, 44, 834, 1, 96, '2016-06-13 05:30:26', '2016-06-13 05:30:26', 0),
(1131, 'dbrFr6QU4r', 'cylinder', 'cylinder', 1, 6, 44, 834, 1, 97, '2016-06-13 05:30:33', '2016-06-13 05:30:33', 0),
(1132, 'TPw7wW6TEZ', 'triangular pyramid', 'triangular pyramid', 1, 6, 44, 834, 1, 98, '2016-06-13 05:30:44', '2016-06-13 05:30:44', 0),
(1133, 'e5waigyJ9e', 'cone', 'cone', 1, 6, 44, 834, 1, 99, '2016-06-13 05:30:50', '2016-06-13 05:30:50', 0),
(1134, 'Ep6H1bGa1Q', 'Follow-ups to the Story', 'Follow-ups to the Story', 1, 5, 45, 295, 1, 100, '2016-06-13 05:37:34', '2016-06-13 05:37:34', 0),
(1136, 'EhuMoCwXtS', 'Found Objects', 'Found Objects', 1, 3, 10, 68, 1, 102, '2016-06-13 09:13:19', '2016-06-13 09:13:19', 0),
(1137, 's4xuz6zkGT', 'Crosstitch', 'Crosstitch', 1, 3, 10, 242, 1, 3, '2016-06-13 09:14:11', '2016-06-13 09:14:29', 0),
(1138, 'TbJwTSOSjv', 'Advanced Sewing Activities', 'Advanced Sewing Activities', 1, 3, 10, 242, 1, 5, '2016-06-13 09:14:20', '2016-06-13 09:14:29', 0),
(1139, 'OpEgUZlkrf', 'CB G2 Distance Matching CE', 'G.2-Distance Matching-CE', 1, 2, 22, 108, 1, 10, '2016-06-13 09:21:49', '2016-06-22 15:07:53', 0),
(1140, 'QIxd0eQEjT', 'Relating Objects', 'Relating Objects', 1, 1, 1, 186, 1, 103, '2016-06-13 09:46:22', '2016-06-13 09:46:22', 0),
(1141, 'S6AL4X29uf', 'St.5-1 Inset, 2 Colors', 'St.5-1 Inset, 2 Colors', 1, 1, 32, 94, 1, 4, '2016-06-13 09:53:17', '2016-06-13 09:53:24', 0),
(1142, 'L5wqe4tc7G', 'Horse Colors', 'Horse Colors', 1, 1, 2, 48, 1, 104, '2016-06-13 09:58:03', '2016-06-13 09:58:03', 0),
(1143, 'uLdFvP1CEK', 'Div Static', 'Static', 1, 4, 8, 487, 1, 0, '2016-06-13 10:03:14', '2016-06-21 21:46:54', 0),
(1144, 'LNdO6ebffC', 'Wide wider widest', '', 1, 2, 22, 108, 1, 3, '2016-06-13 11:27:14', '2016-06-13 11:28:36', 0),
(1145, 'plTxJTETyD', 'Narrow narrower narrowest', 'narrow narrower narrowest', 1, 2, 22, 108, 1, 4, '2016-06-13 11:27:23', '2016-06-13 11:28:36', 0),
(1146, 'rzlpvnfFlM', 'Deep deeper deepest', 'deep deeper deepes', 1, 2, 22, 108, 1, 5, '2016-06-13 11:27:32', '2016-06-22 14:53:53', 0),
(1147, 'Pj4OPT5wP1', 'Shallow shallower shallowest', 'shallow shallower shallowest', 1, 2, 22, 108, 1, 6, '2016-06-13 11:27:43', '2016-06-13 11:28:28', 0),
(1148, 'sZNm6OZVOs', 'Tall taller tallest', 'tall taller tallest', 1, 2, 22, 108, 1, 7, '2016-06-13 11:27:52', '2016-06-13 11:28:44', 0),
(1149, 'tbsYagf0Rc', 'Short shorter shortest', 'short shorter shortest', 1, 2, 22, 108, 1, 8, '2016-06-13 11:28:02', '2016-06-13 11:28:44', 0),
(1150, 'TgVoB7suxq', 'Cube tower aligned', 'cube tower aligned', 1, 2, 22, 243, 1, 6, '2016-06-13 11:30:27', '2016-06-22 14:42:13', 0),
(1151, 'CL2J6vM4XT', 'Large larger largest', 'Large larger largest', 1, 2, 22, 243, 1, 7, '2016-06-13 11:30:36', '2016-06-13 11:31:35', 0),
(1152, 'JE5rGIacFi', 'Small smaller smallest', 'Small smaller smallest', 1, 2, 22, 243, 1, 8, '2016-06-13 11:30:43', '2016-06-13 11:31:37', 0),
(1153, 'wz4ZzrjI67', 'Prism', 'Prism', 1, 2, 22, 15, 1, 6, '2016-06-13 11:33:07', '2016-06-13 11:33:44', 0),
(1154, 'UzfSezabmW', 'Thick thicker thickest', 'Thick thicker thickest', 1, 2, 22, 15, 1, 7, '2016-06-13 11:33:14', '2016-06-13 11:33:46', 0),
(1155, 'aX2RZca89F', 'Thin thinner thinnest', 'Thin thinner thinnest', 1, 2, 22, 15, 1, 8, '2016-06-13 11:33:23', '2016-06-13 11:33:47', 0);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(36) NOT NULL,
  `name` varchar(50) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `created`, `modified`) VALUES
(1, 'Admin', NULL, NULL),
(2, 'User', NULL, NULL),
(3, 'Client', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE IF NOT EXISTS `lessons` (
  `id` int(11) NOT NULL,
  `object_id` varchar(10) DEFAULT NULL,
  `title` varchar(512) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `status` int(2) NOT NULL DEFAULT '1',
  `order_no` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `timestamp` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=851 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`id`, `object_id`, `title`, `description`, `status`, `order_no`, `user_id`, `area_id`, `chapter_id`, `created`, `modified`, `timestamp`) VALUES
(1, '014ZY4b1ov', 'Observing Someone Work', 'null', 1, 3, 1, 3, 17, '2016-01-27 10:35:48', '2016-06-13 11:17:01', 0),
(2, '0CGRrZ8eEf', 'Addition', 'null', 1, 5, 1, 4, 8, '2016-01-27 10:35:48', '2016-06-09 22:57:46', 0),
(3, '0VxWCkoAyy', 'Say Goodbye', 'null', 1, 18, 1, 3, 17, '2016-01-27 10:35:48', '2016-06-13 11:17:02', 0),
(4, '0qihlHty3S', 'Tens Beads', 'null', 1, 5, 1, 4, 15, '2016-01-27 10:35:48', '2016-06-09 23:03:06', 0),
(5, '0vMgmsHPHu', 'Sweeping the Floor', 'null', 1, 2, 1, 3, 25, '2016-01-27 10:35:48', '2016-06-13 09:02:51', 0),
(6, '1DfC18a81r', 'Phonogram Dictionary', 'null', 1, 13, 1, 1, 20, '2016-01-27 10:35:48', '2016-06-13 09:56:13', 0),
(7, '1F8afcpyAK', 'Silence Activity', 'null', 1, 1, 1, 3, 28, '2016-01-27 10:35:48', '2016-04-23 23:53:08', 0),
(8, '1OLoxtJ9n4', 'Bow Frame', 'null', 1, 7, 1, 3, 21, '2016-01-27 10:35:48', '2016-06-13 09:01:05', 0),
(9, '1i7oww8Pj9', 'Add PC #3', 'null', 1, 6, 1, 4, 5, '2016-01-27 10:35:48', '2016-06-10 13:23:38', 0),
(10, '1jbd9LA9K7', 'Washing a Vegetable', 'null', 1, 0, 1, 3, 9, '2016-01-27 10:35:48', '2016-04-23 23:48:36', 0),
(11, '2GqRaciPrJ', 'Cont. of Commands', 'null', 1, 12, 1, 1, 14, '2016-01-27 10:35:48', '2016-06-22 16:57:48', 0),
(12, '2QKfxLnoG2', 'Color Tablets Box 2', 'null', 1, 5, 1, 2, 22, '2016-01-27 10:35:48', '2016-06-10 12:17:09', 0),
(13, '2lDdFN7rS2', 'Fr Subtraction', 'null', 1, 5, 1, 4, 16, '2016-01-27 10:35:48', '2016-06-22 19:21:16', 0),
(15, '2xcWV8LwKf', 'Brown Stair', 'null', 1, 2, 1, 2, 22, '2016-01-27 10:35:48', '2016-04-24 00:02:35', 0),
(16, '2z4inOIA0o', 'Painting', 'null', 1, 8, 1, 3, 10, '2016-01-27 10:35:48', '2016-06-13 09:10:21', 0),
(17, '3nhMVaqz1c', 'Placing a Pitcher', 'null', 1, 1, 1, 3, 7, '2016-01-27 10:35:48', '2016-04-23 23:42:13', 0),
(18, '3pBT6EcFNh', 'Formation of Numbers', 'null', 1, 2, 1, 4, 8, '2016-01-27 10:35:48', '2016-06-09 22:56:26', 0),
(19, '3rukxeNCsu', 'Simple Sentences- Stage 3', 'null', 1, 2, 1, 1, 2, '2016-01-27 10:35:48', '2016-06-10 13:07:39', 0),
(20, '4Fk13W1EU2', 'Form a Line', 'null', 1, 17, 1, 3, 17, '2016-01-27 10:35:48', '2016-06-13 11:17:02', 0),
(21, '4gCRLIdGtX', 'Sandpaper Letters', 'null', 1, 1, 1, 1, 32, '2016-01-27 10:35:49', '2016-06-10 12:58:52', 0),
(22, '529YTiguSR', 'Offer Something', 'null', 1, 14, 1, 3, 17, '2016-01-27 10:35:49', '2016-06-13 11:17:02', 0),
(23, '5A6P6ihQYc', 'Phonogram Research', 'null', 1, 11, 1, 1, 20, '2016-01-27 10:35:49', '2016-06-13 09:56:13', 0),
(24, '5DGAGsC9er', 'Symbol/Phrase Game', 'null', 1, 13, 1, 1, 14, '2016-01-27 10:35:49', '2016-06-22 16:57:48', 0),
(25, '5S5Sn7AuHT', 'Flags', 'null', 1, 5, 1, 2, 30, '2016-01-27 10:35:49', '2016-04-24 00:07:52', 0),
(26, '5fMGeyjcBQ', 'Pruning a Plant', 'null', 1, 14, 1, 3, 25, '2016-01-27 10:35:49', '2016-06-13 09:02:51', 0),
(27, '5nGXJXYGbq', 'Offer Help', 'null', 1, 15, 1, 3, 17, '2016-01-27 10:35:49', '2016-06-13 11:17:02', 0),
(28, '5rK1e0AVaP', 'Number Rods', 'null', 1, 0, 1, 4, 3, '2016-01-27 10:35:49', '2016-04-24 01:34:55', 0),
(29, '6001JWqlvt', 'Decanomial Square', 'null', 1, 15, 1, 2, 22, '2016-01-27 10:35:49', '2016-06-10 12:29:23', 0),
(30, '62HwuFtDGl', 'Making Lemon Water', 'null', 1, 6, 1, 3, 9, '2016-01-27 10:35:49', '2016-06-13 09:04:25', 0),
(31, '74IFouB8qO', 'Up/Down & High/Low', 'null', 1, 1, 1, 2, 6, '2016-01-27 10:35:49', '2016-06-13 09:33:12', 0),
(32, '7Ci8wpYion', 'Subtraction Strip Board', 'null', 1, 12, 1, 4, 5, '2016-01-27 10:35:49', '2016-06-10 13:24:28', 0),
(33, '7gMPxYmDJq', 'Hundreds', 'null', 1, 3, 1, 4, 4, '2016-01-27 10:35:49', '2016-04-24 01:38:12', 0),
(34, '7ve1sQqaz0', 'Tasting Bottles', 'null', 1, 0, 1, 2, 26, '2016-01-27 10:35:49', '2016-01-27 10:35:49', 0),
(35, '83nM8H9RXG', 'Invite a Visitor', 'null', 1, 25, 1, 3, 17, '2016-01-27 10:35:49', '2016-06-13 11:17:03', 0),
(36, '8IC6BLH109', 'Adjective', 'null', 1, 1, 1, 1, 14, '2016-01-27 10:35:49', '2016-06-22 17:02:55', 0),
(37, '8Njpxqf5WV', 'Making Orange Juice', 'null', 1, 7, 1, 3, 9, '2016-01-27 10:35:49', '2016-06-13 09:04:25', 0),
(38, '8nytQwY2mZ', 'Graded Geometrical Figures', 'null', 1, 16, 1, 2, 22, '2016-01-27 10:35:49', '2016-06-10 12:29:23', 0),
(39, '8xTiP6rtWU', 'Setting Down a Chair', 'null', 1, 4, 1, 3, 7, '2016-01-27 10:35:49', '2016-06-13 07:56:40', 0),
(40, '92ecL0kGeb', 'Washing Hands', 'null', 1, 0, 1, 3, 21, '2016-01-27 10:35:49', '2016-06-10 10:29:43', 0),
(41, '9HY13vXdJj', 'Polishing Leaves', 'null', 1, 4, 1, 3, 25, '2016-01-27 10:35:49', '2016-06-13 09:02:51', 0),
(42, '9asdkUPmr1', 'Interrupting', 'null', 1, 9, 1, 3, 17, '2016-01-27 10:35:49', '2016-06-13 11:17:02', 0),
(43, '9eeeBGT4zg', 'Misting Plants', 'null', 1, 6, 1, 3, 25, '2016-01-27 10:35:49', '2016-06-13 09:02:51', 0),
(45, '9xgupPQiZJ', 'Biological Classifications', 'null', 1, 4, 1, 1, 2, '2016-01-27 10:35:49', '2016-06-10 13:13:38', 0),
(46, 'A06g9xSqgC', 'Art of Handwriting', 'null', 1, 7, 1, 1, 32, '2016-01-27 10:35:49', '2016-06-21 21:32:57', 0),
(47, 'A4OKgoHn3X', 'Stamp Game: Multiplication', 'null', 1, 15, 1, 4, 8, '2016-01-27 10:35:49', '2016-06-09 22:57:47', 0),
(48, 'AC3MWjJI3B', 'Classified Cards', 'null', 1, 3, 1, 1, 2, '2016-01-27 10:35:49', '2016-06-10 13:07:41', 0),
(49, 'AnPXRRkB3y', 'Reading Classification', 'null', 1, 16, 1, 1, 20, '2016-01-27 10:35:49', '2016-06-13 09:56:14', 0),
(50, 'AoZLXIwOXV', 'Phonetic Object Box', 'null', 1, 0, 1, 1, 20, '2016-01-27 10:35:49', '2016-04-24 01:00:34', 0),
(51, 'BI02caN3a9', 'Teen Beads & Boards', 'null', 1, 4, 1, 4, 15, '2016-01-27 10:35:49', '2016-06-09 23:03:06', 0),
(52, 'ByMiZ4JCwC', 'Carrying a Working Mat', 'null', 1, 0, 1, 3, 7, '2016-01-27 10:35:49', '2016-06-13 07:52:55', 0),
(53, 'ByvQl3k4mE', 'Phonogram Exploration', 'null', 1, 8, 1, 1, 20, '2016-01-27 10:35:49', '2016-06-13 09:56:13', 0),
(54, 'C1EfINSRE2', 'Knobless Cylinders', 'null', 1, 17, 1, 2, 22, '2016-01-27 10:35:49', '2016-06-10 12:29:23', 0),
(55, 'CL98P1ZnZy', 'Geometry Cabinet', 'null', 1, 8, 1, 2, 22, '2016-01-27 10:35:49', '2016-06-10 12:29:22', 0),
(56, 'ChFqP7P945', 'Phonogram Commands', 'null', 1, 9, 1, 1, 20, '2016-01-27 10:35:50', '2016-06-13 09:56:13', 0),
(57, 'Ci65tcAaDo', 'Multiplication CC #2', 'null', 1, 23, 1, 4, 5, '2016-01-27 10:35:50', '2016-06-10 13:26:40', 0),
(58, 'CknPH1N5Lz', 'Folding a Cloth to Put Away', 'null', 1, 7, 1, 3, 7, '2016-01-27 10:35:50', '2016-06-13 07:56:40', 0),
(59, 'CzBWzFCXhM', 'Fr Prs3 Numerator', 'null', 1, 2, 1, 4, 16, '2016-01-27 10:35:50', '2016-06-22 19:20:15', 0),
(62, 'DWgwklZCZC', 'Geometry Cards', 'null', 1, 9, 1, 2, 22, '2016-01-27 10:35:50', '2016-06-10 12:29:22', 0),
(63, 'DZTfmNbi36', 'Sound Cylinders', 'null', 1, 0, 1, 2, 18, '2016-01-27 10:35:50', '2016-01-27 10:35:50', 0),
(64, 'DaAHY3Pg5e', 'Spooning Grain', 'Spooning Grain', 1, 9, 1, 3, 7, '2016-01-27 10:35:50', '2016-06-13 07:57:04', 0),
(65, 'DadEJGxwKh', 'Using a Dustpan and Brush', 'null', 1, 1, 1, 3, 25, '2016-01-27 10:35:50', '2016-06-13 09:02:50', 0),
(66, 'DcGWVYKGJ6', 'Add PC #2', 'null', 1, 5, 1, 4, 5, '2016-01-27 10:35:50', '2016-06-10 13:23:36', 0),
(67, 'Drsbfaw8Ab', 'World Puzzle Map', 'null', 1, 2, 1, 2, 30, '2016-01-27 10:35:50', '2016-04-24 00:07:46', 0),
(68, 'DvfY5m0Cbp', 'Rubbings', 'null', 1, 4, 1, 3, 10, '2016-01-27 10:35:50', '2016-06-13 09:10:32', 0),
(69, 'EHGab1S6iW', 'Dusting a Table', 'null', 1, 0, 1, 3, 25, '2016-01-27 10:35:50', '2016-06-13 09:02:50', 0),
(70, 'EgINj1Qrdw', 'Moveable Alphabet', 'null', 1, 3, 1, 1, 32, '2016-01-27 10:35:50', '2016-06-10 12:59:09', 0),
(71, 'Ei3O1M35kg', 'Apologizing', 'null', 1, 2, 1, 3, 17, '2016-01-27 10:35:50', '2016-06-10 10:45:41', 0),
(73, 'FQMJ53lZYu', 'Dot Game', 'null', 1, 18, 1, 4, 8, '2016-01-27 10:35:50', '2016-06-09 22:57:51', 0),
(74, 'FfceHDWKkS', 'Synonyms', 'null', 1, 5, 1, 1, 23, '2016-01-27 10:35:50', '2016-04-24 01:11:42', 0),
(76, 'GXZucZOF9D', 'Walking Around a Mat', 'null', 1, 0, 1, 3, 17, '2016-01-27 10:35:50', '2016-04-23 23:49:51', 0),
(77, 'Gfy6R9OrkI', 'Rhyming Words', 'null', 1, 4, 1, 1, 20, '2016-01-27 10:35:50', '2016-06-13 09:56:13', 0),
(78, 'GkMIdkAoYk', 'Teen Beads', 'null', 1, 0, 1, 4, 15, '2016-01-27 10:35:50', '2016-04-24 01:37:07', 0),
(79, 'GlMYUPNRky', 'Bow Intro', 'null', 1, 5, 1, 3, 21, '2016-01-27 10:35:50', '2016-06-13 09:00:57', 0),
(80, 'H62Fh4UXw8', 'Hook & Eye Frame', 'null', 1, 2, 1, 3, 21, '2016-01-27 10:35:50', '2016-06-13 09:00:24', 0),
(81, 'H9DOMes6uS', 'Division Practice Chart', 'null', 1, 29, 1, 4, 5, '2016-01-27 10:35:50', '2016-06-10 13:26:40', 0),
(82, 'HTibGlckGk', 'Ask for Help', 'null', 1, 13, 1, 3, 17, '2016-01-27 10:35:50', '2016-06-13 11:17:02', 0),
(83, 'HU9Zpdh43w', 'Pouring Grain- Pitcher to Pitcher', 'null', 1, 11, 1, 3, 7, '2016-01-27 10:35:50', '2016-06-13 07:56:40', 0),
(84, 'HhywXZ94Qp', 'Subtractions Snake Game', 'null', 1, 11, 1, 4, 5, '2016-01-27 10:35:50', '2016-06-10 13:24:14', 0),
(85, 'I6TH6pATYX', 'Animal Homes', 'null', 1, 13, 1, 1, 23, '2016-01-27 10:35:50', '2016-04-24 01:12:03', 0),
(86, 'IVsuz7g8Wa', 'Zipper Frame', 'null', 1, 4, 1, 3, 21, '2016-01-27 10:35:50', '2016-06-13 09:00:57', 0),
(87, 'IcCP6TaVQe', 'Agree to Disagree', 'null', 1, 23, 1, 3, 17, '2016-01-27 10:35:50', '2016-06-13 11:17:03', 0),
(88, 'IfXh8DsvmY', 'Name Lesson w/Bells', 'null', 1, 1, 1, 1, 11, '2016-01-27 10:35:50', '2016-04-24 00:59:37', 0),
(89, 'Ikhr6wcIZx', 'Phonogram Shadow Box', 'null', 1, 6, 1, 1, 20, '2016-01-27 10:35:51', '2016-06-13 09:56:13', 0),
(90, 'J6UfcPwpkH', 'Fr Prs2 Denominator', 'null', 1, 1, 1, 4, 16, '2016-01-27 10:35:51', '2016-06-22 19:19:49', 0),
(91, 'J7ktHAA26y', 'Accepting a Compliment', 'null', 1, 4, 1, 3, 17, '2016-01-27 10:35:51', '2016-06-13 11:17:01', 0),
(92, 'JGxcH1i4HB', 'Reading Music', 'null', 1, 6, 1, 1, 11, '2016-01-27 10:35:51', '2016-04-24 00:59:59', 0),
(93, 'JwJYfPzyYz', 'Addition Blank Chart', 'null', 1, 9, 1, 4, 5, '2016-01-27 10:35:51', '2016-06-10 13:24:03', 0),
(94, 'KKo1lk8zlG', 'Metal Insets', 'null', 1, 4, 1, 1, 32, '2016-01-27 10:35:51', '2016-06-21 21:32:57', 0),
(95, 'KcH6C0RQ5B', 'Preposition', 'null', 1, 8, 1, 1, 14, '2016-01-27 10:35:51', '2016-06-22 16:57:48', 0),
(96, 'KrYd2J05WF', 'Stamp Game: Addition', 'null', 1, 13, 1, 4, 8, '2016-01-27 10:35:51', '2016-06-09 22:57:47', 0),
(97, 'KwbYDSrrZx', 'Cutting a Vegetable', 'null', 1, 2, 1, 3, 9, '2016-01-27 10:35:51', '2016-06-13 09:04:25', 0),
(98, 'LAShr2hemK', 'Add CC #2', 'null', 1, 3, 1, 4, 5, '2016-01-27 10:35:51', '2016-06-10 13:23:26', 0),
(99, 'LdwYmd9Jee', 'Three Period Lesson', 'null', 1, 7, 1, 2, 22, '2016-01-27 10:35:51', '2016-06-10 12:29:22', 0),
(100, 'LkDY5M1YeK', 'Walking on the Line', 'null', 1, 0, 1, 3, 28, '2016-01-27 10:35:51', '2016-04-23 23:53:08', 0),
(102, 'LnPYkfzYYf', 'Polishing Wood', 'null', 1, 8, 1, 3, 25, '2016-01-27 10:35:51', '2016-06-13 09:02:51', 0),
(103, 'LquXaY09r7', 'Stamp Game: Division', 'null', 1, 17, 1, 4, 8, '2016-01-27 10:35:51', '2016-06-09 22:57:47', 0),
(104, 'M9grReMKdG', 'Lacing linear', 'null', 1, 10, 1, 3, 21, '2016-01-27 10:35:51', '2016-06-13 09:01:29', 0),
(105, 'MepA7szVBo', 'Stamp Game: Linking Beads w/stamps', 'null', 1, 12, 1, 4, 8, '2016-01-27 10:35:51', '2016-06-10 13:18:13', 0),
(106, 'MnpNml8rjb', '100 Chain', 'null', 1, 7, 1, 4, 15, '2016-01-27 10:35:51', '2016-06-09 23:03:22', 0),
(108, 'Mvjms8RKa7', 'Cylinder Blocks', 'null', 1, 0, 1, 2, 22, '2016-01-27 10:35:51', '2016-04-24 00:02:25', 0),
(109, 'NS3rI3e2X0', 'Tens Boards & Beads', 'null', 1, 6, 1, 4, 15, '2016-01-27 10:35:51', '2016-06-09 23:03:16', 0),
(110, 'NXGIbO9z4X', 'Detective Adjective', 'null', 1, 5, 1, 1, 14, '2016-01-27 10:35:51', '2016-06-22 16:58:13', 0),
(111, 'NgKR1Nq3Lu', 'Long Division w/Bows', 'null', 1, 11, 1, 4, 8, '2016-01-27 10:35:51', '2016-06-10 13:18:13', 0),
(112, 'NnfjQdXqEz', 'Continent Puzzle Maps', 'null', 1, 3, 1, 2, 30, '2016-01-27 10:35:51', '2016-04-24 00:07:47', 0),
(113, 'O7UAAfgc3n', 'Chromatic Scale', 'null', 1, 4, 1, 2, 6, '2016-01-27 10:35:51', '2016-06-13 09:33:29', 0),
(114, 'OYL74qcodi', 'Spindle Box', 'null', 1, 3, 1, 4, 3, '2016-01-27 10:35:51', '2016-06-10 13:16:53', 0),
(115, 'PFiWCjNfFF', 'Large Bead Frame', 'null', 1, 2, 1, 4, 12, '2016-01-27 10:35:51', '2016-06-13 10:07:53', 0),
(116, 'PHtzPyLU1V', 'Logical Adverb', 'null', 1, 11, 1, 1, 14, '2016-01-27 10:35:51', '2016-06-22 16:58:37', 0),
(117, 'POIH9XFwiA', 'Wiping Up a Spill', 'null', 1, 3, 1, 3, 25, '2016-01-27 10:35:51', '2016-06-13 09:02:51', 0),
(118, 'PoZXQrWIbF', 'Touch Tablets', 'null', 1, 1, 1, 2, 29, '2016-01-27 10:35:51', '2016-04-24 00:04:20', 0),
(119, 'QPYfJyXAau', 'Article', 'null', 1, 0, 1, 1, 14, '2016-01-27 10:35:51', '2016-04-24 01:03:38', 0),
(120, 'Qbh06Fl5D8', 'Expression', 'null', 1, 0, 1, 3, 10, '2016-01-27 10:35:51', '2016-04-23 23:53:52', 0),
(121, 'RgaBmUFTCS', 'Greet', 'null', 1, 12, 1, 3, 17, '2016-01-27 10:35:51', '2016-06-13 11:17:02', 0),
(122, 'Rp5bUo4yXR', 'Homophones', 'null', 1, 7, 1, 1, 23, '2016-01-27 10:35:51', '2016-04-24 01:11:42', 0),
(123, 'SFlrDrDCQY', 'Yawning', 'null', 1, 7, 1, 3, 17, '2016-01-27 10:35:51', '2016-06-13 11:17:01', 0),
(124, 'SPiwezDDjA', 'Wooden Hierarchical Material', 'null', 1, 1, 1, 4, 12, '2016-01-27 10:35:52', '2016-06-13 10:07:49', 0),
(125, 'SQCyzxtg3b', 'Animal Collectives', 'null', 1, 9, 1, 1, 23, '2016-01-27 10:35:52', '2016-04-24 01:11:42', 0),
(126, 'SRpjzqOmYY', 'Diatonic Scale', 'null', 1, 0, 1, 2, 6, '2016-01-27 10:35:52', '2016-04-24 00:05:21', 0),
(127, 'SVjlRT0ntJ', 'Teens', 'null', 1, 1, 1, 4, 4, '2016-01-27 10:35:52', '2016-04-24 01:38:18', 0),
(128, 'SXAlrpd9dZ', 'Composing on the Bells', 'null', 1, 5, 1, 1, 11, '2016-01-27 10:35:52', '2016-04-24 00:59:59', 0),
(129, 'SffwTIe1C0', 'Baric Tablets', 'null', 1, 0, 1, 2, 31, '2016-01-27 10:35:52', '2016-01-27 10:35:52', 0),
(131, 'SkRrM2Ia7d', 'Trinomial Cube', 'null', 1, 14, 1, 2, 22, '2016-01-27 10:35:52', '2016-06-10 12:29:23', 0),
(132, 'T0xqXTyHW9', 'Staff/Ledger & G-Clef', 'null', 1, 2, 1, 1, 11, '2016-01-27 10:35:52', '2016-04-24 00:59:43', 0),
(133, 'TDK2QgJMUF', 'Adjectives', 'null', 1, 1, 1, 1, 23, '2016-01-27 10:35:52', '2016-06-22 19:14:47', 0),
(134, 'TWJswVKUNM', 'Animals & their Sounds', 'null', 1, 11, 1, 1, 23, '2016-01-27 10:35:52', '2016-04-24 01:11:56', 0),
(135, 'UXBoLHQMQO', 'Sweeping Outside', 'null', 1, 16, 1, 3, 25, '2016-01-27 10:35:52', '2016-06-13 09:02:51', 0),
(136, 'UddZqkoAT5', 'U.S. Puzzle Map', 'null', 1, 4, 1, 2, 30, '2016-01-27 10:35:52', '2016-04-24 00:07:52', 0),
(137, 'UzLseAfY3V', 'Using a Hammer', 'null', 1, 0, 1, 3, 19, '2016-01-27 10:35:52', '2016-06-10 12:14:20', 0),
(138, 'VEhTjT6WCM', 'Grading Chromatic Scale', 'null', 1, 6, 1, 2, 6, '2016-01-27 10:35:52', '2016-06-13 09:33:29', 0),
(139, 'VMSFVRnI0b', 'Puzzle Words', 'null', 1, 15, 1, 1, 20, '2016-01-27 10:35:52', '2016-06-13 09:56:14', 0),
(140, 'VZX4jA1gXR', 'Addition Strip Board', 'null', 1, 1, 1, 4, 5, '2016-01-27 10:35:52', '2016-06-10 13:23:13', 0),
(142, 'W5XisEsTR4', 'Language Development & Appreciation', 'null', 1, 2, 1, 1, 1, '2016-01-27 10:35:52', '2016-04-24 00:57:58', 0),
(143, 'WC3euU3MV7', 'Lacing V-pattern', 'null', 1, 8, 1, 3, 21, '2016-01-27 10:35:52', '2016-06-13 09:01:29', 0),
(144, 'WHw1ZadC6Q', 'Phonogram Cards', 'null', 1, 10, 1, 1, 20, '2016-01-27 10:35:52', '2016-06-13 09:56:13', 0),
(145, 'WdRYnM2Eff', 'Add CC #1', 'null', 1, 2, 1, 4, 5, '2016-01-27 10:35:52', '2016-06-10 13:23:25', 0),
(146, 'WfKOhGXDxr', 'Lacing X-pattern', 'null', 1, 9, 1, 3, 21, '2016-01-27 10:35:52', '2016-06-13 09:01:29', 0),
(147, 'WhtdE9S1Ee', 'Phonetic Booklets', 'null', 1, 3, 1, 1, 20, '2016-01-27 10:35:52', '2016-06-13 09:56:13', 0),
(148, 'WsYqA7j7tz', 'Note Names', 'null', 1, 3, 1, 1, 11, '2016-01-27 10:35:52', '2016-04-24 00:59:54', 0),
(149, 'WwkFOlx4xR', 'Singular & Plural', 'null', 1, 4, 1, 1, 23, '2016-01-27 10:35:52', '2016-04-24 01:11:42', 0),
(150, 'XE8WlBXnm4', 'Polishing Glass', 'null', 1, 7, 1, 3, 25, '2016-01-27 10:35:52', '2016-06-13 09:02:51', 0),
(152, 'Y3kNqiWDY8', 'Blowing Your Nose', 'null', 1, 6, 1, 3, 17, '2016-01-27 10:35:52', '2016-06-13 11:17:01', 0),
(153, 'YQK2GMTeGD', 'Zero Activity', 'null', 1, 4, 1, 4, 3, '2016-01-27 10:35:53', '2016-06-10 13:16:56', 0),
(154, 'YQMT4iaHVn', 'Multiplication BC', 'null', 1, 27, 1, 4, 5, '2016-01-27 10:35:53', '2016-06-10 13:26:40', 0),
(156, 'Z14YqJHDLI', 'Units', 'null', 1, 0, 1, 4, 4, '2016-01-27 10:35:53', '2016-04-24 01:38:08', 0),
(157, 'ZZ1FfrC9Of', 'Pouring Land and Water Forms', 'null', 1, 14, 1, 3, 7, '2016-01-27 10:35:53', '2016-06-13 07:56:40', 0),
(158, 'Zluo9Ijxpo', 'Multiplication PC #1', 'null', 1, 24, 1, 4, 5, '2016-01-27 10:35:53', '2016-06-10 13:26:40', 0),
(159, 'ZorC0V5D4F', 'Multiplication w/bead bars', 'null', 1, 17, 1, 4, 5, '2016-01-27 10:35:53', '2016-06-10 13:26:39', 0),
(160, 'ZrHH9ctm6x', 'Prefixes', 'null', 1, 2, 1, 1, 23, '2016-01-27 10:35:53', '2016-04-24 01:10:54', 0),
(161, 'ZyGJLb1u7c', 'Animals & their Young', 'null', 1, 10, 1, 1, 23, '2016-01-27 10:35:53', '2016-04-24 01:11:42', 0),
(162, 'aa8MsitZ6B', 'Addition Snake Game', 'null', 1, 0, 1, 4, 5, '2016-01-27 10:35:53', '2016-06-21 21:38:13', 0),
(163, 'abHxsjlOYo', 'Contractions', 'null', 1, 14, 1, 1, 23, '2016-01-27 10:35:53', '2016-04-24 01:12:03', 0),
(164, 'afvSc1RXjq', 'Thermic Tablets', 'null', 1, 1, 1, 2, 27, '2016-01-27 10:35:53', '2016-04-24 00:04:48', 0),
(165, 'atwthm80FG', 'Fr Division', 'null', 1, 7, 1, 4, 16, '2016-01-27 10:35:53', '2016-06-22 19:22:41', 0),
(166, 'b5n0e4PRmy', 'Spreading Activities', 'null', 1, 3, 1, 3, 9, '2016-01-27 10:35:53', '2016-06-13 09:04:25', 0),
(167, 'bXqWth2x5i', 'Fr Prs4 Equivalences', 'null', 1, 3, 1, 4, 16, '2016-01-27 10:35:53', '2016-06-22 19:20:40', 0),
(168, 'bcYbvGzsUY', 'Life Cycles', 'null', 1, 5, 1, 1, 2, '2016-01-27 10:35:53', '2016-06-10 13:13:38', 0),
(169, 'cJNM7mLsB3', 'Work Out a Conflict', 'null', 1, 22, 1, 3, 17, '2016-01-27 10:35:53', '2016-06-13 11:17:02', 0),
(170, 'cc9XEIS66l', 'Using a Saw', 'null', 1, 2, 1, 3, 19, '2016-01-27 10:35:53', '2016-06-10 12:14:24', 0),
(171, 'ceFUcNj2Ad', 'Getting Someone''s Attention', 'null', 1, 5, 1, 3, 17, '2016-01-27 10:35:53', '2016-06-13 11:17:01', 0),
(172, 'd5t1mOqPxW', 'Paper Cutting', 'null', 1, 1, 1, 3, 10, '2016-01-27 10:35:53', '2016-04-23 23:53:52', 0),
(173, 'dHQGdV3a0r', 'Unmarked Staff Board', 'null', 1, 4, 1, 1, 11, '2016-01-27 10:35:53', '2016-04-24 00:59:54', 0),
(174, 'dLH2QdYKcJ', 'Smelling Bottles', 'null', 1, 0, 1, 2, 13, '2016-01-27 10:35:53', '2016-01-27 10:35:53', 0),
(175, 'dZhSuuuEdY', 'Simple Sentences - Stage 2', 'null', 1, 1, 1, 1, 2, '2016-01-27 10:35:53', '2016-06-10 13:14:21', 0),
(176, 'de5oyCogi4', 'Painted Globe', 'null', 1, 1, 1, 2, 30, '2016-01-27 10:35:53', '2016-04-24 00:07:39', 0),
(177, 'e5tj1DmLNQ', 'Notation w/Bells', 'null', 1, 0, 1, 1, 11, '2016-01-27 10:35:53', '2016-04-24 00:59:37', 0),
(178, 'e6t7wjJMfq', 'Touch Boards', 'null', 1, 0, 1, 2, 29, '2016-01-27 10:35:53', '2016-04-24 00:04:20', 0),
(180, 'eHbsIAOvyU', 'Sandpaper Globe', 'null', 1, 0, 1, 2, 30, '2016-01-27 10:35:53', '2016-04-24 00:07:37', 0),
(181, 'eRtcG9ZMvR', 'Unit Division Board', 'null', 1, 28, 1, 4, 5, '2016-01-27 10:35:53', '2016-06-10 13:26:40', 0),
(182, 'erle5LSoCq', 'Simple Sentences- Stage 1', 'null', 1, 0, 1, 1, 2, '2016-01-27 10:35:53', '2016-06-10 13:07:30', 0),
(183, 'fEPk5xoFSp', 'Memory Game of Numbers', 'null', 1, 8, 1, 4, 3, '2016-01-27 10:35:53', '2016-06-10 13:16:46', 0),
(184, 'fIAkRzR6fB', 'Please and Thank You', 'null', 1, 8, 1, 3, 17, '2016-01-27 10:35:53', '2016-06-13 11:17:02', 0),
(185, 'fPJIXx7EYO', 'Tens', 'null', 1, 2, 1, 4, 4, '2016-01-27 10:35:54', '2016-04-24 01:38:18', 0),
(186, 'gPnLLzx8Vw', 'Enrichment of Vocabulary', 'null', 1, 0, 1, 1, 1, '2016-01-27 10:35:54', '2016-04-24 00:57:58', 0),
(187, 'gaRFpZ6MZp', 'Mystery Bag', 'null', 1, 2, 1, 2, 24, '2016-01-27 10:35:54', '2016-04-24 00:07:11', 0),
(188, 'gd6G2AEYm7', 'Walk up to Speak (Quietly)', 'null', 1, 10, 1, 3, 17, '2016-01-27 10:35:54', '2016-06-13 11:17:02', 0),
(189, 'gvEXuHTHFo', 'Botany Cards', 'null', 1, 11, 1, 2, 22, '2016-01-27 10:35:54', '2016-06-10 12:29:23', 0),
(190, 'iGN8ggaOyd', 'Folding Napkins', 'null', 1, 6, 1, 3, 7, '2016-01-27 10:35:54', '2016-06-13 07:56:40', 0),
(192, 'iiklF202wr', 'Borrowing', 'null', 1, 11, 1, 3, 17, '2016-01-27 10:35:54', '2016-06-13 11:17:02', 0),
(193, 'im2Yso5Ffo', 'Polishing Metal', 'null', 1, 9, 1, 3, 25, '2016-01-27 10:35:54', '2016-06-13 09:02:51', 0),
(194, 'jBJzHVhc7Z', 'Fr Addition', 'null', 1, 4, 1, 4, 16, '2016-01-27 10:35:54', '2016-06-22 19:20:59', 0),
(195, 'jNh8aIEdiP', 'Subtraction CC', 'null', 1, 13, 1, 4, 5, '2016-01-27 10:35:54', '2016-06-10 13:24:42', 0),
(196, 'jTOZptpMA1', 'Color Tablets Box 1', 'null', 1, 4, 1, 2, 22, '2016-01-27 10:35:54', '2016-06-10 12:17:07', 0),
(198, 'jrPTU8wssN', 'Grasping with Tongs', 'null', 1, 10, 1, 3, 7, '2016-01-27 10:35:54', '2016-06-13 07:56:40', 0),
(199, 'jy7xjpv2bB', 'Add PC #1', 'null', 1, 4, 1, 4, 5, '2016-01-27 10:35:54', '2016-06-10 13:23:34', 0),
(200, 'kam3jcsbBw', '1000 Chain', 'null', 1, 8, 1, 4, 15, '2016-01-27 10:35:54', '2016-06-09 23:03:24', 0),
(201, 'ksgK3hiOVS', 'Antonyms', 'null', 1, 6, 1, 1, 23, '2016-01-27 10:35:54', '2016-04-24 01:11:42', 0),
(202, 'l2Xj3IfGPf', 'Skip Counting', 'null', 1, 10, 1, 4, 15, '2016-01-27 10:35:54', '2016-06-09 23:01:07', 0),
(203, 'lJzGO1uiHy', 'Stamp Game: Subtraction', 'null', 1, 14, 1, 4, 8, '2016-01-27 10:35:54', '2016-06-09 22:57:47', 0),
(205, 'ldBajBUeGL', 'Additional SPL', 'null', 1, 2, 1, 1, 32, '2016-01-27 10:35:54', '2016-06-10 12:59:03', 0),
(206, 'le3qDfmFtz', 'Subtraction PC', 'null', 1, 14, 1, 4, 5, '2016-01-27 10:35:54', '2016-06-10 13:24:56', 0),
(207, 'lly9aFXqlm', 'Logical Adjective ', 'null', 1, 4, 1, 1, 14, '2016-01-27 10:35:54', '2016-06-22 16:58:12', 0),
(208, 'm0DO1KBa10', 'Sandpaper Numerals', 'null', 1, 1, 1, 4, 3, '2016-01-27 10:35:54', '2016-04-24 01:34:55', 0),
(209, 'mB74lFqOj7', 'Stereognostic Bags', 'null', 1, 1, 1, 2, 24, '2016-01-27 10:35:54', '2016-04-24 00:07:11', 0),
(210, 'mBEZK50u6e', 'Pouring Grain- Pitcher to Glass', 'null', 1, 12, 1, 3, 7, '2016-01-27 10:35:54', '2016-06-13 07:56:40', 0),
(211, 'mDOJyW77E0', 'Watering Plants', 'null', 1, 5, 1, 3, 25, '2016-01-27 10:35:54', '2016-06-13 09:02:51', 0),
(212, 'mIUsjrKnea', 'Constructive Triangles', 'null', 1, 12, 1, 2, 22, '2016-01-27 10:35:54', '2016-06-10 12:29:23', 0),
(213, 'n1I47pV5z0', 'Small Metal Insets', 'null', 1, 5, 1, 1, 32, '2016-01-27 10:35:54', '2016-06-10 12:59:18', 0),
(214, 'n3O4mjw3D3', 'Division Blank Chart', 'null', 1, 31, 1, 4, 5, '2016-01-27 10:35:54', '2016-06-10 13:23:07', 0),
(215, 'nBneaQXA9q', 'Thermic Bottles', 'null', 1, 0, 1, 2, 27, '2016-01-27 10:35:54', '2016-04-24 00:04:48', 0),
(216, 'nHYdQ1srWN', 'Conjunction ', 'null', 1, 7, 1, 1, 14, '2016-01-27 10:35:54', '2016-06-22 17:03:36', 0),
(217, 'nKUUalQSbB', 'Rotting a Plant', 'null', 1, 15, 1, 3, 25, '2016-01-27 10:35:54', '2016-06-13 09:02:51', 0),
(218, 'nYYa8fAS44', 'Subtraction', 'null', 1, 6, 1, 4, 8, '2016-01-27 10:35:54', '2016-06-09 22:57:47', 0),
(219, 'ndyf6GegAj', 'Animal Families', 'null', 1, 12, 1, 1, 23, '2016-01-27 10:35:54', '2016-04-24 01:12:03', 0),
(220, 'ngpzUJG0Ee', 'Teen Boards', 'null', 1, 2, 1, 4, 15, '2016-01-27 10:35:55', '2016-06-09 23:01:16', 0),
(221, 'nlr0RKK4i3', 'Definitions', 'null', 1, 6, 1, 1, 2, '2016-01-27 10:35:55', '2016-06-10 13:13:38', 0),
(223, 'oH4hH3ku0A', 'Multiplication', 'null', 1, 8, 1, 4, 8, '2016-01-27 10:35:55', '2016-06-09 22:57:47', 0),
(224, 'oHTZOalBbN', 'Geometry Solids', 'null', 1, 0, 1, 2, 24, '2016-01-27 10:35:55', '2016-04-24 00:07:10', 0),
(225, 'odrLAtj9x7', 'Word Problems', 'null', 1, 19, 1, 4, 8, '2016-01-27 10:35:55', '2016-06-09 22:57:51', 0),
(227, 'os8dletZX2', 'Set a Table Setting', 'null', 1, 21, 1, 3, 17, '2016-01-27 10:35:55', '2016-06-13 11:17:02', 0),
(228, 'oz8NzgEmpZ', 'Golden Bead Material', 'null', 1, 0, 1, 4, 8, '2016-01-27 10:35:55', '2016-04-24 01:35:45', 0),
(230, 'pDPHX69l1k', 'Compound Words', 'null', 1, 0, 1, 1, 23, '2016-01-27 10:35:55', '2016-04-24 01:10:38', 0),
(231, 'pYbv4CDtw2', 'Rolling a Mat', 'null', 1, 3, 1, 3, 7, '2016-01-27 10:35:55', '2016-06-13 07:54:34', 0),
(232, 'pYfprxA8sD', 'Phonogram Booklets', 'null', 1, 7, 1, 1, 20, '2016-01-27 10:35:55', '2016-06-13 09:56:13', 0),
(233, 'pbZc8tJa5o', 'Fr Multiplication', 'null', 1, 6, 1, 4, 16, '2016-01-27 10:35:55', '2016-06-22 19:21:59', 0),
(234, 'peWo6NMoWQ', 'Sound Games', 'null', 1, 0, 1, 1, 32, '2016-01-27 10:35:55', '2016-01-27 10:35:55', 0),
(235, 'pf8HHlo803', 'Subtraction BC', 'null', 1, 15, 1, 4, 5, '2016-01-27 10:35:55', '2016-06-10 13:25:06', 0),
(236, 'phw1CkdDdt', 'Fr Prs1 Introduction', 'null', 1, 0, 1, 4, 16, '2016-01-27 10:35:55', '2016-06-22 19:19:07', 0),
(237, 'pxxOv9Ee9D', 'Folding a Cloth to Dust', 'null', 1, 8, 1, 3, 7, '2016-01-27 10:35:55', '2016-06-13 07:56:40', 0),
(238, 'q80Ot6IbB6', 'Personal Dictionary', 'null', 1, 14, 1, 1, 20, '2016-01-27 10:35:55', '2016-06-13 09:56:13', 0),
(239, 'q80oT73ZH9', 'Map Making', 'null', 1, 6, 1, 1, 32, '2016-01-27 10:35:55', '2016-06-10 12:59:24', 0),
(240, 'q9OC1u5XIY', 'Verb', 'null', 1, 9, 1, 1, 14, '2016-01-27 10:35:55', '2016-06-22 16:57:48', 0),
(241, 'qzaeBhdeKI', 'Grading Diatonic Scale', 'null', 1, 2, 1, 2, 6, '2016-01-27 10:35:55', '2016-06-13 09:33:23', 0),
(242, 'r4zUdwP9HT', 'Sewing', 'null', 1, 6, 1, 3, 10, '2016-01-27 10:35:55', '2016-06-13 09:10:39', 0),
(243, 'rFqqOuQS5D', 'Pink Tower', 'null', 1, 1, 1, 2, 22, '2016-01-27 10:35:55', '2016-06-10 12:29:22', 0),
(244, 'rI0sPAWSxY', 'Fabrics', 'null', 1, 2, 1, 2, 29, '2016-01-27 10:35:55', '2016-04-24 00:04:20', 0),
(246, 'rlARRTUyO4', 'Phonogram Object Box', 'null', 1, 5, 1, 1, 20, '2016-01-27 10:35:55', '2016-06-13 09:56:13', 0),
(247, 'rs3laDT6jd', 'Card Material', 'null', 1, 1, 1, 4, 8, '2016-01-27 10:35:55', '2016-06-09 22:56:21', 0),
(248, 'sbBcdYV648', 'Word Families', 'null', 1, 3, 1, 1, 23, '2016-01-27 10:35:55', '2016-04-24 01:11:42', 0),
(249, 'slGyYWaP8G', 'Small Bead Frame', 'null', 1, 0, 1, 4, 12, '2016-01-27 10:35:55', '2016-04-24 01:40:56', 0),
(251, 'tObQZeBPJz', 'Color Tablets Box 3', 'null', 1, 6, 1, 2, 22, '2016-01-27 10:35:56', '2016-06-10 12:17:11', 0),
(252, 'tjj0WW5odj', 'Cards and Counters', 'null', 1, 6, 1, 4, 3, '2016-01-27 10:35:56', '2016-06-10 13:17:02', 0),
(253, 'uBUq7j00bv', 'Adverb', 'null', 1, 10, 1, 1, 14, '2016-01-27 10:35:56', '2016-06-22 16:58:37', 0),
(254, 'uI7jXsRqhX', 'Number Rods and Cards', 'null', 1, 2, 1, 4, 3, '2016-01-27 10:35:56', '2016-06-10 13:16:50', 0),
(255, 'ux0XH1Dxfz', 'Red Rods', 'null', 1, 3, 1, 2, 22, '2016-01-27 10:35:56', '2016-06-10 12:16:58', 0),
(256, 'uy9pvTrHSr', 'Phonetic Reading Cards', 'null', 1, 1, 1, 1, 20, '2016-01-27 10:35:56', '2016-04-24 01:00:34', 0),
(257, 'v2EkQsh84O', 'Change Game', 'null', 1, 4, 1, 4, 8, '2016-01-27 10:35:56', '2016-06-09 22:57:46', 0),
(260, 'va46ID58NJ', 'Water Transfer Activities', 'null', 1, 15, 1, 3, 7, '2016-01-27 10:35:56', '2016-06-13 07:56:40', 0),
(261, 'wihzYq4U9z', 'Using the Toaster Oven', 'null', 1, 10, 1, 3, 9, '2016-01-27 10:35:56', '2016-06-13 09:04:25', 0),
(262, 'xkVbsQDmy6', 'Have a Conversation', 'null', 1, 20, 1, 3, 17, '2016-01-27 10:35:56', '2016-06-13 11:17:02', 0),
(263, 'y183krSjmY', 'Carrying a Tray', 'null', 1, 2, 1, 3, 7, '2016-01-27 10:35:56', '2016-06-10 10:26:12', 0),
(264, 'y3pV5x32pv', 'Snap Frame', 'null', 1, 1, 1, 3, 21, '2016-01-27 10:35:56', '2016-06-13 09:00:24', 0),
(265, 'y4dPzIOKJ7', 'Sitting in a Chair', 'null', 1, 5, 1, 3, 7, '2016-01-27 10:35:56', '2016-06-13 07:56:40', 0),
(266, 'yQJOacuevP', 'Shoveling Snow', 'null', 1, 19, 1, 3, 25, '2016-01-27 10:35:56', '2016-06-13 11:13:45', 0),
(267, 'yQVmBdCU0k', 'Drawing', 'null', 1, 2, 1, 3, 10, '2016-01-27 10:35:56', '2016-06-13 09:10:31', 0),
(268, 'yw9uiBUQlX', 'Binomial Cube', 'null', 1, 13, 1, 2, 22, '2016-01-27 10:35:56', '2016-06-10 12:29:23', 0),
(269, 'zIwyMASJ7H', 'Botany Cabinet', 'null', 1, 10, 1, 2, 22, '2016-01-27 10:35:56', '2016-06-10 12:29:23', 0),
(270, 'zpC3uqt55h', 'Introducing Yourself', 'null', 1, 1, 1, 3, 17, '2016-01-27 10:35:56', '2016-04-23 23:49:57', 0),
(272, 'zqKwW0yYx8', 'Three Period Lesson', 'null', 1, 1, 1, 1, 1, '2016-01-27 10:35:56', '2016-04-24 00:57:58', 0),
(273, 'zvOcr0TrLw', 'Homographs', 'null', 1, 8, 1, 1, 23, '2016-01-27 10:35:56', '2016-04-24 01:11:42', 0),
(274, '0BJy7bshkz', 'Classes Monocotyledons and Dicotyledons', 'null', 1, 6, 1, 9, 34, '2016-01-27 10:40:02', '2016-06-13 03:36:10', 0),
(275, '0CkOGjWm3G', 'Transformation of a square', 'null', 1, 4, 1, 10, 61, '2016-01-27 10:40:03', '2016-04-23 22:15:18', 0),
(277, '0K6GxSZ2t6', 'Other Functions: holding to earth', 'null', 1, 4, 1, 9, 77, '2016-01-27 10:40:03', '2016-06-13 03:28:11', 0),
(278, '0ayD2gkObW', 'Composition', 'null', 1, 0, 1, 7, 98, '2016-01-27 10:40:04', '2016-04-23 23:27:25', 0),
(280, '0fviVGtbwE', 'Fr. Quantity and Concept', 'null', 1, 0, 1, 10, 92, '2016-01-27 10:40:04', '2016-04-23 22:17:13', 0),
(282, '0s6ixK3p5s', 'Bank Game: 2nd Stage', 'null', 1, 2, 1, 10, 49, '2016-01-27 10:40:05', '2016-04-23 22:12:17', 0),
(284, 'gGblWFaOk1', 'Other Sensitivity: Dislikes Ligth', 'null', 1, 7, 1, 9, 77, '2016-01-27 09:44:26', '2016-06-13 03:28:23', 0),
(285, 'gLkc7HGCW8', '1st Timeline of Human Beings', 'null', 1, 0, 1, 5, 101, '2016-01-27 09:44:26', '2016-02-16 12:54:20', 0),
(287, '1u0iX00PpU', 'Verb Tenses', 'null', 1, 1, 1, 7, 97, '2016-01-27 10:40:06', '2016-06-13 05:44:24', 0),
(288, '1uqeyuhuOb', '1. Five Classes', 'null', 1, 0, 1, 9, 106, '2016-01-27 10:40:06', '2016-04-23 20:44:18', 0),
(289, '1zmmIJ0aee', 'Multp. Frac. by Frac.', 'null', 1, 17, 1, 10, 92, '2016-01-27 10:40:06', '2016-06-13 07:05:46', 0),
(291, '26HGc8ZgTy', 'WHM: compare', 'null', 1, 2, 1, 10, 93, '2016-01-27 10:40:06', '2016-04-23 22:11:32', 0),
(292, '28Mh3B2dDJ', 'Notation of squaring and cubing', 'null', 1, 1, 1, 10, 61, '2016-01-27 10:40:06', '2016-04-23 22:14:56', 0),
(293, '2TYG0FgRea', 'Decanomial and extensions', 'null', 1, 3, 1, 10, 61, '2016-01-27 10:40:06', '2016-04-23 22:15:07', 0),
(294, '2VPyO8iddG', 'ONB: Numeration', 'null', 1, 0, 1, 10, 67, '2016-01-27 10:40:06', '2016-04-23 22:26:16', 0),
(295, '2bRfg6eU63', 'Story of the Coming of Life', 'null', 1, 0, 1, 5, 45, '2016-01-27 10:40:06', '2016-06-13 05:36:09', 0),
(296, 'iStxRVshRD', 'Parts of a general polygon', 'null', 1, 0, 1, 6, 102, '2016-01-27 09:44:26', '2016-02-16 12:54:20', 0),
(300, 'imziLavDiV', 'First Plate', 'null', 1, 1, 1, 6, 54, '2016-01-27 09:44:26', '2016-06-03 06:26:19', 0),
(301, '39D9deim8B', 'SN: Sub concept', 'null', 1, 1, 1, 10, 46, '2016-01-27 10:40:07', '2016-04-23 22:24:10', 0),
(302, '3EoJSMvrBm', 'Speeches', 'null', 1, 2, 1, 7, 68, '2016-01-27 10:40:07', '2016-06-13 05:49:52', 0),
(306, '46xzCR3b0s', 'Naming sharps and flats', 'null', 1, 3, 1, 11, 100, '2016-01-27 10:40:08', '2016-06-13 06:02:33', 0),
(307, '4Bu3solJc8', 'WHM: symbol', 'null', 1, 3, 1, 10, 93, '2016-01-27 10:40:08', '2016-04-23 22:11:33', 0),
(308, '4YWtNZqxxS', 'SN: Mult', 'null', 1, 2, 1, 10, 46, '2016-01-27 10:40:08', '2016-04-23 22:24:10', 0),
(309, '4igoSWUPCe', 'SM: Procedure', 'null', 1, 0, 1, 9, 56, '2016-01-27 10:40:08', '2016-01-27 10:40:08', 0),
(310, '4oApo28wFq', 'Matching, including games', 'null', 1, 1, 1, 11, 82, '2016-01-27 10:40:08', '2016-06-13 06:03:04', 0),
(311, 'k8GX15bnhM', 'Parts of the leaf', 'null', 1, 3, 1, 9, 95, '2016-01-27 09:44:27', '2016-06-13 03:26:07', 0),
(312, '5Ai7q7ZFM4', 'Problem Solving w Ratios', 'null', 1, 1, 1, 10, 53, '2016-01-27 10:40:08', '2016-04-23 20:25:05', 0),
(314, '5ErvDcCUiv', 'Start Classification 2', 'null', 1, 7, 1, 9, 34, '2016-01-27 10:40:08', '2016-06-13 03:33:22', 0),
(315, '5JtnQkf635', 'Naming and Notation of the note values', 'null', 1, 3, 1, 11, 78, '2016-01-27 10:40:08', '2016-06-13 06:04:38', 0),
(316, 'kd1OTwlhOI', 'Calendars', 'null', 1, 1, 1, 5, 72, '2016-01-27 09:44:27', '2016-06-13 05:39:30', 0),
(318, 'kjn46L1BHv', 'Sensorial Exploration of volume', 'null', 1, 0, 1, 6, 89, '2016-01-27 09:44:27', '2016-02-16 12:54:21', 0),
(320, '5WQMi6clbM', 'SN: Div', 'null', 1, 3, 1, 10, 46, '2016-01-27 10:40:09', '2016-04-23 22:24:10', 0),
(321, '5v9rm00a85', 'WP: Steps in Solving', 'null', 1, 0, 1, 10, 110, '2016-01-27 10:40:09', '2016-04-23 22:24:47', 0),
(322, '6EDwGeHlXd', 'Solving for 2 unknowns', 'null', 1, 9, 1, 10, 88, '2016-01-27 10:40:09', '2016-04-23 22:23:44', 0),
(326, '6dyDDiKhJb', 'Introduction to the Grammar Boxes', 'null', 1, 1, 1, 7, 63, '2016-01-27 10:40:09', '2016-06-13 05:43:34', 0),
(327, '6glDdvcLKG', '2nd Stage of Multi a DF by DF', 'null', 1, 4, 1, 10, 58, '2016-01-27 10:40:09', '2016-04-23 20:26:17', 0),
(329, '6nUA0Csxej', 'Black Strip', 'null', 1, 0, 1, 5, 79, '2016-01-27 10:40:09', '2016-01-27 10:40:09', 0),
(330, '73I7PgrMUt', 'Expressing Ratios as Fractions', 'null', 1, 2, 1, 10, 53, '2016-01-27 10:40:09', '2016-04-23 20:25:12', 0),
(331, '7Q8VPjie3t', 'Large Bead Frame', 'null', 1, 0, 1, 10, 49, '2016-01-27 10:40:10', '2016-04-23 22:12:06', 0),
(334, '7xCHLPRaq2', 'Summary of rests', 'null', 1, 4, 1, 11, 78, '2016-01-27 10:40:10', '2016-06-13 06:04:38', 0),
(335, 'mL1Qlnp9lI', 'Scale', 'null', 1, 3, 1, 5, 72, '2016-01-27 09:44:28', '2016-06-13 05:39:30', 0),
(338, '9QQBHYrS7b', 'Seed dispersal', 'null', 1, 4, 1, 9, 38, '2016-01-27 10:40:10', '2016-04-23 20:43:17', 0),
(339, '9dAS2J9EDl', 'Fr. Adding w Diff Den', 'null', 1, 10, 1, 10, 92, '2016-01-27 10:40:10', '2016-06-13 07:02:53', 0),
(341, '9gtmOqSQg8', 'Relative Size of numbers when Dividing', 'null', 1, 8, 1, 10, 58, '2016-01-27 10:40:11', '2016-04-23 20:26:48', 0),
(343, '9lttACllEB', 'Story of Written Language', 'null', 1, 0, 1, 7, 40, '2016-01-27 10:40:11', '2016-04-23 20:20:28', 0),
(346, 'A0wZTesjZc', 'Flat Bead Frame', 'null', 1, 4, 1, 10, 49, '2016-01-27 10:40:11', '2016-04-23 22:12:30', 0),
(347, 'oTK7q6zDiJ', 'Whole and half steps', 'null', 1, 5, 1, 11, 82, '2016-01-27 09:44:28', '2016-06-13 06:03:16', 0),
(348, 'oVRRB6l1xN', 'Notation of sharps and flats', 'null', 1, 4, 1, 11, 100, '2016-01-27 09:44:28', '2016-06-13 06:02:33', 0),
(349, 'AQNVoS9gCa', 'Temperature', 'null', 1, 5, 1, 10, 112, '2016-01-27 10:40:11', '2016-06-13 06:32:51', 0),
(350, 'AVpHNO0hBD', 'Kinds of Fruit', 'null', 1, 1, 1, 9, 71, '2016-01-27 10:40:11', '2016-04-23 20:42:37', 0),
(351, 'pkf1tXCLJo', 'Fraction Charts', 'null', 1, 2, 1, 10, 92, '2016-01-27 09:44:29', '2016-06-13 06:42:20', 0),
(352, 'pndLKktSRa', 'Flower: varieties of the parts', 'null', 1, 2, 1, 9, 70, '2016-01-27 09:44:29', '2016-06-13 03:30:38', 0),
(353, 'pz0shnysh3', 'Small Hexagonal Box', 'null', 1, 0, 1, 6, 37, '2016-01-27 09:44:29', '2016-02-16 12:54:23', 0),
(354, 'CbJivs3UNw', 'Squaring with the hierarchical value of numbers', 'null', 1, 6, 1, 10, 61, '2016-01-27 10:40:12', '2016-04-23 22:16:27', 0),
(355, 'q60CyGZGlN', 'Concentric circular sector', 'null', 1, 6, 1, 6, 64, '2016-01-27 09:44:29', '2016-06-13 05:17:51', 0),
(356, 'DHUgpCWR5E', 'History Question Charts', 'null', 1, 0, 1, 5, 43, '2016-01-27 10:40:13', '2016-01-27 10:40:13', 0),
(357, 'qqMSPNC8RE', 'Decagons', 'null', 1, 2, 1, 6, 55, '2016-01-27 09:44:29', '2016-06-13 05:09:35', 0),
(358, 'DQZAAEuBWF', 'Dec Board w Metric Measure Cards', 'null', 1, 3, 1, 10, 112, '2016-01-27 10:40:13', '2016-06-13 07:26:54', 0),
(359, 'DRwZdcT0Nq', 'Book Work', 'null', 1, 0, 1, 9, 80, '2016-01-27 10:40:13', '2016-01-27 10:40:13', 0),
(361, 'DYBvA1jgaa', 'Movement for expression', 'null', 1, 1, 1, 11, 33, '2016-01-27 10:40:14', '2016-04-23 23:38:41', 0),
(362, 'DYa2f6Ezsk', 'Solving for an unknown: sub', 'null', 1, 5, 1, 10, 88, '2016-01-27 10:40:14', '2016-04-23 22:23:41', 0),
(363, 'DbTJ1vFGs7', 'Fr. Finding LCM', 'null', 1, 13, 1, 10, 92, '2016-01-27 10:40:14', '2016-06-13 07:02:53', 0),
(364, 'DfRr6eHgxZ', 'Powers of 2 and related Exercises', 'null', 1, 0, 1, 10, 90, '2016-01-27 10:40:14', '2016-04-23 22:22:58', 0),
(366, 'sMqEkM0ug8', 'Three Phases in History', 'null', 1, 0, 1, 5, 65, '2016-01-27 09:44:29', '2016-02-16 12:54:23', 0),
(367, 'skU27Phtad', 'Singing with the scale', 'null', 1, 0, 1, 11, 39, '2016-01-27 09:44:29', '2016-02-16 12:54:24', 0),
(368, 'E3KwZaHsE4', 'Box VI: Adverb', 'null', 1, 6, 1, 7, 63, '2016-01-27 10:40:14', '2016-06-13 05:43:34', 0),
(370, 'EJmEzjp79o', 'Solving for 1 unknown', 'null', 1, 8, 1, 10, 88, '2016-01-27 10:40:14', '2016-04-23 22:23:44', 0),
(371, 'tAQw8y40tP', 'Combining Boxes', 'null', 1, 0, 1, 6, 37, '2016-01-27 09:44:30', '2016-02-16 12:54:24', 0),
(372, 'Ehihfwf8Bp', 'Two Main Types of Root', 'null', 1, 6, 1, 9, 77, '2016-01-27 10:40:15', '2016-06-13 03:28:23', 0),
(373, 'EsM3zux0de', 'Fr. Div by Fr', 'null', 1, 20, 1, 10, 92, '2016-01-27 10:40:15', '2016-06-13 07:05:46', 0),
(374, 'Ex1LSCMQyC', 'Parts of the flower', 'null', 1, 1, 1, 9, 70, '2016-01-27 10:40:15', '2016-04-23 20:42:12', 0),
(375, 'FEe4OQ3jdE', 'Debates', 'null', 1, 3, 1, 7, 68, '2016-01-27 10:40:15', '2016-06-13 05:49:52', 0),
(378, 'FV8jAo5Hrc', 'Notation of bass clef', 'null', 1, 9, 1, 11, 100, '2016-01-27 10:40:15', '2016-06-13 06:01:11', 0),
(379, 'FXRq9i1xVJ', 'Needs of the Plant', 'null', 1, 0, 1, 9, 47, '2016-01-27 10:40:15', '2016-04-23 20:32:10', 0),
(380, 'FfECWz3cij', 'Effects of Mult/Div #s by Powers of 10', 'null', 1, 3, 1, 10, 58, '2016-01-27 10:40:15', '2016-04-23 20:26:07', 0),
(381, 'FjBiWZTSjE', 'Exponential Notation: Simple Operations', 'null', 1, 1, 1, 10, 90, '2016-01-27 10:40:15', '2016-04-23 22:22:58', 0),
(384, 'FydpYDvu86', 'Kingdom Vegetalia ', 'null', 1, 2, 1, 9, 34, '2016-01-27 10:40:16', '2016-06-13 03:33:22', 0),
(387, 'Gg1aXM4fCO', 'Hand Chart', 'null', 1, 0, 1, 5, 81, '2016-01-27 10:40:16', '2016-01-27 10:40:16', 0),
(388, 'GiqzOVnUvY', 'WHM: linear', 'null', 1, 0, 1, 10, 93, '2016-01-27 10:40:16', '2016-04-23 22:11:29', 0),
(390, 'wAnCY07jgq', 'Position of lines', 'null', 1, 2, 1, 6, 105, '2016-01-27 09:44:30', '2016-06-03 06:26:02', 0),
(391, 'H1azmuBeP6', 'Length', 'null', 1, 0, 1, 10, 112, '2016-01-27 10:40:16', '2016-04-23 22:13:38', 0),
(392, 'wYZdrlvoOg', 'Stem: two main kinds', 'null', 1, 1, 1, 9, 115, '2016-01-27 09:44:30', '2016-06-13 03:30:10', 0),
(393, 'IJVt02vNEx', 'American Literature', 'null', 1, 1, 1, 7, 35, '2016-01-27 10:40:16', '2016-04-23 23:28:56', 0),
(394, 'IqM2poQuSV', 'Category Multiplication', 'null', 1, 6, 1, 10, 49, '2016-01-27 10:40:16', '2016-04-23 22:12:37', 0),
(396, 'Is18tIzGA4', 'Clock of Eras', 'null', 1, 0, 1, 5, 75, '2016-01-27 10:40:17', '2016-01-27 10:40:17', 0),
(399, 'J5GEV17V5F', 'Time', 'null', 1, 0, 1, 5, 72, '2016-01-27 10:40:17', '2016-01-27 10:40:17', 0),
(400, 'JFqwReitBG', 'Writing music', 'null', 1, 7, 1, 11, 100, '2016-01-27 10:40:17', '2016-06-13 06:01:11', 0),
(401, 'JL2z9AREIT', 'Balancing an equation: sub', 'null', 1, 1, 1, 10, 88, '2016-01-27 10:40:17', '2016-04-23 22:23:32', 0),
(402, 'yVbv3rzQTt', 'Simple Classification', 'null', 1, 6, 1, 9, 95, '2016-01-27 09:44:31', '2016-06-13 03:26:31', 0),
(403, 'JRWmhPX5LM', 'Needs of Humans', 'null', 1, 0, 1, 5, 109, '2016-01-27 10:40:17', '2016-01-27 10:40:17', 0),
(404, 'JTlprRmVDK', 'Leading to Abstraction of multiplication of DF', 'null', 1, 10, 1, 10, 58, '2016-01-27 10:40:17', '2016-04-23 20:27:13', 0),
(405, 'ynfTpGpWRy', 'Intro to note patterns', 'null', 1, 1, 1, 11, 78, '2016-01-27 09:44:31', '2016-06-13 06:04:37', 0),
(406, 'Jz1u6ol40a', 'Fr. Finding common denominator on paper', 'null', 1, 12, 1, 10, 92, '2016-01-27 10:40:17', '2016-06-13 07:02:53', 0),
(407, 'K04hYe4PIF', 'Parts of the root', 'null', 1, 2, 1, 9, 77, '2016-01-27 10:40:18', '2016-06-13 03:27:57', 0),
(409, 'zgKOxU2yPx', 'Ratio: Concept and Notation', 'null', 1, 0, 1, 10, 53, '2016-01-27 09:44:31', '2016-02-16 12:54:25', 0),
(411, 'Kbt1487ZhL', 'Poetry', 'null', 1, 4, 1, 7, 68, '2016-01-27 10:40:18', '2016-06-13 05:49:55', 0),
(412, 'KuQJU0BDbv', 'Box VII: Pronoun', 'null', 1, 7, 1, 7, 63, '2016-01-27 10:40:18', '2016-06-13 05:43:35', 0),
(413, 'Kx182XdqVO', 'Plants need minerals', 'null', 1, 2, 1, 9, 47, '2016-01-27 10:40:18', '2016-04-23 20:32:10', 0),
(414, 'LGazRAEJ9g', 'Root: main function (experiments)', 'null', 1, 0, 1, 9, 77, '2016-01-27 10:40:18', '2016-04-23 20:39:31', 0),
(415, 'LKfSHPUmhM', '1st River Civilizations', 'null', 1, 0, 1, 5, 52, '2016-01-27 10:40:18', '2016-01-27 10:40:18', 0),
(416, 'LNHNW5BioQ', 'Proportion', 'null', 1, 3, 1, 10, 53, '2016-01-27 10:40:18', '2016-04-23 20:25:18', 0),
(417, 'LUCbpV4DTi', 'Discussion', 'null', 1, 0, 1, 7, 68, '2016-01-27 10:40:18', '2016-04-23 23:28:20', 0),
(418, 'LUOMy68vml', 'AC Main Activities', 'null', 1, 2, 1, 9, 66, '2016-01-27 10:40:18', '2016-04-23 20:50:19', 0),
(420, 'LcyheMTjFz', 'Intro to Decimals', 'null', 1, 0, 1, 10, 58, '2016-01-27 10:40:18', '2016-04-23 20:25:44', 0),
(423, 'MHhTtRXUNB', 'Intro to the Decimal Checkerboard', 'null', 1, 5, 1, 10, 58, '2016-01-27 10:40:19', '2016-04-23 20:26:24', 0),
(424, 'MRLs6ETvsY', 'Movement for control', 'null', 1, 0, 1, 11, 33, '2016-01-27 10:40:19', '2016-04-23 23:38:41', 0),
(425, 'MT86D96ZLe', 'Families', 'null', 1, 9, 1, 9, 34, '2016-01-27 10:40:19', '2016-06-13 03:33:22', 0),
(427, 'McrFFYrIqQ', 'Extraction of Square Root', 'null', 1, 9, 1, 10, 61, '2016-01-27 10:40:19', '2016-04-23 22:16:27', 0),
(429, 'MfanqiXCAr', 'Another Function: stomata', 'null', 1, 1, 1, 9, 95, '2016-01-27 10:40:19', '2016-04-23 20:35:19', 0),
(431, 'Mvd869oRwm', 'Varieties of stems', 'null', 1, 5, 1, 9, 115, '2016-01-27 10:40:19', '2016-06-13 03:30:12', 0),
(432, 'N0pybW5omP', 'Games of squaring and cubing', 'null', 1, 2, 1, 10, 61, '2016-01-27 10:40:19', '2016-04-23 22:15:02', 0),
(433, 'N7gMxUrocG', 'Division of DF by DF', 'null', 1, 9, 1, 10, 58, '2016-01-27 10:40:19', '2016-04-23 20:27:07', 0),
(434, 'NFUZJuW1b7', 'Fr. Multiplication by Whole N', 'null', 1, 6, 1, 10, 92, '2016-01-27 10:40:20', '2016-06-13 07:02:53', 0),
(435, 'NGD080MtUp', 'Solving for an unknown: add', 'null', 1, 4, 1, 10, 88, '2016-01-27 10:40:20', '2016-04-23 22:23:41', 0),
(436, 'NGt54PHUl9', 'Tempo', 'null', 1, 4, 1, 11, 33, '2016-01-27 10:40:20', '2016-04-23 23:38:41', 0),
(437, 'NYR4x7pfQ5', 'AC Genealogy', 'null', 1, 3, 1, 9, 66, '2016-01-27 10:40:20', '2016-04-23 20:49:18', 0),
(440, 'Nl8MGgivPF', 'Multiples Concept', 'null', 1, 10, 1, 10, 49, '2016-01-27 10:40:20', '2016-06-13 06:28:08', 0),
(442, 'NpIVVNKFcg', 'AC Phyla to Introduce', 'null', 1, 5, 1, 9, 66, '2016-01-27 10:40:20', '2016-04-23 20:49:02', 0),
(443, 'NtedSU2Pp8', 'AC Materials', 'null', 1, 1, 1, 9, 66, '2016-01-27 10:40:20', '2016-04-23 20:48:22', 0),
(444, 'O6SYpW62Kt', '2. Definitions and Functions', 'null', 1, 1, 1, 9, 106, '2016-01-27 10:40:20', '2016-04-23 20:44:18', 0),
(445, 'OALTrVMYbv', 'High and low exercise', 'null', 1, 3, 1, 11, 82, '2016-01-27 10:40:20', '2016-06-13 06:03:13', 0),
(449, 'OOMJKkIeWz', 'WHM: layered', 'null', 1, 1, 1, 10, 93, '2016-01-27 10:40:20', '2016-04-23 22:11:30', 0),
(450, 'OTCRGW5j3G', 'English Literature', 'null', 1, 0, 1, 7, 35, '2016-01-27 10:40:20', '2016-04-23 23:28:55', 0),
(451, 'OaANWhqMdU', 'Music charts for the bells', 'null', 1, 2, 1, 11, 100, '2016-01-27 10:40:20', '2016-06-13 06:02:20', 0),
(455, 'PEHdJs1LUq', 'DF Simple Operations', 'null', 1, 1, 1, 10, 58, '2016-01-27 10:40:20', '2016-04-23 20:25:47', 0),
(456, '9hOMgosVie', 'Division w/racks and tubes', 'null', 1, 3, 1, 4, 12, '2016-01-27 10:04:36', '2016-06-13 10:07:53', 0),
(458, 'Pwc1WPas73', 'Bank Game: 1st Stage', 'null', 1, 1, 1, 10, 49, '2016-01-27 10:40:20', '2016-04-23 22:12:16', 0),
(459, 'Pyx0NRJWGl', '3. Compare and Contrast', 'null', 1, 2, 1, 9, 106, '2016-01-27 10:40:20', '2016-04-23 20:44:20', 0),
(460, 'QJjJD4yMun', 'Cubing a binomial', 'null', 1, 7, 1, 10, 61, '2016-01-27 10:40:20', '2016-04-23 22:16:27', 0),
(461, 'QOOEkF6rLd', 'SN: add concept', 'null', 1, 0, 1, 10, 46, '2016-01-27 10:40:20', '2016-04-23 22:24:10', 0),
(462, 'QcE9u2T49t', 'Proportion on 3 dimensions', 'null', 1, 5, 1, 10, 53, '2016-01-27 10:40:20', '2016-04-23 20:25:00', 0),
(465, 'RGaH4yBXSD', 'Early Civilizations of the New World', 'null', 1, 0, 1, 5, 59, '2016-01-27 10:40:21', '2016-06-13 05:35:39', 0),
(466, 'RGjyCbgYfn', 'Introduction to squaring and cubing', 'null', 1, 0, 1, 10, 61, '2016-01-27 10:40:21', '2016-04-23 22:14:50', 0),
(467, 'RHbum2YhuG', 'Specialization to ensure pollination', 'null', 1, 4, 1, 9, 70, '2016-01-27 10:40:21', '2016-06-13 03:30:38', 0),
(468, 'ReYvsJdPbg', 'Plants grow towards light', 'null', 1, 1, 1, 9, 47, '2016-01-27 10:40:21', '2016-04-23 20:32:10', 0),
(469, 'Ci65tcAaDo', 'Multiplication CC #2', 'null', 1, 22, 1, 4, 5, '2016-01-27 10:04:37', '2016-06-10 13:26:40', 0),
(470, 'RjIwjWSAIW', '3. DTV Formula', 'null', 1, 5, 1, 10, 110, '2016-01-27 10:40:21', '2016-06-13 07:15:52', 0),
(471, 'RowZIJ6trH', 'Other Functions: prevents erosion', 'null', 1, 5, 1, 9, 77, '2016-01-27 10:40:21', '2016-06-13 03:28:18', 0),
(472, 'DL6oP6l29t', 'Phonetic Commands', 'null', 1, 2, 1, 1, 20, '2016-01-27 10:04:37', '2016-06-13 09:56:13', 0),
(473, 'DSL0iqutvC', 'Multiplication Board', 'null', 1, 19, 1, 4, 5, '2016-01-27 10:04:37', '2016-06-10 13:26:39', 0),
(474, 'SEL9jmKm4F', 'Fr. Abstr of Div Rule', 'null', 1, 21, 1, 10, 92, '2016-01-27 10:40:21', '2016-06-13 07:05:46', 0),
(475, 'SFUfYyCHTb', 'Equivalence with dotted notes', 'null', 1, 5, 1, 11, 78, '2016-01-27 10:40:21', '2016-06-13 06:04:38', 0),
(478, 'SKyZpLoeAc', 'PRTI Rate', 'null', 1, 7, 1, 10, 110, '2016-01-27 10:40:21', '2016-06-13 07:15:50', 0),
(479, 'SLl66eyiqA', 'Fr. Change to Equiv Fr', 'null', 1, 9, 1, 10, 92, '2016-01-27 10:40:22', '2016-06-22 19:52:49', 0),
(482, 'T5aIL9LZG4', 'PRTI Time', 'null', 1, 9, 1, 10, 110, '2016-01-27 10:40:22', '2016-06-13 07:15:50', 0),
(485, 'V3Zcu79IUf', 'Style', 'null', 1, 4, 1, 7, 98, '2016-01-27 10:40:22', '2016-04-23 23:27:25', 0),
(486, 'VAM2lMF4vm', 'Clapping 4-beat measure patterns', 'null', 1, 0, 1, 11, 78, '2016-01-27 10:40:22', '2016-04-23 20:28:32', 0),
(487, 'Fz6ERcYnna', 'Division', 'null', 1, 9, 1, 4, 8, '2016-01-27 10:04:37', '2016-06-09 22:57:47', 0),
(488, 'VbOzxG2iFi', 'Fr. Div by Whole Number', 'null', 1, 19, 1, 10, 92, '2016-01-27 10:40:22', '2016-06-13 07:05:46', 0),
(489, 'VnqB4nQTrx', 'Parts of a woody stem', 'null', 1, 2, 1, 9, 115, '2016-01-27 10:40:22', '2016-06-13 03:30:10', 0),
(492, 'WAbmetYLpz', 'Story of Numbers', 'null', 1, 0, 1, 10, 50, '2016-01-27 10:40:22', '2016-01-27 10:40:22', 0),
(493, 'WEV12SSU51', 'Solving for an unknown: div', 'null', 1, 7, 1, 10, 88, '2016-01-27 10:40:23', '2016-04-23 22:23:43', 0),
(497, 'I6TH6pATYX', 'Animal Homes', 'null', 1, 1, 1, 1, 23, '2016-01-27 10:04:38', '2016-02-17 03:41:44', 0),
(498, 'WtxsVtHuzh', 'Details of writing music', 'null', 1, 5, 1, 11, 33, '2016-01-27 10:40:24', '2016-04-23 23:38:41', 0),
(499, 'XEjgfHhCYY', 'Root: main function (story)', 'null', 1, 1, 1, 9, 77, '2016-01-27 10:40:24', '2016-06-13 03:27:55', 0),
(500, 'XUpixu2aht', 'BC/AD', 'null', 1, 5, 1, 5, 72, '2016-01-27 10:40:24', '2016-06-13 05:39:31', 0),
(501, 'XXbtl9qOBt', 'Establishing up and down', 'null', 1, 2, 1, 11, 82, '2016-01-27 10:40:24', '2016-06-13 06:03:09', 0),
(504, 'Y0Iow0c7ep', 'Varieties of function', 'null', 1, 8, 1, 9, 95, '2016-01-27 10:40:25', '2016-06-13 03:26:33', 0),
(505, 'JwJYfPzyYz', 'Addition Blank Chart', 'null', 1, 8, 1, 4, 5, '2016-01-27 10:04:38', '2016-06-10 13:24:03', 0),
(507, 'YIpfUsNvch', 'Drama', 'null', 1, 6, 1, 7, 68, '2016-01-27 10:40:25', '2016-06-13 05:50:01', 0),
(508, 'YKJlaTpCyA', 'How to strike and carry and bell', 'null', 1, 0, 1, 11, 82, '2016-01-27 10:40:25', '2016-04-23 23:37:20', 0),
(509, 'YOrQZRpmOH', 'Kinds of Dry Fruit', 'null', 1, 3, 1, 9, 71, '2016-01-27 10:40:25', '2016-04-23 20:42:36', 0),
(510, 'YkUjcOrdCb', 'Name lesson with the bells', 'null', 1, 8, 1, 11, 82, '2016-01-27 10:40:25', '2016-06-13 06:02:56', 0),
(511, 'Z5sBB4Rwly', 'Racks and Tubes', 'null', 1, 0, 1, 10, 117, '2016-01-27 10:40:25', '2016-04-23 20:27:59', 0),
(513, 'Ll2wOo38h8', 'Velcro Closures', 'null', 1, 6, 1, 3, 21, '2016-01-27 10:04:39', '2016-06-13 09:00:45', 0),
(514, 'ZFkR9ohel9', 'Naming scales', 'null', 1, 6, 1, 11, 100, '2016-01-27 10:40:25', '2016-06-13 06:01:11', 0),
(516, 'ZjJ9CJHGQo', 'WHM: quantity + symbol', 'null', 1, 4, 1, 10, 93, '2016-01-27 10:40:26', '2016-04-23 22:11:33', 0),
(517, 'Zjvustbo3z', 'How water is moved through the stem', 'null', 1, 4, 1, 9, 115, '2016-01-27 10:40:26', '2016-06-13 03:30:12', 0),
(518, 'ZlKDC27HcV', 'PRTI Interest', 'null', 1, 6, 1, 10, 110, '2016-01-27 10:40:26', '2016-06-13 07:15:50', 0),
(519, 'MphyT8z5YA', 'Woodworking Projects', 'null', 1, 4, 1, 3, 19, '2016-01-27 10:04:39', '2016-06-10 12:14:17', 0),
(520, 'ZvKqz9SqER', 'Factual Writing', 'null', 1, 1, 1, 7, 98, '2016-01-27 10:40:26', '2016-04-23 23:27:25', 0),
(521, 'aBqoEHshUO', 'Cubing a trinomial', 'null', 1, 8, 1, 10, 61, '2016-01-27 10:40:26', '2016-04-23 22:16:27', 0),
(522, 'aFUWxuYqvC', 'Expanded Power Notation', 'null', 1, 2, 1, 10, 90, '2016-01-27 10:40:26', '2016-04-23 22:22:58', 0),
(523, 'ajj6G5l84p', 'Time', 'null', 1, 4, 1, 10, 112, '2016-01-27 10:40:26', '2016-06-13 07:26:54', 0),
(524, 'anfw0sTEEK', 'Parts of the Seed', 'null', 1, 1, 1, 9, 38, '2016-01-27 10:40:26', '2016-04-23 20:43:17', 0),
(526, 'b9qntiKrwT', 'Story of Spoken English', 'null', 1, 2, 1, 7, 40, '2016-01-27 10:40:26', '2016-04-23 20:20:33', 0),
(527, 'bG9o10cVoT', 'Division of DF on paper', 'null', 1, 11, 1, 10, 58, '2016-01-27 10:40:26', '2016-04-23 20:27:13', 0),
(529, 'bbE8KjTsIi', 'Passage from one square to another', 'null', 1, 5, 1, 10, 61, '2016-01-27 10:40:26', '2016-04-23 22:15:29', 0),
(530, 'bfKaanN9AK', 'Root: Collaboration', 'null', 1, 3, 1, 9, 77, '2016-01-27 10:40:26', '2016-06-13 03:28:01', 0),
(531, 'bfvDp96sJM', 'Simple classification', 'null', 1, 3, 1, 9, 38, '2016-01-27 10:40:26', '2016-04-23 20:43:26', 0),
(532, 'bnZTTNjoQL', 'Varieties of Roots', 'null', 1, 10, 1, 9, 77, '2016-01-27 10:40:26', '2016-06-13 03:27:52', 0),
(533, 'cOwhzxUICb', '2nd Timeline of Human Beings', 'null', 1, 0, 1, 5, 103, '2016-01-27 10:40:27', '2016-01-27 10:40:27', 0),
(534, 'cQnQJIYjwv', 'Imaginative Writing', 'null', 1, 2, 1, 7, 98, '2016-01-27 10:40:27', '2016-04-23 23:27:25', 0),
(535, 'caswn6fJ48', 'Another Function: oxygen', 'null', 1, 2, 1, 9, 95, '2016-01-27 10:40:27', '2016-06-13 03:26:07', 0),
(536, 'co2RIborqq', 'Leaf: main function', 'null', 1, 0, 1, 9, 95, '2016-01-27 10:40:27', '2016-04-23 20:35:11', 0),
(537, 'dFZpF0NTmm', 'Pitch dictation', 'null', 1, 8, 1, 11, 100, '2016-01-27 10:40:27', '2016-06-13 06:01:11', 0),
(539, 'dOwOdxkJip', 'Multiplication of Fractions: Writing', 'null', 1, 16, 1, 10, 92, '2016-01-27 10:40:27', '2016-06-13 07:05:46', 0),
(540, 'dTeCsPmngU', 'Box IX: Interjection', 'null', 1, 9, 1, 7, 63, '2016-01-27 10:40:27', '2016-06-13 05:43:42', 0);
INSERT INTO `lessons` (`id`, `object_id`, `title`, `description`, `status`, `order_no`, `user_id`, `area_id`, `chapter_id`, `created`, `modified`, `timestamp`) VALUES
(542, 'Sfx97hFDo9', 'Using the Carpet Sweeper', 'null', 1, 17, 1, 3, 25, '2016-01-27 10:04:40', '2016-06-13 09:02:51', 0),
(543, 'dz6viOv3G1', 'listening activities', 'null', 1, 0, 1, 11, 42, '2016-01-27 10:40:27', '2016-01-27 10:40:27', 0),
(546, 'e1QlCgm5bt', 'Migration Charts', 'null', 1, 0, 1, 5, 108, '2016-01-27 10:40:27', '2016-01-27 10:40:27', 0),
(547, 'eByaHSimAg', 'Compound Sentences', 'null', 1, 3, 1, 7, 36, '2016-01-27 10:40:27', '2016-06-13 05:46:43', 0),
(548, 'eKTNJqMxOy', 'Kinds of Seed', 'null', 1, 2, 1, 9, 38, '2016-01-27 10:40:27', '2016-04-23 20:43:26', 0),
(549, 'ebniUrJ5fM', 'ONB: Operations', 'null', 1, 1, 1, 10, 67, '2016-01-27 10:40:28', '2016-04-23 22:26:16', 0),
(551, 'ezLpa9A6Eh', 'Box VIII: Conjunction', 'null', 1, 8, 1, 7, 63, '2016-01-27 10:40:28', '2016-06-13 05:43:42', 0),
(552, 'fCL7HYVkhI', 'Complex Sentences', 'null', 1, 4, 1, 7, 36, '2016-01-27 10:40:28', '2016-06-13 05:46:44', 0),
(553, 'W0v2HLQ8W8', 'Using a Screwdriver', 'null', 1, 1, 1, 3, 19, '2016-01-27 10:04:40', '2016-06-10 12:14:20', 0),
(554, 'fdYqH38kqY', 'Communication in Signs', 'null', 1, 0, 1, 7, 104, '2016-01-27 10:40:28', '2016-01-27 10:40:28', 0),
(555, 'g4jlbndYqq', 'Checkerboard', 'null', 1, 5, 1, 10, 49, '2016-01-27 10:40:28', '2016-04-23 22:12:30', 0),
(559, 'gLsZsKXn1l', 'Dialogue', 'null', 1, 5, 1, 7, 68, '2016-01-27 10:40:28', '2016-06-13 05:49:59', 0),
(560, 'guMPwZIxaF', 'Note name on the staff', 'null', 1, 1, 1, 11, 100, '2016-01-27 10:40:28', '2016-06-13 06:02:15', 0),
(561, 'h41mWvd26L', 'Proportion on 2 dimensions', 'null', 1, 4, 1, 10, 53, '2016-01-27 10:40:28', '2016-04-23 20:25:18', 0),
(562, 'h8DHz5DKRo', 'Solving for an unknown: mult', 'null', 1, 6, 1, 10, 88, '2016-01-27 10:40:28', '2016-04-23 22:23:41', 0),
(563, 'Xe3GOaVflf', 'Arranging Flowers', 'null', 1, 13, 1, 3, 25, '2016-01-27 10:04:41', '2016-06-13 09:02:51', 0),
(564, 'hWposCMdB4', 'Flower: main function', 'null', 1, 0, 1, 9, 70, '2016-01-27 10:40:28', '2016-04-23 20:42:12', 0),
(565, 'i23ntrIp9I', 'Balancing an equation: div', 'null', 1, 3, 1, 10, 88, '2016-01-27 10:40:28', '2016-04-23 22:23:38', 0),
(567, 'Yu47TTrhEr', 'Buckle Frame', 'null', 1, 3, 1, 3, 21, '2016-01-27 10:04:41', '2016-06-13 09:00:25', 0),
(568, 'iSFCAEsgeS', 'Other Sensitivity: grows toward ground', 'null', 1, 9, 1, 9, 77, '2016-01-27 10:40:28', '2016-06-13 03:27:52', 0),
(570, 'Zluo9Ijxpo', 'Multiplication PC #1', 'null', 1, 25, 1, 4, 5, '2016-01-27 10:04:41', '2016-06-10 13:26:40', 0),
(571, 'ih9mrfULS4', 'Start Classification 1', 'null', 1, 1, 1, 9, 34, '2016-01-27 10:40:29', '2016-06-13 03:33:21', 0),
(572, 'ilxuydIATV', 'Box II: Noun', 'null', 1, 2, 1, 7, 63, '2016-01-27 10:40:29', '2016-06-13 05:43:34', 0),
(573, 'ZyGJLb1u7c', 'Animals & their Young', 'null', 1, 7, 1, 1, 23, '2016-01-27 10:04:41', '2016-02-17 03:41:45', 0),
(574, 'j1dOiPzbLv', 'Multip. Frac. by Frac. Outside the material', 'null', 1, 18, 1, 10, 92, '2016-01-27 10:40:29', '2016-06-13 07:05:46', 0),
(575, 'abHxsjlOYo', 'Contractions', 'null', 1, 8, 1, 1, 23, '2016-01-27 10:04:41', '2016-02-17 03:41:45', 0),
(576, 'jLCE4f4JE5', 'Money', 'null', 1, 6, 1, 10, 112, '2016-01-27 10:40:29', '2016-06-13 07:26:54', 0),
(579, 'jeeSUPArLG', 'Other parts of a woody stem', 'null', 1, 3, 1, 9, 115, '2016-01-27 10:40:29', '2016-06-13 03:30:11', 0),
(581, 'joMpYaeSDO', 'Fr. Subtraction Same Den', 'null', 1, 5, 1, 10, 92, '2016-01-27 10:40:29', '2016-06-22 19:51:24', 0),
(582, 'jseFzHOxx3', 'Box V: Preposition', 'null', 1, 5, 1, 7, 63, '2016-01-27 10:40:29', '2016-06-13 05:43:34', 0),
(583, 'k4KW1EdAV7', 'Branches Angiospermae and Gymnospermae', 'null', 1, 5, 1, 9, 34, '2016-01-27 10:40:29', '2016-06-13 03:36:01', 0),
(585, 'kH10l8YA0x', 'AC Tree of Classification', 'null', 1, 4, 1, 9, 66, '2016-01-27 10:40:29', '2016-04-23 20:47:53', 0),
(586, 'kLgqUSxyNI', 'Geometric Formation of Multiplication', 'null', 1, 7, 1, 10, 49, '2016-01-27 10:40:29', '2016-04-23 22:12:37', 0),
(587, 'kYE0gtYqMe', 'Kinds of Succulent Fruit', 'null', 1, 2, 1, 9, 71, '2016-01-27 10:40:29', '2016-04-23 20:42:37', 0),
(588, 'kcb9yo2CsX', 'Teaching a song', 'null', 1, 0, 1, 11, 39, '2016-01-27 10:40:29', '2016-01-27 10:40:29', 0),
(590, 'khimHYVp54', 'Stem: main function', 'null', 1, 0, 1, 9, 115, '2016-01-27 10:40:29', '2016-04-23 20:41:52', 0),
(591, 'e7KB6rXwDd', 'Excuse Self', 'null', 1, 16, 1, 3, 17, '2016-01-27 10:04:42', '2016-06-13 11:17:02', 0),
(593, 'kzdhskjwgb', 'How to Help with the Writing Form', 'null', 1, 3, 1, 7, 98, '2016-01-27 10:40:29', '2016-04-23 23:27:25', 0),
(594, 'l14yPICUzW', '4. Similarites/differences', 'null', 1, 3, 1, 9, 106, '2016-01-27 10:40:29', '2016-04-23 20:44:20', 0),
(596, 'l3mROnZzGt', 'Divisions Phanerogamae and Cryptogamae', 'null', 1, 4, 1, 9, 34, '2016-01-27 10:40:29', '2016-06-13 03:35:53', 0),
(597, 'l6Fg8FqcmN', 'Word Study', 'null', 1, 0, 1, 7, 63, '2016-01-27 10:40:29', '2016-06-13 05:43:34', 0),
(598, 'lHuu2SFFlp', 'Presentation', 'null', 1, 0, 1, 9, 80, '2016-01-27 10:40:29', '2016-01-27 10:40:29', 0),
(599, 'lR2Hg5edih', 'Accents', 'null', 1, 2, 1, 11, 33, '2016-01-27 10:40:29', '2016-04-23 23:38:41', 0),
(600, 'lTRtix95Wh', 'Fruit: Main Function', 'null', 1, 0, 1, 9, 71, '2016-01-27 10:40:30', '2016-04-23 20:42:36', 0),
(601, 'lTgKbNLBGd', 'Fr. Division by a Whole Number', 'null', 1, 8, 1, 10, 92, '2016-01-27 10:40:30', '2016-06-13 07:02:53', 0),
(602, 'lVhVhqWCn0', 'Multiplication of Fractions', 'null', 1, 15, 1, 10, 92, '2016-01-27 10:40:30', '2016-06-13 07:05:46', 0),
(603, 'iQGoKJlv8b', 'Grinding Activities', 'null', 1, 4, 1, 3, 9, '2016-01-27 10:04:43', '2016-06-13 09:04:25', 0),
(604, 'lb4zhkhKSW', 'Group Division', 'null', 1, 1, 1, 10, 117, '2016-01-27 10:40:30', '2016-04-23 20:27:59', 0),
(605, 'litikN5C2H', 'Seed: Main Function', 'null', 1, 0, 1, 9, 38, '2016-01-27 10:40:30', '2016-04-23 20:43:17', 0),
(606, 'm2p2e95q3s', 'Negative Form of the Verb', 'null', 1, 3, 1, 7, 97, '2016-01-27 10:40:30', '2016-06-13 05:44:32', 0),
(607, 'mIv7mBvugV', 'Story of the Coming of Human Beings', 'null', 1, 0, 1, 5, 48, '2016-01-27 10:40:30', '2016-06-13 05:36:15', 0),
(609, 'jdgGCyNLab', 'Peeling a Vegetable', 'null', 1, 1, 1, 3, 9, '2016-01-27 10:04:43', '2016-06-13 09:04:24', 0),
(610, 'mYVyV3OTVd', '2. DTV Arithmetic', 'null', 1, 3, 1, 10, 110, '2016-01-27 10:40:30', '2016-06-13 07:15:50', 0),
(611, 'mc60CWMQVx', 'Varieties of Leaves', 'null', 1, 5, 1, 9, 95, '2016-01-27 10:40:30', '2016-06-13 03:26:16', 0),
(612, 'nFGQZgidBl', 'Dynamics', 'null', 1, 3, 1, 11, 33, '2016-01-27 10:40:30', '2016-04-23 23:38:41', 0),
(613, 'nGPddlfrQq', 'Clarity of Expression', 'null', 1, 8, 1, 7, 68, '2016-01-27 10:40:30', '2016-06-13 05:49:52', 0),
(615, 'nkTsw6eYBY', 'Weight', 'null', 1, 2, 1, 10, 112, '2016-01-27 10:40:30', '2016-06-13 07:26:54', 0),
(616, 'lau4VlcMzM', 'Doing Laundry', 'null', 1, 12, 1, 3, 25, '2016-01-27 10:04:43', '2016-06-13 09:02:51', 0),
(617, 'o61JQic3Fv', 'Oral Reports', 'null', 1, 1, 1, 7, 68, '2016-01-27 10:40:30', '2016-06-13 05:47:38', 0),
(618, 'o9FjoFD3Xm', 'Extraction of Cube Root', 'null', 1, 11, 1, 10, 61, '2016-01-27 10:40:30', '2016-06-13 06:39:40', 0),
(619, 'oSEYtIExYx', 'AC Introduction', 'null', 1, 0, 1, 9, 66, '2016-01-27 10:40:30', '2016-04-23 20:47:32', 0),
(622, 'p7e4w9Pa1a', 'Simple Sentences', 'null', 1, 0, 1, 7, 36, '2016-01-27 10:40:31', '2016-04-23 23:07:15', 0),
(623, 'pO8cnanByN', 'Balancing an equation: Add', 'null', 1, 0, 1, 10, 88, '2016-01-27 10:40:31', '2016-04-23 22:23:27', 0),
(624, 'pkf1tXCLJo', 'Fraction Charts', 'null', 1, 22, 1, 10, 92, '2016-01-27 10:40:31', '2016-06-13 07:05:46', 0),
(627, 'q4712z69ru', 'Commutative and Distributive Laws', 'null', 1, 9, 1, 10, 49, '2016-01-27 10:40:31', '2016-06-13 06:28:08', 0),
(629, 'qbncLPppd6', 'Tetra chord', 'null', 1, 7, 1, 11, 82, '2016-01-27 10:40:31', '2016-06-13 06:02:56', 0),
(631, 'ndyf6GegAj', 'Animal Families', 'null', 1, 10, 1, 1, 23, '2016-01-27 10:04:44', '2016-02-17 03:41:45', 0),
(632, 'qzY8tlENXU', 'Fr. Finding Common Den beyond the material', 'null', 1, 11, 1, 10, 92, '2016-01-27 10:40:31', '2016-06-13 07:02:53', 0),
(633, 'r5aixbEHBg', 'Fr. Steps on Paper (add or sub)', 'null', 1, 14, 1, 10, 92, '2016-01-27 10:40:31', '2016-06-13 07:02:53', 0),
(634, 'o1EGXnnK98', 'Scrubbing a Floor', 'null', 1, 11, 1, 3, 25, '2016-01-27 10:04:44', '2016-06-13 09:02:51', 0),
(635, 'rwTqTYjGRx', 'PRTI Principal', 'null', 1, 8, 1, 10, 110, '2016-01-27 10:40:31', '2016-06-13 07:15:50', 0),
(636, 's0fh1EZ7mp', 'Bank Game: 3rd Stage', 'null', 1, 3, 1, 10, 49, '2016-01-27 10:40:31', '2016-04-23 22:12:23', 0),
(638, 'on6nVu3vhh', 'Washing a Table', 'null', 1, 10, 1, 3, 25, '2016-01-27 10:04:44', '2016-06-13 09:02:51', 0),
(641, 'p5TFYZbEHu', 'Using the Tape Measure', 'null', 1, 3, 1, 3, 19, '2016-01-27 10:04:44', '2016-06-10 12:14:24', 0),
(642, 'pDPHX69l1k', 'Compound Words', 'null', 1, 11, 1, 1, 23, '2016-01-27 10:04:44', '2016-02-17 03:41:45', 0),
(643, 't8vgrC3I6Y', 'Infinitives and Mood', 'null', 1, 2, 1, 7, 97, '2016-01-27 10:40:31', '2016-06-13 05:44:32', 0),
(645, 'tIKxwk8XF5', 'Intro to the musical staff', 'null', 1, 0, 1, 11, 100, '2016-01-27 10:40:31', '2016-06-13 06:01:12', 0),
(649, 'ti7UasKhnB', 'Fr. Addition Same Den', 'null', 1, 4, 1, 10, 92, '2016-01-27 10:40:31', '2016-06-22 19:51:07', 0),
(650, 'tlPbYqbCd4', 'Other Aspects of Simple Sentences', 'null', 1, 2, 1, 7, 36, '2016-01-27 10:40:31', '2016-06-13 05:46:43', 0),
(651, 'tlTk3OTmNV', 'Subclass Archichlamydae and Metachlamydae', 'Subclass Archichlamydae and Metachlamydae', 1, 8, 1, 9, 34, '2016-01-27 10:40:32', '2016-06-13 03:36:24', 0),
(652, 'u5DdaieoUp', 'Converting common fractions and decimal fractions', 'null', 1, 2, 1, 10, 58, '2016-01-27 10:40:32', '2016-04-23 20:25:57', 0),
(653, 'u7ZzPiZKkZ', 'Liquid Volume', 'null', 1, 1, 1, 10, 112, '2016-01-27 10:40:32', '2016-06-13 06:32:26', 0),
(657, 'rZT6eDJvgw', 'Knock on Bathroom Door', 'null', 1, 19, 1, 3, 17, '2016-01-27 10:04:45', '2016-06-13 11:17:02', 0),
(658, 'urUfEipt93', 'Box III: Adjective', 'null', 1, 3, 1, 7, 63, '2016-01-27 10:40:32', '2016-06-13 05:43:34', 0),
(659, 'vK08veARvI', '1. DTV Sensorial', 'null', 1, 2, 1, 10, 110, '2016-01-27 10:40:32', '2016-06-13 07:15:50', 0),
(660, 'veznVQdnSy', 'Balancing an equation: mult', 'null', 1, 2, 1, 10, 88, '2016-01-27 10:40:32', '2016-04-23 22:23:35', 0),
(661, 'vknsmd02vR', 'Personal Pronoun', 'null', 1, 0, 1, 7, 97, '2016-01-27 10:40:32', '2016-04-23 23:06:39', 0),
(662, 'suwxEsn0x9', 'Pouring Water', 'null', 1, 13, 1, 3, 7, '2016-01-27 10:04:46', '2016-06-13 07:56:40', 0),
(666, 'waXDPWlNvl', 'Factors Concept', 'null', 1, 11, 1, 10, 49, '2016-01-27 10:40:32', '2016-06-13 06:28:08', 0),
(667, 'wre8Eodmu7', 'Multiplication on the decimal checkerboard', 'null', 1, 6, 1, 10, 58, '2016-01-27 10:40:32', '2016-04-23 20:26:35', 0),
(668, 'x42AJ8L4zI', 'Equivalency w Fractions', 'null', 1, 3, 1, 10, 92, '2016-01-27 10:40:32', '2016-06-13 06:42:25', 0),
(669, 'x92cHrDShO', 'Grading, including extension 1-3 and games', 'null', 1, 4, 1, 11, 82, '2016-01-27 10:40:32', '2016-06-13 06:03:16', 0),
(671, 'v4q8vGdi4P', 'Baking Activities', 'null', 1, 5, 1, 3, 9, '2016-01-27 10:04:46', '2016-06-13 09:04:25', 0),
(672, 'xs3AacVdPf', 'Box IV: Verb', 'null', 1, 4, 1, 7, 63, '2016-01-27 10:40:32', '2016-06-13 05:43:34', 0),
(673, 'xz1nm5ChEH', 'Fr. Writing the Symbol', 'null', 1, 1, 1, 10, 92, '2016-01-27 10:40:32', '2016-04-23 22:17:13', 0),
(674, 'y9aHEN8xtQ', 'Genera Level', 'null', 1, 0, 1, 9, 80, '2016-01-27 10:40:32', '2016-01-27 10:40:32', 0),
(678, 'ynfTpGpWRy', 'Notes on making the material', 'Notes on making the material', 1, 2, 1, 11, 78, '2016-01-27 10:40:32', '2016-06-13 06:05:42', 0),
(679, 'yoyqMnvBV3', 'Divisibility', 'null', 1, 2, 1, 10, 117, '2016-01-27 10:40:32', '2016-04-23 20:27:59', 0),
(681, 'z4BDJnWbwS', 'Relative Size of the Terms in multiplication problem', 'null', 1, 7, 1, 10, 58, '2016-01-27 10:40:32', '2016-04-23 20:26:47', 0),
(684, 'zjeDgfXOQL', 'Story of Spoken Language', 'null', 1, 1, 1, 7, 40, '2016-01-27 10:40:32', '2016-04-23 20:20:33', 0),
(685, 'zvOcr0TrLw', 'Homographs', 'null', 1, 13, 1, 1, 23, '2016-01-27 10:04:47', '2016-02-17 03:41:45', 0),
(706, 'ucOBTTJju7', 'God With No Hands', 'God With No Hands', 1, 0, 1, 8, 96, '2016-06-03 03:45:35', '2016-06-03 05:36:19', 0),
(707, 'yXanmdOF24', 'Command Cards', 'Command Cards', 1, 1, 1, 8, 96, '2016-06-03 03:45:59', '2016-06-03 05:36:22', 0),
(708, 'L8TDQGBXUp', 'Composition of the Earth: names and Layers', 'Composition of the Earth: names and Layers', 1, 2, 1, 8, 96, '2016-06-03 03:46:15', '2016-06-03 05:36:26', 0),
(709, 'kScp7ZWpcd', 'Comparison of the thickness of layers', 'Comparison of the thickness of layers', 1, 3, 1, 8, 96, '2016-06-03 03:48:15', '2016-06-03 05:36:29', 0),
(710, '0Ur0bIHFVw', 'Force of gravity', 'Force of gravity', 1, 4, 1, 8, 96, '2016-06-03 03:48:43', '2016-06-03 05:36:32', 0),
(711, 'jDbpDv97Rq', 'Further Details: Crust, Mantle, Core', 'Further Details: Crust, Mantle, Core', 1, 5, 1, 8, 96, '2016-06-03 03:58:27', '2016-06-03 05:36:41', 0),
(712, 'Il2nH8b8Ou', '3 States of Matter', '3 States of Matter', 1, 0, 1, 8, 60, '2016-06-03 04:07:02', '2016-06-03 05:37:58', 0),
(713, 'iIdf4nY7F4', 'Further States: Solids', 'Further States: Solids', 1, 1, 1, 8, 60, '2016-06-03 04:08:15', '2016-06-03 05:38:04', 0),
(714, 'EGQ0eoQQPA', 'Further States: Liquids', 'Further States: Liquids', 1, 2, 1, 8, 60, '2016-06-03 04:08:34', '2016-06-03 05:38:07', 0),
(715, 'Kri2qbNlgp', 'Different Ways of Combining: Solutions', 'Different Ways of Combining: Solutions', 1, 3, 1, 8, 60, '2016-06-03 04:10:29', '2016-06-03 05:38:12', 0),
(716, 'D24f6swByR', 'Matter in suspension', 'Matter in suspension', 1, 4, 1, 8, 60, '2016-06-03 04:10:55', '2016-06-03 05:38:44', 0),
(717, 'neZRZS759A', 'Mixtures', 'Mixtures', 1, 5, 1, 8, 60, '2016-06-03 04:11:56', '2016-06-03 05:38:44', 0),
(718, 'iNIhQsvVZF', 'Chemical Reactions', 'Chemical Reactions', 1, 6, 1, 8, 60, '2016-06-03 04:12:08', '2016-06-03 05:38:44', 0),
(719, 'Yn8yAMRR6M', 'Separation', 'Separation', 1, 7, 1, 8, 60, '2016-06-03 04:12:18', '2016-06-03 05:38:44', 0),
(720, '5qQFFDMPwY', 'Saturated solution', 'Saturated solution', 1, 8, 1, 8, 60, '2016-06-03 04:12:28', '2016-06-03 05:38:44', 0),
(721, 'Me3Qvs1ZCG', 'Super saturation', 'Super saturation', 1, 9, 1, 8, 60, '2016-06-03 04:12:39', '2016-06-03 05:38:44', 0),
(722, '02eg4AEDqd', 'Attraction and Gravity', 'Attraction and Gravity', 1, 10, 1, 8, 60, '2016-06-03 04:12:50', '2016-06-03 05:38:44', 0),
(723, 'JLgJLOGYBD', 'Comparative measuring with scales', 'Comparative measuring with scales', 1, 11, 1, 8, 60, '2016-06-03 04:12:58', '2016-06-03 05:38:44', 0),
(724, 'Ws4OvpzkKL', 'Heavy objects seek the center: Liquids', 'Heavy objects seek the center: Liquids', 1, 12, 1, 8, 60, '2016-06-03 04:13:07', '2016-06-03 05:38:44', 0),
(725, '27eNIAaHNI', 'Heavy objects seek the center: Solids', 'Heavy objects seek the center: Solids', 1, 13, 1, 8, 60, '2016-06-03 04:13:17', '2016-06-03 05:38:44', 0),
(726, '1Qhq8JiyLT', 'Heavy objects seek the center: Demo #4', 'Heavy objects seek the center: Demo #4', 1, 14, 1, 8, 60, '2016-06-03 04:13:44', '2016-06-03 05:38:44', 0),
(727, 'lU7kl6gyTu', 'The Rotation of the Earth and Its Consequence', 'The Rotation of the Earth and Its Consequence', 1, 0, 1, 8, 87, '2016-06-03 04:16:47', '2016-06-03 05:42:29', 0),
(728, 'CptcKwZu2L', 'Two movements of the Earth', 'Two movements of the Earth', 1, 1, 1, 8, 87, '2016-06-03 04:16:56', '2016-06-03 05:42:29', 0),
(729, 'TuWImDpS8s', 'Day and night', 'Day and night', 1, 2, 1, 8, 87, '2016-06-03 04:17:05', '2016-06-03 05:42:29', 0),
(730, 'kP96YuYcqC', 'Sunrise, Morning, Midday, Afternoon, Sunset, and Night', 'Sunrise, Morning, Midday, Afternoon, Sunset, and Night', 1, 3, 1, 8, 87, '2016-06-03 04:17:39', '2016-06-03 05:42:29', 0),
(731, 'VAnPZaGfch', 'Sunrise, Noon, Sunset', 'Sunrise, Noon, Sunset', 1, 4, 1, 8, 87, '2016-06-03 04:17:47', '2016-06-03 05:42:29', 0),
(732, 'BFMbwLGLLU', 'Hottest and Coldest Parts of the Day', 'Hottest and Coldest Parts of the Day', 1, 5, 1, 8, 87, '2016-06-03 04:17:54', '2016-06-03 05:42:29', 0),
(733, 'IzC9rxciUT', 'AM and PM', 'AM and PM', 1, 6, 1, 8, 87, '2016-06-03 04:18:18', '2016-06-03 05:42:29', 0),
(734, 'xUxMbCmPfM', 'Meridians or Longitudes', 'Meridians or Longitudes', 1, 7, 1, 8, 87, '2016-06-03 04:18:27', '2016-06-03 05:42:29', 0),
(735, 'hsMbY8SYN3', 'Latitudes', 'Latitudes', 1, 8, 1, 8, 87, '2016-06-03 04:18:37', '2016-06-03 05:42:29', 0),
(736, 'DeINkHhjTH', 'Time Zone Chart', 'Time Zone Chart', 1, 9, 1, 8, 87, '2016-06-03 04:18:49', '2016-06-03 05:42:29', 0),
(737, '9cjkuiCITh', 'Earth as Sphere and Its Result', 'Earth as Sphere and Its Result', 1, 10, 1, 8, 87, '2016-06-03 04:18:59', '2016-06-03 05:42:29', 0),
(738, 'iqtGM5vW93', 'The Earth Tilted on Its Axis', 'The Earth Tilted on Its Axis', 1, 11, 1, 8, 87, '2016-06-03 04:20:27', '2016-06-03 05:42:29', 0),
(739, 'mX44YtDz3q', 'Winter, Spring, Summer, Autumn', 'Winter, Spring, Summer, Autumn', 1, 12, 1, 8, 87, '2016-06-03 04:20:42', '2016-06-03 05:42:29', 0),
(740, 'BhZ4WcPMCA', 'Arctic, Antarctic', 'Arctic, Antarctic', 1, 13, 1, 8, 87, '2016-06-03 04:20:51', '2016-06-03 05:42:29', 0),
(741, 'GWtJ8wpQ1B', 'Equinoxes', 'Equinoxes', 1, 14, 1, 8, 87, '2016-06-03 04:21:04', '2016-06-03 05:42:29', 0),
(742, 'CrE9fvtajK', 'Tropic of Cancer and Tropic of Capricorn', 'Tropic of Cancer and Tropic of Capricorn', 1, 15, 1, 8, 87, '2016-06-03 04:21:13', '2016-06-03 05:42:29', 0),
(743, 'Hk2o5suAOp', 'Dates of the Solstices and the Equinoxes', 'Dates of the Solstices and the Equinoxes', 1, 16, 1, 8, 87, '2016-06-03 04:21:21', '2016-06-03 05:42:29', 0),
(744, '2bf7ZLwz5h', 'Zone Charts and Work Charts', 'Zone Charts and Work Charts', 1, 17, 1, 8, 87, '2016-06-03 04:21:33', '2016-06-03 05:42:29', 0),
(745, '8qe1kOjHEO', 'Protractor Chart', 'Protractor Chart', 1, 18, 1, 8, 87, '2016-06-03 04:21:48', '2016-06-03 05:42:29', 0),
(746, 'g0QGRB4l1g', 'Seasons Work Chart', 'Seasons Work Chart', 1, 19, 1, 8, 87, '2016-06-03 04:21:55', '2016-06-03 05:42:29', 0),
(747, 'kqbsLxy16s', 'Two Kinds of Heat', 'Two Kinds of Heat', 1, 20, 1, 8, 87, '2016-06-03 04:22:10', '2016-06-03 05:42:29', 0),
(748, 'husIuerqN5', 'Rains', 'Rains', 1, 21, 1, 8, 87, '2016-06-03 04:22:19', '2016-06-03 05:42:29', 0),
(749, 'JtmgMebYAr', 'Prelude to the Winds', 'Prelude to the Winds', 1, 0, 1, 8, 107, '2016-06-03 04:23:51', '2016-06-03 04:23:51', 0),
(750, 'fHXU4dFQHm', 'Winds', 'Winds', 1, 1, 1, 8, 107, '2016-06-03 04:24:17', '2016-06-03 05:44:08', 0),
(751, 'IU9DLDPlzk', 'The River', 'The River', 1, 0, 1, 8, 85, '2016-06-03 04:26:26', '2016-06-03 05:45:02', 0),
(752, '9SH72z4ji2', 'Erosion', 'Erosion', 1, 1, 1, 8, 85, '2016-06-03 04:26:35', '2016-06-03 05:45:02', 0),
(753, '4RIt4WecPR', 'Earth Pillar', 'Earth Pillar', 1, 2, 1, 8, 85, '2016-06-03 04:26:50', '2016-06-03 05:44:59', 0),
(754, 'RIqMK65yPn', 'Ocean Waves', 'Ocean Waves', 1, 3, 1, 8, 85, '2016-06-03 04:27:05', '2016-06-03 05:44:59', 0),
(755, 'va822yy8G7', 'Glaciers', 'Glaciers', 1, 4, 1, 8, 85, '2016-06-03 04:27:09', '2016-06-03 05:44:59', 0),
(756, 'ZqEHlOl6rb', 'Water Cycle', 'Water Cycle', 1, 5, 1, 8, 85, '2016-06-03 04:27:20', '2016-06-03 05:44:59', 0),
(757, 'ohSkhxXSoz', 'Spread of Vegetation', 'Spread of Vegetation', 1, 6, 1, 8, 85, '2016-06-03 04:27:29', '2016-06-03 05:44:59', 0),
(758, 'kzKd19XLYP', 'Interdependencies: Intro', 'Interdependencies: Intro', 1, 0, 1, 8, 84, '2016-06-03 04:29:18', '2016-06-03 05:45:31', 0),
(759, '0BMJyk9cBe', 'Economic Geography', 'Economic Geography', 1, 1, 1, 8, 84, '2016-06-03 04:29:24', '2016-06-03 05:45:31', 0),
(760, 'gALH4staYq', 'Study of Consumption', 'Study of Consumption', 1, 2, 1, 8, 84, '2016-06-03 04:29:34', '2016-06-03 04:31:36', 0),
(761, 'xC71s9Izpq', 'Comparison of Consumption and Production', 'Comparison of Consumption and Production', 1, 3, 1, 8, 84, '2016-06-03 04:29:51', '2016-06-03 04:31:36', 0),
(762, 'WsRvVRDNIg', 'Volume of Trade', 'Volume of Trade', 1, 5, 1, 8, 84, '2016-06-03 04:30:04', '2016-06-03 04:31:37', 0),
(763, 'frosZk5PoE', 'Story of Interrelation', 'Story of Interrelation', 1, 6, 1, 8, 84, '2016-06-03 04:30:14', '2016-06-03 04:31:37', 0),
(764, '6Ilmh9hMXZ', 'Geography Nomenclature', 'Geography Nomenclature', 1, 7, 1, 8, 84, '2016-06-03 04:30:24', '2016-06-03 04:31:37', 0),
(765, 'FDxPo9aTtb', 'Imports and Exports', 'Imports and Exports', 1, 4, 1, 8, 84, '2016-06-03 04:30:37', '2016-06-03 04:31:37', 0),
(766, '6yAXa8RLFd', 'Congruency', 'Conguency', 1, 0, 1, 6, 51, '2016-06-03 06:06:48', '2016-06-21 22:18:03', 0),
(767, 'jiMEITwyZg', 'Similarity', 'Similarity', 1, 1, 1, 6, 51, '2016-06-03 06:07:03', '2016-06-03 06:24:22', 0),
(768, 'qNbqUyYqwe', 'Equivalence: concept and name', 'Equivalence: concept and name', 1, 0, 1, 6, 37, '2016-06-03 06:08:00', '2016-06-03 06:08:00', 0),
(769, 'sTzHGKo0Z2', 'Classified nomenclature', 'Classified nomenclature', 1, 3, 1, 6, 113, '2016-06-03 06:10:43', '2016-06-03 06:24:59', 0),
(770, 'uNVgMG0RU8', 'Polygons: concept and name', 'Polygons: concept and name', 1, 0, 1, 6, 113, '2016-06-03 06:10:53', '2016-06-03 06:24:53', 0),
(771, 'd7LkCv9oA6', 'Triangle as the constructor', 'Triangle as the constructor', 1, 1, 1, 6, 113, '2016-06-03 06:10:58', '2016-06-03 06:24:56', 0),
(772, 'eihziePBKE', 'Enclosed space with a curved line', 'Enclosed space with a curved line', 1, 2, 1, 6, 113, '2016-06-03 06:11:14', '2016-06-03 06:24:59', 0),
(773, 'ZGUuqYK6kn', 'Angles: concept and kinds', 'Angles: concept and kinds', 1, 0, 1, 6, 94, '2016-06-03 06:13:30', '2016-06-03 06:25:35', 0),
(774, 'oC3m8q4L2b', 'Classify triangles by angles', 'Classify triangles by angles', 1, 1, 1, 6, 94, '2016-06-03 06:13:37', '2016-06-03 06:25:35', 0),
(775, '7Kaib5Q9vm', 'Classify triangles by sides', 'Classify triangles by sides ', 1, 2, 1, 6, 94, '2016-06-03 06:13:53', '2016-06-03 06:25:33', 0),
(776, 'SFdMGzq6SF', 'Triangles: angles and sides', 'Triangles: angles and sides', 1, 3, 1, 6, 94, '2016-06-03 06:14:00', '2016-06-03 06:25:33', 0),
(777, 'sBfRLy187N', 'Bisect angles', 'Bisect angles', 1, 4, 1, 6, 94, '2016-06-03 06:14:09', '2016-06-03 06:25:33', 0),
(778, '14QM7kAo19', 'Relation of angles formed by parallel lines and a transversal', 'Relation of angles formed by parallel lines and a transversal', 1, 5, 1, 6, 94, '2016-06-03 06:14:17', '2016-06-03 06:25:33', 0),
(779, 'fpR3YqHGiA', 'Size relationships of corresponding and alternate angles', 'Size relationships of corresponding and alternate angles', 1, 6, 1, 6, 94, '2016-06-03 06:14:27', '2016-06-03 06:25:33', 0),
(780, 'NGijqmpjsF', 'Position of two lines', 'Position of two lines', 1, 3, 1, 6, 105, '2016-06-03 06:15:34', '2016-06-03 06:26:02', 0),
(781, 'uknJFtGwjn', 'Parts of a straight line', 'Parts of a straight line', 1, 1, 1, 6, 105, '2016-06-03 06:15:41', '2016-06-03 06:25:59', 0),
(782, 'AFzfM8QJjY', 'Kinds of lines', 'Kinds of lines', 1, 0, 1, 6, 105, '2016-06-03 06:15:47', '2016-06-03 06:25:55', 0),
(783, 'KN1OWIZaEZ', 'Introductory Story', 'Introductory Story', 1, 0, 1, 6, 54, '2016-06-03 06:17:06', '2016-06-03 06:17:06', 0),
(785, '2IBWWs2PP4', 'Second plate', 'Second plate', 1, 3, 1, 6, 54, '2016-06-03 06:17:14', '2016-06-03 06:26:19', 0),
(786, 'VzcrE4Lf0D', 'Follow-up work', 'Follow-up work', 1, 4, 1, 6, 54, '2016-06-03 06:17:19', '2016-06-03 06:26:19', 0),
(787, '9ZAJcN3UFu', 'Constructive triangles', 'Constructive triangles', 1, 5, 1, 6, 54, '2016-06-03 06:17:27', '2016-06-03 06:26:19', 0),
(788, 'r5bUHgXR0L', 'Finding arithmetic value', 'Finding arithmetic value', 1, 6, 1, 6, 54, '2016-06-03 06:17:35', '2016-06-03 06:26:19', 0),
(789, 'qNAE6YkWhD', 'Finding fractional value', 'Finding fractional value', 1, 7, 1, 6, 54, '2016-06-03 06:17:42', '2016-06-03 06:26:20', 0),
(790, 'uYCw74mHAN', 'Euclidian Plate', 'Euclidian Plate', 1, 0, 1, 6, 111, '2016-06-03 06:19:08', '2016-06-03 06:19:08', 0),
(791, 'okSkAE0AwV', 'Parts of a triangle', 'Parts of a triangle', 1, 1, 1, 6, 102, '2016-06-03 06:20:08', '2016-06-03 06:26:55', 0),
(792, 'rgQTxDNDTi', 'Parts of a trapezoid', 'Parts of a trapezoid', 1, 3, 1, 6, 102, '2016-06-03 06:20:19', '2016-06-03 06:27:02', 0),
(793, 'IqmSpARkgg', 'How to find the center of a figure', 'How to find the center of a figure', 1, 4, 1, 6, 102, '2016-06-03 06:20:26', '2016-06-03 06:27:03', 0),
(794, '82hSA6ZSjL', 'Parts of a rhombus', 'Parts of a rhombus', 1, 2, 1, 6, 102, '2016-06-03 06:20:31', '2016-06-03 06:27:02', 0),
(795, 'BzrPyAB0Ml', 'Sum of angles in a triangle', 'Sum of angles in a triangle', 1, 0, 1, 6, 114, '2016-06-03 06:21:17', '2016-06-03 07:05:09', 0),
(796, 'bUJjF3Wbcl', 'Sum of angles in a quadrilateral', 'Sum of angles in a quadrilateral', 1, 1, 1, 6, 114, '2016-06-03 06:21:24', '2016-06-03 07:05:12', 0),
(797, 'IIBfJ3bOhe', 'Sum of angles in a trapezoid', 'Sum of angles in a trapezoid', 1, 2, 1, 6, 114, '2016-06-03 06:21:33', '2016-06-03 07:05:12', 0),
(798, '5tn2rGirHU', 'Stage One: (sensorial)', 'Stage One: (sensorial)', 1, 0, 1, 6, 57, '2016-06-03 06:22:08', '2016-06-03 06:22:08', 0),
(799, 'Ee8JAVFtEA', 'Stage Two: (making child conscious)', 'Stage Two: (making child conscious)', 1, 33, 1, 6, 57, '2016-06-13 04:10:53', '2016-06-13 04:10:53', 0),
(800, '8QN5ZWmu8W', 'Trapezoid and Rectangle', 'Trapezoid and Rectangle', 1, 34, 1, 6, 57, '2016-06-13 04:11:36', '2016-06-13 04:11:36', 0),
(801, 'HbYrpSzCtv', 'Stage One: decagons', 'Stage One: decagons', 1, 35, 1, 6, 57, '2016-06-13 04:12:37', '2016-06-13 04:12:37', 0),
(802, 'wqYchJgiZS', 'Stage Two: decagons', 'Stage Two: decagons', 1, 36, 1, 6, 57, '2016-06-13 04:17:48', '2016-06-13 04:17:48', 0),
(803, 'ZNdzn2Cu1U', 'Yellow material: concept', 'Yellow material: concept', 1, 37, 1, 6, 99, '2016-06-13 04:29:56', '2016-06-13 04:29:56', 0),
(804, 'juL9gw8fxy', 'C Rectangle', 'Rectangle', 1, 38, 1, 6, 99, '2016-06-13 04:30:03', '2016-06-22 16:10:36', 0),
(805, 'HrpGCwdmvN', 'Acute angled triangle', 'Acute angled triangle', 1, 39, 1, 6, 99, '2016-06-13 04:30:09', '2016-06-13 04:30:09', 0),
(806, 'R3Z3RqFRoJ', 'Right angle triangle', 'Right angle triangle', 1, 40, 1, 6, 99, '2016-06-13 04:30:15', '2016-06-13 04:30:15', 0),
(807, '7WnyV0NXaY', 'Obtuse angle triangle', 'Obtuse angle triangle', 1, 41, 1, 6, 99, '2016-06-13 04:30:28', '2016-06-13 04:30:28', 0),
(808, 'K7c8LwXBPY', 'Yellow material: deriving formula', 'Yellow material: deriving formula', 1, 42, 1, 6, 99, '2016-06-13 04:30:35', '2016-06-13 04:30:35', 0),
(809, 'AHlPchi2nM', 'F Rectangle', 'Rectangle', 1, 43, 1, 6, 99, '2016-06-13 04:30:42', '2016-06-22 16:10:55', 0),
(810, 'TUJfvPW559', 'Acute angle triangle', 'Acute angle triangle', 1, 44, 1, 6, 99, '2016-06-13 04:30:48', '2016-06-13 04:30:48', 0),
(811, '7KSQovpVvx', 'Right angle triangle', 'Right angle triangle', 1, 45, 1, 6, 99, '2016-06-13 04:30:57', '2016-06-13 04:30:57', 0),
(812, 'Yx0DYn1Z9y', 'Obtuse angle triangle', 'Obtuse angle triangle', 1, 46, 1, 6, 99, '2016-06-13 04:31:04', '2016-06-13 04:31:04', 0),
(813, '4gp09qkNMi', 'Rhombus', 'Rhombus', 1, 0, 1, 6, 55, '2016-06-13 05:06:52', '2016-06-13 05:09:35', 0),
(814, 'Bt2KkjcLX6', 'Trapezoid', 'Trapezoid', 1, 1, 1, 6, 55, '2016-06-13 05:07:02', '2016-06-13 05:09:35', 0),
(815, 'WY4wkQY22T', 'Nomenclature of a Circle', 'Nomenclature of a Circle', 1, 0, 1, 6, 64, '2016-06-13 05:15:30', '2016-06-13 05:17:50', 0),
(817, '554xtsqX3E', 'Relationship of line to circumference', 'Relationship of line to circumference', 1, 2, 1, 6, 64, '2016-06-13 05:15:41', '2016-06-13 05:17:51', 0),
(818, 'LbF2etWwHi', 'Relationship between the center of a circle and these lines', 'Relationship between the center of a circle and these lines', 1, 3, 1, 6, 64, '2016-06-13 05:15:46', '2016-06-13 05:17:51', 0),
(819, 'mHbzdPygSi', 'Relationship between circumference', 'Relationship between circumference', 1, 4, 1, 6, 64, '2016-06-13 05:15:52', '2016-06-13 05:17:51', 0),
(820, 'fdY5BqWryV', 'Miscellaneous terms', 'Miscellaneous terms', 1, 5, 1, 6, 64, '2016-06-13 05:15:56', '2016-06-13 05:17:51', 0),
(821, 'CMfomI2NAE', 'Area of a Circle', 'Area of a Circle', 1, 7, 1, 6, 64, '2016-06-13 05:16:00', '2016-06-13 05:17:51', 0),
(822, '6gdpWyIEKr', 'Circle as a special polygon', 'Circle as a special polygon ', 1, 8, 1, 6, 64, '2016-06-13 05:16:05', '2016-06-13 05:17:51', 0),
(823, 'tJURmXfIzJ', 'Measuring for a circle finding pi', 'Measuring for a circle finding ?', 1, 9, 1, 6, 64, '2016-06-13 05:16:11', '2016-06-22 19:53:36', 0),
(824, 'BlI7jwBYWR', 'Formula for area of a circle', 'Formula for area of a circle', 1, 10, 1, 6, 64, '2016-06-13 05:16:18', '2016-06-13 05:17:51', 0),
(825, '2NzaNdZvQm', 'Relation between the apothem and the side of a plane figure', 'Relation between the apothem and the side of a plane figure', 1, 11, 1, 6, 64, '2016-06-13 05:16:22', '2016-06-13 05:17:51', 0),
(826, 'KXghxlRpmr', 'Equivalence as it is related to solid figures', 'Equivalence as it is related to solid figures', 1, 47, 1, 6, 89, '2016-06-13 05:20:21', '2016-06-13 05:20:21', 0),
(827, 's3oqnk7ddV', 'Three important dimensions', 'Three important dimensions', 1, 48, 1, 6, 89, '2016-06-13 05:20:27', '2016-06-13 05:20:27', 0),
(828, 'X22UXCwRDP', 'Equivalence between the prism with various bases', 'Equivalence between the prism with various bases', 1, 49, 1, 6, 89, '2016-06-13 05:20:35', '2016-06-13 05:20:35', 0),
(829, 'hVBZfJy8ST', 'Derivation of the formula for volume', 'Derivation of the formula for volume', 1, 50, 1, 6, 89, '2016-06-13 05:20:43', '2016-06-13 05:20:43', 0),
(830, 'DODankf8Zt', 'Solids of rotation', 'Solids of rotation', 1, 51, 1, 6, 89, '2016-06-13 05:20:58', '2016-06-13 05:20:58', 0),
(831, 'TYH0L2l3bK', 'Volume of the pyramid', 'Volume of the pyramid', 1, 52, 1, 6, 89, '2016-06-13 05:21:10', '2016-06-13 05:21:10', 0),
(832, 'hZPFtqlo7V', 'Concept', 'Concept', 1, 53, 1, 6, 44, '2016-06-13 05:28:55', '2016-06-13 05:28:55', 0),
(833, 'L2H4YPiLay', 'Nomenclature', 'Nomenclature', 1, 54, 1, 6, 44, '2016-06-13 05:28:59', '2016-06-13 05:28:59', 0),
(834, 'pC6Vw2bx7Z', 'Lateral and total area of solids', 'Lateral and total area of solids', 1, 55, 1, 6, 44, '2016-06-13 05:29:06', '2016-06-13 05:29:06', 0),
(835, 'S3D9DdABCx', 'Simple Sentences with Extensions', 'Simple Sentences with Extensions', 1, 1, 1, 7, 36, '2016-06-13 05:46:33', '2016-06-13 05:46:43', 0),
(836, 'WPDIHL7dSP', 'Sensorial introduction', 'Sensorial introduction', 1, 56, 1, 11, 76, '2016-06-13 06:08:00', '2016-06-13 06:08:00', 0),
(837, 'pZu6dqNHoF', 'Naming and notation of tone bars', 'Naming and notation of tone bars', 1, 57, 1, 11, 76, '2016-06-13 06:08:06', '2016-06-13 06:08:06', 0),
(838, 'TB0OMkCZaS', 'Degrees of the scale', 'Degrees of the scale', 1, 58, 1, 11, 76, '2016-06-13 06:08:12', '2016-06-13 06:08:12', 0),
(839, 'g6warCdqKo', 'Intervals', 'Intervals', 1, 59, 1, 11, 76, '2016-06-13 06:08:24', '2016-06-13 06:08:24', 0),
(840, 'y6WjXL0Igt', 'Sequence of major scales- sharps', 'Sequence of major scales- sharps', 1, 60, 1, 11, 76, '2016-06-13 06:08:32', '2016-06-13 06:08:32', 0),
(841, '3DsObneTDr', 'Sequence of minor scales- flats', 'Sequence of minor scales- flats', 1, 61, 1, 11, 76, '2016-06-13 06:08:40', '2016-06-13 06:08:40', 0),
(842, 'Q0Ifv9Hhg8', 'Key signature', 'Key signature', 1, 62, 1, 11, 76, '2016-06-13 06:08:49', '2016-06-13 06:08:49', 0),
(843, 'NaNF5zws69', 'Transposition of simple songs', 'Transposition of simple songs', 1, 63, 1, 11, 76, '2016-06-13 06:08:59', '2016-06-13 06:08:59', 0),
(844, 'p6i9vQrgXY', 'Introduction to minor scales', 'Introduction to minor scales', 1, 64, 1, 11, 76, '2016-06-13 06:09:05', '2016-06-13 06:09:05', 0),
(845, 'trXmB4OahZ', 'Fr. Large Numbers, Lg Numbers, Mixed Numbers', 'Fr. Large Numbers, Lg Numbers, Mixed Numbers', 1, 7, 1, 10, 92, '2016-06-13 07:05:30', '2016-06-13 07:05:46', 0),
(846, 'bzl4Y293wT', 'Making Cocoa', '', 1, 8, 1, 3, 9, '2016-06-13 09:04:07', '2016-06-13 09:04:29', 0),
(847, 'Slql8m7rIx', 'Using the Toaster', '', 1, 9, 1, 3, 9, '2016-06-13 09:04:15', '2016-06-13 09:04:29', 0),
(848, '1TKss7voIc', 'Phonogram Spelling', 'PHONOGRAM SPELLING', 1, 12, 1, 1, 20, '2016-06-13 09:55:54', '2016-06-13 09:56:40', 0),
(849, 'HQumXeKCcO', 'Feeding Pets', 'Feeding Pets', 1, 18, 1, 3, 25, '2016-06-13 11:13:24', '2016-06-13 11:13:45', 0),
(850, 'nBgesBuHQk', 'Visit another Class', 'Visit another Class', 1, 24, 1, 3, 17, '2016-06-13 11:16:46', '2016-06-13 11:17:03', 0);

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE IF NOT EXISTS `notes` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `timestamp` int(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `description`, `status`, `user_id`, `created`, `modified`, `timestamp`) VALUES
(4, 'test again', '', 1, 1, '2015-12-11 05:10:58', '2015-12-15 10:41:11', 0),
(17, 'rwerwe', 'rwerwe', 1, 10, '2015-12-11 13:36:44', '2015-12-11 13:36:44', 1449840966),
(18, 'ewffgfsdfdfgdgfssffg', 'ewffgfsdfdfgdgfssffg', 1, 10, '2015-12-11 13:36:57', '2015-12-11 13:36:57', 1449840979),
(19, 'gtghhghhhh\nddssdsdds\n\nwqdwddwqdqw\n\n\n\ndwdwddwq', 'gtghhghhhh\nddssdsdds\n\nwqdwddwqdqw\n\n\n\ndwdwddwq', 1, 3, '2016-01-22 12:49:17', '2016-01-22 12:52:47', 1453466957),
(32, 'TEst Add Note ', 'Hello !23 , testing uyai agf a fahd fad fgad fh ad fhga df agdf ad f ad fgad fgadf a dfgadfkgakdg fa dgf adgjkdf ad fag dfgajdak dfk adgkf agfkad gfkadgf ag dfgadjkdfgadkfg adkgf akdgf kadgkf agdf kgad fadgf kad fgka dfga fkagjkf d agk kfja gkdfkadfdsfsdfsdfgsgsfg dfgfgdfgdfg, fq ydfq fdyq ge ieqwig rfewfw', 1, 14, '2016-03-03 05:25:57', '2016-03-03 06:24:10', 1456986250),
(35, 'TEst Note 1', 'ghagfh a gaf aga df  gafh ahf adf gf ahf dgf  ahf ahd fhd fg ads f adgf ah f ah fa hfagdf hadgf a df hfa gf af agd fa  gadhf f a hagf h adfgadhf adfg adghf ald f adf g afadfadf', 1, 14, '2016-03-03 10:05:12', '2016-03-03 10:05:12', 1456999512),
(47, 'Title View', 'Hi this is a title view for montessori notes and this is gHi this is a Hi this is a title view for montessori notes and this is g view for montessori notes and this is gHi Hi this is a title view for montessori notes and this is g is a title view for montessori notes and this is gHi this Hi this is a title view for montessori notes and this is g a title view for montessori notes and this is gHi this is Hi this is a title view for montessori notes and this is g title view for montessori notes and this is gHi this Hi this is a title view for montessori notes and this is g a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for Hi this is a title view for montessori notes and this is g notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gHi this is a title view for montessori notes and this is gnxdnnxnddnndndndndnndndnndnd jxjdjjdjdjjd nsjdjjdjdjdjdj xjdjdjjdndndn  xjdnnddd', 1, 12, '2016-03-04 09:19:17', '2016-04-01 12:02:02', 1459512121),
(48, 'Title', 'sdkj sdjklds sdlvk svilsv fi dfviuf voifvn fnkv dfiv ilfaduvhidguoifsd', 1, 13, '2016-03-04 10:06:36', '2016-03-04 10:06:36', 1457085996),
(49, 'uu', 'rthsjryyrjurwyjwryujyrwur', 1, 14, '2016-03-07 04:49:53', '2016-03-07 04:49:53', 1457326193),
(50, 'jjj', 'yuwr6uwurjfnfjmsrjyj', 1, 14, '2016-03-07 04:50:06', '2016-03-07 04:50:06', 1457326206),
(51, 'fshjfhj', 'hfjjhsfhjfhjfhj', 1, 14, '2016-03-07 04:50:13', '2016-03-07 04:50:13', 1457326213),
(52, 'fshjfhj', 'hfjjhsfhjfhjfhj', 1, 14, '2016-03-07 04:50:13', '2016-03-07 04:50:13', 1457326213),
(53, 'hjhj', 'hjfshjfsjhfj', 1, 14, '2016-03-07 04:50:25', '2016-03-07 04:50:25', 1457326225),
(54, 'hjhj', 'hjfshjfsjhfj', 1, 14, '2016-03-07 04:50:25', '2016-03-07 04:50:25', 1457326225),
(55, 'hfjfhsjfhjsfhj', 'hfjfhjfhjfhjf', 1, 14, '2016-03-07 04:50:36', '2016-03-07 04:50:36', 1457326236),
(56, 'hfjhfjfhj', 'hfjfhjfhsjfhj', 1, 14, '2016-03-07 04:50:44', '2016-03-07 04:50:44', 1457326244),
(57, 'mshmhmsfh', 'mhsmsfhmsfhmh', 1, 14, '2016-03-07 04:50:57', '2016-03-07 04:50:57', 1457326257),
(58, 'mshmhmsfh', 'mhsmsfhmsfhmh', 1, 14, '2016-03-07 04:50:57', '2016-03-07 04:50:57', 1457326257),
(59, 'fhmhfm', 'fhmsfhmsfhm', 1, 14, '2016-03-07 04:51:20', '2016-03-07 04:51:20', 1457326280),
(60, 'GSFGSFG', 'sfgvsfbsG', 1, 14, '2016-03-07 05:27:47', '2016-03-07 05:27:47', 1457328467),
(61, 'SFGFSG', 'FGfsgfsg', 1, 14, '2016-03-07 05:27:52', '2016-03-07 05:27:52', 1457328472),
(62, 'FGFSG', 'FSGSFGSFGSFGSFGSFGSFG', 1, 14, '2016-03-07 05:27:58', '2016-03-07 05:27:58', 1457328478),
(63, 'FGFSG', 'SFGAFGSFGFSGSFBVSFBVS FBFBFASBBFGBFB', 1, 14, '2016-03-07 05:28:06', '2016-03-07 05:28:06', 1457328486),
(64, 'FG', 'FSGFSGFSGFS', 1, 14, '2016-03-07 05:28:12', '2016-03-07 05:28:12', 1457328491),
(65, 'FGFGFG', 'FGSFAGB FB\nFSF\nG\n\n\nFGFGFGFG', 1, 14, '2016-03-07 05:28:20', '2016-03-07 05:28:20', 1457328500),
(66, 'FG', 'FGFGG', 1, 14, '2016-03-07 05:28:24', '2016-03-07 05:28:24', 1457328504),
(67, 'Jeje', 'Hehjejr', 1, 14, '2016-03-07 07:36:38', '2016-03-07 07:36:38', 1457336198),
(68, 'This could be a big title', 'My descrition goes on here', 1, 7, '2016-03-07 07:39:31', '2016-03-07 07:39:31', 1457336370),
(69, 'Disabled', 'this is a test dsibale test', 1, 12, '2016-03-18 06:32:08', '2016-03-18 06:32:08', 1458282728),
(70, 'Note', 'Testing', 1, 23, '2016-04-27 04:24:18', '2016-04-27 04:24:18', 1461731058),
(78, 'TEsting Notes Scenario', 'Hi kjldhs a sd asdhas lahfd d fhk lhflkdsfklhdf l', 1, 25, '2016-05-20 06:30:50', '2016-05-20 06:30:50', 1463725850),
(81, 'Help', 'Remembdont forget to add lessonshelp ', 1, 20, '2016-06-17 13:18:57', '2016-06-17 13:18:57', 1466169536),
(87, 'This is to notigy the new job', 'This is to notigy the new job', 1, 26, '2016-06-20 05:54:52', '2016-06-20 05:54:52', 1466402092),
(88, 'This to notify that ', 'This to notify that this ', 1, 26, '2016-06-20 05:59:05', '2016-06-20 05:59:05', 1466402344),
(89, 'This is wat we called a udta punjab ho ho ho udta ', 'This is wat we called a udta punjab ho ho ho udta punjab ', 1, 26, '2016-06-20 06:02:27', '2016-06-20 06:02:27', 1466402547),
(90, 'jxjd dhd', 'jxjd dhdhd xdhd dhdjd xhdj', 1, 35, '2016-06-20 06:12:45', '2016-06-20 06:12:59', 1466403179),
(93, 'firstnote to see how this', 'firstnote to see how this works', 1, 29, '2016-06-24 01:52:19', '2016-06-24 01:52:26', 1466733146),
(94, 'Loren ipsum test loren ipsum', 'Loren ipsum test loren ipsum dummy text loren ipsm loren ipsum loren ipsum loren ipsum loren ipsum loren ipsum', 1, 66, '2016-07-11 05:15:50', '2016-07-11 05:15:50', 1468214150),
(95, 'Hello', 'dsfadfs s df s fasd fasdfa sdfasdfasdf sadfasdfasdfa sdfsdf sdfsfsdmer eo hdjluk du ins hj l a hf nklpor bn i hoisghkjh hj hj hj hj hj jh kh jkjhhj hj  j    hjh gh hfghjf ghj fghjfghjfg g jghjgf fg gh g hfg g ghjfghj fghj ghjf ghj gh ghjf ghj fghjgfhjgh  ghjgfhj fghghjgf ghjgjgj ghjghfgh fgh jgfhjghj fgh ghjgj gf ghjg ghjfghj fhjfh fghjgj fghjfghjfg gfhjghjghj fghjfghj fghj fghj fghjf ghjfghjfghjf ghjghj ghjg ghjghjghgh', 1, 66, '2016-07-19 11:12:42', '2016-07-19 11:13:45', 1468926825);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `txn_id` varchar(255) NOT NULL,
  `payment_gross` double(10,2) NOT NULL,
  `currency_code` varchar(5) NOT NULL,
  `payment_status` int(11) NOT NULL DEFAULT '0',
  `payment_data` text,
  `platform` varchar(50) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `user_id`, `product_id`, `txn_id`, `payment_gross`, `currency_code`, `payment_status`, `payment_data`, `platform`, `created`, `modified`) VALUES
(1, 1, 1, '', 0.00, '', 0, NULL, NULL, '2016-07-04 07:36:38', '2016-07-04 09:21:37'),
(2, 2, 2, '', 111.00, 'USD', 0, NULL, NULL, '2016-07-04 08:00:18', '2016-07-04 08:00:18'),
(3, 41, 1, '', 0.00, '', 0, NULL, NULL, '2016-07-04 09:41:16', '2016-07-04 10:32:43'),
(4, 42, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-04 10:50:25', '2016-07-04 10:50:25'),
(5, 43, 3, '8BU95792BR364913A', 39.90, 'USD', 1, NULL, NULL, '2016-07-04 10:54:46', '2016-07-04 10:59:31'),
(6, 44, 3, '6FA04683C44621429', 39.90, 'USD', 1, NULL, NULL, '2016-07-04 11:04:34', '2016-07-04 11:05:25'),
(7, 45, 3, '3RX163207V660622T', 39.90, 'USD', 1, NULL, NULL, '2016-07-04 11:53:46', '2016-07-04 11:54:35'),
(8, 47, 2, '', 3.99, 'USD', 0, NULL, NULL, '2016-07-04 12:58:39', '2016-07-04 12:58:39'),
(9, 48, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-04 13:21:08', '2016-07-04 13:21:08'),
(10, 49, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-05 04:09:51', '2016-07-05 04:30:51'),
(11, 49, 2, '', 39.90, 'USD', 0, '', NULL, '2016-07-05 04:31:59', '2016-07-05 04:45:19'),
(12, 50, 2, '3DN76577YT707015D', 3.99, 'USD', 1, 'YTo4OntzOjY6InR4bl9pZCI7czoxNzoiM0RONzY1NzdZVDcwNzAxNUQiO3M6MTQ6InBheW1lbnRfc3RhdHVzIjtzOjk6IkNvbXBsZXRlZCI7czoxMzoicGF5bWVudF9ncm9zcyI7czo0OiIzLjk5IjtzOjExOiJtY19jdXJyZW5jeSI7czozOiJVU0QiO3M6NjoiY3VzdG9tIjtzOjE2OiJOVEIwYkhSaGJXOXVkSGs9IjtzOjExOiJpdGVtX251bWJlciI7czoxOiIyIjtzOjM6InNpZyI7czoxNzI6ImdERW85N1VGaWM4MzZoK1daZ1pzWVYzV29GVXJvWUYzdUZ1clc2YUUwUXhMOGZxQUkvWlZZWnZQM3FDNC9laHQzVlR3dDZoQmxxZlNyQm1nT2xISXM5RHVUVzBhckF4Skd0ZlVhc241UmNWMmlVUlg5N1gva2ZvV2FHb3lWSERnR09aTUphU2pCaDlITnVZWkd5TDd2ZmFtTDFqKzR0YUs0VjRCbUhUelZybz0iO3M6MzoiR0VUIjthOjc6e3M6MjoidHgiO3M6MTc6IjNETjc2NTc3WVQ3MDcwMTVEIjtzOjI6InN0IjtzOjk6IkNvbXBsZXRlZCI7czozOiJhbXQiO3M6NDoiMy45OSI7czoyOiJjYyI7czozOiJVU0QiO3M6MjoiY20iO3M6MTY6Ik5UQjBiSFJoYlc5dWRIaz0iO3M6MTE6Iml0ZW1fbnVtYmVyIjtzOjE6IjIiO3M6Mzoic2lnIjtzOjE3MjoiZ0RFbzk3VUZpYzgzNmgrV1pnWnNZVjNXb0ZVcm9ZRjN1RnVyVzZhRTBReEw4ZnFBSS9aVlladlAzcUM0L2VodDNWVHd0NmhCbHFmU3JCbWdPbEhJczlEdVRXMGFyQXhKR3RmVWFzbjVSY1YyaVVSWDk3WC9rZm9XYUdveVZIRGdHT1pNSmFTakJoOUhOdVlaR3lMN3ZmYW1MMWorNHRhSzRWNEJtSFR6VnJvPSI7fX0=', NULL, '2016-07-05 04:48:50', '2016-07-05 10:08:19'),
(13, 51, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-05 06:24:20', '2016-07-05 06:24:20'),
(14, 52, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-05 06:33:19', '2016-07-05 06:34:57'),
(15, 53, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-05 06:44:48', '2016-07-05 06:46:41'),
(16, 54, 3, '80J0783866024320P', 39.90, 'USD', 1, 'YTo0Mzp7czo4OiJtY19ncm9zcyI7czo1OiIzOS45MCI7czoyMjoicHJvdGVjdGlvbl9lbGlnaWJpbGl0eSI7czo4OiJFbGlnaWJsZSI7czoxNDoiYWRkcmVzc19zdGF0dXMiO3M6MTE6InVuY29uZmlybWVkIjtzOjg6InBheWVyX2lkIjtzOjEzOiI2UEhTSzlYS0dXVkdRIjtzOjM6InRheCI7czo0OiIwLjAwIjtzOjE0OiJhZGRyZXNzX3N0cmVldCI7czo2NzoiRmxhdCBuby4gNTA3IFdpbmcgQSBSYWhlamEgUmVzaWRlbmN5DQpGaWxtIENpdHkgUm9hZCwgR29yZWdhb24gRWFzdCI7czoxMjoicGF5bWVudF9kYXRlIjtzOjI1OiIwMDoxNDoyNiBKdWwgMDUsIDIwMTYgUERUIjtzOjE0OiJwYXltZW50X3N0YXR1cyI7czo5OiJDb21wbGV0ZWQiO3M6NzoiY2hhcnNldCI7czoxMjoid2luZG93cy0xMjUyIjtzOjExOiJhZGRyZXNzX3ppcCI7czo2OiI0MDAwOTciO3M6MTA6ImZpcnN0X25hbWUiO3M6NToiUGF3YW4iO3M6NjoibWNfZmVlIjtzOjQ6IjEuODYiO3M6MjA6ImFkZHJlc3NfY291bnRyeV9jb2RlIjtzOjI6IklOIjtzOjEyOiJhZGRyZXNzX25hbWUiO3M6MjQ6IlBhd2FuIEt1bWFyJ3MgVGVzdCBTdG9yZSI7czoxNDoibm90aWZ5X3ZlcnNpb24iO3M6MzoiMy44IjtzOjY6ImN1c3RvbSI7czoxNjoiTlRSMGJIUmhiVzl1ZEhrPSI7czoxMjoicGF5ZXJfc3RhdHVzIjtzOjg6InZlcmlmaWVkIjtzOjg6ImJ1c2luZXNzIjtzOjIzOiJiaGFyYXQuYm9yYW5hQHhpY29tLmJpeiI7czoxNToiYWRkcmVzc19jb3VudHJ5IjtzOjU6IkluZGlhIjtzOjEyOiJhZGRyZXNzX2NpdHkiO3M6NjoiTXVtYmFpIjtzOjg6InF1YW50aXR5IjtzOjE6IjEiO3M6MTE6InBheWVyX2VtYWlsIjtzOjIxOiJwYXdhbi54aWNvbUBnbWFpbC5jb20iO3M6MTE6InZlcmlmeV9zaWduIjtzOjU2OiJBRmNXeFYyMUM3ZmQwdjNiWVlZUkNwU1NSbDMxQWZXQ1VncjJNNTc1SzVHNmRybEo3REt5cjMuNiI7czo2OiJ0eG5faWQiO3M6MTc6IjgwSjA3ODM4NjYwMjQzMjBQIjtzOjEyOiJwYXltZW50X3R5cGUiO3M6NzoiaW5zdGFudCI7czoxOToicGF5ZXJfYnVzaW5lc3NfbmFtZSI7czoyNDoiUGF3YW4gS3VtYXIncyBUZXN0IFN0b3JlIjtzOjk6Imxhc3RfbmFtZSI7czo1OiJLdW1hciI7czoxMzoiYWRkcmVzc19zdGF0ZSI7czoxMToiTWFoYXJhc2h0cmEiO3M6MTQ6InJlY2VpdmVyX2VtYWlsIjtzOjIzOiJiaGFyYXQuYm9yYW5hQHhpY29tLmJpeiI7czoxMToicGF5bWVudF9mZWUiO3M6NDoiMS44NiI7czoxMToicmVjZWl2ZXJfaWQiO3M6MTM6IlpKM0JRNE1TV1hRQlkiO3M6ODoidHhuX3R5cGUiO3M6MTA6IndlYl9hY2NlcHQiO3M6OToiaXRlbV9uYW1lIjtzOjY6IlllYXJseSI7czoxMToibWNfY3VycmVuY3kiO3M6MzoiVVNEIjtzOjExOiJpdGVtX251bWJlciI7czoxOiIzIjtzOjE3OiJyZXNpZGVuY2VfY291bnRyeSI7czoyOiJJTiI7czo4OiJ0ZXN0X2lwbiI7czoxOiIxIjtzOjE1OiJoYW5kbGluZ19hbW91bnQiO3M6NDoiMC4wMCI7czoxOToidHJhbnNhY3Rpb25fc3ViamVjdCI7czowOiIiO3M6MTM6InBheW1lbnRfZ3Jvc3MiO3M6NToiMzkuOTAiO3M6ODoic2hpcHBpbmciO3M6NDoiMC4wMCI7czo0OiJhdXRoIjtzOjg3OiJBcTd5TTlWeENLZXZ2a0owZkwwQVpVbHJWMkl3VXozeVlKTHV1NDVVYzV1ZnBWQmpwMXhzTVAxMEJaeXczdGViQlpWWjdnVnJsakxhUFh3TTJ6cjJMOVEiO3M6MTI6ImZvcm1fY2hhcnNldCI7czo1OiJVVEYtOCI7fQ==', NULL, '2016-07-05 06:53:49', '2016-07-05 07:14:37'),
(17, 56, 3, '5U97891376188330E', 39.90, 'USD', 1, 'YTo4OntzOjY6InR4bl9pZCI7czoxNzoiNVU5Nzg5MTM3NjE4ODMzMEUiO3M6MTQ6InBheW1lbnRfc3RhdHVzIjtzOjk6IkNvbXBsZXRlZCI7czoxMzoicGF5bWVudF9ncm9zcyI7czo1OiIzOS45MCI7czoxMToibWNfY3VycmVuY3kiO3M6MzoiVVNEIjtzOjY6ImN1c3RvbSI7czoxNjoiTlRaMGJIUmhiVzl1ZEhrPSI7czoxMToiaXRlbV9udW1iZXIiO3M6MToiMyI7czozOiJzaWciO3M6MTcyOiJkcUtnUmpQOXVKSzZnWDByWHpMVUFYY0VUVlh4VUZrdEd4V2ZSZHZYZHMzRlhVVExqLzJoT2xvMDVwWjBDKzZBOFRuUC8wVDY0MkRpVFZwZFpiUVkvZExlaVpIMG5JV1RHQktVSU1DKzJPb2JPNzRjUG43NUkrajlvblYvaHg5VlRnTjMvWGVoRDh3N2F0cmt5WXh2eVEvSnZzSHRTcFFLRzdvM0hhYm90UXM9IjtzOjM6IkdFVCI7YTo3OntzOjI6InR4IjtzOjE3OiI1VTk3ODkxMzc2MTg4MzMwRSI7czoyOiJzdCI7czo5OiJDb21wbGV0ZWQiO3M6MzoiYW10IjtzOjU6IjM5LjkwIjtzOjI6ImNjIjtzOjM6IlVTRCI7czoyOiJjbSI7czoxNjoiTlRaMGJIUmhiVzl1ZEhrPSI7czoxMToiaXRlbV9udW1iZXIiO3M6MToiMyI7czozOiJzaWciO3M6MTcyOiJkcUtnUmpQOXVKSzZnWDByWHpMVUFYY0VUVlh4VUZrdEd4V2ZSZHZYZHMzRlhVVExqLzJoT2xvMDVwWjBDKzZBOFRuUC8wVDY0MkRpVFZwZFpiUVkvZExlaVpIMG5JV1RHQktVSU1DKzJPb2JPNzRjUG43NUkrajlvblYvaHg5VlRnTjMvWGVoRDh3N2F0cmt5WXh2eVEvSnZzSHRTcFFLRzdvM0hhYm90UXM9Ijt9fQ==', NULL, '2016-07-05 07:19:51', '2016-07-05 10:18:27'),
(18, 57, 3, '0NJ03412DU8034531', 39.90, 'USD', 1, 'YTo0NDp7czo4OiJtY19ncm9zcyI7czo1OiIzOS45MCI7czoyMjoicHJvdGVjdGlvbl9lbGlnaWJpbGl0eSI7czo4OiJFbGlnaWJsZSI7czoxNDoiYWRkcmVzc19zdGF0dXMiO3M6MTE6InVuY29uZmlybWVkIjtzOjg6InBheWVyX2lkIjtzOjEzOiI2UEhTSzlYS0dXVkdRIjtzOjM6InRheCI7czo0OiIwLjAwIjtzOjE0OiJhZGRyZXNzX3N0cmVldCI7czo2NzoiRmxhdCBuby4gNTA3IFdpbmcgQSBSYWhlamEgUmVzaWRlbmN5DQpGaWxtIENpdHkgUm9hZCwgR29yZWdhb24gRWFzdCI7czoxMjoicGF5bWVudF9kYXRlIjtzOjI1OiIwMDoyNToyMiBKdWwgMDUsIDIwMTYgUERUIjtzOjE0OiJwYXltZW50X3N0YXR1cyI7czo5OiJDb21wbGV0ZWQiO3M6NzoiY2hhcnNldCI7czoxMjoid2luZG93cy0xMjUyIjtzOjExOiJhZGRyZXNzX3ppcCI7czo2OiI0MDAwOTciO3M6MTA6ImZpcnN0X25hbWUiO3M6NToiUGF3YW4iO3M6NjoibWNfZmVlIjtzOjQ6IjEuODYiO3M6MjA6ImFkZHJlc3NfY291bnRyeV9jb2RlIjtzOjI6IklOIjtzOjEyOiJhZGRyZXNzX25hbWUiO3M6MjQ6IlBhd2FuIEt1bWFyJ3MgVGVzdCBTdG9yZSI7czoxNDoibm90aWZ5X3ZlcnNpb24iO3M6MzoiMy44IjtzOjY6ImN1c3RvbSI7czoxNjoiTlRkMGJIUmhiVzl1ZEhrPSI7czoxMjoicGF5ZXJfc3RhdHVzIjtzOjg6InZlcmlmaWVkIjtzOjg6ImJ1c2luZXNzIjtzOjIzOiJiaGFyYXQuYm9yYW5hQHhpY29tLmJpeiI7czoxNToiYWRkcmVzc19jb3VudHJ5IjtzOjU6IkluZGlhIjtzOjEyOiJhZGRyZXNzX2NpdHkiO3M6NjoiTXVtYmFpIjtzOjg6InF1YW50aXR5IjtzOjE6IjEiO3M6MTE6InBheWVyX2VtYWlsIjtzOjIxOiJwYXdhbi54aWNvbUBnbWFpbC5jb20iO3M6MTE6InZlcmlmeV9zaWduIjtzOjU2OiJBRmNXeFYyMUM3ZmQwdjNiWVlZUkNwU1NSbDMxQWEuWklHZzQzOXgtT0JYRE12QzUwOHguUHIweiI7czo2OiJ0eG5faWQiO3M6MTc6IjBOSjAzNDEyRFU4MDM0NTMxIjtzOjEyOiJwYXltZW50X3R5cGUiO3M6NzoiaW5zdGFudCI7czoxOToicGF5ZXJfYnVzaW5lc3NfbmFtZSI7czoyNDoiUGF3YW4gS3VtYXIncyBUZXN0IFN0b3JlIjtzOjk6Imxhc3RfbmFtZSI7czo1OiJLdW1hciI7czoxMzoiYWRkcmVzc19zdGF0ZSI7czoxMToiTWFoYXJhc2h0cmEiO3M6MTQ6InJlY2VpdmVyX2VtYWlsIjtzOjIzOiJiaGFyYXQuYm9yYW5hQHhpY29tLmJpeiI7czoxMToicGF5bWVudF9mZWUiO3M6NDoiMS44NiI7czoxMToicmVjZWl2ZXJfaWQiO3M6MTM6IlpKM0JRNE1TV1hRQlkiO3M6ODoidHhuX3R5cGUiO3M6MTA6IndlYl9hY2NlcHQiO3M6OToiaXRlbV9uYW1lIjtzOjY6IlllYXJseSI7czoxMToibWNfY3VycmVuY3kiO3M6MzoiVVNEIjtzOjExOiJpdGVtX251bWJlciI7czoxOiIzIjtzOjE3OiJyZXNpZGVuY2VfY291bnRyeSI7czoyOiJJTiI7czo4OiJ0ZXN0X2lwbiI7czoxOiIxIjtzOjE1OiJoYW5kbGluZ19hbW91bnQiO3M6NDoiMC4wMCI7czoxOToidHJhbnNhY3Rpb25fc3ViamVjdCI7czowOiIiO3M6MTM6InBheW1lbnRfZ3Jvc3MiO3M6NToiMzkuOTAiO3M6ODoic2hpcHBpbmciO3M6NDoiMC4wMCI7czoyMDoibWVyY2hhbnRfcmV0dXJuX2xpbmsiO3M6MTA6ImNsaWNrIGhlcmUiO3M6NDoiYXV0aCI7czo4NzoiQWREQmlQdDNwWTA5REozejFRbXhBNklNemdOTEYzLjd2QkY4aExkRXlpdE5qRjM4Y2RnWVZvem54cktzTlJoSUh6UnREdEtxWXB5czVoeXhaQXRaMFlRIjtzOjEyOiJmb3JtX2NoYXJzZXQiO3M6NToiVVRGLTgiO30=', NULL, '2016-07-05 07:24:45', '2016-07-05 07:26:02'),
(19, 59, 3, '2G574754KL4619157', 39.90, 'USD', 1, 'YTo0Mzp7czo4OiJtY19ncm9zcyI7czo1OiIzOS45MCI7czoyMjoicHJvdGVjdGlvbl9lbGlnaWJpbGl0eSI7czo4OiJFbGlnaWJsZSI7czoxNDoiYWRkcmVzc19zdGF0dXMiO3M6MTE6InVuY29uZmlybWVkIjtzOjg6InBheWVyX2lkIjtzOjEzOiI2UEhTSzlYS0dXVkdRIjtzOjM6InRheCI7czo0OiIwLjAwIjtzOjE0OiJhZGRyZXNzX3N0cmVldCI7czo2NzoiRmxhdCBuby4gNTA3IFdpbmcgQSBSYWhlamEgUmVzaWRlbmN5DQpGaWxtIENpdHkgUm9hZCwgR29yZWdhb24gRWFzdCI7czoxMjoicGF5bWVudF9kYXRlIjtzOjI1OiIwMDozMDoyMyBKdWwgMDUsIDIwMTYgUERUIjtzOjE0OiJwYXltZW50X3N0YXR1cyI7czo5OiJDb21wbGV0ZWQiO3M6NzoiY2hhcnNldCI7czoxMjoid2luZG93cy0xMjUyIjtzOjExOiJhZGRyZXNzX3ppcCI7czo2OiI0MDAwOTciO3M6MTA6ImZpcnN0X25hbWUiO3M6NToiUGF3YW4iO3M6NjoibWNfZmVlIjtzOjQ6IjEuODYiO3M6MjA6ImFkZHJlc3NfY291bnRyeV9jb2RlIjtzOjI6IklOIjtzOjEyOiJhZGRyZXNzX25hbWUiO3M6MjQ6IlBhd2FuIEt1bWFyJ3MgVGVzdCBTdG9yZSI7czoxNDoibm90aWZ5X3ZlcnNpb24iO3M6MzoiMy44IjtzOjY6ImN1c3RvbSI7czoxNjoiTlRsMGJIUmhiVzl1ZEhrPSI7czoxMjoicGF5ZXJfc3RhdHVzIjtzOjg6InZlcmlmaWVkIjtzOjg6ImJ1c2luZXNzIjtzOjIzOiJiaGFyYXQuYm9yYW5hQHhpY29tLmJpeiI7czoxNToiYWRkcmVzc19jb3VudHJ5IjtzOjU6IkluZGlhIjtzOjEyOiJhZGRyZXNzX2NpdHkiO3M6NjoiTXVtYmFpIjtzOjg6InF1YW50aXR5IjtzOjE6IjEiO3M6MTE6InBheWVyX2VtYWlsIjtzOjIxOiJwYXdhbi54aWNvbUBnbWFpbC5jb20iO3M6MTE6InZlcmlmeV9zaWduIjtzOjU2OiJBRmNXeFYyMUM3ZmQwdjNiWVlZUkNwU1NSbDMxQVJ2UmVjVnZmV2FmZUN1cmkwTndoSnY3eWdmeCI7czo2OiJ0eG5faWQiO3M6MTc6IjJHNTc0NzU0S0w0NjE5MTU3IjtzOjEyOiJwYXltZW50X3R5cGUiO3M6NzoiaW5zdGFudCI7czoxOToicGF5ZXJfYnVzaW5lc3NfbmFtZSI7czoyNDoiUGF3YW4gS3VtYXIncyBUZXN0IFN0b3JlIjtzOjk6Imxhc3RfbmFtZSI7czo1OiJLdW1hciI7czoxMzoiYWRkcmVzc19zdGF0ZSI7czoxMToiTWFoYXJhc2h0cmEiO3M6MTQ6InJlY2VpdmVyX2VtYWlsIjtzOjIzOiJiaGFyYXQuYm9yYW5hQHhpY29tLmJpeiI7czoxMToicGF5bWVudF9mZWUiO3M6NDoiMS44NiI7czoxMToicmVjZWl2ZXJfaWQiO3M6MTM6IlpKM0JRNE1TV1hRQlkiO3M6ODoidHhuX3R5cGUiO3M6MTA6IndlYl9hY2NlcHQiO3M6OToiaXRlbV9uYW1lIjtzOjY6IlllYXJseSI7czoxMToibWNfY3VycmVuY3kiO3M6MzoiVVNEIjtzOjExOiJpdGVtX251bWJlciI7czoxOiIzIjtzOjE3OiJyZXNpZGVuY2VfY291bnRyeSI7czoyOiJJTiI7czo4OiJ0ZXN0X2lwbiI7czoxOiIxIjtzOjE1OiJoYW5kbGluZ19hbW91bnQiO3M6NDoiMC4wMCI7czoxOToidHJhbnNhY3Rpb25fc3ViamVjdCI7czowOiIiO3M6MTM6InBheW1lbnRfZ3Jvc3MiO3M6NToiMzkuOTAiO3M6ODoic2hpcHBpbmciO3M6NDoiMC4wMCI7czo0OiJhdXRoIjtzOjg3OiJBRlA4ek5uakk4dGR0N05sd01oTi1UdlJSUU1DdGNPUzFKY3FDS29qTTRpSTJ2bFRpNDBoSmpkTlZhVWNhU094blFVemJldzJ2ZFhUSjJDakRFOFp1d2ciO3M6MTI6ImZvcm1fY2hhcnNldCI7czo1OiJVVEYtOCI7fQ==', NULL, '2016-07-05 07:29:43', '2016-07-05 07:40:19'),
(20, 60, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-05 07:45:46', '2016-07-05 07:45:46'),
(21, 63, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-06 12:12:35', '2016-07-06 12:12:35'),
(22, 64, 2, '57T588311V2182928', 3.99, 'USD', 1, 'YTo4OntzOjY6InR4bl9pZCI7czoxNzoiNTdUNTg4MzExVjIxODI5MjgiO3M6MTQ6InBheW1lbnRfc3RhdHVzIjtzOjk6IkNvbXBsZXRlZCI7czoxMzoicGF5bWVudF9ncm9zcyI7czo0OiIzLjk5IjtzOjExOiJtY19jdXJyZW5jeSI7czozOiJVU0QiO3M6NjoiY3VzdG9tIjtzOjE2OiJOalIwYkhSaGJXOXVkSGs9IjtzOjExOiJpdGVtX251bWJlciI7czoxOiIyIjtzOjM6InNpZyI7czoxNzI6IkVOcklIZXRoVmgveE51WlpBNkp6ODNzVHk4cWEydHpqUTZ0eHplY0M2akkxU3NJVWJETThlUjdzMjBsT2haY2Yvb290d3M5aVhVVUtvelBJeGdFZk44UjdIOU44Q1pKZEc2eFU4VFdjVnB6WnovZUF3ZU5sNHhreTlIa3gyeTJXUGRxckR5VFJacE5NaDNQTWkwU1RwY2dkRzU4Z1hRQjBNMGsrOXpIYi9nZz0iO3M6MzoiR0VUIjthOjc6e3M6MjoidHgiO3M6MTc6IjU3VDU4ODMxMVYyMTgyOTI4IjtzOjI6InN0IjtzOjk6IkNvbXBsZXRlZCI7czozOiJhbXQiO3M6NDoiMy45OSI7czoyOiJjYyI7czozOiJVU0QiO3M6MjoiY20iO3M6MTY6Ik5qUjBiSFJoYlc5dWRIaz0iO3M6MTE6Iml0ZW1fbnVtYmVyIjtzOjE6IjIiO3M6Mzoic2lnIjtzOjE3MjoiRU5ySUhldGhWaC94TnVaWkE2Sno4M3NUeThxYTJ0empRNnR4emVjQzZqSTFTc0lVYkRNOGVSN3MyMGxPaFpjZi9vb3R3czlpWFVVS296UEl4Z0VmTjhSN0g5TjhDWkpkRzZ4VThUV2NWcHpaei9lQXdlTmw0eGt5OUhreDJ5MldQZHFyRHlUUlpwTk1oM1BNaTBTVHBjZ2RHNThnWFFCME0ways5ekhiL2dnPSI7fX0=', NULL, '2016-07-07 04:40:48', '2016-07-07 04:41:43'),
(23, 67, 3, '', 39.90, 'USD', 0, NULL, NULL, '2016-07-11 05:28:08', '2016-07-11 05:28:08');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `price` double NOT NULL,
  `currency_code` varchar(50) NOT NULL,
  `currency_symbol` varchar(50) NOT NULL,
  `validity` int(11) NOT NULL COMMENT 'In days',
  `status_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `user_id`, `title`, `description`, `price`, `currency_code`, `currency_symbol`, `validity`, `status_id`, `created`, `modified`) VALUES
(1, 1, 'Free Trial', 'Free Trial', 0, '', '', 30, 1, '2016-07-01 04:02:06', '2016-07-01 04:02:06'),
(2, 1, 'Monthly', 'Monthly', 2.99, 'USD', '$', 60, 1, '2016-07-01 04:02:06', '2016-07-01 04:02:06'),
(3, 1, 'Yearly', 'Yearly', 29.99, 'USD', '$', 395, 1, '2016-07-01 04:02:06', '2016-07-01 04:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `color` varchar(10) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `statuses`
--

INSERT INTO `statuses` (`id`, `name`, `color`, `type`, `created`, `modified`) VALUES
(1, 'Active', NULL, 'user-status', '2015-06-26 00:00:00', '2015-06-26 00:00:00'),
(2, 'Inactive', NULL, 'user-status', '2015-06-26 00:00:00', '2015-06-26 00:00:00'),
(3, 'Not Verified', NULL, 'user-status', '2015-06-29 00:00:00', '2015-06-29 00:00:00'),
(4, 'Presented', '#ffffff', 'student-view', '2016-01-22 01:04:17', '2016-01-22 01:04:17'),
(5, 'Further refinement', '#ffffff', 'student-view', '2016-01-22 01:04:17', '2016-01-22 01:04:17'),
(6, 'Working', '#ffffff', 'student-view', '2016-01-22 01:04:17', '2016-01-22 01:04:17'),
(7, 'None', '#ffffff', 'student-view', '2016-01-22 01:04:17', '2016-01-22 01:04:17'),
(8, 'Satisfied', '#FF7905', 'student-view', '2016-10-04 02:03:01', '2016-10-04 02:03:01');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE IF NOT EXISTS `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `first_name` varchar(55) NOT NULL,
  `last_name` varchar(55) NOT NULL,
  `birthday` date NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `modified` datetime NOT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=206 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`id`, `user_id`, `email`, `first_name`, `last_name`, `birthday`, `status`, `modified`, `created`) VALUES
(1, 12, NULL, 'Anmol', 'Verma', '1990-05-25', 1, '2016-04-05 10:06:48', '2016-04-05 10:06:48'),
(2, 12, NULL, 'Vicky', 'Sharma', '1987-04-05', 1, '2016-04-05 10:07:11', '2016-04-05 10:07:11'),
(3, 12, NULL, 'Pawan', 'Kumar', '1996-04-05', 1, '2016-04-05 10:28:25', '2016-04-05 10:28:25'),
(4, 7, NULL, 'Deepak', 'Batra', '1995-04-05', 1, '2016-04-05 13:51:20', '2016-04-05 13:51:20'),
(5, 7, NULL, 'Vicky', 'dharma', '1989-04-07', 1, '2016-04-06 05:25:46', '2016-04-06 05:25:46'),
(6, 14, NULL, 'anmol', 'palekar', '2014-04-06', 1, '2016-04-06 06:00:51', '2016-04-06 06:00:51'),
(7, 14, NULL, 'raju ', 'rastogi', '2012-04-06', 1, '2016-04-06 06:01:12', '2016-04-06 06:01:12'),
(8, 14, NULL, 'isha', 'sharma', '2013-04-06', 1, '2016-04-06 06:01:28', '2016-04-06 06:01:28'),
(19, 14, NULL, 'Amna', 'Desai', '2008-01-08', 1, '2016-04-08 09:52:36', '2016-04-08 09:52:36'),
(20, 20, NULL, 'Kari', 'well', '2010-04-11', 1, '2016-04-11 23:32:51', '2016-04-11 23:32:51'),
(22, 20, NULL, 'Steve', 'Carkson ', '2006-04-14', 1, '2016-04-14 16:14:13', '2016-04-14 16:14:13'),
(23, 20, NULL, 'George', 'Best', '2006-01-14', 1, '2016-04-14 16:14:33', '2016-04-14 16:14:33'),
(24, 20, NULL, 'Danica', 'Carawly', '2007-02-27', 1, '2016-04-14 16:14:55', '2016-04-14 16:14:55'),
(25, 20, NULL, 'Jennifer', 'Book', '2006-08-26', 1, '2016-04-14 16:15:20', '2016-04-14 16:15:20'),
(26, 22, NULL, 'Eliza', 'bush', '2008-04-19', 1, '2016-04-19 18:06:41', '2016-04-19 18:06:41'),
(27, 22, NULL, 'David', 'Binter', '2007-06-30', 1, '2016-04-19 18:08:54', '2016-04-19 18:08:54'),
(28, 22, NULL, 'Sara', 'Vindra', '2009-02-14', 1, '2016-04-19 18:09:16', '2016-04-19 18:09:16'),
(29, 22, NULL, 'Sasa', 'Solof', '2009-10-24', 1, '2016-04-19 18:09:41', '2016-04-19 18:09:41'),
(30, 22, NULL, 'Amy', 'Finn', '2010-09-01', 1, '2016-04-19 18:10:10', '2016-04-19 18:10:10'),
(31, 22, NULL, 'Kim', 'Marsa', '2010-11-26', 1, '2016-04-19 18:10:34', '2016-04-19 18:10:34'),
(32, 22, NULL, 'Michah', 'Carldon', '2009-02-19', 1, '2016-04-19 18:11:00', '2016-04-19 18:11:00'),
(33, 22, NULL, 'Natasja', 'Tholander', '2010-06-24', 1, '2016-04-19 18:11:33', '2016-04-19 18:11:33'),
(34, 22, NULL, 'Lise', 'Elliott', '2006-04-23', 1, '2016-04-19 18:11:57', '2016-04-19 18:11:57'),
(35, 22, NULL, 'Andrew', 'Wester', '2008-09-18', 1, '2016-04-19 18:13:31', '2016-04-19 18:13:31'),
(36, 23, NULL, 'Test', 'User1', '2009-04-21', 1, '2016-04-21 06:04:40', '2016-04-21 06:04:40'),
(67, 23, NULL, 'Amoli', 'Verma', '2003-04-29', 1, '2016-04-29 05:41:58', '2016-04-29 05:41:58'),
(68, 23, NULL, 'Samar', 'Sharma', '2010-04-29', 1, '2016-04-29 05:42:25', '2016-04-29 05:42:25'),
(71, 26, NULL, 'Amol', 'V', '2014-04-29', 1, '2016-04-29 06:37:17', '2016-04-29 06:37:17'),
(74, 26, NULL, 'Surya', 'V', '2012-05-02', 1, '2016-05-02 07:36:24', '2016-05-02 07:36:24'),
(82, 29, NULL, 'Gracie', 'R', '2012-08-29', 1, '2016-05-22 19:01:12', '2016-05-07 02:36:04'),
(83, 29, NULL, 'Jameson', 'K', '2012-08-20', 1, '2016-05-22 18:48:37', '2016-05-07 02:36:32'),
(84, 29, NULL, 'Tillie', 'R', '2012-01-11', 1, '2016-05-22 19:01:22', '2016-05-07 02:37:06'),
(87, 26, NULL, 'Taran', 'H', '2013-05-10', 1, '2016-05-10 06:19:35', '2016-05-10 06:19:35'),
(90, 30, NULL, 'Pawan', 'Kumar', '2010-05-27', 1, '2016-05-12 07:35:36', '2016-05-12 07:35:36'),
(92, 25, NULL, 'Moli', 'S', '2008-05-18', 1, '2016-05-18 05:10:34', '2016-05-18 05:10:34'),
(98, 29, NULL, 'Ducky', 'Ayala', '2010-12-18', 1, '2016-05-22 18:50:48', '2016-05-22 18:50:48'),
(100, 29, NULL, 'Nettie', 'Busiek', '2012-05-08', 1, '2016-05-22 18:51:50', '2016-05-22 18:51:50'),
(101, 29, NULL, 'Ronan', 'Byrnes', '2010-11-15', 1, '2016-05-22 18:52:17', '2016-05-22 18:52:17'),
(103, 29, NULL, 'Emmett', 'Cram', '2010-07-05', 1, '2016-05-22 18:53:19', '2016-05-22 18:53:19'),
(104, 29, NULL, 'Jimmy', 'Croke', '2011-10-06', 1, '2016-05-22 18:53:40', '2016-05-22 18:53:40'),
(105, 29, NULL, 'Caroline', 'Cunningham', '2011-06-15', 1, '2016-05-22 18:54:04', '2016-05-22 18:54:04'),
(106, 29, NULL, 'Sofia', 'Eckford', '2012-01-06', 1, '2016-05-22 18:54:29', '2016-05-22 18:54:29'),
(107, 29, NULL, 'Dexter ', 'Evancy', '2011-03-24', 1, '2016-05-22 18:54:53', '2016-05-22 18:54:53'),
(108, 29, NULL, 'Nathan', 'Foltz', '2010-10-11', 1, '2016-05-22 18:55:19', '2016-05-22 18:55:19'),
(109, 29, NULL, 'Cooper', 'Groves', '2011-05-22', 1, '2016-05-22 18:55:44', '2016-05-22 18:55:44'),
(110, 29, NULL, 'Max', 'Hoffmann', '2011-09-10', 1, '2016-05-22 18:56:23', '2016-05-22 18:56:23'),
(114, 29, NULL, 'Lucy', 'Lyden', '2010-12-21', 1, '2016-05-22 18:58:32', '2016-05-22 18:58:32'),
(115, 29, NULL, 'Kapo', 'Mikaelian', '2012-03-12', 1, '2016-05-22 18:59:01', '2016-05-22 18:59:01'),
(116, 29, NULL, 'Sabine', 'Moore', '2012-04-06', 1, '2016-05-22 18:59:20', '2016-05-22 18:59:20'),
(117, 29, NULL, 'Elise', 'Ramirez', '2012-01-13', 1, '2016-05-22 18:59:39', '2016-05-22 18:59:39'),
(118, 29, NULL, 'Isabel', 'Randall', '2011-07-21', 1, '2016-05-22 19:00:00', '2016-05-22 19:00:00'),
(119, 29, NULL, 'Junie', 'Seidel', '2010-08-06', 1, '2016-05-22 19:01:59', '2016-05-22 19:01:59'),
(120, 29, NULL, 'Quin', 'Shapiro', '2011-05-15', 1, '2016-05-22 19:02:22', '2016-05-22 19:02:22'),
(121, 29, NULL, 'Miro', 'Terzeiva', '2010-09-25', 1, '2016-05-22 19:02:55', '2016-05-22 19:02:55'),
(122, 25, NULL, 'Aman', 'Nene', '2017-11-05', 1, '2016-05-24 07:28:53', '2016-05-23 13:01:28'),
(124, 25, NULL, 'Test', 'Birla', '2012-05-19', 1, '2016-05-24 07:29:27', '2016-05-24 07:29:27'),
(126, 27, NULL, 'Pawan', 'Bhatia', '2008-05-25', 1, '2016-05-25 07:03:29', '2016-05-25 07:03:29'),
(127, 20, NULL, 'Dorothy', 'John', '2006-05-25', 1, '2016-05-26 00:34:54', '2016-05-26 00:34:54'),
(128, 26, NULL, 'Nihal', 'Verma', '2006-06-07', 1, '2016-06-09 05:04:01', '2016-06-09 05:04:01'),
(130, 33, NULL, 'fgfdg', 'dfgdfg', '2016-06-24', 1, '2016-06-09 06:22:25', '2016-06-09 06:22:25'),
(131, 34, NULL, 'Pawan', 'Kumar', '2011-06-06', 1, '2016-06-13 10:30:52', '2016-06-13 10:30:52'),
(132, 35, NULL, 'Anmol', 'Verma', '1996-06-20', 1, '2016-06-16 05:59:58', '2016-06-16 05:59:58'),
(133, 35, NULL, 'chhkc', 'xykjyx', '2016-06-16', 1, '2016-06-16 07:04:49', '2016-06-16 07:04:49'),
(134, 20, NULL, 'Eve', 'Martin', '2005-11-17', 1, '2016-06-17 12:27:12', '2016-06-17 12:25:59'),
(135, 20, NULL, 'Nora', 'Hirthe', '2004-04-15', 1, '2016-06-17 12:27:50', '2016-06-17 12:27:50'),
(136, 20, NULL, 'Maryam', 'Yusuf', '2005-02-13', 1, '2016-06-17 12:28:23', '2016-06-17 12:28:23'),
(137, 20, NULL, 'Nora ', 'Fitak', '2006-05-06', 1, '2016-06-17 12:29:05', '2016-06-17 12:29:05'),
(138, 20, NULL, 'Faye', 'Mayeshiba', '2005-05-30', 1, '2016-06-17 12:29:43', '2016-06-17 12:29:43'),
(139, 20, NULL, 'Olivia ', 'Alamo', '2006-02-24', 1, '2016-06-17 12:30:19', '2016-06-17 12:30:19'),
(140, 20, NULL, 'Nolan', 'Farah', '2005-01-14', 1, '2016-06-17 12:31:14', '2016-06-17 12:31:14'),
(141, 20, NULL, 'Ben', 'Gallion', '2005-04-06', 1, '2016-06-17 12:32:12', '2016-06-17 12:32:12'),
(142, 20, NULL, 'Nathan', 'Lasalle', '2004-04-12', 1, '2016-06-17 12:33:39', '2016-06-17 12:33:39'),
(143, 20, NULL, 'Bill', 'Bob', '2004-03-10', 1, '2016-06-17 12:34:41', '2016-06-17 12:34:41'),
(144, 20, NULL, 'Jill', 'Bob', '2007-04-14', 1, '2016-06-17 12:36:31', '2016-06-17 12:36:31'),
(145, 20, NULL, 'Bob', 'Bill', '2007-03-11', 1, '2016-06-17 12:37:20', '2016-06-17 12:37:20'),
(146, 20, NULL, 'Jill', 'Bill', '2008-06-17', 1, '2016-06-17 12:38:58', '2016-06-17 12:38:05'),
(147, 20, NULL, 'Sue ', 'Do', '2007-08-17', 1, '2016-06-17 12:39:55', '2016-06-17 12:39:55'),
(148, 20, NULL, 'Cam', 'Side', '2007-11-17', 1, '2016-06-17 12:40:46', '2016-06-17 12:40:46'),
(149, 20, NULL, 'Will', 'Dew', '2007-07-13', 1, '2016-06-17 12:41:25', '2016-06-17 12:41:25'),
(150, 20, NULL, 'All', 'Done', '2007-07-03', 1, '2016-06-17 12:41:50', '2016-06-17 12:41:50'),
(151, 20, NULL, 'Crazy', 'Horse', '2006-11-17', 1, '2016-06-17 12:42:10', '2016-06-17 12:42:10'),
(152, 20, NULL, 'Gimme', 'More', '2008-10-16', 1, '2016-06-17 12:42:38', '2016-06-17 12:42:38'),
(153, 20, NULL, 'Gotta', 'Go', '2008-06-20', 1, '2016-06-17 12:43:08', '2016-06-17 12:43:08'),
(154, 20, NULL, 'Idgey', 'Threadgood', '2006-02-23', 1, '2016-06-17 12:43:38', '2016-06-17 12:43:38'),
(155, 20, NULL, 'Selma', 'Hayak', '2005-01-26', 1, '2016-06-17 12:44:06', '2016-06-17 12:44:06'),
(156, 20, NULL, 'John', 'Stamos', '2005-07-01', 1, '2016-06-17 12:44:32', '2016-06-17 12:44:32'),
(157, 20, NULL, 'Mother', 'Theresa', '2008-12-06', 1, '2016-06-17 12:45:28', '2016-06-17 12:45:28'),
(158, 20, NULL, 'Maria', 'Montessori', '2008-04-04', 1, '2016-06-17 12:45:59', '2016-06-17 12:45:59'),
(159, 20, NULL, 'Mahatma', 'Gandhi', '2008-07-08', 1, '2016-06-17 12:46:31', '2016-06-17 12:46:31'),
(160, 20, NULL, 'Al', 'Guggenheim ', '2008-09-26', 1, '2016-06-17 12:47:22', '2016-06-17 12:47:22'),
(161, 35, NULL, 'new', 'name', '2016-06-24', 1, '2016-06-24 12:39:03', '2016-06-24 12:39:03'),
(162, 35, NULL, 'budh', 'hdhdd', '2016-06-24', 1, '2016-06-24 12:39:12', '2016-06-24 12:39:12'),
(163, 35, NULL, 'udhdd', 'dyydd', '2016-06-24', 1, '2016-06-24 12:39:20', '2016-06-24 12:39:20'),
(164, 35, NULL, 'xbbdbd', 'shhdhdd', '2016-06-24', 1, '2016-06-24 12:39:29', '2016-06-24 12:39:29'),
(183, 41, NULL, 'gdhd', 'dhhd', '2016-07-05', 1, '2016-07-05 03:42:31', '2016-07-05 03:42:31'),
(202, 56, NULL, 'Pawan', 'Kumar', '2012-11-06', 1, '2016-07-05 16:12:23', '2016-07-05 16:12:23'),
(203, 56, NULL, 'Ravi', 'Kumar', '2011-07-05', 1, '2016-07-05 16:13:13', '2016-07-05 16:13:13'),
(204, 50, NULL, 'dsfsdf', 'sdfsdf', '2016-07-06', 1, '2016-07-06 03:55:21', '2016-07-06 03:55:21'),
(205, 64, NULL, 'qwerty', 'qwerty', '2016-07-28', 1, '2016-07-07 04:43:33', '2016-07-07 04:43:33');

-- --------------------------------------------------------

--
-- Table structure for table `student_views`
--

CREATE TABLE IF NOT EXISTS `student_views` (
  `id` int(11) NOT NULL,
  `user_type` int(11) DEFAULT NULL,
  `creation_type` varchar(50) NOT NULL DEFAULT 'plan',
  `user_plan_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  `exercise_id` int(11) NOT NULL DEFAULT '0',
  `status_for` varchar(50) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `state_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1869 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student_views`
--

INSERT INTO `student_views` (`id`, `user_type`, `creation_type`, `user_plan_id`, `student_id`, `area_id`, `chapter_id`, `lesson_id`, `exercise_id`, `status_for`, `status_id`, `state_date`, `end_date`, `order_no`, `created`, `modified`) VALUES
(1, NULL, 'plan', 1, 71, 1, 23, 133, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-04 12:19:27'),
(2, NULL, 'plan', 1, 72, 1, 23, 133, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-06 13:05:21'),
(4, NULL, 'plan', 1, 74, 1, 23, 133, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-03 06:23:06'),
(6, NULL, 'plan', 1, 71, 2, 27, 215, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-02 07:38:33'),
(7, NULL, 'plan', 1, 72, 2, 27, 215, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-02 09:03:08'),
(9, NULL, 'plan', 1, 74, 2, 27, 215, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-07 09:39:40'),
(10, NULL, 'plan', 1, 71, 3, 17, 22, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-06 11:59:24'),
(11, NULL, 'plan', 1, 72, 3, 17, 22, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-03 06:25:45'),
(12, NULL, 'plan', 1, 71, 4, 8, 73, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-02 07:38:33'),
(13, NULL, 'plan', 1, 72, 4, 8, 73, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-03 06:25:33'),
(14, NULL, 'plan', 1, 71, 30, 126, 691, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-02 07:38:33'),
(15, NULL, 'plan', 1, 71, 3, 21, 104, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 07:38:33', '2016-05-02 07:43:54'),
(28, NULL, 'plan', 5, 72, 1, 2, 45, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 08:12:41', '2016-05-02 09:02:06'),
(29, NULL, 'plan', 5, 72, 4, 3, 28, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 08:12:41', '2016-05-07 09:38:36'),
(30, NULL, 'plan', 5, 71, 2, 22, 15, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-02 08:12:42', '2016-05-07 09:38:54'),
(35, NULL, 'plan', 6, 69, 10, 50, 492, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 09:22:08', '2016-05-02 09:22:08'),
(37, NULL, 'plan', 6, 69, 9, 47, 379, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 09:22:08', '2016-05-02 09:22:08'),
(40, NULL, 'plan', 6, 69, 9, 77, 471, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 09:22:08', '2016-05-02 09:22:08'),
(51, NULL, 'plan', 10, 59, 1, 20, 50, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:16:57'),
(52, NULL, 'plan', 10, 65, 1, 20, 50, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-05 22:23:55'),
(53, NULL, 'plan', 10, 40, 1, 20, 50, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:15:48'),
(54, NULL, 'plan', 10, 42, 1, 20, 50, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:15:48'),
(55, NULL, 'plan', 10, 61, 2, 29, 244, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:15:48'),
(56, NULL, 'plan', 10, 51, 2, 29, 244, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:15:48'),
(57, NULL, 'plan', 10, 50, 3, 17, 20, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:15:48'),
(58, NULL, 'plan', 10, 46, 3, 17, 20, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:15:48'),
(59, NULL, 'plan', 10, 66, 3, 17, 20, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-02 16:15:48', '2016-05-02 16:17:02'),
(60, NULL, 'plan', 11, 54, 1, 32, 213, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:16:28', '2016-05-02 16:16:28'),
(61, NULL, 'plan', 11, 54, 2, 26, 34, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:16:28', '2016-05-02 16:16:28'),
(62, NULL, 'plan', 11, 54, 3, 21, 86, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:16:28', '2016-05-02 16:16:28'),
(63, NULL, 'plan', 11, 54, 4, 16, 194, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-02 16:16:28', '2016-05-02 16:16:28'),
(96, NULL, 'plan', 13, 61, 2, 29, 178, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(97, NULL, 'plan', 13, 61, 3, 10, 267, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(98, NULL, 'plan', 13, 61, 4, 5, 57, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(99, NULL, 'plan', 13, 61, 1, 23, 125, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(100, NULL, 'plan', 13, 57, 2, 27, 215, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(101, NULL, 'plan', 13, 57, 3, 17, 22, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(102, NULL, 'plan', 13, 57, 1, 32, 213, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(103, NULL, 'plan', 13, 57, 4, 15, 4, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-06 15:44:55', '2016-05-06 15:44:55'),
(104, NULL, 'plan', 14, 80, 3, 25, 102, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:26', '2016-05-07 02:29:26'),
(105, NULL, 'plan', 14, 80, 3, 25, 150, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:27', '2016-05-07 02:29:27'),
(106, NULL, 'plan', 14, 81, 4, 16, 165, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:27', '2016-05-07 02:29:27'),
(107, NULL, 'plan', 14, 81, 4, 16, 236, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:27', '2016-05-07 02:29:27'),
(108, NULL, 'plan', 14, 79, 2, 27, 215, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:27', '2016-05-07 02:29:27'),
(109, NULL, 'plan', 14, 79, 1, 14, 110, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:27', '2016-05-07 02:29:27'),
(110, NULL, 'plan', 14, 79, 4, 16, 233, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 02:29:27', '2016-05-07 02:29:27'),
(125, NULL, 'plan', 17, 71, 1, 1, 142, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 12:43:44', '2016-05-07 12:43:44'),
(128, NULL, 'plan', 17, 71, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(131, NULL, 'plan', 17, 71, 3, 28, 7, 125, 'exercise', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(133, NULL, 'plan', 17, 71, 3, 28, 7, 523, 'exercise', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(136, NULL, 'plan', 17, 71, 4, 12, 249, 106, 'exercise', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(137, NULL, 'plan', 17, 74, 4, 12, 249, 229, 'exercise', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(139, NULL, 'plan', 17, 71, 4, 12, 249, 247, 'exercise', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(141, NULL, 'plan', 17, 74, 4, 12, 249, 247, 'exercise', 7, NULL, NULL, NULL, '2016-05-07 12:43:45', '2016-05-07 12:43:45'),
(290, NULL, 'plan', 27, 90, 5, 45, 607, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-12 07:35:58', '2016-05-12 07:56:16'),
(292, NULL, 'plan', 27, 90, 7, 104, 554, 0, 'lesson', 1, NULL, NULL, NULL, '2016-05-12 07:35:59', '2016-05-12 07:35:59'),
(293, NULL, 'plan', 27, 90, 10, 50, 492, 0, 'lesson', 1, NULL, NULL, NULL, '2016-05-12 07:35:59', '2016-05-12 07:35:59'),
(294, NULL, 'plan', 27, 88, 5, 45, 607, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 07:35:59', '2016-05-12 07:35:59'),
(296, NULL, 'plan', 27, 88, 7, 104, 554, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 07:36:00', '2016-05-12 07:36:00'),
(297, NULL, 'plan', 27, 88, 10, 50, 492, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 07:36:00', '2016-05-12 07:36:00'),
(302, NULL, 'plan', 28, 90, 3, 7, 157, 140, 'exercise', 4, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:32'),
(304, NULL, 'plan', 28, 88, 3, 7, 157, 140, 'exercise', 6, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:46'),
(305, NULL, 'plan', 28, 90, 3, 7, 157, 90, 'exercise', 4, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:35'),
(307, NULL, 'plan', 28, 88, 3, 7, 157, 90, 'exercise', 4, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:50'),
(308, NULL, 'plan', 28, 90, 3, 7, 157, 415, 'exercise', 4, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:18'),
(310, NULL, 'plan', 28, 88, 3, 7, 157, 415, 'exercise', 6, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:23'),
(311, NULL, 'plan', 28, 90, 3, 7, 157, 173, 'exercise', 6, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:37'),
(313, NULL, 'plan', 28, 88, 3, 7, 157, 173, 'exercise', 6, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:51'),
(314, NULL, 'plan', 28, 90, 3, 7, 157, 376, 'exercise', 5, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:33'),
(316, NULL, 'plan', 28, 88, 3, 7, 157, 376, 'exercise', 6, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:48'),
(317, NULL, 'plan', 28, 90, 3, 7, 157, 168, 'exercise', 4, NULL, NULL, NULL, '2016-05-12 09:21:09', '2016-05-12 09:21:27'),
(319, NULL, 'plan', 28, 88, 3, 7, 157, 168, 'exercise', 6, NULL, NULL, NULL, '2016-05-12 09:21:10', '2016-05-12 09:21:30'),
(320, NULL, 'plan', 29, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 09:23:04', '2016-05-20 05:02:34'),
(322, NULL, 'plan', 29, 88, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 09:23:05', '2016-05-12 10:33:48'),
(325, NULL, 'plan', 30, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:16:28', '2016-05-20 05:02:34'),
(326, NULL, 'plan', 30, 90, 3, 7, 17, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:16:28', '2016-05-20 05:00:08'),
(327, NULL, 'plan', 30, 90, 3, 7, 263, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-12 10:16:28', '2016-05-20 05:04:06'),
(427, NULL, 'plan', 31, 90, 3, 7, 265, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:00:10'),
(428, NULL, 'plan', 31, 90, 3, 7, 237, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:03:32'),
(429, NULL, 'plan', 31, 90, 3, 7, 265, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:00:10'),
(430, NULL, 'plan', 31, 90, 3, 7, 17, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:00:08'),
(431, NULL, 'plan', 31, 90, 3, 7, 237, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:03:32'),
(432, NULL, 'plan', 31, 90, 3, 7, 263, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:04:06'),
(433, NULL, 'plan', 31, 90, 3, 7, 231, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-12 10:35:11'),
(434, NULL, 'plan', 31, 90, 3, 7, 190, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 04:59:56'),
(435, NULL, 'plan', 31, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:11', '2016-05-20 05:02:34'),
(436, NULL, 'plan', 31, 90, 3, 7, 237, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:12', '2016-05-20 05:03:32'),
(437, NULL, 'plan', 31, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:12', '2016-05-20 05:02:34'),
(438, NULL, 'plan', 31, 90, 3, 7, 190, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:12', '2016-05-20 04:59:56'),
(439, NULL, 'plan', 31, 90, 3, 7, 17, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:12', '2016-05-20 05:00:08'),
(440, NULL, 'plan', 31, 90, 3, 7, 58, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-12 10:35:12', '2016-05-12 10:35:12'),
(441, NULL, 'plan', 31, 90, 3, 7, 263, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-12 10:35:12', '2016-05-20 05:04:06'),
(487, NULL, 'plan', 32, 0, 4, 3, 28, 0, 'lesson', 1, NULL, NULL, NULL, '2016-05-16 03:55:06', '2016-05-16 03:55:06'),
(488, NULL, 'plan', 32, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-16 03:55:06', '2016-05-20 05:02:34'),
(489, NULL, 'plan', 32, 90, 3, 7, 231, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 03:55:06', '2016-05-16 03:55:06'),
(490, NULL, 'plan', 32, 90, 2, 22, 243, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 03:55:06', '2016-05-16 03:55:06'),
(491, NULL, 'plan', 32, 90, 2, 22, 243, 275, 'exercise', 7, NULL, NULL, NULL, '2016-05-16 03:55:06', '2016-05-16 03:55:06'),
(492, NULL, 'plan', 32, 90, 2, 22, 243, 390, 'exercise', 7, NULL, NULL, NULL, '2016-05-16 03:55:06', '2016-05-16 03:55:06'),
(493, NULL, 'plan', 32, 90, 1, 1, 186, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 03:55:07', '2016-05-16 03:55:07'),
(494, NULL, 'plan', 32, 90, 1, 1, 142, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 03:55:07', '2016-05-16 03:55:07'),
(495, NULL, 'plan', 32, 90, 1, 1, 186, 377, 'exercise', 6, NULL, NULL, NULL, '2016-05-16 03:55:07', '2016-05-16 03:55:07'),
(496, NULL, 'plan', 32, 90, 1, 1, 186, 265, 'exercise', 7, NULL, NULL, NULL, '2016-05-16 03:55:07', '2016-05-16 03:55:07'),
(497, NULL, 'plan', 32, 90, 1, 1, 186, 486, 'exercise', 7, NULL, NULL, NULL, '2016-05-16 03:55:07', '2016-05-16 03:55:07'),
(504, NULL, 'plan', 32, 90, 2, 22, 255, 0, 'lesson', 1, NULL, NULL, NULL, '2016-05-16 03:55:07', '2016-05-16 03:55:07'),
(530, NULL, 'plan', 34, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-16 07:16:36', '2016-05-20 05:02:34'),
(531, NULL, 'plan', 34, 90, 3, 7, 17, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-16 07:16:36', '2016-05-20 05:00:08'),
(532, NULL, 'plan', 34, 90, 3, 7, 263, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-16 07:16:36', '2016-05-20 05:04:06'),
(533, NULL, 'plan', 34, 90, 2, 22, 243, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:16:37'),
(534, NULL, 'plan', 34, 90, 2, 22, 196, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:16:37'),
(535, NULL, 'plan', 34, 90, 2, 26, 34, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:16:37'),
(536, NULL, 'plan', 34, 90, 2, 26, 34, 257, 'exercise', 7, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:16:37'),
(537, NULL, 'plan', 34, 90, 2, 26, 34, 16, 'exercise', 7, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:16:37'),
(538, NULL, 'plan', 34, 90, 1, 32, 70, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:16:37'),
(539, NULL, 'plan', 34, 90, 1, 32, 46, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:52:53'),
(540, NULL, 'plan', 34, 90, 1, 32, 21, 248, 'exercise', 4, NULL, NULL, NULL, '2016-05-16 07:16:37', '2016-05-16 07:52:50'),
(550, NULL, 'new', 40, 90, 3, 7, 64, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-17 11:26:02', '2016-05-17 11:26:02'),
(551, NULL, 'new', 40, 90, 3, 7, 64, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-17 11:26:22', '2016-05-17 11:26:22'),
(552, NULL, 'new', 40, 90, 3, 7, 198, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-17 12:07:40', '2016-05-17 12:07:40'),
(553, NULL, 'new', 40, 90, 3, 7, 198, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-17 12:08:51', '2016-05-17 12:08:51'),
(567, NULL, 'new', 40, 90, 3, 7, 210, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-17 12:44:28', '2016-05-17 12:44:28'),
(577, NULL, 'new', 40, 90, 3, 7, 39, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-17 12:58:10', '2016-05-17 12:58:10'),
(578, NULL, 'new', 40, 90, 2, 27, 215, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-17 12:58:13', '2016-05-17 12:58:13'),
(579, NULL, 'new', 40, 90, 2, 27, 215, 459, 'exercise', 4, NULL, NULL, NULL, '2016-05-17 12:58:16', '2016-05-17 12:58:16'),
(580, NULL, 'new', 40, 90, 2, 22, 108, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-17 12:58:23', '2016-05-17 12:58:23'),
(646, NULL, 'plan', 49, 82, 3, 9, 37, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-22 19:23:00'),
(647, NULL, 'plan', 49, 82, 2, 18, 63, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(648, NULL, 'plan', 49, 82, 1, 20, 49, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(650, NULL, 'plan', 49, 82, 4, 16, 167, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(651, NULL, 'plan', 49, 82, 3, 21, 86, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(652, NULL, 'plan', 49, 82, 2, 13, 174, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(653, NULL, 'plan', 49, 82, 1, 11, 92, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(654, NULL, 'plan', 49, 82, 1, 14, 116, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(655, NULL, 'plan', 49, 82, 4, 5, 66, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(656, NULL, 'plan', 49, 82, 4, 15, 106, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(661, NULL, 'plan', 49, 83, 3, 17, 27, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(662, NULL, 'plan', 49, 83, 2, 26, 34, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:36', '2016-05-19 21:44:36'),
(663, NULL, 'plan', 49, 83, 1, 14, 95, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(664, NULL, 'plan', 49, 83, 4, 12, 115, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(665, NULL, 'plan', 49, 83, 1, 14, 240, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(666, NULL, 'plan', 49, 83, 2, 18, 63, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:43'),
(667, NULL, 'plan', 49, 84, 3, 10, 242, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(668, NULL, 'plan', 49, 84, 2, 27, 215, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(669, NULL, 'plan', 49, 84, 1, 14, 110, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(670, NULL, 'plan', 49, 84, 4, 16, 167, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-19 21:44:37', '2016-05-19 21:44:37'),
(678, NULL, 'plan', 51, 90, 3, 7, 263, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-20 05:03:18', '2016-05-20 05:04:06'),
(680, NULL, 'plan', 51, 90, 3, 7, 237, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-20 05:03:18', '2016-05-20 05:03:32'),
(681, NULL, 'plan', 51, 90, 1, 11, 128, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-20 05:03:19', '2016-05-20 05:03:28'),
(713, NULL, 'plan', 52, 82, 3, 9, 37, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(714, NULL, 'plan', 52, 82, 2, 13, 174, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(715, NULL, 'plan', 52, 82, 1, 20, 23, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(716, NULL, 'plan', 52, 82, 4, 16, 165, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(717, NULL, 'plan', 52, 83, 3, 21, 143, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(718, NULL, 'plan', 52, 83, 2, 27, 164, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(719, NULL, 'plan', 52, 83, 1, 20, 49, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:02', '2016-05-22 19:24:02'),
(720, NULL, 'plan', 52, 83, 1, 1, 272, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(721, NULL, 'plan', 52, 83, 4, 5, 66, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(723, NULL, 'plan', 52, 100, 2, 18, 63, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(724, NULL, 'plan', 52, 100, 1, 23, 133, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(725, NULL, 'plan', 52, 100, 4, 8, 105, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(726, NULL, 'plan', 52, 116, 3, 10, 242, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(727, NULL, 'plan', 52, 116, 2, 26, 34, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-07-25 17:26:59'),
(728, NULL, 'plan', 52, 116, 1, 14, 110, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(729, NULL, 'plan', 52, 116, 4, 12, 124, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(730, NULL, 'plan', 52, 115, 3, 10, 172, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(731, NULL, 'plan', 52, 115, 2, 27, 215, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(732, NULL, 'plan', 52, 115, 1, 20, 49, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-06-08 18:27:27'),
(733, NULL, 'plan', 52, 115, 4, 16, 13, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(734, NULL, 'plan', 52, 117, 3, 10, 267, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(735, NULL, 'plan', 52, 117, 2, 22, 15, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(736, NULL, 'plan', 52, 117, 1, 14, 110, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(737, NULL, 'plan', 52, 117, 4, 3, 153, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(739, NULL, 'plan', 52, 84, 2, 31, 129, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(740, NULL, 'plan', 52, 84, 1, 32, 21, 58, 'exercise', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(741, NULL, 'plan', 52, 84, 4, 8, 2, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-22 19:24:03', '2016-05-22 19:24:03'),
(743, NULL, 'plan', 50, 90, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 04:24:40', '2016-05-24 04:24:40'),
(744, NULL, 'plan', 50, 90, 2, 29, 118, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-24 04:24:40', '2016-05-24 04:24:40'),
(746, NULL, 'plan', 50, 90, 4, 15, 51, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-24 04:24:40', '2016-05-24 04:24:40'),
(747, NULL, 'new', 54, 122, 0, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 07:53:19', '2016-05-24 07:53:28'),
(748, NULL, 'new', 54, 122, 0, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 07:53:45', '2016-05-24 07:53:45'),
(749, NULL, 'new', 54, 122, 0, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 07:53:47', '2016-05-24 07:53:47'),
(750, NULL, 'new', 54, 122, 0, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 07:54:03', '2016-05-24 07:54:03'),
(751, NULL, 'new', 54, 122, 0, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 07:54:25', '2016-05-24 07:54:25'),
(752, NULL, 'new', 54, 122, 0, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 07:54:56', '2016-05-24 07:54:56'),
(753, NULL, 'new', 54, 122, 3, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 08:06:29', '2016-05-24 08:06:29'),
(754, NULL, 'new', 54, 122, 3, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 08:09:31', '2016-05-24 08:09:31'),
(755, NULL, 'new', 54, 122, 3, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:02:50', '2016-05-24 09:02:50'),
(756, NULL, 'new', 54, 122, 3, 9, 10, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:07:26', '2016-05-24 09:07:26'),
(757, NULL, 'new', 54, 122, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:08:10', '2016-05-25 10:30:02'),
(758, NULL, 'new', 54, 122, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:08:23', '2016-05-25 10:30:03'),
(759, NULL, 'new', 54, 122, 3, 10, 120, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:08:30', '2016-05-24 09:08:30'),
(760, NULL, 'new', 54, 122, 3, 17, 76, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-24 09:08:39', '2016-05-24 09:09:21'),
(761, NULL, 'new', 54, 122, 3, 17, 76, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-24 09:08:57', '2016-05-24 09:09:21'),
(762, NULL, 'new', 54, 92, 3, 7, 39, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-24 09:13:12', '2016-05-24 09:13:12'),
(763, NULL, 'new', 54, 92, 3, 7, 58, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:13:18', '2016-05-24 09:13:18'),
(764, NULL, 'new', 54, 92, 3, 7, 190, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-24 09:13:28', '2016-05-24 09:13:28'),
(765, NULL, 'new', 54, 92, 3, 7, 157, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:13:35', '2016-05-24 09:13:35'),
(766, NULL, 'new', 54, 92, 3, 7, 83, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-24 09:13:37', '2016-05-24 09:13:37'),
(767, NULL, 'new', 54, 92, 3, 7, 157, 140, 'exercise', 4, NULL, NULL, NULL, '2016-05-24 09:13:46', '2016-05-24 09:13:46'),
(768, NULL, 'new', 54, 92, 3, 7, 157, 415, 'exercise', 4, NULL, NULL, NULL, '2016-05-24 09:13:49', '2016-05-24 09:13:49'),
(769, NULL, 'new', 54, 92, 3, 7, 157, 90, 'exercise', 4, NULL, NULL, NULL, '2016-05-24 09:13:52', '2016-05-24 09:13:52'),
(770, NULL, 'new', 54, 92, 3, 7, 157, 173, 'exercise', 4, NULL, NULL, NULL, '2016-05-24 09:13:54', '2016-05-24 09:13:54'),
(771, NULL, 'new', 54, 92, 3, 7, 157, 376, 'exercise', 4, NULL, NULL, NULL, '2016-05-24 09:13:56', '2016-05-24 09:13:56'),
(772, NULL, 'new', 54, 92, 3, 7, 157, 168, 'exercise', 4, NULL, NULL, NULL, '2016-05-24 09:13:59', '2016-05-24 09:13:59'),
(776, NULL, 'plan', 55, 126, 5, 45, 607, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-25 07:04:31', '2016-05-25 10:10:41'),
(777, NULL, 'plan', 55, 126, 7, 63, 326, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-25 07:04:31', '2016-05-25 07:04:31'),
(778, NULL, 'plan', 55, 126, 7, 63, 658, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-25 07:04:31', '2016-05-25 07:04:31'),
(779, NULL, 'plan', 55, 126, 7, 63, 412, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-25 07:04:31', '2016-05-25 07:04:31'),
(780, NULL, 'plan', 55, 126, 10, 112, 615, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-25 07:04:31', '2016-05-25 07:04:31'),
(781, NULL, 'plan', 55, 126, 10, 112, 653, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-25 07:04:31', '2016-05-25 10:11:27'),
(854, NULL, 'new', 58, 82, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-25 10:21:31', '2016-05-25 10:21:31'),
(855, NULL, 'new', 58, 82, 3, 7, 263, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-25 10:21:36', '2016-05-25 10:21:36'),
(861, NULL, 'new', 54, 122, 3, 10, 172, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-25 10:41:15', '2016-05-25 10:41:15'),
(862, NULL, 'plan', 60, 20, 5, 109, 403, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-26 00:35:56', '2016-05-26 00:36:09'),
(863, NULL, 'plan', 60, 20, 7, 63, 368, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(864, NULL, 'plan', 60, 20, 10, 117, 604, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(865, NULL, 'plan', 60, 20, 9, 38, 548, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(867, NULL, 'plan', 60, 24, 7, 97, 661, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(868, NULL, 'plan', 60, 24, 10, 112, 523, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(869, NULL, 'plan', 60, 24, 9, 38, 548, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(870, NULL, 'plan', 60, 24, 11, 42, 543, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:35:57', '2016-05-26 00:35:57'),
(871, NULL, 'plan', 61, 20, 5, 81, 387, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-26 00:37:51', '2016-05-26 00:38:03'),
(872, NULL, 'plan', 61, 127, 5, 81, 387, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-26 00:37:51', '2016-05-26 00:37:59'),
(873, NULL, 'plan', 61, 23, 5, 81, 387, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-26 00:37:51', '2016-05-26 00:37:51'),
(874, NULL, 'new', 62, 126, 9, 77, 499, 0, 'lesson', 5, NULL, NULL, NULL, '2016-05-27 04:57:08', '2016-05-27 04:57:08'),
(875, NULL, 'new', 62, 126, 9, 77, 407, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-27 04:57:13', '2016-05-27 04:57:13'),
(877, NULL, 'new', 62, 126, 9, 115, 392, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-27 04:57:25', '2016-05-27 04:57:25'),
(881, NULL, 'plan', 63, 20, 7, 98, 278, 0, 'lesson', 4, NULL, NULL, NULL, '2016-05-28 12:11:26', '2016-06-17 13:21:53'),
(883, NULL, 'plan', 63, 24, 6, 54, 300, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-28 12:11:26', '2016-06-17 13:21:56'),
(884, NULL, 'plan', 63, 24, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:11:26', '2016-05-28 12:11:26'),
(885, NULL, 'plan', 63, 24, 7, 68, 417, 0, 'lesson', 6, NULL, NULL, NULL, '2016-05-28 12:11:26', '2016-06-17 13:21:59'),
(886, NULL, 'plan', 64, 20, 7, 63, 368, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(887, NULL, 'plan', 64, 127, 7, 63, 368, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(888, NULL, 'plan', 64, 23, 7, 63, 368, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(889, NULL, 'plan', 64, 24, 10, 49, 346, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(890, NULL, 'plan', 64, 23, 9, 95, 504, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(891, NULL, 'plan', 64, 20, 5, 48, 295, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(892, NULL, 'plan', 64, 25, 5, 48, 295, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(893, NULL, 'plan', 64, 23, 5, 48, 295, 0, 'lesson', 7, NULL, NULL, NULL, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(909, NULL, 'new', 67, 24, 9, 95, 311, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-07 02:14:59', '2016-06-07 02:14:59'),
(910, NULL, 'new', 67, 24, 9, 95, 429, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-07 02:15:03', '2016-06-07 02:15:03'),
(990, NULL, 'new', 68, 71, 5, 48, 295, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-09 05:28:06', '2016-06-09 05:28:06'),
(991, NULL, 'plan', 73, 5, 3, 7, 17, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-14 13:09:22', '2016-06-14 13:09:35'),
(992, NULL, 'plan', 73, 5, 3, 7, 64, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-14 13:09:23', '2016-06-14 13:09:38'),
(993, NULL, 'plan', 74, 131, 3, 7, 17, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-14 13:09:23', '2016-06-14 13:09:31'),
(994, NULL, 'plan', 74, 131, 3, 7, 64, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-14 13:09:23', '2016-06-14 13:09:34'),
(995, NULL, 'new', 68, 71, 5, 48, 607, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-15 13:39:16', '2016-07-11 06:05:09'),
(996, NULL, 'new', 68, 71, 7, 98, 593, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-15 13:39:32', '2016-06-15 13:39:32'),
(1000, NULL, 'new', 76, 132, 3, 19, 170, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-16 06:27:13', '2016-06-16 06:27:13'),
(1039, NULL, 'new', 86, 71, 3, 21, 80, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-16 12:28:11', '2016-06-16 12:28:11'),
(1040, NULL, 'new', 86, 71, 3, 21, 567, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-16 12:28:18', '2016-06-16 12:28:18'),
(1041, NULL, 'new', 86, 71, 3, 21, 86, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-16 12:28:22', '2016-06-16 12:28:22'),
(1042, NULL, 'new', 86, 71, 3, 21, 79, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-16 12:29:28', '2016-06-16 12:29:28'),
(1043, NULL, 'new', 86, 71, 3, 21, 264, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-16 12:29:33', '2016-06-16 12:29:33'),
(1044, NULL, 'new', 86, 71, 3, 21, 40, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-16 12:29:37', '2016-06-16 12:29:37'),
(1045, NULL, 'new', 86, 71, 3, 21, 143, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-16 12:29:42', '2016-06-16 12:29:42'),
(1097, NULL, 'plan', 88, 133, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 09:16:11', '2016-06-17 09:16:11'),
(1098, NULL, 'plan', 88, 133, 2, 22, 108, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-17 09:16:11', '2016-06-17 09:16:11'),
(1099, NULL, 'plan', 88, 132, 3, 25, 69, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-17 09:16:11', '2016-06-17 09:16:11'),
(1100, NULL, 'plan', 88, 132, 3, 28, 100, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-17 09:16:11', '2016-06-17 09:16:11'),
(1101, NULL, 'plan', 88, 132, 4, 3, 208, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-17 09:16:11', '2016-06-17 09:16:11'),
(1120, NULL, 'new', 86, 128, 3, 19, 519, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 09:48:37', '2016-06-17 09:48:37'),
(1121, NULL, 'new', 86, 128, 3, 19, 641, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 09:48:43', '2016-06-17 09:48:43'),
(1122, NULL, 'new', 86, 128, 3, 19, 553, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 09:48:46', '2016-06-17 09:48:46'),
(1284, NULL, 'plan', 97, 20, 5, 45, 295, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:10:27'),
(1285, NULL, 'plan', 97, 20, 9, 47, 379, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1286, NULL, 'plan', 97, 20, 10, 50, 492, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:09:47'),
(1287, NULL, 'plan', 97, 20, 7, 104, 554, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1288, NULL, 'plan', 97, 20, 8, 96, 706, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1289, NULL, 'plan', 97, 157, 5, 45, 295, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:09:37'),
(1290, NULL, 'plan', 97, 157, 6, 51, 766, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1291, NULL, 'plan', 97, 157, 9, 47, 379, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:14:04'),
(1292, NULL, 'plan', 97, 157, 10, 50, 492, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1293, NULL, 'plan', 97, 157, 7, 104, 554, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1294, NULL, 'plan', 97, 157, 8, 96, 706, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1295, NULL, 'plan', 97, 152, 5, 45, 295, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:14:00'),
(1296, NULL, 'plan', 97, 152, 6, 51, 766, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:14:07'),
(1297, NULL, 'plan', 97, 152, 9, 47, 468, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:09:58'),
(1298, NULL, 'plan', 97, 152, 10, 93, 388, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1299, NULL, 'plan', 97, 152, 7, 40, 343, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1300, NULL, 'plan', 97, 152, 8, 96, 707, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1301, NULL, 'plan', 97, 152, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1302, NULL, 'plan', 97, 160, 5, 79, 329, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:09:41'),
(1303, NULL, 'plan', 97, 160, 11, 82, 508, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:21:16'),
(1304, NULL, 'plan', 97, 160, 6, 37, 371, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:09:55'),
(1305, NULL, 'plan', 97, 160, 9, 77, 471, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1306, NULL, 'plan', 97, 160, 10, 49, 636, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:29', '2016-06-17 13:02:29'),
(1307, NULL, 'plan', 97, 160, 7, 97, 606, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1308, NULL, 'plan', 97, 160, 8, 87, 729, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1309, NULL, 'plan', 97, 160, 5, 81, 387, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1310, NULL, 'plan', 97, 159, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1311, NULL, 'plan', 97, 159, 9, 70, 352, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:09:44'),
(1312, NULL, 'plan', 97, 159, 10, 112, 358, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:11:50'),
(1313, NULL, 'plan', 97, 159, 7, 97, 643, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:10:17'),
(1314, NULL, 'plan', 97, 159, 8, 107, 750, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1315, NULL, 'plan', 97, 159, 5, 45, 295, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1316, NULL, 'plan', 97, 159, 6, 51, 766, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:30', '2016-06-17 13:02:30'),
(1317, NULL, 'plan', 97, 153, 5, 81, 387, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:02:31', '2016-06-17 13:10:09'),
(1318, NULL, 'plan', 97, 153, 6, 51, 767, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:02:31', '2016-06-17 13:21:27'),
(1319, NULL, 'plan', 97, 153, 7, 97, 643, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:02:31', '2016-06-17 13:10:05'),
(1320, NULL, 'plan', 97, 153, 10, 49, 555, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:31', '2016-06-17 13:02:31'),
(1321, NULL, 'plan', 97, 153, 9, 70, 352, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:31', '2016-06-17 13:02:31'),
(1322, NULL, 'plan', 97, 153, 6, 113, 772, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-17 13:02:31', '2016-06-17 13:02:31'),
(1323, NULL, 'new', 58, 82, 3, 7, 17, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:10:15', '2016-06-17 13:10:15'),
(1324, NULL, 'new', 58, 82, 3, 7, 231, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:10:19', '2016-06-17 13:10:19'),
(1325, NULL, 'new', 58, 82, 3, 7, 39, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-17 13:10:23', '2016-06-17 13:10:23'),
(1326, NULL, 'new', 58, 82, 3, 21, 40, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-17 13:10:35', '2016-06-17 13:10:58'),
(1327, NULL, 'new', 58, 82, 3, 21, 40, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-17 13:10:40', '2016-06-17 13:10:58'),
(1328, NULL, 'new', 58, 82, 3, 21, 264, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:10:46', '2016-06-17 13:11:08'),
(1329, NULL, 'new', 67, 152, 5, 79, 329, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:13:19', '2016-06-17 13:13:19'),
(1330, NULL, 'new', 58, 83, 3, 21, 264, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:15:11', '2016-06-17 13:15:11'),
(1331, NULL, 'new', 58, 83, 3, 21, 80, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:15:15', '2016-06-17 13:15:15'),
(1332, NULL, 'new', 58, 83, 3, 21, 567, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:15:18', '2016-06-17 13:15:18'),
(1333, NULL, 'new', 58, 83, 3, 21, 86, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-17 13:15:22', '2016-06-17 13:15:22'),
(1334, NULL, 'new', 58, 83, 3, 21, 79, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:15:31', '2016-06-17 13:15:31'),
(1335, NULL, 'new', 58, 83, 3, 21, 513, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:15:34', '2016-06-17 13:15:34'),
(1336, NULL, 'new', 58, 83, 3, 21, 8, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-17 13:15:38', '2016-06-17 13:15:38'),
(1380, NULL, 'plan', 94, 133, 1, 32, 70, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:07', '2016-06-20 03:43:07'),
(1381, NULL, 'plan', 94, 132, 1, 32, 213, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:07', '2016-06-20 03:43:07'),
(1382, NULL, 'plan', 94, 132, 3, 7, 52, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-20 03:43:07', '2016-06-20 03:43:07'),
(1383, NULL, 'plan', 94, 133, 1, 32, 234, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1384, NULL, 'plan', 94, 132, 1, 32, 234, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1385, NULL, 'plan', 94, 133, 3, 25, 5, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1386, NULL, 'plan', 94, 132, 3, 25, 5, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1387, NULL, 'plan', 94, 133, 2, 22, 108, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1388, NULL, 'plan', 94, 132, 2, 22, 108, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1389, NULL, 'plan', 94, 133, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-20 03:43:08', '2016-06-20 03:43:08'),
(1398, NULL, 'plan', 98, 132, 3, 7, 52, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-20 03:47:16', '2016-06-20 03:47:16'),
(1399, NULL, 'plan', 98, 132, 3, 7, 17, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-20 03:47:16', '2016-06-20 03:47:16'),
(1400, NULL, 'plan', 98, 132, 3, 7, 263, 0, 'lesson', 1, NULL, NULL, NULL, '2016-06-20 03:47:16', '2016-06-20 03:47:16'),
(1401, NULL, 'plan', 99, 159, 8, 60, 713, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-23 00:22:45', '2016-06-23 00:22:51'),
(1402, NULL, 'plan', 99, 159, 7, 98, 520, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 00:22:45', '2016-06-23 00:22:45'),
(1403, NULL, 'plan', 99, 159, 10, 117, 604, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 00:22:45', '2016-06-23 00:22:45'),
(1404, NULL, 'plan', 99, 159, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 00:22:45', '2016-06-23 00:22:45'),
(1405, NULL, 'plan', 100, 157, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 00:23:57', '2016-06-23 00:23:57'),
(1406, NULL, 'plan', 100, 160, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 00:23:57', '2016-06-23 00:23:57'),
(1407, NULL, 'plan', 100, 153, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 00:23:57', '2016-06-23 00:23:57'),
(1419, NULL, 'plan', 101, 116, 3, 28, 100, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-23 19:00:25'),
(1420, NULL, 'plan', 101, 116, 1, 23, 497, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-23 19:00:25'),
(1421, NULL, 'plan', 101, 116, 4, 4, 185, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-24 01:50:11'),
(1422, NULL, 'plan', 101, 116, 2, 31, 129, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-23 19:00:25'),
(1423, NULL, 'plan', 101, 117, 3, 17, 71, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-23 19:02:16'),
(1424, NULL, 'plan', 101, 117, 2, 26, 34, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-23 19:00:25'),
(1425, NULL, 'plan', 101, 117, 1, 20, 256, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-07-03 19:16:14'),
(1426, NULL, 'plan', 101, 117, 4, 3, 28, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-23 19:00:25', '2016-06-23 19:02:20'),
(1431, NULL, 'new', 58, 100, 2, 27, 215, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-24 01:48:55', '2016-06-24 01:48:55'),
(1432, NULL, 'new', 58, 100, 2, 27, 164, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-24 01:49:00', '2016-06-24 01:49:00'),
(1433, NULL, 'new', 58, 100, 4, 4, 185, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-24 01:49:07', '2016-06-24 01:49:07'),
(1440, NULL, 'new', 58, 84, 3, 17, 184, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-24 01:52:51', '2016-06-24 01:52:51'),
(1458, NULL, 'plan', 104, 161, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1459, NULL, 'plan', 104, 163, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1460, NULL, 'plan', 104, 163, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1461, NULL, 'plan', 104, 164, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1462, NULL, 'plan', 104, 164, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1463, NULL, 'plan', 104, 164, 3, 7, 263, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1464, NULL, 'plan', 104, 133, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(1465, NULL, 'plan', 104, 133, 3, 7, 263, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1466, NULL, 'plan', 104, 133, 3, 7, 39, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1467, NULL, 'plan', 104, 133, 3, 7, 265, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:59:29'),
(1468, NULL, 'plan', 104, 132, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1469, NULL, 'plan', 104, 132, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1470, NULL, 'plan', 104, 132, 3, 10, 120, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1471, NULL, 'plan', 104, 132, 3, 10, 172, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1472, NULL, 'plan', 104, 132, 3, 10, 267, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1473, NULL, 'plan', 104, 162, 3, 9, 609, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1474, NULL, 'plan', 104, 162, 3, 17, 270, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1475, NULL, 'plan', 104, 162, 3, 17, 71, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:56:33', '2016-06-24 12:56:33'),
(1476, NULL, 'plan', 105, 161, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1477, NULL, 'plan', 105, 161, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1478, NULL, 'plan', 105, 161, 3, 7, 263, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1479, NULL, 'plan', 105, 162, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1480, NULL, 'plan', 105, 162, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1481, NULL, 'plan', 105, 163, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1482, NULL, 'plan', 105, 163, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1483, NULL, 'plan', 105, 163, 3, 7, 263, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1484, NULL, 'plan', 105, 133, 3, 19, 519, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(1485, NULL, 'plan', 105, 133, 3, 19, 641, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:22', '2016-06-24 12:58:22'),
(1486, NULL, 'plan', 105, 133, 3, 19, 170, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:22', '2016-06-24 12:58:22'),
(1487, NULL, 'plan', 105, 164, 3, 25, 69, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:22', '2016-06-24 12:58:22'),
(1488, NULL, 'plan', 105, 164, 3, 25, 65, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:58:22', '2016-06-24 12:58:22'),
(1489, NULL, 'plan', 106, 161, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(1490, NULL, 'plan', 106, 162, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(1491, NULL, 'plan', 106, 163, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(1492, NULL, 'plan', 106, 164, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(1493, NULL, 'plan', 106, 133, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(1494, NULL, 'plan', 106, 132, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(1495, NULL, 'plan', 107, 82, 3, 25, 41, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:09', '2016-06-24 13:41:09'),
(1496, NULL, 'plan', 107, 110, 3, 25, 41, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:09', '2016-06-24 13:41:09'),
(1497, NULL, 'plan', 107, 101, 3, 25, 41, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-24 13:41:09', '2016-06-24 14:01:39'),
(1498, NULL, 'plan', 107, 83, 2, 6, 126, 1071, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:41:09', '2016-06-24 13:41:09'),
(1499, NULL, 'plan', 107, 106, 2, 6, 126, 1071, 'exercise', 5, NULL, NULL, NULL, '2016-06-24 13:41:09', '2016-06-24 14:01:34'),
(1500, NULL, 'plan', 107, 114, 2, 6, 126, 1071, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1502, NULL, 'plan', 107, 114, 4, 5, 84, 92, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1503, NULL, 'plan', 107, 98, 4, 5, 84, 92, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1504, NULL, 'plan', 107, 83, 4, 4, 185, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1505, NULL, 'plan', 107, 116, 4, 4, 185, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1506, NULL, 'plan', 107, 106, 4, 4, 185, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1507, NULL, 'plan', 107, 104, 3, 17, 22, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 14:01:31'),
(1508, NULL, 'plan', 107, 105, 3, 17, 22, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1509, NULL, 'plan', 107, 114, 2, 22, 12, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1510, NULL, 'plan', 107, 121, 2, 22, 12, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1511, NULL, 'plan', 107, 119, 2, 22, 12, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:41:10', '2016-06-24 13:41:10'),
(1512, NULL, 'plan', 108, 82, 3, 21, 79, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:14', '2016-06-24 13:44:14'),
(1513, NULL, 'plan', 108, 82, 2, 29, NULL, 143, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:14', '2016-06-24 13:44:14'),
(1514, NULL, 'plan', 108, 82, 1, 11, 88, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:14', '2016-06-24 13:44:14'),
(1515, NULL, 'plan', 108, 82, 4, 5, 199, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1516, NULL, 'plan', 108, 83, 3, 9, 166, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1517, NULL, 'plan', 108, 83, 2, 27, NULL, 314, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1518, NULL, 'plan', 108, 83, 1, 23, 160, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1519, NULL, 'plan', 108, 83, 4, 4, 127, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1520, NULL, 'plan', 108, 83, 1, 14, NULL, 66, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1521, NULL, 'plan', 108, 83, 4, 3, NULL, 431, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1522, NULL, 'plan', 108, 100, 3, 9, 97, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1523, NULL, 'plan', 108, 100, 2, 13, 174, 0, 'lesson', 4, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-07-22 00:03:10'),
(1524, NULL, 'plan', 108, 100, 1, 20, 147, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1525, NULL, 'plan', 108, 100, 4, 5, 98, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1526, NULL, 'plan', 108, 116, 3, 9, 97, 0, 'lesson', 6, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-07-25 17:27:02');
INSERT INTO `student_views` (`id`, `user_type`, `creation_type`, `user_plan_id`, `student_id`, `area_id`, `chapter_id`, `lesson_id`, `exercise_id`, `status_for`, `status_id`, `state_date`, `end_date`, `order_no`, `created`, `modified`) VALUES
(1527, NULL, 'plan', 108, 116, 2, 26, 34, 0, 'lesson', 5, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-07-25 17:26:59'),
(1528, NULL, 'plan', 108, 116, 1, 14, 110, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1529, NULL, 'plan', 108, 116, 4, 5, 66, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1530, NULL, 'plan', 108, 115, 3, 9, 609, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1531, NULL, 'plan', 108, 115, 2, 13, 174, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:15', '2016-06-24 13:44:15'),
(1532, NULL, 'plan', 108, 115, 1, 32, NULL, 442, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:16', '2016-06-24 13:44:16'),
(1533, NULL, 'plan', 108, 117, 3, 28, 100, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:16', '2016-06-24 13:44:16'),
(1534, NULL, 'plan', 108, 117, 2, 29, 118, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:16', '2016-06-24 13:44:16'),
(1535, NULL, 'plan', 108, 117, 1, 11, NULL, 405, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:16', '2016-06-24 13:44:16'),
(1536, NULL, 'plan', 108, 117, 4, 15, 51, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:44:16', '2016-06-24 13:44:16'),
(1537, NULL, 'plan', 108, 117, 4, 15, NULL, 398, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:44:16', '2016-06-24 13:44:16'),
(1538, NULL, 'plan', 109, 20, 5, 101, 285, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1539, NULL, 'plan', 109, 20, 8, 96, 707, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1540, NULL, 'plan', 109, 20, 7, 63, 326, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1541, NULL, 'plan', 109, 20, 10, 58, 455, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1542, NULL, 'plan', 109, 157, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1543, NULL, 'plan', 109, 157, 8, 107, 750, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1544, NULL, 'plan', 109, 157, 7, 97, NULL, 765, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1545, NULL, 'plan', 109, 157, 10, 112, 615, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1546, NULL, 'plan', 109, 157, 9, 70, 374, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1547, NULL, 'plan', 109, 152, 7, 98, 534, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1548, NULL, 'plan', 109, 152, 10, 117, NULL, 811, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1549, NULL, 'plan', 109, 152, 6, 105, 781, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1550, NULL, 'plan', 109, 152, 9, 115, 579, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1551, NULL, 'plan', 109, 160, 7, 68, 375, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1552, NULL, 'plan', 109, 160, 10, 92, 351, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1553, NULL, 'plan', 109, 160, 9, 38, 338, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1554, NULL, 'plan', 109, 160, 6, 94, 777, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1555, NULL, 'plan', 109, 160, 6, 94, NULL, 1017, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1556, NULL, 'plan', 109, 160, 11, 42, 543, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1557, NULL, 'plan', 109, 159, 5, 52, 415, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1558, NULL, 'plan', 109, 159, 8, 107, 750, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1559, NULL, 'plan', 109, 159, 6, 94, NULL, 1017, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1560, NULL, 'plan', 109, 159, 9, 95, 536, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:35', '2016-06-24 13:54:35'),
(1561, NULL, 'plan', 109, 153, 8, 107, 749, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1562, NULL, 'plan', 109, 153, 7, 40, 684, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1563, NULL, 'plan', 109, 153, 10, 117, NULL, 811, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1564, NULL, 'plan', 109, 153, 9, 115, 489, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1565, NULL, 'plan', 109, 146, 5, 103, 533, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1566, NULL, 'plan', 109, 146, 8, 107, 749, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1567, NULL, 'plan', 109, 146, 7, 36, 835, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1568, NULL, 'plan', 109, 146, 10, 93, 291, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1569, NULL, 'plan', 109, 146, 9, 70, 374, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1570, NULL, 'plan', 109, 158, 5, 108, 546, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1571, NULL, 'plan', 109, 158, 8, 87, 729, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1572, NULL, 'plan', 109, 158, 7, 36, 835, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1573, NULL, 'plan', 109, 158, 10, 112, 653, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1574, NULL, 'plan', 109, 148, 8, 107, 749, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1575, NULL, 'plan', 109, 148, 7, 63, NULL, 795, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1576, NULL, 'plan', 109, 147, 5, 109, 403, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1577, NULL, 'plan', 109, 147, 7, 97, 643, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1578, NULL, 'plan', 109, 147, 9, 115, 392, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1579, NULL, 'plan', 109, 147, 6, 105, NULL, 1032, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1580, NULL, 'plan', 109, 149, 5, 72, 316, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1581, NULL, 'plan', 109, 149, 8, 107, NULL, 960, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1582, NULL, 'plan', 109, 149, 7, 98, 534, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1583, NULL, 'plan', 109, 149, 10, 112, 523, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1584, NULL, 'plan', 109, 150, 8, 107, NULL, 961, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1585, NULL, 'plan', 109, 150, 7, 36, 547, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1586, NULL, 'plan', 109, 150, 10, 92, 668, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1587, NULL, 'plan', 109, 150, 9, 38, 548, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 13:54:36', '2016-06-24 13:54:36'),
(1588, NULL, 'plan', 110, 143, 5, 108, 546, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1589, NULL, 'plan', 110, 143, 8, 107, 749, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1590, NULL, 'plan', 110, 143, 8, 107, 749, 957, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1591, NULL, 'plan', 110, 143, 7, 36, 650, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1592, NULL, 'plan', 110, 142, 5, 65, 366, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1593, NULL, 'plan', 110, 142, 9, 38, 531, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1594, NULL, 'plan', 110, 142, 6, 54, 787, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1595, NULL, 'plan', 110, 142, 7, 36, 650, 638, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1596, NULL, 'plan', 110, 127, 5, 103, 533, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1597, NULL, 'plan', 110, 127, 7, 36, 547, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1598, NULL, 'plan', 110, 127, 10, 117, 604, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1599, NULL, 'plan', 110, 155, 7, 97, 643, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1600, NULL, 'plan', 110, 155, 10, 112, 615, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1601, NULL, 'plan', 110, 155, 9, 70, 352, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1602, NULL, 'plan', 110, 136, 5, 81, 387, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1603, NULL, 'plan', 110, 136, 7, 63, 658, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1604, NULL, 'plan', 110, 136, 10, 46, 461, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1605, NULL, 'plan', 110, 136, 6, 94, 777, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1606, NULL, 'plan', 110, 160, 5, 103, 533, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1607, NULL, 'plan', 110, 160, 10, 58, 423, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1608, NULL, 'plan', 110, 160, 10, 58, 667, 922, 'exercise', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1609, NULL, 'plan', 110, 160, 9, 56, 309, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1610, NULL, 'plan', 110, 160, 5, 75, 396, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1611, NULL, 'plan', 110, 160, 9, 70, 564, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1612, NULL, 'plan', 110, 160, 6, 37, 768, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1613, NULL, 'plan', 110, 160, 7, 104, 554, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1614, NULL, 'plan', 110, 152, 10, 112, 653, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(1615, NULL, 'plan', 110, 152, 9, 77, 499, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:34', '2016-06-24 14:00:34'),
(1616, NULL, 'plan', 110, 152, 6, 37, 353, 0, 'lesson', 7, NULL, NULL, NULL, '2016-06-24 14:00:34', '2016-06-24 14:00:34'),
(1617, NULL, 'new', 68, 128, 7, 97, 287, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-01 09:50:33', '2016-07-14 10:11:31'),
(1618, NULL, 'new', 68, 128, 7, 97, 643, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-01 09:50:44', '2016-07-01 09:50:44'),
(1619, NULL, 'new', 68, 128, 7, 97, 606, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-01 09:50:51', '2016-07-01 09:50:51'),
(1620, NULL, 'new', 68, 128, 7, 97, 287, 721, 'exercise', 4, NULL, NULL, NULL, '2016-07-01 09:51:02', '2016-07-01 09:51:02'),
(1621, NULL, 'new', 68, 128, 7, 97, 287, 765, 'exercise', 6, NULL, NULL, NULL, '2016-07-01 09:51:06', '2016-07-01 09:51:06'),
(1622, NULL, 'new', 68, 128, 7, 97, 287, 781, 'exercise', 4, NULL, NULL, NULL, '2016-07-01 09:51:09', '2016-07-01 09:51:09'),
(1637, NULL, 'new', 113, 202, 3, 7, 52, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-05 16:14:44', '2016-07-05 16:14:44'),
(1638, NULL, 'new', 113, 202, 3, 7, 231, 0, 'lesson', 5, NULL, NULL, NULL, '2016-07-05 16:15:03', '2016-07-05 16:15:03'),
(1639, NULL, 'new', 113, 202, 3, 7, 237, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-05 16:15:19', '2016-07-05 16:15:19'),
(1640, NULL, 'new', 113, 202, 2, 29, 178, 0, 'lesson', 5, NULL, NULL, NULL, '2016-07-05 16:15:43', '2016-07-05 16:15:43'),
(1641, NULL, 'plan', 114, 202, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:32', '2016-07-05 16:20:32'),
(1642, NULL, 'plan', 114, 203, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:36', '2016-07-05 16:20:36'),
(1643, NULL, 'plan', 114, 202, 3, 7, 263, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1644, NULL, 'plan', 114, 203, 3, 7, 263, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1645, NULL, 'plan', 114, 202, 3, 7, 265, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1646, NULL, 'plan', 114, 203, 3, 7, 265, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1647, NULL, 'plan', 114, 202, 2, 29, 244, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1648, NULL, 'plan', 114, 203, 2, 29, 244, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1649, NULL, 'plan', 114, 203, 2, 29, 118, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:37', '2016-07-05 16:20:37'),
(1650, NULL, 'plan', 114, 202, 1, 23, 248, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1651, NULL, 'plan', 114, 202, 1, 23, 133, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1652, NULL, 'plan', 114, 203, 1, 23, 133, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1653, NULL, 'plan', 114, 202, 4, 15, 51, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1654, NULL, 'plan', 114, 203, 4, 15, 51, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1655, NULL, 'plan', 114, 202, 4, 15, 106, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1656, NULL, 'plan', 114, 203, 4, 15, 106, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:38', '2016-07-05 16:20:38'),
(1657, NULL, 'plan', 114, 202, 4, 15, 78, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:39', '2016-07-05 16:20:39'),
(1658, NULL, 'plan', 114, 203, 1, 20, 147, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:39', '2016-07-05 16:20:39'),
(1659, NULL, 'plan', 114, 202, 1, 20, 246, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-05 16:20:39', '2016-07-05 16:20:39'),
(1660, NULL, 'plan', 115, 205, 3, 7, 52, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1661, NULL, 'plan', 115, 205, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1662, NULL, 'plan', 115, 205, 3, 7, 39, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1663, NULL, 'plan', 115, 205, 2, 27, 164, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1664, NULL, 'plan', 115, 205, 2, 27, 215, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1665, NULL, 'plan', 115, 205, 1, 32, 94, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1666, NULL, 'plan', 115, 205, 1, 32, 205, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1667, NULL, 'plan', 115, 205, 3, 17, 91, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1668, NULL, 'plan', 115, 205, 2, 22, 108, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1669, NULL, 'plan', 115, 205, 1, 1, 186, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1670, NULL, 'plan', 115, 205, 2, 22, 255, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1671, NULL, 'plan', 115, 205, 2, 22, 196, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(1672, NULL, 'new', 68, 74, 7, 35, 393, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-11 05:39:52', '2016-07-11 05:39:52'),
(1673, NULL, 'new', 41, 92, 5, 43, 356, 0, 'lesson', 5, NULL, NULL, NULL, '2016-07-11 05:49:35', '2016-07-11 05:49:35'),
(1674, NULL, 'new', 41, 92, 5, 109, 403, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-11 05:49:59', '2016-07-11 05:49:59'),
(1675, NULL, 'new', 41, 92, 5, 48, NULL, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-11 05:50:17', '2016-07-11 05:50:17'),
(1676, NULL, 'new', 68, 128, 7, 36, 622, 0, 'lesson', 5, NULL, NULL, NULL, '2016-07-14 07:01:47', '2016-07-14 07:01:47'),
(1677, NULL, 'new', 68, 128, 8, 107, 750, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 07:02:48', '2016-07-14 07:02:48'),
(1678, NULL, 'new', 68, 128, 8, 107, 749, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 07:02:53', '2016-07-14 07:02:53'),
(1679, NULL, 'new', 68, 74, 5, 75, 396, 0, 'lesson', 5, NULL, NULL, NULL, '2016-07-14 07:03:54', '2016-07-14 07:03:54'),
(1680, NULL, 'new', 68, 128, 7, 97, 661, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 10:11:42', '2016-07-14 10:11:42'),
(1681, NULL, 'new', 68, 128, 7, 98, 278, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 10:12:08', '2016-07-14 10:12:08'),
(1682, NULL, 'new', 68, 128, 7, 98, 520, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 10:12:15', '2016-07-14 10:12:15'),
(1683, NULL, 'new', 68, 128, 7, 98, 534, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 10:12:20', '2016-07-14 10:12:20'),
(1684, NULL, 'new', 68, 128, 7, 98, 593, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:15:02', '2016-07-14 11:15:02'),
(1685, NULL, 'new', 68, 74, 5, 72, 500, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 11:27:24', '2016-07-14 11:27:24'),
(1686, NULL, 'new', 68, 74, 5, 72, 335, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 11:27:31', '2016-07-14 11:27:31'),
(1687, NULL, 'new', 68, 74, 5, 72, 316, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 11:27:39', '2016-07-14 11:27:39'),
(1688, NULL, 'new', 68, 74, 5, 72, 399, 0, 'lesson', 5, NULL, NULL, NULL, '2016-07-14 11:27:53', '2016-07-14 11:28:25'),
(1689, NULL, 'new', 68, 74, 5, 59, 465, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 11:28:33', '2016-07-14 11:28:33'),
(1690, NULL, 'new', 68, 74, 10, 92, 673, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 11:28:45', '2016-07-14 11:28:45'),
(1691, NULL, 'new', 68, 74, 10, 92, 434, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 11:28:48', '2016-07-14 11:28:48'),
(1692, NULL, 'new', 68, 74, 10, 92, 649, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 11:28:50', '2016-07-14 11:28:50'),
(1693, NULL, 'new', 68, 74, 10, 92, 845, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 11:28:52', '2016-07-14 11:28:52'),
(1694, NULL, 'new', 68, 74, 10, 92, 581, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 11:28:55', '2016-07-14 11:28:55'),
(1695, NULL, 'new', 68, 74, 10, 92, 574, 881, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 11:29:02', '2016-07-14 11:29:02'),
(1696, NULL, 'new', 68, 74, 10, 92, 633, 881, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 11:29:11', '2016-07-14 11:29:11'),
(1697, NULL, 'new', 68, 74, 10, 92, 339, 881, 'exercise', 6, NULL, NULL, NULL, '2016-07-14 11:29:14', '2016-07-14 11:29:14'),
(1698, NULL, 'new', 68, 74, 10, 92, 406, 881, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 11:29:20', '2016-07-14 11:29:20'),
(1743, NULL, 'plan', 116, 128, 5, 48, 607, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1744, NULL, 'plan', 116, 128, 7, 104, 554, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1745, NULL, 'plan', 116, 128, 10, 50, 492, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1746, NULL, 'plan', 116, 128, 10, 112, 391, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1747, NULL, 'plan', 116, 128, 10, 112, 349, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1748, NULL, 'plan', 116, 128, 10, 112, 523, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1749, NULL, 'plan', 116, 128, 10, 112, 358, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 11:58:31', '2016-07-14 11:58:31'),
(1750, NULL, 'plan', 117, 71, 5, 108, 546, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 12:07:32', '2016-07-14 12:07:32'),
(1751, NULL, 'plan', 117, 87, 5, 108, 546, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-14 12:07:32', '2016-07-14 12:07:32'),
(1752, NULL, 'new', 68, 74, 5, 65, 366, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 12:08:37', '2016-07-14 12:08:37'),
(1753, NULL, 'new', 68, 74, 8, 84, 763, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 12:09:10', '2016-07-14 12:09:10'),
(1754, NULL, 'new', 68, 74, 8, 84, 760, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 12:09:13', '2016-07-14 12:09:13'),
(1755, NULL, 'new', 68, 74, 8, 84, 761, 0, 'lesson', 6, NULL, NULL, NULL, '2016-07-14 12:09:18', '2016-07-14 12:09:18'),
(1756, NULL, 'new', 68, 74, 8, 84, 765, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 12:09:22', '2016-07-14 12:09:22'),
(1757, NULL, 'new', 68, 74, 8, 84, 758, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-14 12:09:25', '2016-07-14 12:09:25'),
(1758, NULL, 'new', 68, 74, 8, 107, 750, 959, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 12:10:03', '2016-07-14 12:10:03'),
(1759, NULL, 'new', 68, 74, 8, 107, 750, 960, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 12:10:07', '2016-07-14 12:10:07'),
(1760, NULL, 'new', 68, 74, 8, 107, 750, 961, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 12:10:09', '2016-07-14 12:10:09'),
(1761, NULL, 'new', 68, 74, 8, 107, 750, 965, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 12:10:12', '2016-07-14 12:10:12'),
(1762, NULL, 'new', 68, 74, 8, 107, 750, 962, 'exercise', 5, NULL, NULL, NULL, '2016-07-14 12:10:34', '2016-07-14 12:10:34'),
(1763, NULL, 'new', 68, 74, 8, 107, 750, 964, 'exercise', 6, NULL, NULL, NULL, '2016-07-14 12:10:37', '2016-07-14 12:10:37'),
(1764, NULL, 'new', 68, 74, 8, 107, 750, 963, 'exercise', 4, NULL, NULL, NULL, '2016-07-14 12:10:39', '2016-07-14 12:10:39'),
(1765, NULL, 'new', 58, 82, 3, 17, 76, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-25 17:16:58', '2016-07-25 17:16:58'),
(1766, NULL, 'new', 58, 82, 3, 17, 270, 0, 'lesson', 4, NULL, NULL, NULL, '2016-07-25 17:17:36', '2016-07-25 17:17:36'),
(1787, NULL, 'plan', 119, 100, 3, 7, 17, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 17:30:54', '2016-07-25 17:30:54'),
(1799, NULL, 'plan', 111, 82, 3, 21, 80, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:12:29', '2016-07-25 22:12:29'),
(1800, NULL, 'plan', 111, 82, 2, 18, 63, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:12:29', '2016-07-25 22:12:29'),
(1801, NULL, 'plan', 111, 82, 1, 14, 216, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:12:29', '2016-07-25 22:12:29'),
(1802, NULL, 'plan', 111, 100, 3, 9, 609, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:12:29', '2016-07-25 22:12:29'),
(1803, NULL, 'plan', 111, 100, 1, 32, 94, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:12:29', '2016-07-25 22:12:29'),
(1810, NULL, 'plan', 122, 100, 3, 9, 603, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:14:23', '2016-07-25 22:14:23'),
(1811, NULL, 'plan', 122, 100, 2, 6, 241, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:14:23', '2016-07-25 22:14:23'),
(1812, NULL, 'plan', 122, 100, 2, 6, NULL, 483, 'exercise', 7, NULL, NULL, NULL, '2016-07-25 22:14:23', '2016-07-25 22:14:23'),
(1813, NULL, 'plan', 122, 100, 1, 23, 497, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:14:23', '2016-07-25 22:14:23'),
(1836, NULL, 'plan', 118, 117, 3, 28, 100, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:49:32', '2016-07-25 22:49:32'),
(1837, NULL, 'plan', 118, 117, 2, 6, 241, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:49:33', '2016-07-25 22:49:33'),
(1838, NULL, 'plan', 118, 117, 2, 6, NULL, 483, 'exercise', 7, NULL, NULL, NULL, '2016-07-25 22:49:33', '2016-07-25 22:49:33'),
(1839, NULL, 'plan', 118, 117, 1, 1, NULL, 377, 'exercise', 7, NULL, NULL, NULL, '2016-07-25 22:49:33', '2016-07-25 22:49:33'),
(1840, NULL, 'plan', 118, 100, 3, 21, 567, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:49:33', '2016-07-25 22:49:33'),
(1841, NULL, 'plan', 121, 82, 3, 25, 41, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1842, NULL, 'plan', 121, 116, 3, 25, 41, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1843, NULL, 'plan', 121, 104, 3, 25, 41, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1844, NULL, 'plan', 121, 83, 3, 25, 117, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1845, NULL, 'plan', 121, 100, 3, 25, 117, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1846, NULL, 'plan', 121, 117, 3, 25, 117, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1847, NULL, 'plan', 121, 104, 3, 25, 117, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1848, NULL, 'plan', 121, 82, 3, 17, 71, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1849, NULL, 'plan', 121, 83, 3, 17, 71, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-25 22:50:05', '2016-07-25 22:50:05'),
(1850, NULL, 'plan', 123, 83, 3, 17, 22, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1851, NULL, 'plan', 123, 82, 2, 22, 15, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1852, NULL, 'plan', 123, 83, 1, 20, 6, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1853, NULL, 'plan', 123, 84, 1, 20, 6, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1854, NULL, 'plan', 123, 101, 1, 32, 46, 79, 'exercise', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1855, NULL, 'plan', 123, 119, 1, 32, 46, 79, 'exercise', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1856, NULL, 'plan', 123, 101, 2, 27, 164, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1857, NULL, 'plan', 123, 108, 2, 27, 164, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1858, NULL, 'plan', 123, 103, 2, 27, 164, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1859, NULL, 'plan', 123, 83, 2, 22, 54, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1860, NULL, 'plan', 123, 120, 2, 22, 54, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1861, NULL, 'plan', 123, 107, 2, 22, 54, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1862, NULL, 'plan', 123, 120, 1, 1, 186, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1863, NULL, 'plan', 123, 107, 1, 1, 186, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1864, NULL, 'plan', 123, 84, 4, 15, 4, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1865, NULL, 'plan', 123, 110, 4, 15, 4, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1866, NULL, 'plan', 123, 118, 4, 15, 78, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1867, NULL, 'plan', 123, 109, 4, 15, 78, 0, 'lesson', 7, NULL, NULL, NULL, '2016-07-26 01:34:35', '2016-07-26 01:34:35'),
(1868, NULL, 'new', 67, 152, 10, 49, 346, 0, 'lesson', 6, NULL, NULL, NULL, '2016-09-28 22:35:14', '2016-09-28 22:35:14');

-- --------------------------------------------------------

--
-- Table structure for table `thumbs`
--

CREATE TABLE IF NOT EXISTS `thumbs` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `thumbnail` text NOT NULL,
  `type` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `thumbs`
--

INSERT INTO `thumbs` (`id`, `name`, `thumbnail`, `type`, `created`, `modified`) VALUES
(2, 'qeqweqwewq', '700324567_f2l930yhs1rsqu3.medium.jpg', 1, '2015-07-24 09:43:56', '2015-07-24 09:43:56'),
(3, 'Slide1', '1925578909_c61sekpealupopldyqqukbp2zi6rdcyffwpwpwyekdfed2qwswbfne9jp9b6ngb8.jpg', 1, '2015-07-24 09:49:47', '2015-07-24 09:49:47'),
(4, 'Slide2', '1150972094_napstercrew.png', 1, '2015-07-24 09:49:58', '2015-07-24 09:49:58'),
(5, 'Slide3', '303205619_programmerhdwallpaperbypcbots.png', 1, '2015-07-24 09:50:07', '2015-07-24 09:50:07'),
(6, 'sadsadsas', '1031456057_screenshotfrom20150602124603.png', 2, '2015-07-31 11:32:29', '2015-07-31 11:34:34'),
(7, '432432', '1682762579_499787.png', 2, '2015-08-05 10:25:46', '2015-08-05 10:25:46'),
(8, 'dasdsa', '778962091_screenshotfrom20150507145059.png', 3, '2015-08-05 10:26:16', '2015-08-05 10:26:16');

-- --------------------------------------------------------

--
-- Table structure for table `upload_images`
--

CREATE TABLE IF NOT EXISTS `upload_images` (
  `id` bigint(11) NOT NULL,
  `type` enum('user','form') NOT NULL,
  `user_id` int(5) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `upload_images`
--

INSERT INTO `upload_images` (`id`, `type`, `user_id`, `name`) VALUES
(13, 'user', 17, 'Jay452113891-1436168395.jpeg'),
(14, 'user', 17, 'Jay1569966193-1436168395.jpeg'),
(15, 'form', 18, 'Jay1642691427-1436176091.jpeg'),
(16, 'form', 18, 'Jay668833617-1436176091.jpeg'),
(17, 'form', 19, 'Jay1784536921-1436176295.jpeg'),
(18, 'form', 20, 'Jay1657253632-1436176922.jpeg'),
(19, 'form', 21, 'Jay1047652362-1436178064.jpeg'),
(20, 'form', 26, 'Jay1497737070-1436180043.jpeg'),
(21, 'user', 28, 'Jay149076589-1436181286.jpeg'),
(22, 'form', 28, 'Jay331477591-1436181286.jpeg'),
(23, 'user', 30, 'Neetika2116555219-1436187768.jpeg'),
(24, 'form', 30, 'Neetika635030202-1436187768.jpeg'),
(25, 'user', 38, 'aaaa1255373633-1437036984.jpeg'),
(26, 'user', 39, 'aaaa1715768893-1437037241.jpeg'),
(27, 'form', 39, 'aaaa619448932-1437037241.jpeg'),
(28, 'form', 39, 'aaaa506245443-1437037241.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL,
  `username` varchar(55) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `group_id` int(1) NOT NULL DEFAULT '2' COMMENT '1=Admin, 2=User',
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `classroom` varchar(100) DEFAULT NULL,
  `image` varchar(500) DEFAULT NULL,
  `is_trial` int(1) DEFAULT '1' COMMENT '1=On, 0=Off',
  `is_paid` int(1) DEFAULT '0' COMMENT '1=On, 0=Off',
  `is_free_used` int(11) NOT NULL DEFAULT '0',
  `product_id` int(11) NOT NULL DEFAULT '1' COMMENT 'Default is 1 Free trial plan',
  `user_type` int(2) NOT NULL DEFAULT '1' COMMENT '1=Primary, 2=Elementry',
  `gender` int(11) NOT NULL DEFAULT '1' COMMENT '1=Male, 2=Female',
  `dob` date NOT NULL,
  `mobile` varchar(20) NOT NULL,
  `zipcode` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `city` varchar(50) NOT NULL,
  `country_id` int(11) NOT NULL,
  `sessionId` varchar(100) DEFAULT NULL,
  `verification_token` varchar(50) DEFAULT NULL,
  `forgotpass_token` varchar(50) DEFAULT NULL,
  `is_verified` int(1) NOT NULL DEFAULT '0' COMMENT '0=Default, 1=Active, 2=In active',
  `status_id` int(1) NOT NULL DEFAULT '0' COMMENT '0=Not verified, 1=Verified',
  `is_active` tinyint(1) DEFAULT '1',
  `last_login` datetime NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `group_id`, `first_name`, `last_name`, `classroom`, `image`, `is_trial`, `is_paid`, `is_free_used`, `product_id`, `user_type`, `gender`, `dob`, `mobile`, `zipcode`, `address`, `city`, `country_id`, `sessionId`, `verification_token`, `forgotpass_token`, `is_verified`, `status_id`, `is_active`, `last_login`, `created`, `modified`) VALUES
(1, 'admin', 'pawan@xicom.biz', '$2y$10$oAPlcmCsHEvackc71kmIrevpPLuwAk0swB9fpjewswu0.16dtW6Xa', 1, 'Vivek', 'K', 'xyz', '', 1, 0, 0, 1, 1, 1, '1999-11-30', '8888888888', '', 'Address', 'City', 99, 'ddB3x7N5dIltu7CWlNqLRrYdn', 'bbXVqGftA29RhJXwdzzhNFS0T', '', 1, 1, 1, '2016-06-23 19:07:43', '2016-01-14 05:54:00', '2016-07-04 09:20:54'),
(2, 'boranab', 'bharat.borana@xicom.biz', '$2y$10$zME9W4VpHG4LhKyqTRoNO.mZIkmocxqMtv4pErVkPJv30upkot.w2', 2, 'Bhavin', 'Borana', NULL, '296425550_screenshotfrom20151203184209.png', 1, 0, 0, 1, 1, 1, '1999-11-30', '', '', '', '', 0, 'UGoo6Dy8pY1aDnmXVl2pjlI02', '92MqSLEmcjxY5uYjiHG9sugZy', '', 1, 3, 1, '1945-05-12 06:45:00', '2015-12-09 05:53:00', '2016-01-21 09:51:00'),
(3, 'gurtej', 'gurtej@xicom.biz', '$2y$10$VMR20NcbRbUvT007lMK/u.8eCmU1gpeVYyL2p5yOtOl5PF.25rK8K', 2, 'gurtej', 'singh', NULL, '2044292103_cdvphoto001.jpg', 1, 0, 0, 1, 1, 1, '1999-11-30', '', '', '', '', 0, 'Cw64wfUJF24MIDPu1br5rCkcV', 'Qcp8k6Fz3MolW3fafLjd3BI3X', '', 1, 1, 1, '2016-01-21 09:49:00', '2015-12-10 06:39:00', '2016-01-22 12:51:07'),
(5, 'chitvan', 'chitvan@xicom.biz', '$2y$10$AIVbBgnK8d7FIzajpooSjOrSUYRTaozmsjRlPNuE9AyJH3ewn2QHe', 2, 'Chitvan ', 'Seth', NULL, '', 1, 0, 0, 1, 1, 1, '1999-11-30', '', '', '', '', 0, 'B0Rj4r50vaMPSRvTY0RuLaXFC', 'MW34MjH4G06uYwLitUrG3KmZX', '', 1, 1, 1, '2016-01-21 09:49:00', '2016-01-19 14:38:00', '2016-01-21 09:51:00'),
(6, 'vivek', 'vivekveer@xicom.biz', '$2y$10$5BkPLrFz8Lz2eaZAxL6f4e64XiB0bHgo/ZF61LLAuqibp253YCHJW', 2, 'vivek', 'veer', NULL, NULL, 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, 'gbMZBLGurtaTBg6MU8RlEYxU4', 'HTFMFr85dbD15rv6bg672QQzh', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-01-21 11:18:09', '2016-01-21 11:18:09'),
(7, 'hary', 'harmeet@xicom.biz', '$2y$10$VQwJ.nO5MwS3aSw57pL3/Oz/nrgqTNOW3NKC35luytzEW6IQgX/nW', 2, 'Harmeets', 'Singh', 'Hary', '1291204542_modified.jpg1456988504762', 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'PwA8xDqrz3nOzKsLe5EaTRg16', '2qATeiewioFEMdtsWNnizIKTf', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-01-21 12:06:26', '2016-06-15 13:00:48'),
(9, 'lisawell', 'lisareinst@gmail.com', '$2y$10$v40MyslhrwheN3rxj7kwg.evEn3vx/K4AjncJYQhpfqZwxRcMhFWu', 2, 'Lisa', 'Wellhausen', NULL, NULL, 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, '2RqvaNAEBTpVjJ1V6q8BgsN01', 'zLyvWp97C10v3KrpziVo59R1V', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-01-28 17:24:21', '2016-07-14 04:51:04'),
(10, 'Teachus', 't@yopmail.com', '$2y$10$dBOz3RZCfdo7Dn1DwwAnfuvF1i6IuG672vPRuEIG1Aid/yumDDKhm', 2, 'Teacher', 'New', NULL, NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '786777788', '', '', '', 0, 'e3d37lRvXVlw1GPQnzUhYRCuJ', 'OnC3Qz5kiOHJ4TpXlvRo3AlWx', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-02-15 11:35:57', '2016-02-15 11:44:38'),
(13, 'inderpal', 'inderpal@xicom.biz', '$2y$10$ujSxPyV7ro/2HiZuR07ziemLqJ6tumrrT3XAXYXVrs4S/Z/9h3dZa', 2, 'Inderpal', 'Singh', NULL, '1022861829_img1456744456474.jpg', 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'krNhV87XNrTqmpNhUPuY64yV2', 'ik8TpaO8xIO18KifxuAdV1FcD', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-02-25 10:43:37', '2016-03-07 07:40:35'),
(17, 'bablixicom', 'testNotes@mailinator.com', '$2y$10$ROdlzr4lcPFn8chOjTQU9.uL3KLouRhvnxCZQSy2S1YA6vtIKJ6Su', 2, 'Babli', 'Bistt', NULL, NULL, 1, 0, 0, 1, 1, 2, '0000-00-00', '', '', '', '', 0, 'oF0KKeTtwRNf6e44I7fa0umNI', 'xAFAUQgCVBSGstPyp8QkbLSkR', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-03-10 10:32:03', '2016-03-10 12:40:21'),
(18, 'femaletest', 'female@mailinator.com', '$2y$10$D0smF2Z6NhsAhnX4oh8o8OPEPgTImHMyomw/KUviX21CMsm0t4OIm', 2, 'She', 'Girl', NULL, '1677939125_img1457607504713.jpg', 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, '', 'ceYePfnWaf5HBgQ1shMC4u7Jm', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-03-10 10:54:29', '2016-03-10 11:41:39'),
(19, 'kloppsl', 'slklopp@yahoo.com', '$2y$10$ZI.FEw/8GYanCBWOPVlPYOl3d6fFlOq/.Gz1MC3XIK04YkhlCw976', 2, 'Stefanie', 'Klopp', NULL, NULL, 1, 0, 0, 1, 2, 2, '0000-00-00', '', '', '', '', 0, 'bYlc0A4JrbfBS6rVAOTx9rFFi', 'SJQ6waGQQ3umXWly7vQvZfjAC', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-03-29 22:14:25', '2016-03-29 22:21:04'),
(20, 'kariwell', 'oliverstoes@gmail.com', '$2y$10$MDhCHTqK0.CeauSYBxaUfOC4raXJc4O5n0ZWJ1XvgwmOHMrN7/vhi', 2, 'Well', 'Kari', 'Upper El 27', NULL, 1, 0, 0, 1, 2, 2, '0000-00-00', '', '', '', '', 0, 'iWa5bkjaAgwkHWobWeHviy2PU', 'eYfWmKrq3uZQvz3Rwxm3TwEKi', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-04-11 23:31:00', '2016-06-24 13:55:28'),
(21, 'anmolverma', 'anmol.verma4@gmail.com', '$2y$10$axPexnLgAYq28KCLtWcnX.lDogPwPeERANBCuLRyw6OeZvihOtQP6', 2, 'Anmol', 'Verma', 'Some class', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'nitRZA6MEMAOecYD6cHry58sg', 'fM3FN9sCaoUd3kmoHUaNlKldR', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-04-14 09:43:14', '2016-05-25 07:04:04'),
(22, 'annewell', 'hello@montessorinotes.com', '$2y$10$zlolJmsk.k0t/.01wyB6CujM0jMWAcfTkFPDk2fcEgg9VbCd6yvW2', 2, 'Anne', 'Wellhardt', 'room 26', NULL, 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, '61LnUZYCzBAIHchq90ehJBN7I', 'AIzCY95CyJWJO7Imwn78KQiA9', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-04-19 17:47:14', '2016-04-29 16:16:15'),
(25, 'anmol92verma', 'anmol@xicom.biz', '$2y$10$wMtK3bXm8AiAM3ZEAcjgrOQd2wnNoGvADZGlmX.P1nM/phoADb5uu', 2, 'Anmol', 'Verma', 'Test Class', '1567801544_img1462188768148.jpg', 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, '17o3gdksZfh4RzVBO5kbLBtnk', 'eGPtFdawhmhX6LKdDhZKFQT4k', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-04-27 10:43:22', '2016-07-11 05:51:26'),
(26, 'vickyxicom', 'vicky.sharma@xicom.biz', '$2y$10$cd8cMVO.RNM67QK/83.rQOGElq6qH1kSgG5W6q5VAP4do5n4CAxoe', 2, 'Mohit', 'Kashyp', 'Prep B ', '37156967_userimage11072016112456.jpg', 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, 'eHF1OcYtIztJLovAaO7LAyAv3', 'RB15ddrzJcYBNICxAU5EzCGOZ', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-04-29 06:34:27', '2016-09-20 11:54:15'),
(27, 'adminx', 'pawan.xicom@gmail.com', '$2y$10$3X91pf8mB26TMa4ZT0OBJOxdxk0VM6VJ3YyU6dCL3vYySZuLjO.yq', 1, 'Xicom', '', 'Secondary', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 99, 'tP47SjYul4HyvhiIfTwYw3yq8', 'svri6EBTdxHK96E03nPITutOh', NULL, 1, 1, 1, '2016-06-30 13:18:07', '2016-05-06 08:17:23', '2016-06-30 13:18:07'),
(29, 'lisarein', 'reinhal@gmail.com', '$2y$10$kviHiMMbM44rgKxGk2DX2.ENtkyBh/HtOJCfvOSDPXmCMa21vYauy', 2, 'Lisa ', 'Reinhardt', 'Children''s House 16', '817983366_userimage09052016062534.jpg', 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'Q7CrDPygOprSgJT6YBZtnbKlq', '8OZsg8q1L5A28ILE1ftVqQft1', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-05-07 02:33:47', '2016-09-05 13:21:12'),
(30, 'harish', 'harish@mailinator.com', '$2y$10$Fw6EuhkfoBztYp.PyEncZ.cIlg2jv3aFhuAdW.onaIjWPq.wZJ7yO', 2, 'Harish', 'Singh', 'Jxjd', '1953379713_img1463038502509.jpg', 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'HyUQnBT7wvRJfBYBrFRFEDUCf', '3KUBKcKJflQGgdZLfXCi9jAYX', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-05-12 07:29:07', '2016-05-16 07:14:56'),
(31, 'Qurab', 'qurab@mailinator.com', '$2y$10$stUlbEzko0Wm8YrQOWH2augKLrDHp4FQBbwGRzliFXTUXAZjC70IS', 2, 'Test', 'Account', 'X', NULL, 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, 'gv0e9KoI8JLTeOPkRdywGMrdE', '9ynl3Lu2V53neEtdUxSD37Ndp', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-06-06 10:25:51', '2016-06-06 10:28:07'),
(32, 'anmolverma123', 'anmol@mailinator.com', '$2y$10$pj7LKautV03vmaJejJUDxe05nSS6XCEYxefItjzdpBsP9dnN8FkXy', 2, 'anmol', 'verma', 'fsdf', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'WBhBGpwzutOvzS4fa2twuIUrz', 'VS4We164yFhYdmrfnWQxzsEsX', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-06-09 06:11:05', '2016-06-09 06:11:53'),
(33, 'kamal', 'kamal@xicom.biz', '$2y$10$Pma/B8uRNfpRLdYZsHuloOyg4EmaYM7ni0fwTOV3F4mACzgs8JPFG', 2, 'dsjkdsjfk', 'fjsjfk', 'dsf', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, '9PGe8LC4U9nZZDA1Hv0oXxY3u', 'oW9wi5QgA13VZHrxz6W4GqLr2', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-06-09 06:13:09', '2016-06-09 06:46:48'),
(34, 'sanu', 'sanu@gmail.com', '$2y$10$Lj6nlcDOUzzHobHjUSXvWewsWPle0XWAflpKCpuMKs6RwqwvpX/Rm', 2, 'Kumar', 'Sanu', 'Sanu Class', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'm4bzP4FoRK2SiPDzGCY29YTLP', '5zN4E0yMLhRZolxZRCRqAvFOS', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-06-13 06:13:04', '2016-06-14 16:23:55'),
(35, 'anmol.verma4', 'anmolverma@mailinator.com', '$2y$10$J5x9imUD0022FTdG9EqHE.K0GY7PkdS0iSb3zwj1iV1kqynxltMf.', 2, 'Anmol', 'Verma', 'Class', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, '75ysH1lj6G1ArzJlYF5mFFKem', 'SC5kHtKx8TpWKnZAozGeLBurG', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-06-16 05:58:07', '2016-07-06 03:50:46'),
(36, 'Gary''s', 'harys@yopmail.com', '$2y$10$MCHSno8taofk55DRNqbozec6.jk79nZT1Ob/qWWjN.D3BQ6fMXLka', 2, 'Hary', 'Elementary', 'Eng', NULL, 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, '8rL4pV8dhDQOjoNYaHbfazSm2', '3OlvDxFxZFMUd4snDctoIzRc8', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-06-16 07:49:26', '2016-06-16 07:49:26'),
(37, 'Mahesh', 'mahesh@mailinator.com', '$2y$10$kBUT1gD6KafY4CMZIIv59uW3iyqkMW7vAwTSP2GkDad85D35zOgZG', 2, 'Mahesh', 'Yadav', 'Class 2', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'BmFETXyJmWBCi3kedwQvzvWkZ', 'UPonRglsHVabCh3FqKurc2nCV', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-01 11:47:56', '2016-07-01 11:47:56'),
(38, 'test', 'test@mailinator.com', '$2y$10$HIB2WTqtIkaqSDsNfQZ7wOlgN61kv5BoMI4AfaQ0NSOA0lqd2NVzS', 2, 'Test', 'Test', 'Class_test', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'dJFkTwN8GbVHI6JUvb6SZJzqy', 'tf9nN1xa1cpsbmNCGrOYwYVg1', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-01 11:59:08', '2016-07-01 11:59:08'),
(39, 'TestUser', 'account@mailinator.com', '$2y$10$jwtt8VYHqEjvFXkUuijnhOTfFO8OekfDVDJzKtA4kAJgKdtqZ/K5W', 2, 'Account', 'Test', 'Class II', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'v5mZDRbS2FjibDjkYj9BkkrOF', 'bfauqgvj18kZPD0aQukwfLTsY', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-01 12:07:42', '2016-07-01 12:07:42'),
(40, '123', '123@ff.com', '$2y$10$rvbH6IOW9Rp8vvYXDY63vO.7VSe6NMn/QTK4ojQA.34V7fgqIm6me', 2, 'Account 123 ', '123', '123', NULL, 1, 0, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, '95w4nXt547cF7eOFPtpVerl06', 'oH7E7A019yAFJ6L1qLEH1YBJ5', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-01 12:08:37', '2016-07-01 12:08:37'),
(41, 'pawan', 'pawan@mailinator.com', '$2y$10$gmAu1N2YwBz3OCOyOa5jyeBweBWMCk9sjfEebDwGQAYN9JsE2QvtS', 2, 'Pawan', 'Kumar', 'Clsas II', NULL, 1, 1, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, '', 'G7Z1cfakg7jpLarxSFGc8tpGc', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-04 09:17:46', '2016-07-05 04:08:52'),
(42, 'anuj', 'anuj@gmail.com', '$2y$10$yEHW8gGrQQoymdPGkDHcuOQCeKiKPNOnCkC9uLPqGIvX5Xmbe44xe', 2, 'Anju', 'Bhatia', 'xyz', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'xJBkF9MjTah7gB6zUbRmimkPi', 'sEJoYe6jYjj5hr6vYxVXYeOPL', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-04 10:49:48', '2016-07-04 10:49:48'),
(43, 'harmeet', 'harmeet@gmail.com', '$2y$10$1jwTw/HMrUE5vdRY8y3zi.odsGZzNSu3buXeqjZM8eV7RjLf.gojO', 2, 'Harmeet', 'Bhatia', 'xyz', NULL, 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'Lrvh7blL8ciBFVRqEp09wzyW7', '4EWQxttCgKJxzu7zppxepJ07S', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-04 10:53:27', '2016-07-04 10:59:31'),
(44, 'Balli', 'balli@gmail.com', '$2y$10$x0bLwDB2WpORl/gw39iIJOJfDwY22oW3oe0qyQVgFpQTc6zUpqeOC', 2, 'Balli', 'Bhatia', 'xyz', NULL, 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'TWJsTXy629a1xjmm3yhCBDbnF', '5c4A4Yo8lPKbVy3lzM2PjZAUV', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-04 11:03:51', '2016-07-04 11:05:27'),
(45, 'Balli2', 'balli2@mailinator.com', '$2y$10$TYZUdR8CzKtdKCmOvf4Ny.Gj5F0vUn0vEFaJfsVFSjnRKjQU.hGPm', 2, 'Balli', 'Bhatia', 'xyz', NULL, 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'qm1TcJtAb1aRoOf4VRmanHCLz', '52k9NdAHxA40UR3Zw5NjhvC74', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-04 11:53:23', '2016-07-05 04:29:52'),
(46, 'Poiuyt', 'qw@qw.com', '$2y$10$exav9hc5FjqhGDYZxsUTg.D7ks/5MivlLyZllu5VZpb0wNl3sGniS', 2, 'Qwerty', 'Asdfgh', 'Qwerty', NULL, 1, 0, 0, 1, 1, 1, '0000-00-00', '', '', '', '', 0, 'E5fArPwIGfo5SmdzvTV6JP8ac', 'VgRIGoDX8G9FmAQU2qmEAi5Ox', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-04 11:58:52', '2016-07-04 11:58:52'),
(47, 'Hdhd', 'testing@mailinator.com', '$2y$10$ME7MUuYfuDK.Yweq8pNGz.WIMTxCd0GVfDJ9hr.soD2lKWNJ9ZLii', 2, 'Test', 'Dhhd', 'Testsh', NULL, 1, 0, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, 'SQkigcSXPpQb83pA0ReyST9CM', 'zGCwTmJddrXrEy1FAJSevXfoC', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-04 12:58:30', '2016-07-04 12:58:30'),
(48, 'qwerty', 'qwerty@mailinator.com', '$2y$10$XG4uJrptMC3sAvUsmTsyZesvvTZukRmJ8qt0xL3BmWdZXun2ePmfC', 2, 'Hshdhd', 'Dbbdhd', 'Qwerty', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'CfdQMwN2NEGih39bxADRI1KJX', '1vBnqMpI2RFqkePYCZCpm8cFO', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-04 13:20:59', '2016-07-04 13:21:40'),
(49, 'hdhdhd', 'qaz@mailinator.com', '$2y$10$S.ZGILzdSc8ZAF3OJ/2N..aqfDSYEFIboQAtz6dGQ/J.hSxl0rCQS', 2, 'Balli', 'Bhatia', 'xyz', NULL, 0, 1, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, '', 'aaVLg6q9XS1vBvKMxrCx5Nkej', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-05 04:09:41', '2016-07-05 04:47:52'),
(50, 'qaz', 'zaq@mailinator.com', '$2y$10$ST67oF377gOQZyDFqxxyyutrXYsSuXfkzBZ0eVFmgvteu8EAzHbvu', 2, 'Dhhddh', 'Xbhdhdhd', 'Jdjd', NULL, 0, 1, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, '', 'ypFyhGg4hRRBpgZLeD6zxA9po', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-05 04:48:35', '2016-07-07 04:15:31'),
(51, 'test1', 'test1@mailinator.com', '$2y$10$.Yw0o0JN5A7b8z5cYzGDE.4OYaUXBNjuEPmCTbOJ4DIZ6u2O94vkG', 2, 'Balli', 'Bhatia', 'xyz', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'MPVXnRj3hhmKieJS6dLD2utjp', 'lGqXjs1SZzRuSwOIQgVPWsGES', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 06:23:59', '2016-07-05 06:23:59'),
(52, 'test3', 'test4@mailinator.com', '$2y$10$Ktw9VM8.o1K7YClBTL5r4OcJDWwxuN6a8qR.IatfifjPpisnISpaG', 2, 'Balli', 'Bhatia', 'xyz', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'IzWaDtEZSzsfqw6MbhCWzGbTg', 'tlpVtnR3QlEaPKh4fkA7Rasfw', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 06:33:00', '2016-07-05 06:33:00'),
(53, 'test5', 'test5@mailinator.com', '$2y$10$R4ra0RwIZ/JCbKRaaeb4iOLwErsciwFbHbKos/PKlTkVb0VCPAQjK', 2, 'Balli', 'Bhatia', 'xyz', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'tK1t6YcY3MJeApLdRedI8WaRN', 'IR4zKbOGxCstZQUJsIRursR4S', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 06:44:34', '2016-07-05 06:44:34'),
(54, 'test6', 'test6@mailinator.com', '$2y$10$d6t391d8Ddyj8NRkjxIAT.uhCT7jYnVG091/YxznN.gmg9UcvEtqC', 2, 'Balli', 'Bhatia', 'xyz', NULL, 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'swte3yvQDRwPizKHnWyyUr3Pw', 'hN5mFbr2VoObQaYSvV59x9Jvw', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 06:53:12', '2016-07-05 07:14:37'),
(55, 'Anmolkaliya', 'anmolkaliya@mailinator.com', '$2y$10$cQlho03uOukTH79RNBiKz.gp6Fki5fIlv6Dg6j939NujmWJNXnzjK', 2, 'Anmol', 'Kaliya', 'Asd', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'rxG7Ln0POGSsym9CVr2s79peJ', 'S4qG2DSuH3zhpwG7X6APXSsyA', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 07:18:12', '2016-07-05 07:18:12'),
(56, 'anmolkaliya1', 'anmolkaliya1@mailinator.com', '$2y$10$wzQQrc9ReworB.THd9tcgO5tpDu14JBkG1favxRA./S3mR/MFxwVW', 2, 'Anmol', 'Kaliya', 'Asd', '1388857461_img1467735729689.jpg', 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, '', 'P14fT3pHAzasQgtUhGUOLafa7', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-05 07:19:33', '2016-07-08 06:54:59'),
(57, 'test7', 'test7@mailinator.com', '$2y$10$e3x7ipFoIfCRgoNet7EIUe5.RRYvYHckuhnLPkbTRw3k32Uq3j4eq', 2, 'Balli', 'Bhatia', 'xyz', NULL, 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'Zt5JZuHBDH5MWOvE1v8z75hjZ', 'XB90u8fIIIdZtyCXHcUTJfPCt', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 07:23:11', '2016-07-05 07:26:03'),
(58, 'test8', 'test8@mailinator.com', '$2y$10$NfjtQoPyF3ef4VY33kBt4uvPkQq9r7TnoG.SLkzAFNeTHmC2n1Hma', 2, 'Balli', 'Bhatia', 'xyz', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'l4Kjp3QLcU6MdTc9JlxK1uBgC', 'xl83kAjNpVQ9n0GXQe7PgaF9H', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 07:28:39', '2016-07-05 07:28:39'),
(59, 'test9', 'test9@mailinator.com', '$2y$10$nCMN8D8BTyE6l3IiAhVwPO44YWXk18H4IgM1PshNhXIyExUBBYI/C', 2, 'Balli', 'Bhatia', 'xyz', NULL, 0, 1, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, '5hSdBETJ1dDgPy7TdrC7nyIRC', 'F7mkTfBVQ4FjITVVBu3nRfWkV', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 07:29:14', '2016-07-05 07:40:19'),
(60, 'Anmol', 'anmolq@mailinator.com', '$2y$10$Gob9Ha9GJSsZyvZiq42y6ur1VIYnn99IRGloJGFkn3VMg0jIgI32G', 2, 'Anmolq', 'Anmol', 'Asj', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'fpebYueP8n8TMXuSJGp6x52Iv', '3RE9jKoOA6McwmQGVbpg9mii4', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-05 07:45:30', '2016-07-05 07:45:30'),
(61, 'LAST', 'WW@GMAIL.COM', '$2y$10$fiViAXt74W9KuOgfEpaAG.7V7w./9wxyMBt3VMnH9u6dU/egMPsnu', 2, 'test ', 'Last', 'W', NULL, 1, 0, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, '2r8SkJEU7jsfonMdopZEu21vf', 'MznEy85VxO1CLf52n1dmEDIFC', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-06 11:43:50', '2016-07-06 11:43:50'),
(62, 'Qwqw', 'qq@gmail.com', '$2y$10$5OORZuKFoXeqJf8rq9dhnOb4X9TqQC8kqMjhxsaz6iqkrzgBHttIS', 2, 'Test', 'Qwqw', 'We''re', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, '2kriBLuCwevtIB9VN3ZR3ti5E', 'c1LJTWt5FdcU340tq2bodFj8O', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-06 12:10:13', '2016-07-06 12:10:13'),
(63, 'qwqe', 'qe@gmail.com', '$2y$10$2gDsVSKasZJiZyCA31g1Gu5rcqquAiRlqqq0jXpXGEe9lNWJImZga', 2, 'Test', 'We', 'Ewe', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'uWeRqnZeWGrNTCytKEArnwlo8', '8NzGdQdbLA766HIWT1BotmAGJ', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-06 12:12:00', '2016-07-06 12:12:00'),
(64, 'qazwsx', 'qwer@mailinator.com', '$2y$10$0Sfq/5H8MqfFXgQl3irwLOz/CQu/WL9gKtxiUeYF2GfVfG724iH/u', 2, 'Sdxr', 'Viyviy', 'Cgjcgc', NULL, 0, 1, 0, 2, 1, 1, '0000-00-00', '', '', '', '', 0, 'JTbbOxPiHbCS5wio5GWTSI79T', 'NPR4dYyFhO3Vncp3ET2wOCMP3', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-07 04:40:32', '2016-07-07 04:42:29'),
(65, 'wellhakx', 'wellhakx@milwaukee.k12.wi.us', '$2y$10$Jg131w6k2D0.R7BZkxcsHu6uFrj2EiB.iAnhUjA01QlcPvPlj8Yuu', 2, 'Kari ', 'Wellhausen', '205', NULL, 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, 'D4JBtPgYf5o0Oa3URBs1ksPRN', 'FupOqKJL35Gxy9I0OxlBaVSxz', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-07 14:05:53', '2016-07-07 14:05:53'),
(66, 'xicomvivek', 'xicomvivek@gmail.com', '$2y$10$UfPbqx4BiPjA4OCcKu9Hne4nyADrrDzeXDYIN2LbUSNAE8CxrkFWq', 2, 'xicom ', 'Vivek', 'Classroom x', '218528242_img1468496286721.jpg', 1, 0, 0, 1, 2, 1, '0000-00-00', '', '', '', '', 0, 'ZhJY56wDlHBd2Fb555Uc2seDv', '9wQITVKqnFpcfXv187Kwt3d5k', NULL, 1, 1, 1, '0000-00-00 00:00:00', '2016-07-08 06:44:13', '2016-07-19 11:11:57'),
(67, 'fevers', 'q@gmail.com', '$2y$10$Niero4QlqP1fovAC1d39MuUVRVPpRpGDK5XDxVeuZPC3pv3BFmZCW', 2, 'Fever', 'Egg', 'Evefvefv', NULL, 1, 0, 0, 3, 1, 1, '0000-00-00', '', '', '', '', 0, 'MjrofeEVWYNUqtbcQxTTwvnzP', 'fFIkRYsGhLmlG3YCu3kMZ2eKo', NULL, 0, 3, 1, '0000-00-00 00:00:00', '2016-07-11 05:27:47', '2016-07-11 05:27:47');

-- --------------------------------------------------------

--
-- Table structure for table `user_apps`
--

CREATE TABLE IF NOT EXISTS `user_apps` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `access_token` varchar(50) NOT NULL,
  `device_type` enum('iphone','android') NOT NULL,
  `device_id` varchar(500) NOT NULL COMMENT 'store while login to send push notification',
  `app_status` enum('active','killed') NOT NULL DEFAULT 'active',
  `imei` varchar(500) DEFAULT NULL,
  `created` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_areas`
--

CREATE TABLE IF NOT EXISTS `user_areas` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(20) NOT NULL COMMENT 'edit-delete',
  `title` varchar(100) NOT NULL,
  `area_color` varchar(50) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_areas`
--

INSERT INTO `user_areas` (`id`, `area_id`, `user_id`, `action`, `title`, `area_color`, `created`, `modified`) VALUES
(1, 11, 25, 'delete', 'Music', '#ffffff\n', '2016-05-06 10:34:59', '2016-05-06 10:34:59'),
(2, 45, 26, 'edit', 'Area I', '#ff394572', '2016-05-11 10:31:03', '2016-05-11 10:31:03'),
(3, 3, 25, 'delete', 'Practical Life', '#fff2cc', '2016-06-08 11:47:49', '2016-06-08 11:47:49'),
(4, 4, 25, 'delete', 'Mathematics', '#d9d2e9', '2016-06-08 11:48:27', '2016-06-08 11:48:27'),
(5, 11, 26, 'delete', 'Music', '#ffffff\n', '2016-06-08 12:46:03', '2016-06-08 12:46:03'),
(6, 6, 25, 'delete', 'Geometry', '#e6b8af', '2016-06-08 13:04:56', '2016-06-08 13:04:56'),
(7, 2, 25, 'delete', 'Sensorial', '#f4cccc', '2016-06-09 05:29:54', '2016-06-09 05:29:54'),
(8, 3, 33, 'delete', 'Practical Life', '#fff2cc', '2016-06-09 06:34:48', '2016-06-09 06:34:48'),
(9, 6, 26, 'delete', 'Geometry', '#e6b8af', '2016-07-04 07:17:11', '2016-07-04 07:17:11'),
(10, 9, 26, 'delete', 'Biology', '#d9ead3', '2016-07-04 07:17:49', '2016-07-04 07:17:49');

-- --------------------------------------------------------

--
-- Table structure for table `user_area_orders`
--

CREATE TABLE IF NOT EXISTS `user_area_orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `order_no` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_chapters`
--

CREATE TABLE IF NOT EXISTS `user_chapters` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_chapters`
--

INSERT INTO `user_chapters` (`id`, `user_id`, `chapter_id`, `area_id`, `title`, `action`, `created`, `modified`) VALUES
(1, 26, 125, 3, 'Control of Emotions', 'edit', '2016-05-06 09:53:59', '2016-05-06 10:13:03'),
(2, 26, 7, 3, 'Preliminary', 'edit', '2016-05-06 10:24:44', '2016-05-06 10:24:44'),
(3, 30, 104, 7, 'Communication in Signss', 'edit', '2016-05-12 07:37:44', '2016-05-12 07:37:44'),
(4, 29, 125, 3, 'gdsfg', 'delete', '2016-05-22 19:04:22', '2016-05-22 19:04:22'),
(5, 29, 140, 3, 'Test', 'delete', '2016-05-22 19:04:29', '2016-05-22 19:04:29'),
(6, 29, 119, 1, 'newone', 'delete', '2016-05-22 19:04:45', '2016-05-22 19:04:45'),
(7, 29, 118, 1, 'abc', 'delete', '2016-05-22 19:04:51', '2016-05-22 19:04:51'),
(8, 29, 124, 1, 'Test', 'delete', '2016-05-22 19:04:56', '2016-05-22 19:04:56'),
(9, 29, 123, 4, 'Martixx', 'delete', '2016-05-22 19:05:07', '2016-05-22 19:05:07'),
(10, 26, 79, 5, 'Black Strip', 'delete', '2016-05-25 06:19:34', '2016-05-25 06:19:34'),
(11, 25, 21, 3, 'Care of Self', 'delete', '2016-05-25 06:27:31', '2016-05-25 06:27:31'),
(12, 26, 40, 7, 'History of Language', 'delete', '2016-05-25 10:22:24', '2016-05-25 10:22:24'),
(13, 25, 25, 3, 'Care of Environment', 'delete', '2016-05-25 10:29:18', '2016-05-25 10:29:18'),
(14, 25, 9, 3, 'Food Preparation', 'delete', '2016-05-25 10:40:14', '2016-05-25 10:40:14'),
(15, 26, 45, 5, 'Story of the Coming of Life', 'delete', '2016-06-08 12:41:19', '2016-06-08 12:41:19'),
(16, 26, 81, 5, 'Hand Chart', 'delete', '2016-06-08 12:41:25', '2016-06-08 12:41:25'),
(17, 33, 22, 2, 'Visual Sense', 'delete', '2016-06-09 06:35:00', '2016-06-09 06:35:00'),
(18, 33, 29, 2, 'Tactile Sense', 'delete', '2016-06-09 06:36:15', '2016-06-09 06:36:15'),
(19, 33, 3, 4, 'Numbers 1 - 10', 'delete', '2016-06-09 06:37:35', '2016-06-09 06:37:35'),
(20, 33, 31, 2, 'Baric Sense', 'delete', '2016-06-09 06:49:14', '2016-06-09 06:49:14'),
(21, 25, 45, 5, 'Story of the Coming of Life', 'delete', '2016-06-10 06:33:18', '2016-06-10 06:33:18'),
(22, 26, 119, 1, 'newone', 'delete', '2016-06-10 07:32:33', '2016-06-10 07:32:33'),
(23, 1, 119, 1, 'newone', 'delete', '2016-06-10 07:35:40', '2016-06-10 07:35:40');

-- --------------------------------------------------------

--
-- Table structure for table `user_chapter_orders`
--

CREATE TABLE IF NOT EXISTS `user_chapter_orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `order_no` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_exercises`
--

CREATE TABLE IF NOT EXISTS `user_exercises` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `exercise_id` int(11) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_exercises`
--

INSERT INTO `user_exercises` (`id`, `user_id`, `exercise_id`, `lesson_id`, `chapter_id`, `area_id`, `title`, `action`, `created`, `modified`) VALUES
(1, 26, 937, 39, 7, 3, 'sdfgasgfgdfag', 'delete', '2016-05-07 09:48:20', '2016-05-07 09:50:08'),
(2, 26, 936, 83, 7, 3, 'fdgdfg', 'delete', '2016-05-07 09:50:18', '2016-05-07 09:50:18');

-- --------------------------------------------------------

--
-- Table structure for table `user_exercise_orders`
--

CREATE TABLE IF NOT EXISTS `user_exercise_orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `exercise_id` int(11) NOT NULL,
  `order_no` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_lessons`
--

CREATE TABLE IF NOT EXISTS `user_lessons` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  `chapter_id` int(11) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_lessons`
--

INSERT INTO `user_lessons` (`id`, `user_id`, `lesson_id`, `chapter_id`, `area_id`, `title`, `action`, `created`, `modified`) VALUES
(1, 33, 165, 16, 4, 'Division', 'delete', '2016-06-09 06:14:27', '2016-06-09 06:14:27'),
(2, 33, 648, 16, 4, 'Prs1 Introduction', 'delete', '2016-06-09 06:14:53', '2016-06-09 06:14:53'),
(3, 33, 28, 3, 4, 'Number Rods', 'delete', '2016-06-09 06:31:01', '2016-06-09 06:31:01'),
(4, 33, 595, 3, 4, 'Memory Game of Numbers', 'delete', '2016-06-09 06:31:24', '2016-06-09 06:31:24'),
(5, 33, 664, 3, 4, 'Cards and Counters', 'delete', '2016-06-09 06:32:58', '2016-06-09 06:32:58'),
(6, 33, 4, 15, 4, 'Tens Beads', 'delete', '2016-06-09 06:40:29', '2016-06-09 06:40:29'),
(7, 25, 607, 45, 5, 'Story of the Coming of Human Beings', 'delete', '2016-06-09 06:44:53', '2016-06-09 06:44:53'),
(8, 25, 329, 79, 5, 'Black Strip', 'delete', '2016-06-10 06:33:29', '2016-06-10 06:33:29');

-- --------------------------------------------------------

--
-- Table structure for table `user_lesson_orders`
--

CREATE TABLE IF NOT EXISTS `user_lesson_orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `order_no` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_plans`
--

CREATE TABLE IF NOT EXISTS `user_plans` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_type` int(11) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `plan_type` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_plans`
--

INSERT INTO `user_plans` (`id`, `user_id`, `user_type`, `title`, `start_date`, `end_date`, `plan_type`, `status`, `created`, `modified`) VALUES
(31, 30, 1, NULL, '2016-05-12', '2016-05-28', 2, 1, '2016-05-12 10:17:07', '2016-05-12 10:35:11'),
(32, 30, 1, NULL, '2016-05-13', '2016-05-20', 1, 1, '2016-05-13 04:49:27', '2016-05-16 03:55:06'),
(34, 30, 1, NULL, '2016-05-16', '2016-05-28', 1, 1, '2016-05-16 07:16:01', '2016-05-16 07:16:36'),
(40, 30, 1, NULL, '2184-12-05', '2184-12-05', 1, 0, '2016-05-17 11:26:02', '2016-05-17 11:26:02'),
(41, 25, 2, NULL, '2178-12-07', '2178-12-07', 1, 0, '2016-05-17 11:58:20', '2016-07-11 05:49:34'),
(49, 29, 1, NULL, '2016-05-19', '2016-05-21', 1, 1, '2016-05-19 21:44:35', '2016-05-19 21:44:35'),
(50, 30, 1, NULL, '2016-05-20', '2016-05-28', 1, 1, '2016-05-20 05:02:16', '2016-05-24 04:24:40'),
(51, 30, 1, NULL, '2016-05-20', '2016-05-31', 2, 1, '2016-05-20 05:03:18', '2016-05-20 05:03:18'),
(52, 29, 1, NULL, '2016-05-23', '2016-05-26', 1, 1, '2016-05-22 19:22:47', '2016-05-22 19:24:02'),
(54, 25, 1, NULL, '2174-12-06', '2174-12-06', 1, 0, '2016-05-24 07:53:19', '2016-06-07 06:10:20'),
(55, 27, 2, NULL, '2016-05-25', '2016-05-26', 1, 1, '2016-05-25 07:04:30', '2016-05-25 07:04:30'),
(58, 29, 1, NULL, '2192-12-07', '2192-12-07', 1, 0, '2016-05-25 10:21:31', '2016-07-25 17:16:58'),
(60, 20, 2, NULL, '2016-05-25', '2016-05-25', 1, 1, '2016-05-26 00:35:56', '2016-05-26 00:35:56'),
(61, 20, 2, NULL, '2016-05-25', '2016-05-25', 2, 1, '2016-05-26 00:37:51', '2016-05-26 00:37:51'),
(62, 27, 2, NULL, '2194-12-05', '2194-12-05', 1, 0, '2016-05-27 04:57:08', '2016-05-27 04:57:08'),
(63, 20, 2, NULL, '2016-05-28', '2016-05-30', 1, 1, '2016-05-28 12:11:26', '2016-05-28 12:11:26'),
(64, 20, 2, NULL, '2016-06-04', '2021-06-04', 2, 1, '2016-05-28 12:20:59', '2016-05-28 12:20:59'),
(67, 20, 2, NULL, '2195-12-09', '2195-12-09', 1, 0, '2016-06-07 02:14:59', '2016-09-28 22:35:14'),
(68, 26, 2, NULL, '2181-12-07', '2181-12-07', 1, 0, '2016-06-08 10:02:25', '2016-07-14 07:01:47'),
(72, 7, 1, NULL, '2181-12-06', '2181-12-06', 1, 0, '2016-06-14 13:07:35', '2016-06-14 13:07:35'),
(73, 7, 1, NULL, '2016-06-14', '2016-06-16', 1, 1, '2016-06-14 13:09:21', '2016-06-14 13:09:21'),
(74, 34, 1, NULL, '2016-06-14', '2016-06-14', 1, 1, '2016-06-14 13:09:23', '2016-06-14 13:09:23'),
(76, 35, 1, NULL, '2183-12-06', '2183-12-06', 1, 0, '2016-06-16 06:27:13', '2016-06-16 06:27:13'),
(86, 26, 1, NULL, '2184-12-06', '2184-12-06', 1, 0, '2016-06-16 12:28:11', '2016-06-17 09:48:37'),
(88, 35, 1, NULL, '2016-06-17', '2016-06-25', 1, 1, '2016-06-17 06:21:00', '2016-06-17 09:16:11'),
(94, 35, 1, NULL, '2016-06-17', '2016-06-24', 2, 1, '2016-06-17 09:20:29', '2016-06-20 03:43:07'),
(97, 20, 2, NULL, '2016-06-17', '2016-06-23', 1, 1, '2016-06-17 12:51:48', '2016-06-17 13:02:28'),
(98, 35, 1, NULL, '2016-06-20', '2016-06-25', 1, 1, '2016-06-20 03:37:55', '2016-06-20 03:47:16'),
(99, 20, 2, NULL, '2016-06-22', '2016-06-25', 1, 1, '2016-06-23 00:22:45', '2016-06-23 00:22:45'),
(100, 20, 2, NULL, '2016-06-22', '2016-06-28', 2, 1, '2016-06-23 00:23:57', '2016-06-23 00:23:57'),
(101, 29, 1, NULL, '2016-06-23', '2016-06-29', 1, 1, '2016-06-23 19:00:25', '2016-06-23 19:00:25'),
(104, 35, 1, NULL, '2016-06-24', '2016-06-30', 1, 1, '2016-06-24 12:56:32', '2016-06-24 12:56:32'),
(105, 35, 1, NULL, '2016-06-24', '2016-06-30', 1, 1, '2016-06-24 12:58:21', '2016-06-24 12:58:21'),
(106, 35, 1, NULL, '2016-06-24', '2016-06-30', 2, 1, '2016-06-24 12:59:12', '2016-06-24 12:59:12'),
(107, 29, 1, NULL, '2016-06-24', '2016-06-30', 2, 1, '2016-06-24 13:41:09', '2016-06-24 13:41:09'),
(108, 29, 1, NULL, '2016-06-25', '2016-07-05', 1, 1, '2016-06-24 13:44:14', '2016-06-24 13:44:14'),
(109, 20, 2, NULL, '2016-08-24', '2016-08-27', 1, 1, '2016-06-24 13:54:34', '2016-06-24 13:54:34'),
(110, 20, 2, NULL, '2016-09-02', '2016-09-06', 1, 1, '2016-06-24 14:00:33', '2016-06-24 14:00:33'),
(111, 29, 1, NULL, '2016-07-25', '2016-07-27', 1, 1, '2016-07-03 19:15:30', '2016-07-25 22:12:29'),
(113, 56, 1, NULL, '2172-12-07', '2172-12-07', 1, 0, '2016-07-05 16:14:44', '2016-07-05 16:14:44'),
(114, 56, 1, NULL, '2016-07-05', '2016-07-07', 2, 1, '2016-07-05 16:20:32', '2016-07-05 16:20:32'),
(115, 64, 1, NULL, '2016-07-07', '2016-07-30', 1, 1, '2016-07-07 04:44:26', '2016-07-07 04:44:26'),
(116, 26, 2, NULL, '2016-07-14', '2016-07-14', 1, 1, '2016-07-14 11:31:49', '2016-07-14 11:58:31'),
(117, 26, 2, NULL, '2016-07-14', '2016-07-14', 2, 1, '2016-07-14 12:07:32', '2016-07-14 12:07:32'),
(118, 29, 1, NULL, '2016-08-02', '2016-08-09', 1, 1, '2016-07-25 17:25:38', '2016-07-25 22:49:32'),
(119, 29, 1, NULL, '2016-07-28', '2016-07-29', 1, 1, '2016-07-25 17:30:54', '2016-07-25 17:30:54'),
(121, 29, 1, NULL, '2016-07-25', '2016-07-29', 2, 1, '2016-07-25 22:13:33', '2016-07-25 22:50:04'),
(122, 29, 1, NULL, '2016-07-25', '2016-07-31', 1, 1, '2016-07-25 22:14:23', '2016-07-25 22:14:23'),
(123, 29, 1, NULL, '2016-08-28', '2016-08-31', 2, 1, '2016-07-26 01:34:35', '2016-07-26 01:34:35');

-- --------------------------------------------------------

--
-- Table structure for table `user_products`
--

CREATE TABLE IF NOT EXISTS `user_products` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `pack_start_date` datetime DEFAULT NULL,
  `free_days` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_products`
--

INSERT INTO `user_products` (`id`, `user_id`, `product_id`, `status_id`, `pack_start_date`, `free_days`, `created`, `modified`) VALUES
(1, 5, 1, 1, '2016-06-29 03:11:34', NULL, '2016-07-01 03:11:34', '2016-06-29 03:11:34'),
(2, 26, 1, 1, '2016-07-01 11:04:12', NULL, '2016-07-01 11:04:12', '2016-07-01 11:04:12'),
(3, 37, 1, 1, '2016-07-01 11:48:00', NULL, '2016-07-01 11:48:00', '2016-07-01 11:48:00'),
(4, 38, 1, 1, '2016-07-01 11:59:13', NULL, '2016-07-01 11:59:13', '2016-07-01 11:59:13'),
(5, 39, 1, 1, '2016-07-01 12:07:46', NULL, '2016-07-01 12:07:46', '2016-07-01 12:07:46'),
(6, 40, 2, 1, '2016-07-01 12:08:40', NULL, '2016-07-01 12:08:40', '2016-07-01 12:08:40'),
(7, 25, 1, 1, '2016-07-04 07:28:16', NULL, '2016-07-04 07:28:16', '2016-07-04 07:28:16'),
(8, 1, 1, 1, '2016-07-04 07:33:31', NULL, '2016-07-04 07:33:31', '2016-07-04 07:33:31'),
(9, 41, 2, 1, '2016-07-04 09:17:53', NULL, '2016-07-04 09:17:53', '2016-07-04 09:17:53'),
(10, 42, 3, 1, '2016-07-04 10:49:53', NULL, '2016-07-04 10:49:53', '2016-07-04 10:49:53'),
(11, 43, 3, 1, '2016-07-04 10:53:31', NULL, '2016-07-04 10:53:31', '2016-07-04 10:53:31'),
(12, 44, 3, 1, NULL, NULL, '2016-07-04 11:04:14', '2016-07-04 11:04:14'),
(13, 45, 3, 1, '2016-07-04 11:53:30', NULL, '2016-07-04 11:53:30', '2016-07-04 11:53:30'),
(14, 46, 1, 1, '2016-07-04 11:58:55', NULL, '2016-07-04 11:58:55', '2016-07-04 11:58:55'),
(15, 47, 2, 1, '2016-07-04 12:58:35', NULL, '2016-07-04 12:58:35', '2016-07-04 12:58:35'),
(16, 48, 3, 1, '2016-07-04 13:21:04', NULL, '2016-07-04 13:21:04', '2016-07-04 13:21:04'),
(17, 29, 1, 1, '2016-07-04 18:38:08', NULL, '2016-07-04 18:38:08', '2016-07-04 18:38:08'),
(18, 49, 2, 1, '2016-07-05 04:09:45', NULL, '2016-07-05 04:09:45', '2016-07-05 04:09:45'),
(19, 50, 2, 1, '2016-07-05 04:48:40', NULL, '2016-07-05 04:48:40', '2016-07-05 04:48:40'),
(20, 51, 3, 1, '2016-07-05 06:24:10', NULL, '2016-07-05 06:24:10', '2016-07-05 06:24:10'),
(21, 52, 3, 1, '2016-07-05 06:33:09', NULL, '2016-07-05 06:33:09', '2016-07-05 06:33:09'),
(22, 53, 3, 1, '2016-07-05 06:44:39', NULL, '2016-07-05 06:44:39', '2016-07-05 06:44:39'),
(23, 54, 3, 1, '2016-07-05 06:53:19', NULL, '2016-07-05 06:53:19', '2016-07-05 06:53:19'),
(24, 55, 3, 1, '2016-07-05 07:18:39', NULL, '2016-07-05 07:18:39', '2016-07-05 07:18:39'),
(25, 56, 3, 1, '2016-07-05 07:19:37', NULL, '2016-07-05 07:19:37', '2016-07-05 07:19:37'),
(26, 57, 3, 1, '2016-07-05 07:23:37', NULL, '2016-07-05 07:23:37', '2016-07-05 07:23:37'),
(27, 58, 3, 1, '2016-07-05 07:29:13', NULL, '2016-07-05 07:29:13', '2016-07-05 07:29:13'),
(28, 59, 3, 1, '2016-07-05 07:29:18', NULL, '2016-07-05 07:29:18', '2016-07-05 07:29:18'),
(29, 60, 3, 1, '2016-07-05 07:45:37', NULL, '2016-07-05 07:45:37', '2016-07-05 07:45:37'),
(30, 61, 2, 1, '2016-07-06 11:43:59', NULL, '2016-07-06 11:43:59', '2016-07-06 11:43:59'),
(31, 62, 3, 1, '2016-07-06 12:10:26', NULL, '2016-07-06 12:10:26', '2016-07-06 12:10:26'),
(32, 63, 3, 1, '2016-07-06 12:12:03', NULL, '2016-07-06 12:12:04', '2016-07-06 12:12:04'),
(33, 64, 2, 1, '2016-07-07 04:40:39', NULL, '2016-07-07 04:40:39', '2016-07-07 04:40:39'),
(34, 65, 1, 1, '2016-07-07 14:05:58', NULL, '2016-07-07 14:05:58', '2016-07-07 14:05:58'),
(35, 66, 1, 1, '2016-06-07 06:44:18', NULL, '2016-07-08 06:44:18', '2016-07-08 06:44:18'),
(36, 67, 3, 1, '2016-07-11 05:27:52', NULL, '2016-07-11 05:27:52', '2016-07-11 05:27:52'),
(37, 9, 1, 1, '2016-07-14 04:51:04', NULL, '2016-07-14 04:51:04', '2016-07-14 04:51:04');

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE IF NOT EXISTS `user_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `weight_sett` int(11) NOT NULL DEFAULT '1',
  `height_sett` int(11) NOT NULL DEFAULT '1',
  `distance_sett` int(11) NOT NULL DEFAULT '1',
  `energy_sett` int(11) NOT NULL DEFAULT '1',
  `currency_sett` int(11) NOT NULL DEFAULT '1',
  `date_sett` int(11) NOT NULL DEFAULT '1',
  `time_sett` int(11) NOT NULL DEFAULT '1',
  `is_food_view_advanced` tinyint(1) NOT NULL DEFAULT '0',
  `rda_selection` int(11) NOT NULL DEFAULT '1',
  `is_exercise_view_advanced` tinyint(1) NOT NULL DEFAULT '0',
  `logo` varchar(300) DEFAULT NULL,
  `theme` int(11) NOT NULL DEFAULT '1',
  `passcode` int(11) NOT NULL DEFAULT '1',
  `passcode_value` int(11) DEFAULT NULL,
  `app_auto_lock` int(11) NOT NULL DEFAULT '1',
  `app_auto_lock_value` int(11) NOT NULL DEFAULT '0',
  `fingerprint_lock` int(11) NOT NULL DEFAULT '1',
  `tutorials` tinyint(1) NOT NULL DEFAULT '1',
  `week_start` int(11) NOT NULL DEFAULT '1',
  `master_booking` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`id`, `user_id`, `weight_sett`, `height_sett`, `distance_sett`, `energy_sett`, `currency_sett`, `date_sett`, `time_sett`, `is_food_view_advanced`, `rda_selection`, `is_exercise_view_advanced`, `logo`, `theme`, `passcode`, `passcode_value`, `app_auto_lock`, `app_auto_lock_value`, `fingerprint_lock`, `tutorials`, `week_start`, `master_booking`, `created`, `modified`) VALUES
(1, 11, 2, 2, 1, 2, 3, 1, 1, 1, 2, 1, '895589833_needcodebypcbots.png', 2, 0, NULL, 1, 11, 0, 1, 2, 1, '2015-07-10 06:45:56', '2015-08-07 10:53:52'),
(2, 36, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, NULL, 1, 1, NULL, 1, 0, 1, 1, 1, 0, '2015-07-10 10:53:43', '2015-07-10 10:53:43'),
(3, 61, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, NULL, 1, 1, NULL, 1, 0, 1, 1, 1, 0, '2015-08-07 09:36:25', '2015-08-07 09:36:25'),
(4, 62, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, NULL, 1, 1, NULL, 1, 0, 1, 1, 1, 0, '2015-08-07 09:56:18', '2015-08-07 09:56:18');

-- --------------------------------------------------------

--
-- Table structure for table `user_stats`
--

CREATE TABLE IF NOT EXISTS `user_stats` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `stat_date` date NOT NULL,
  `weight` float(10,2) NOT NULL,
  `height` float(10,2) NOT NULL,
  `neck` float(10,2) NOT NULL,
  `chest` float(10,2) NOT NULL,
  `upperarm` float(10,2) NOT NULL,
  `forearm` float(10,2) NOT NULL,
  `hip` float(10,2) NOT NULL,
  `thigh` float(10,2) NOT NULL,
  `calf` float(10,2) NOT NULL,
  `heart_rate` int(11) NOT NULL,
  `bmi` int(11) NOT NULL,
  `bmr` int(11) NOT NULL,
  `ideal_body_weight` int(11) NOT NULL,
  `max_heart_rate` int(11) NOT NULL,
  `body_fat` int(11) NOT NULL,
  `lean_muscle_mass` int(11) NOT NULL,
  `front_image` text NOT NULL,
  `side_image` text NOT NULL,
  `back_image` text NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_stats`
--

INSERT INTO `user_stats` (`id`, `user_id`, `client_id`, `stat_date`, `weight`, `height`, `neck`, `chest`, `upperarm`, `forearm`, `hip`, `thigh`, `calf`, `heart_rate`, `bmi`, `bmr`, `ideal_body_weight`, `max_heart_rate`, `body_fat`, `lean_muscle_mass`, `front_image`, `side_image`, `back_image`, `created`, `modified`) VALUES
(1, 11, 22, '2015-12-20', 100.70, 563.88, 172.72, 690.88, 1943.10, 1973.58, 195.58, 170.18, 55.88, 22, 77, 88, 222, 222, 222, 234, '', '', '', '2015-07-10 11:29:57', '2015-07-10 11:30:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `add_limits`
--
ALTER TABLE `add_limits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_COUNTRIES_NAME` (`country`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `exercises`
--
ALTER TABLE `exercises`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_2` (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`,`user_id`,`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `student_views`
--
ALTER TABLE `student_views`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `thumbs`
--
ALTER TABLE `thumbs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `upload_images`
--
ALTER TABLE `upload_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_apps`
--
ALTER TABLE `user_apps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `user_id_2` (`user_id`),
  ADD KEY `access_token` (`access_token`);

--
-- Indexes for table `user_areas`
--
ALTER TABLE `user_areas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_area_orders`
--
ALTER TABLE `user_area_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_chapters`
--
ALTER TABLE `user_chapters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_chapter_orders`
--
ALTER TABLE `user_chapter_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_exercises`
--
ALTER TABLE `user_exercises`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_exercise_orders`
--
ALTER TABLE `user_exercise_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_lessons`
--
ALTER TABLE `user_lessons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_lesson_orders`
--
ALTER TABLE `user_lesson_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_plans`
--
ALTER TABLE `user_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_products`
--
ALTER TABLE `user_products`
  ADD PRIMARY KEY (`id`,`user_id`,`product_id`,`status_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_stats`
--
ALTER TABLE `user_stats`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `add_limits`
--
ALTER TABLE `add_limits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=120;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=240;
--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `exercises`
--
ALTER TABLE `exercises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1156;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(36) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=851;
--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=96;
--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `statuses`
--
ALTER TABLE `statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=206;
--
-- AUTO_INCREMENT for table `student_views`
--
ALTER TABLE `student_views`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1869;
--
-- AUTO_INCREMENT for table `thumbs`
--
ALTER TABLE `thumbs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `upload_images`
--
ALTER TABLE `upload_images`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `user_apps`
--
ALTER TABLE `user_apps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_areas`
--
ALTER TABLE `user_areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `user_area_orders`
--
ALTER TABLE `user_area_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_chapters`
--
ALTER TABLE `user_chapters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT for table `user_chapter_orders`
--
ALTER TABLE `user_chapter_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_exercises`
--
ALTER TABLE `user_exercises`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `user_exercise_orders`
--
ALTER TABLE `user_exercise_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_lessons`
--
ALTER TABLE `user_lessons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `user_lesson_orders`
--
ALTER TABLE `user_lesson_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user_plans`
--
ALTER TABLE `user_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=124;
--
-- AUTO_INCREMENT for table `user_products`
--
ALTER TABLE `user_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `user_settings`
--
ALTER TABLE `user_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `user_stats`
--
ALTER TABLE `user_stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `user_products`
--
ALTER TABLE `user_products`
  ADD CONSTRAINT `user_products_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
