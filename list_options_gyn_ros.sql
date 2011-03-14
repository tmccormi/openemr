-- phpMyAdmin SQL Dump
-- version 2.11.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Mar 13, 2011 at 06:18 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.2-1ubuntu4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `openemr_test40`
--

-- --------------------------------------------------------

--
-- Table structure for table `list_options`
--

INSERT INTO `list_options` (`list_id`, `option_id`, `title`, `seq`, `is_default`, `option_value`, `mapping`, `notes`) VALUES
('menses_cycle', '1', 'Once a month', 1, 0, 0, '', 'for form gyn_ros'),
('menses_cycle', '2', 'Less than once a month', 2, 0, 0, '', 'for form gyn_ros'),
('menses_cycle', '3', '1 to 3 months', 3, 0, 0, '', 'for form gyn_ros'),
('menses_cycle', '4', '3 month or longer', 4, 0, 0, '', 'for form gyn_ros'),
('menses_pain', 'between', 'Between Menses', 2, 0, 0, '', 'for form gyn_ros'),
('menses_pain', 'constant', 'Constant', 3, 0, 0, '', 'for form gyn_ros'),
('menses_pain', 'other', 'Other', 4, 0, 0, '', 'for form gyn_ros'),
('menses_pain', 'with', 'With Menses', 1, 0, 0, '', 'for form gyn_ros'),
('menses_pain_location', 'lowleft', 'Lower Left Quadrant', 2, 0, 0, '', 'for form gyn_ros'),
('menses_pain_location', 'lowright', 'Lower Right Quadrant', 1, 0, 0, '', 'for form gyn_ros'),
('menses_pain_location', 'mid', 'Middle Quadrant', 3, 0, 0, '', 'for form gyn_ros'),
('menses_pain_location', 'rectal', 'Rectal Area', 4, 0, 0, '', 'for form gyn_ros');
