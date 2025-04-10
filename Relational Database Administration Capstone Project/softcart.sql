-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: labs-mysql-young-echoing-architect:3306
-- Generation Time: Apr 10, 2025 at 11:53 AM
-- Server version: 8.0.37
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `softcart`
--

-- --------------------------------------------------------

--
-- Table structure for table `dim_category`
--

CREATE TABLE `dim_category` (
  `category_id` int NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_country`
--

CREATE TABLE `dim_country` (
  `country_id` int NOT NULL,
  `country_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_date`
--

CREATE TABLE `dim_date` (
  `date_id` int NOT NULL,
  `date` date NOT NULL,
  `day` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `month_name` varchar(15) DEFAULT NULL,
  `quarter` int DEFAULT NULL,
  `year` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dim_item`
--

CREATE TABLE `dim_item` (
  `item_id` int NOT NULL,
  `item_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fact_sales`
--

CREATE TABLE `fact_sales` (
  `sales_id` int NOT NULL,
  `date_id` int DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `country_id` int DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dim_category`
--
ALTER TABLE `dim_category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `dim_country`
--
ALTER TABLE `dim_country`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `dim_date`
--
ALTER TABLE `dim_date`
  ADD PRIMARY KEY (`date_id`);

--
-- Indexes for table `dim_item`
--
ALTER TABLE `dim_item`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `fact_sales`
--
ALTER TABLE `fact_sales`
  ADD PRIMARY KEY (`sales_id`),
  ADD KEY `date_id` (`date_id`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `country_id` (`country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dim_category`
--
ALTER TABLE `dim_category`
  MODIFY `category_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dim_country`
--
ALTER TABLE `dim_country`
  MODIFY `country_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dim_date`
--
ALTER TABLE `dim_date`
  MODIFY `date_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dim_item`
--
ALTER TABLE `dim_item`
  MODIFY `item_id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fact_sales`
--
ALTER TABLE `fact_sales`
  MODIFY `sales_id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fact_sales`
--
ALTER TABLE `fact_sales`
  ADD CONSTRAINT `fact_sales_ibfk_1` FOREIGN KEY (`date_id`) REFERENCES `dim_date` (`date_id`),
  ADD CONSTRAINT `fact_sales_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `dim_item` (`item_id`),
  ADD CONSTRAINT `fact_sales_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `dim_category` (`category_id`),
  ADD CONSTRAINT `fact_sales_ibfk_4` FOREIGN KEY (`country_id`) REFERENCES `dim_country` (`country_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
