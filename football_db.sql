-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 04, 2026 at 05:08 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `football_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `goals`
--

DROP TABLE IF EXISTS `goals`;
CREATE TABLE IF NOT EXISTS `goals` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `match_id` int NOT NULL,
  `scoring_team_id` int NOT NULL,
  `minute` int NOT NULL,
  `match_half` enum('First Half','Second Half','First Extra Half','Second Extra Half') COLLATE utf8mb4_general_ci NOT NULL,
  `xg` decimal(4,2) NOT NULL,
  `xgot` decimal(4,2) NOT NULL,
  `scorer_pos` enum('GK','DF','MF','FW') COLLATE utf8mb4_general_ci NOT NULL,
  `assister_pos` enum('GK','DF','MF','FW') COLLATE utf8mb4_general_ci NOT NULL,
  `shot_location` enum('6-Yard','Penalty-Area','Outside-Box','Half-Way') COLLATE utf8mb4_general_ci NOT NULL,
  `goal_method` enum('Open-Play','Set-Piece','Penalty','Counter-Attack','Own-Goal') COLLATE utf8mb4_general_ci NOT NULL,
  `body_part` enum('Right-Foot','Left-Foot','Head','Other') COLLATE utf8mb4_general_ci NOT NULL,
  `goal_mouth_zone` enum('Top-Left','Top-Center','Top-Right','Left','Center','Right','Bottom-Left','Bottom-Center','Bottom-Right') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_goal_match` (`match_id`),
  KEY `fk_goal_team` (`scoring_team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
CREATE TABLE IF NOT EXISTS `matches` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `tournament_id` int NOT NULL,
  `home_team_id` int NOT NULL,
  `away_team_id` int NOT NULL,
  `gw_round` int NOT NULL,
  `match_order` int NOT NULL,
  `match_month` int NOT NULL,
  `match_status` enum('Scheduled','Played','Completed','Postponed') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `fk_match_tournament` (`tournament_id`),
  KEY `fk_match_home_team` (`home_team_id`),
  KEY `fk_match_away_team` (`away_team_id`),
  KEY `fk_match_round` (`gw_round`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rounds`
--

DROP TABLE IF EXISTS `rounds`;
CREATE TABLE IF NOT EXISTS `rounds` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `round_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
CREATE TABLE IF NOT EXISTS `teams` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `short_name` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `country` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `stadium` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `logo_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tournaments`
--

DROP TABLE IF EXISTS `tournaments`;
CREATE TABLE IF NOT EXISTS `tournaments` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `tournament_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `season` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `tournament_type` enum('League','Cup','Continental','International') COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `goals`
--
ALTER TABLE `goals`
  ADD CONSTRAINT `fk_goal_match` FOREIGN KEY (`match_id`) REFERENCES `matches` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_goal_team` FOREIGN KEY (`scoring_team_id`) REFERENCES `teams` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `matches`
--
ALTER TABLE `matches`
  ADD CONSTRAINT `fk_match_away_team` FOREIGN KEY (`away_team_id`) REFERENCES `teams` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_match_home_team` FOREIGN KEY (`home_team_id`) REFERENCES `teams` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_match_round` FOREIGN KEY (`gw_round`) REFERENCES `rounds` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `fk_match_tournament` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`Id`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
