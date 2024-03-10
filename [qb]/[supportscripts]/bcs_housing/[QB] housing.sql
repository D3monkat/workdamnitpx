ALTER TABLE `players` ADD furniture longtext;
ALTER TABLE `players` ADD `last_property` varchar(50) NOT NULL DEFAULT 'outside';

CREATE TABLE `house` (
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `name` varchar(50) DEFAULT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'shell',
  `payment` mediumtext DEFAULT NULL,
  `furniture` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `mortgage` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping structure for table server.house_mortgage
CREATE TABLE `house_mortgage` (
  `identifier` varchar(50) NOT NULL,
  `interest` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `payment` int(11) NOT NULL DEFAULT 0,
  `lastPayment` varchar(50) DEFAULT NULL,
  `remaining` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping structure for table server.house_owned
CREATE TABLE `house_owned` (
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `owner` varchar(50) NOT NULL,
  `lastLogin` bigint(20) DEFAULT NULL,
  `lastPayment` bigint(20) DEFAULT NULL,
  `keys` mediumtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- INSERT INTO `jobs` VALUES ('rea', 'Real Estate Agent');

-- INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
-- ('rea', 0, 'junior', 'Junior', 200),
-- ('rea', 1, 'senior', 'Senior', 300),
-- ('rea', 2, 'boss', 'Boss', 400);

