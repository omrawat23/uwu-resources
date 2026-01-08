CREATE TABLE IF NOT EXISTS `crux_uwucafe_bossmenu` (
    `id` varchar(50) NOT NULL,
    `business_name` varchar(50) NOT NULL DEFAULT 'Food Business',
    `balance` int(11) DEFAULT 0,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(50) NOT NULL,
  `order_label` INT(11) DEFAULT NULL,
  `order_date` DATE DEFAULT NULL,
  `customer_name` VARCHAR(255) DEFAULT NULL,
  `customer_identifier` VARCHAR(255) NULL DEFAULT NULL,
  `employee_identifier` VARCHAR(255),
  `self_pickup` BOOLEAN NOT NULL DEFAULT FALSE,
  `items` JSON NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `status` ENUM('cooking', 'ready', 'completed', 'cancelled') NOT NULL DEFAULT 'cooking',
  `created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_order_date` (`order_date`)
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_employees` (
    `license` varchar(50) NOT NULL,
    `balance` int(11) DEFAULT 0,
    `name` varchar(50) NOT NULL,
    `experience` int(11) NOT NULL DEFAULT 0,
    `deliveries` int(11) DEFAULT 0,
    `image` varchar(255),
    `job` VARCHAR(50) DEFAULT NULL,
    `job_grade` INT DEFAULT 0,
    `billings` INT DEFAULT 0,
    `delivery_balance` INT DEFAULT 0,
    `billing_balance` INT DEFAULT 0,
    `paycheck_balance` INT DEFAULT 0,
    `notifications_enabled` BOOLEAN NOT NULL DEFAULT TRUE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`license`)
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_vendingMachineItems` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL DEFAULT 0,
    `image` VARCHAR(255) NOT NULL,
    `category` VARCHAR(50) DEFAULT 'Ingredients',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_vendingmenuItemsSold` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) NOT NULL,
    `quantity` INT NOT NULL DEFAULT 0,
    `image` VARCHAR(255) NOT NULL,
    `vending_index` INT NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_menuItems` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL DEFAULT 0,
    `image` VARCHAR(255) NOT NULL,
    `category` VARCHAR(50) NOT NULL DEFAULT 'Ingredients',
    `categoryimage` VARCHAR(255) NOT NULL DEFAULT '',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_transactions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `sender_identifier` VARCHAR(50) NOT NULL,
    `sender_name` VARCHAR(50) NOT NULL,
    `receiver_identifier` VARCHAR(50) NOT NULL,
    `receiver_name` VARCHAR(50) NOT NULL,
    `amount` INT NOT NULL,
    `commission_amount` INT NOT NULL DEFAULT 0,
    `reason` VARCHAR(255) NOT NULL,
    `payment_method` VARCHAR(20) NOT NULL,
    `items` TEXT NOT NULL,
    `job` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add tables for custom job system
CREATE TABLE IF NOT EXISTS `crux_uwucafe_jobs` (
    `name` varchar(50) NOT NULL,
    `label` varchar(50) NOT NULL,
    `type` varchar(50) DEFAULT 'public',
    `default_duty` BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (`name`)
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_job_grades` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `job_name` varchar(50) NOT NULL,
    `grade` int(11) NOT NULL,
    `name` varchar(50) NOT NULL,
    `label` varchar(50) NOT NULL,
    `salary` int(11) NOT NULL DEFAULT 0,
    `commission` int(11) NOT NULL DEFAULT 0,
    `is_boss` BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`id`),
    KEY `job_name` (`job_name`),
    KEY `grade` (`grade`),
    CONSTRAINT `crux_uwucafe_job_grades_ibfk_1` FOREIGN KEY (`job_name`) REFERENCES `crux_uwucafe_jobs` (`name`) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_user_jobs` (
    `identifier` varchar(50) NOT NULL,
    `job` varchar(50) NOT NULL,
    `grade` int(11) NOT NULL DEFAULT 0,
    `onduty` BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (`identifier`),
    KEY `job` (`job`),
    CONSTRAINT `crux_uwucafe_user_jobs_ibfk_1` FOREIGN KEY (`job`) REFERENCES `crux_uwucafe_jobs` (`name`) ON DELETE CASCADE
);

-- Create paycheck history table
CREATE TABLE IF NOT EXISTS `crux_uwucafe_paycheck_history` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `license` VARCHAR(50) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `job` VARCHAR(50) NOT NULL,
    `job_grade` INT NOT NULL,
    `amount` INT NOT NULL,
    `from_society` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX (`license`)
);

-- Create business settings table for persistent business status
CREATE TABLE IF NOT EXISTS `crux_uwucafe_business_settings` (
    `job` VARCHAR(50) NOT NULL,
    `is_open` BOOLEAN NOT NULL DEFAULT TRUE,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`job`)
);


CREATE TABLE IF NOT EXISTS `crux_uwucafe_player_job_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) NOT NULL,
  `plate` varchar(15) NOT NULL,
  `model` varchar(50) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE IF NOT EXISTS `crux_uwucafe_storage_boxes` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `item_id` VARCHAR(50) NOT NULL COMMENT 'Unique identifier for the item instance',
    `stash_id` VARCHAR(100) NOT NULL COMMENT 'Unique stash identifier',
    `owner_identifier` VARCHAR(50) DEFAULT NULL COMMENT 'Player identifier who created it',
    `items` LONGTEXT DEFAULT NULL COMMENT 'JSON encoded items stored in this storage box',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `last_accessed` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_item_id` (`item_id`),
    UNIQUE KEY `unique_stash_id` (`stash_id`),
    INDEX `idx_owner` (`owner_identifier`),
    INDEX `idx_stash` (`stash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `crux_uwucafe_vending_machine_status` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `is_open` BOOLEAN NOT NULL DEFAULT TRUE,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `crux_uwucafe_door_states` (
    `door_index` INT NOT NULL,
    `is_locked` BOOLEAN NOT NULL DEFAULT TRUE,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`door_index`)
);