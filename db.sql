-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table db_master_pos.adjustments
CREATE TABLE IF NOT EXISTS `adjustments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `adjustment_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `adjustment_date` date NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `total` bigint DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `adjustments_document_number_unique` (`adjustment_number`) USING BTREE,
  KEY `adjustments_user_id_foreign` (`user_id`),
  CONSTRAINT `adjustments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.adjustments: ~1 rows (approximately)
INSERT INTO `adjustments` (`id`, `adjustment_number`, `adjustment_date`, `user_id`, `description`, `total`, `image`, `created_at`, `updated_at`) VALUES
	(8, 'ADJ-20241214153636', '2024-12-14', 1, 'dfsfssff', -19000, '20241214153636_ASTACODE.webp', '2024-12-14 08:36:36', '2024-12-14 08:36:36');

-- Dumping structure for table db_master_pos.adjustment_details
CREATE TABLE IF NOT EXISTS `adjustment_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `adjustment_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `adjustment_details_adjustment_id_foreign` (`adjustment_id`),
  KEY `adjustment_details_product_id_foreign` (`product_id`),
  CONSTRAINT `adjustment_details_adjustment_id_foreign` FOREIGN KEY (`adjustment_id`) REFERENCES `adjustments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `adjustment_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.adjustment_details: ~2 rows (approximately)
INSERT INTO `adjustment_details` (`id`, `adjustment_id`, `product_id`, `quantity`, `reason`, `created_at`, `updated_at`) VALUES
	(9, 8, 9, 1, 'dd', '2024-12-14 08:36:36', '2024-12-14 08:36:36'),
	(10, 8, 10, -4, 'fff', '2024-12-14 08:36:36', '2024-12-14 08:36:36');

-- Dumping structure for table db_master_pos.cache
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.cache: ~1 rows (approximately)
INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
	('spatie.permission.cache', 'a:3:{s:5:"alias";a:5:{s:1:"a";s:2:"id";s:1:"b";s:4:"name";s:1:"c";s:10:"guard_name";s:1:"d";s:6:"urutan";s:1:"r";s:5:"roles";}s:11:"permissions";a:90:{i:0;a:5:{s:1:"a";i:1;s:1:"b";s:9:"user-list";s:1:"c";s:3:"web";s:1:"d";i:21;s:1:"r";a:1:{i:0;i:1;}}i:1;a:5:{s:1:"a";i:2;s:1:"b";s:11:"user-create";s:1:"c";s:3:"web";s:1:"d";i:22;s:1:"r";a:1:{i:0;i:1;}}i:2;a:5:{s:1:"a";i:3;s:1:"b";s:9:"user-edit";s:1:"c";s:3:"web";s:1:"d";i:23;s:1:"r";a:1:{i:0;i:1;}}i:3;a:5:{s:1:"a";i:4;s:1:"b";s:11:"user-delete";s:1:"c";s:3:"web";s:1:"d";i:24;s:1:"r";a:1:{i:0;i:1;}}i:4;a:5:{s:1:"a";i:5;s:1:"b";s:15:"permission-list";s:1:"c";s:3:"web";s:1:"d";i:13;s:1:"r";a:1:{i:0;i:1;}}i:5;a:5:{s:1:"a";i:6;s:1:"b";s:17:"permission-create";s:1:"c";s:3:"web";s:1:"d";i:14;s:1:"r";a:1:{i:0;i:1;}}i:6;a:5:{s:1:"a";i:7;s:1:"b";s:15:"permission-edit";s:1:"c";s:3:"web";s:1:"d";i:15;s:1:"r";a:1:{i:0;i:1;}}i:7;a:5:{s:1:"a";i:8;s:1:"b";s:17:"permission-delete";s:1:"c";s:3:"web";s:1:"d";i:16;s:1:"r";a:1:{i:0;i:1;}}i:8;a:5:{s:1:"a";i:9;s:1:"b";s:9:"role-list";s:1:"c";s:3:"web";s:1:"d";i:17;s:1:"r";a:1:{i:0;i:1;}}i:9;a:5:{s:1:"a";i:10;s:1:"b";s:11:"role-create";s:1:"c";s:3:"web";s:1:"d";i:18;s:1:"r";a:1:{i:0;i:1;}}i:10;a:5:{s:1:"a";i:11;s:1:"b";s:9:"role-edit";s:1:"c";s:3:"web";s:1:"d";i:19;s:1:"r";a:1:{i:0;i:1;}}i:11;a:5:{s:1:"a";i:12;s:1:"b";s:11:"role-delete";s:1:"c";s:3:"web";s:1:"d";i:20;s:1:"r";a:1:{i:0;i:1;}}i:12;a:5:{s:1:"a";i:13;s:1:"b";s:11:"profil-list";s:1:"c";s:3:"web";s:1:"d";i:33;s:1:"r";a:1:{i:0;i:1;}}i:13;a:5:{s:1:"a";i:14;s:1:"b";s:12:"general-list";s:1:"c";s:3:"web";s:1:"d";i:1;s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:14;a:5:{s:1:"a";i:15;s:1:"b";s:14:"dashboard-list";s:1:"c";s:3:"web";s:1:"d";i:2;s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:15;a:5:{s:1:"a";i:16;s:1:"b";s:15:"pengaturan-list";s:1:"c";s:3:"web";s:1:"d";i:12;s:1:"r";a:1:{i:0;i:1;}}i:16;a:5:{s:1:"a";i:17;s:1:"b";s:14:"menugroup-list";s:1:"c";s:3:"web";s:1:"d";i:25;s:1:"r";a:1:{i:0;i:1;}}i:17;a:5:{s:1:"a";i:18;s:1:"b";s:16:"menugroup-create";s:1:"c";s:3:"web";s:1:"d";i:26;s:1:"r";a:1:{i:0;i:1;}}i:18;a:5:{s:1:"a";i:19;s:1:"b";s:14:"menugroup-edit";s:1:"c";s:3:"web";s:1:"d";i:27;s:1:"r";a:1:{i:0;i:1;}}i:19;a:5:{s:1:"a";i:20;s:1:"b";s:16:"menugroup-delete";s:1:"c";s:3:"web";s:1:"d";i:28;s:1:"r";a:1:{i:0;i:1;}}i:20;a:5:{s:1:"a";i:21;s:1:"b";s:11:"master-list";s:1:"c";s:3:"web";s:1:"d";i:3;s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:21;a:5:{s:1:"a";i:22;s:1:"b";s:9:"blog-list";s:1:"c";s:3:"web";s:1:"d";i:4;s:1:"r";a:2:{i:0;i:1;i:1;i:2;}}i:22;a:5:{s:1:"a";i:23;s:1:"b";s:13:"menuitem-list";s:1:"c";s:3:"web";s:1:"d";i:29;s:1:"r";a:1:{i:0;i:1;}}i:23;a:5:{s:1:"a";i:24;s:1:"b";s:15:"menuitem-create";s:1:"c";s:3:"web";s:1:"d";i:30;s:1:"r";a:1:{i:0;i:1;}}i:24;a:5:{s:1:"a";i:25;s:1:"b";s:13:"menuitem-edit";s:1:"c";s:3:"web";s:1:"d";i:31;s:1:"r";a:1:{i:0;i:1;}}i:25;a:5:{s:1:"a";i:26;s:1:"b";s:15:"menuitem-delete";s:1:"c";s:3:"web";s:1:"d";i:32;s:1:"r";a:1:{i:0;i:1;}}i:26;a:5:{s:1:"a";i:34;s:1:"b";s:11:"profil-edit";s:1:"c";s:3:"web";s:1:"d";i:34;s:1:"r";a:1:{i:0;i:1;}}i:27;a:5:{s:1:"a";i:35;s:1:"b";s:15:"create-resource";s:1:"c";s:3:"web";s:1:"d";i:40;s:1:"r";a:1:{i:0;i:1;}}i:28;a:5:{s:1:"a";i:37;s:1:"b";s:15:"loghistori-list";s:1:"c";s:3:"web";s:1:"d";i:46;s:1:"r";a:1:{i:0;i:1;}}i:29;a:5:{s:1:"a";i:44;s:1:"b";s:20:"loghistori-deleteall";s:1:"c";s:3:"web";s:1:"d";i:46;s:1:"r";a:1:{i:0;i:1;}}i:30;a:5:{s:1:"a";i:45;s:1:"b";s:12:"advance-list";s:1:"c";s:3:"web";s:1:"d";i:45;s:1:"r";a:1:{i:0;i:1;}}i:31;a:5:{s:1:"a";i:46;s:1:"b";s:10:"route-list";s:1:"c";s:3:"web";s:1:"d";i:46;s:1:"r";a:1:{i:0;i:1;}}i:32;a:5:{s:1:"a";i:47;s:1:"b";s:12:"route-create";s:1:"c";s:3:"web";s:1:"d";i:50;s:1:"r";a:1:{i:0;i:1;}}i:33;a:5:{s:1:"a";i:48;s:1:"b";s:9:"menu-list";s:1:"c";s:3:"web";s:1:"d";i:50;s:1:"r";a:1:{i:0;i:1;}}i:34;a:5:{s:1:"a";i:49;s:1:"b";s:19:"permissionrole-list";s:1:"c";s:3:"web";s:1:"d";i:50;s:1:"r";a:1:{i:0;i:1;}}i:35;a:5:{s:1:"a";i:71;s:1:"b";s:9:"unit-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:36;a:5:{s:1:"a";i:72;s:1:"b";s:11:"unit-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:37;a:5:{s:1:"a";i:73;s:1:"b";s:9:"unit-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:38;a:5:{s:1:"a";i:74;s:1:"b";s:11:"unit-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:39;a:5:{s:1:"a";i:75;s:1:"b";s:13:"category-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:40;a:5:{s:1:"a";i:76;s:1:"b";s:15:"category-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:41;a:5:{s:1:"a";i:77;s:1:"b";s:13:"category-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:42;a:5:{s:1:"a";i:78;s:1:"b";s:15:"category-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:43;a:5:{s:1:"a";i:79;s:1:"b";s:12:"product-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:44;a:5:{s:1:"a";i:80;s:1:"b";s:14:"product-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:45;a:5:{s:1:"a";i:81;s:1:"b";s:12:"product-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:46;a:5:{s:1:"a";i:82;s:1:"b";s:14:"product-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:47;a:5:{s:1:"a";i:83;s:1:"b";s:13:"supplier-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:48;a:5:{s:1:"a";i:84;s:1:"b";s:15:"supplier-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:49;a:5:{s:1:"a";i:85;s:1:"b";s:13:"supplier-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:50;a:5:{s:1:"a";i:86;s:1:"b";s:15:"supplier-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:51;a:5:{s:1:"a";i:87;s:1:"b";s:13:"purchase-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:52;a:5:{s:1:"a";i:88;s:1:"b";s:15:"purchase-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:53;a:5:{s:1:"a";i:89;s:1:"b";s:13:"purchase-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:54;a:5:{s:1:"a";i:90;s:1:"b";s:15:"purchase-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:55;a:5:{s:1:"a";i:91;s:1:"b";s:9:"cash-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:56;a:5:{s:1:"a";i:92;s:1:"b";s:9:"cash-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:57;a:5:{s:1:"a";i:93;s:1:"b";s:11:"cash-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:58;a:5:{s:1:"a";i:94;s:1:"b";s:11:"cash-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:59;a:5:{s:1:"a";i:95;s:1:"b";s:13:"transact-list";s:1:"c";s:3:"web";s:1:"d";i:2;s:1:"r";a:1:{i:0;i:1;}}i:60;a:5:{s:1:"a";i:96;s:1:"b";s:10:"order-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:61;a:5:{s:1:"a";i:97;s:1:"b";s:12:"order-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:62;a:5:{s:1:"a";i:98;s:1:"b";s:10:"order-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:63;a:5:{s:1:"a";i:99;s:1:"b";s:12:"order-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:64;a:5:{s:1:"a";i:100;s:1:"b";s:13:"customer-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:65;a:5:{s:1:"a";i:101;s:1:"b";s:15:"customer-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:66;a:5:{s:1:"a";i:102;s:1:"b";s:13:"customer-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:67;a:5:{s:1:"a";i:103;s:1:"b";s:15:"customer-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:68;a:5:{s:1:"a";i:104;s:1:"b";s:24:"transactioncategory-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:69;a:5:{s:1:"a";i:105;s:1:"b";s:26:"transactioncategory-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:70;a:5:{s:1:"a";i:106;s:1:"b";s:24:"transactioncategory-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:71;a:5:{s:1:"a";i:107;s:1:"b";s:26:"transactioncategory-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:72;a:5:{s:1:"a";i:108;s:1:"b";s:16:"transaction-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:73;a:5:{s:1:"a";i:109;s:1:"b";s:18:"transaction-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:74;a:5:{s:1:"a";i:110;s:1:"b";s:16:"transaction-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:75;a:5:{s:1:"a";i:111;s:1:"b";s:18:"transaction-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:76;a:5:{s:1:"a";i:112;s:1:"b";s:16:"stockopname-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:77;a:5:{s:1:"a";i:113;s:1:"b";s:18:"stockopname-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:78;a:5:{s:1:"a";i:114;s:1:"b";s:16:"stockopname-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:79;a:5:{s:1:"a";i:115;s:1:"b";s:18:"stockopname-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:80;a:5:{s:1:"a";i:116;s:1:"b";s:15:"adjustment-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:81;a:5:{s:1:"a";i:117;s:1:"b";s:17:"adjustment-create";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:82;a:5:{s:1:"a";i:118;s:1:"b";s:15:"adjustment-edit";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:83;a:5:{s:1:"a";i:119;s:1:"b";s:17:"adjustment-delete";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:84;a:5:{s:1:"a";i:120;s:1:"b";s:11:"report-list";s:1:"c";s:3:"web";s:1:"d";i:4;s:1:"r";a:1:{i:0;i:1;}}i:85;a:5:{s:1:"a";i:121;s:1:"b";s:19:"purchasereport-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:86;a:5:{s:1:"a";i:122;s:1:"b";s:16:"orderreport-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:87;a:5:{s:1:"a";i:123;s:1:"b";s:18:"productreport-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:88;a:5:{s:1:"a";i:124;s:1:"b";s:17:"profitreport-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}i:89;a:5:{s:1:"a";i:125;s:1:"b";s:21:"topproductreport-list";s:1:"c";s:3:"web";s:1:"d";N;s:1:"r";a:1:{i:0;i:1;}}}s:5:"roles";a:2:{i:0;a:3:{s:1:"a";i:1;s:1:"b";s:5:"Admin";s:1:"c";s:3:"web";}i:1;a:3:{s:1:"a";i:2;s:1:"b";s:8:"Pengguna";s:1:"c";s:3:"web";}}}', 1735219716);

-- Dumping structure for table db_master_pos.cache_locks
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.cache_locks: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.cash
CREATE TABLE IF NOT EXISTS `cash` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.cash: ~2 rows (approximately)
INSERT INTO `cash` (`id`, `name`, `amount`, `created_at`, `updated_at`) VALUES
	(1, 'Kas Toko', 113700, '2024-11-24 07:27:30', '2024-12-23 16:27:28'),
	(2, 'Bank BSI', 628200, '2024-11-24 07:27:43', '2024-12-25 05:15:45');

-- Dumping structure for table db_master_pos.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.categories: ~2 rows (approximately)
INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'Makanan', 'Kategori Makanan', '2024-11-22 23:53:12', '2024-11-22 23:53:47'),
	(2, 'Minuman', 'Kategori Minuman', '2024-11-22 23:53:24', '2024-11-22 23:54:06'),
	(3, 'Cemilan', 'Kategori Cemilan', '2024-11-22 23:53:35', '2024-11-22 23:53:35'),
	(4, 'Aksesoris', NULL, '2024-11-30 03:19:48', '2024-11-30 03:19:48'),
	(5, 'Alat Tulis Kantor', 'Alat Tulis Kantor Terlengkap', '2024-12-04 03:27:24', '2024-12-04 03:27:24');

-- Dumping structure for table db_master_pos.customers
CREATE TABLE IF NOT EXISTS `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_category_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`),
  KEY `customers_customer_category_id_foreign` (`customer_category_id`),
  CONSTRAINT `customers_customer_category_id_foreign` FOREIGN KEY (`customer_category_id`) REFERENCES `customer_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.customers: ~2 rows (approximately)
INSERT INTO `customers` (`id`, `name`, `email`, `phone`, `customer_category_id`, `created_at`, `updated_at`) VALUES
	(1, 'Pelanggan Umum', 'pelanggan@gmail.com', '0000000', 1, '2024-11-28 03:48:29', '2024-11-28 03:48:30'),
	(2, 'Rudi Turmudzi', 'rudi@gmail.com', '0000000', 2, '2024-11-28 03:48:59', '2024-11-28 03:48:59'),
	(3, 'Maryam Layla Alfathunissa', 'alfathunissamaryamlayla@gmail.com', '0000000', 2, '2024-12-02 08:17:20', '2024-12-02 08:33:16');

-- Dumping structure for table db_master_pos.customer_categories
CREATE TABLE IF NOT EXISTS `customer_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.customer_categories: ~2 rows (approximately)
INSERT INTO `customer_categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Pengguna Umum', '2024-11-23 10:09:59', '2024-11-23 10:10:00'),
	(2, 'Member', '2024-11-23 10:10:22', '2024-11-23 10:10:23');

-- Dumping structure for table db_master_pos.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.galeries
CREATE TABLE IF NOT EXISTS `galeries` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.galeries: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.jobs: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.job_batches
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.job_batches: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.log_histories
CREATE TABLE IF NOT EXISTS `log_histories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `Tabel_Asal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ID_Entitas` bigint unsigned DEFAULT NULL,
  `Aksi` enum('Create','Read','Update','Delete') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Waktu` timestamp NULL DEFAULT NULL,
  `Pengguna` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Data_Lama` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `Data_Baru` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=947 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.log_histories: ~103 rows (approximately)
INSERT INTO `log_histories` (`id`, `Tabel_Asal`, `ID_Entitas`, `Aksi`, `Waktu`, `Pengguna`, `Data_Lama`, `Data_Baru`, `created_at`, `updated_at`) VALUES
	(833, 'Purchase', 116, 'Create', '2024-12-15 02:21:40', '1', NULL, '{"image":"20241215092139_ELECTRO_MUSIC.webp","type_payment":"CASH","purchase_date":"2024-12-15","no_purchase":"MST-20241215-000001-PCS","supplier_id":"1","user_id":1,"cash_id":"1","total_cost":"128000","status":"Pesanan Pembelian","description":"Pembelian Pada Supplier Baru","updated_at":"2024-12-15T09:21:39.000000Z","created_at":"2024-12-15T09:21:39.000000Z","id":116}', '2024-12-15 02:21:40', '2024-12-15 02:21:40'),
	(834, 'Purchase', 116, 'Update', '2024-12-15 02:22:08', '1', '{"id":116,"purchase_date":"2024-12-15","no_purchase":"MST-20241215-000001-PCS","user_id":1,"supplier_id":1,"cash_id":1,"total_cost":128000,"status":"Pesanan Pembelian","image":"20241215092139_ELECTRO_MUSIC.webp","description":"Pembelian Pada Supplier Baru","type_payment":"CASH","created_at":"2024-12-15T09:21:39.000000Z","updated_at":"2024-12-15T09:21:39.000000Z"}', '{"id":116,"purchase_date":"2024-12-15","no_purchase":"MST-20241215-000001-PCS","user_id":1,"supplier_id":1,"cash_id":1,"total_cost":128000,"status":"Lunas","image":"20241215092139_ELECTRO_MUSIC.webp","description":"Pembelian Pada Supplier Baru","type_payment":"CASH","created_at":"2024-12-15T09:21:39.000000Z","updated_at":"2024-12-15T09:22:08.000000Z"}', '2024-12-15 02:22:08', '2024-12-15 02:22:08'),
	(835, 'Purchase', 117, 'Create', '2024-12-15 02:23:17', '1', NULL, '{"image":"20241215092317_ELECTRO_MUSIC2.webp","type_payment":"CASH","purchase_date":"2024-12-15","no_purchase":"MST-20241215-000002-PCS","supplier_id":"2","user_id":1,"cash_id":"1","total_cost":"590000","status":"Lunas","description":"Prima Rasa Abadi","updated_at":"2024-12-15T09:23:17.000000Z","created_at":"2024-12-15T09:23:17.000000Z","id":117}', '2024-12-15 02:23:17', '2024-12-15 02:23:17'),
	(836, 'Purchase', 118, 'Create', '2024-12-15 02:25:24', '1', NULL, '{"image":"20241215092523_IMG-20220630-WA0000.webp","type_payment":"CASH","purchase_date":"2024-12-15","no_purchase":"MST-20241215-000003-PCS","supplier_id":"3","user_id":1,"cash_id":"1","total_cost":"258000","status":"Lunas","description":"ATK","updated_at":"2024-12-15T09:25:23.000000Z","created_at":"2024-12-15T09:25:23.000000Z","id":118}', '2024-12-15 02:25:24', '2024-12-15 02:25:24'),
	(837, 'Purchase', 119, 'Create', '2024-12-15 02:26:41', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2024-12-15","no_purchase":"MST-20241215-000004-PCS","supplier_id":"1","user_id":1,"cash_id":"1","total_cost":"23000","status":"Lunas","description":"Sementara","updated_at":"2024-12-15T09:26:40.000000Z","created_at":"2024-12-15T09:26:40.000000Z","id":119}', '2024-12-15 02:26:41', '2024-12-15 02:26:41'),
	(838, 'Order', 40, 'Create', '2024-12-15 04:44:30', '1', NULL, '{"image":"20241215114430_ELECTRO_MUSIC.webp","type_payment":"CASH","order_date":"2024-12-15","no_order":"MST-20241215-000001-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"49000","status":"Lunas","total_cost_before":"49000","percent_discount":"0","amount_discount":"0","input_payment":"50.000","return_payment":"1.000","description":"Penjualan Pertama","updated_at":"2024-12-15T11:44:30.000000Z","created_at":"2024-12-15T11:44:30.000000Z","id":40}', '2024-12-15 04:44:30', '2024-12-15 04:44:30'),
	(839, 'Order', 41, 'Create', '2024-12-15 04:46:07', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-15","no_order":"MST-20241215-000002-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"268000","status":"Pesanan Penjualan","total_cost_before":"268000","percent_discount":"0","amount_discount":"0","input_payment":"268000","return_payment":null,"description":null,"updated_at":"2024-12-15T11:46:06.000000Z","created_at":"2024-12-15T11:46:06.000000Z","id":41}', '2024-12-15 04:46:07', '2024-12-15 04:46:07'),
	(840, 'Order', 41, 'Update', '2024-12-15 04:46:40', '1', '{"id":41,"order_date":"2024-12-15","no_order":"MST-20241215-000002-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":268000,"percent_discount":0,"amount_discount":0,"input_payment":268000,"return_payment":null,"total_cost":268000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-15T11:46:06.000000Z","updated_at":"2024-12-15T11:46:06.000000Z"}', '{"id":41,"order_date":"2024-12-15","no_order":"MST-20241215-000002-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":268000,"percent_discount":0,"amount_discount":0,"input_payment":268000,"return_payment":null,"total_cost":268000,"status":"Lunas","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-15T11:46:06.000000Z","updated_at":"2024-12-15T11:46:40.000000Z"}', '2024-12-15 04:46:40', '2024-12-15 04:46:40'),
	(841, 'Purchase', 120, 'Create', '2024-12-15 16:42:01', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2024-12-15","no_purchase":"MST-20241215-000005-PCS","supplier_id":"1","user_id":1,"cash_id":"1","total_cost":"21000","status":"Lunas","description":null,"updated_at":"2024-12-15T23:42:00.000000Z","created_at":"2024-12-15T23:42:00.000000Z","id":120}', '2024-12-15 16:42:01', '2024-12-15 16:42:01'),
	(842, 'Order', 42, 'Create', '2024-12-15 16:42:36', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-15","no_order":"MST-20241215-000003-ORD","customer_id":"1","user_id":1,"cash_id":null,"total_cost":"103000","status":"Pesanan Penjualan","total_cost_before":"103000","percent_discount":"0","amount_discount":"0","input_payment":"103000","return_payment":null,"description":null,"updated_at":"2024-12-15T23:42:36.000000Z","created_at":"2024-12-15T23:42:36.000000Z","id":42}', '2024-12-15 16:42:36', '2024-12-15 16:42:36'),
	(843, 'Order', 42, 'Update', '2024-12-15 16:44:05', '1', '{"id":42,"order_date":"2024-12-15","no_order":"MST-20241215-000003-ORD","customer_id":1,"user_id":1,"cash_id":null,"total_cost_before":103000,"percent_discount":0,"amount_discount":0,"input_payment":103000,"return_payment":null,"total_cost":103000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-15T23:42:36.000000Z","updated_at":"2024-12-15T23:42:36.000000Z"}', '{"id":42,"order_date":"2024-12-15","no_order":"MST-20241215-000003-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":103000,"percent_discount":0,"amount_discount":0,"input_payment":103000,"return_payment":null,"total_cost":103000,"status":"Lunas","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-15T23:42:36.000000Z","updated_at":"2024-12-15T23:44:05.000000Z"}', '2024-12-15 16:44:05', '2024-12-15 16:44:05'),
	(844, 'Permission', 120, 'Create', '2024-12-15 16:48:27', '1', NULL, '{"name":"laporan-index","urutan":"4","guard_name":"web","updated_at":"2024-12-15T23:48:27.000000Z","created_at":"2024-12-15T23:48:27.000000Z","id":120}', '2024-12-15 16:48:27', '2024-12-15 16:48:27'),
	(845, 'Permission', 120, 'Update', '2024-12-15 16:48:51', '1', '{"id":120,"name":"laporan-index","guard_name":"web","urutan":4,"created_at":"2024-12-15T23:48:27.000000Z","updated_at":"2024-12-15T23:48:27.000000Z"}', '{"id":120,"name":"laporan-list","guard_name":"web","urutan":4,"created_at":"2024-12-15T23:48:27.000000Z","updated_at":"2024-12-15T23:48:51.000000Z"}', '2024-12-15 16:48:51', '2024-12-15 16:48:51'),
	(846, 'MenuGroup', 11, 'Create', '2024-12-15 16:49:21', '1', NULL, '{"name":"Laporan","permission_name":"laporan-list","status":"Aktif","position":"4","updated_at":"2024-12-15T23:49:21.000000Z","created_at":"2024-12-15T23:49:21.000000Z","id":11}', '2024-12-15 16:49:21', '2024-12-15 16:49:21'),
	(847, 'Role', 1, 'Update', '2024-12-15 16:49:59', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","laporan-list"]}', '2024-12-15 16:49:59', '2024-12-15 16:49:59'),
	(848, 'Permission', 121, 'Create', '2024-12-15 17:42:48', '1', NULL, '{"name":"report-purchase_report","urutan":null,"guard_name":"web","updated_at":"2024-12-16T00:42:48.000000Z","created_at":"2024-12-16T00:42:48.000000Z","id":121}', '2024-12-15 17:42:48', '2024-12-15 17:42:48'),
	(849, 'Role', 1, 'Update', '2024-12-15 17:43:13', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","laporan-list"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","laporan-list","report-purchase_report"]}', '2024-12-15 17:43:13', '2024-12-15 17:43:13'),
	(850, 'Menu Item', 39, 'Create', '2024-12-15 17:44:06', '1', NULL, '{"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"purchase_reports","permission_name":"report-purchase_report","status":"Aktif","position":"1","menu_group_id":"11","parent_id":null,"updated_at":"2024-12-16T00:44:06.000000Z","created_at":"2024-12-16T00:44:06.000000Z","id":39}', '2024-12-15 17:44:06', '2024-12-15 17:44:06'),
	(851, 'Permission', 120, 'Update', '2024-12-15 20:17:58', '1', '{"id":120,"name":"laporan-list","guard_name":"web","urutan":4,"created_at":"2024-12-15T23:48:27.000000Z","updated_at":"2024-12-15T23:48:51.000000Z"}', '{"id":120,"name":"purchasereport-list","guard_name":"web","urutan":4,"created_at":"2024-12-15T23:48:27.000000Z","updated_at":"2024-12-16T03:17:58.000000Z"}', '2024-12-15 20:17:58', '2024-12-15 20:17:58'),
	(852, 'Permission', 120, 'Update', '2024-12-15 20:19:05', '1', '{"id":120,"name":"purchasereport-list","guard_name":"web","urutan":4,"created_at":"2024-12-15T23:48:27.000000Z","updated_at":"2024-12-16T03:17:58.000000Z"}', '{"id":120,"name":"report-list","guard_name":"web","urutan":4,"created_at":"2024-12-15T23:48:27.000000Z","updated_at":"2024-12-16T03:19:05.000000Z"}', '2024-12-15 20:19:05', '2024-12-15 20:19:05'),
	(853, 'Permission', 121, 'Update', '2024-12-15 20:19:37', '1', '{"id":121,"name":"report-purchase_report","guard_name":"web","urutan":null,"created_at":"2024-12-16T00:42:48.000000Z","updated_at":"2024-12-16T00:42:48.000000Z"}', '{"id":121,"name":"purchasereport-list","guard_name":"web","urutan":null,"created_at":"2024-12-16T00:42:48.000000Z","updated_at":"2024-12-16T03:19:37.000000Z"}', '2024-12-15 20:19:37', '2024-12-15 20:19:37'),
	(854, 'Menu Item', 39, 'Update', '2024-12-15 20:21:10', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"adjustments.index","status":"Aktif","permission_name":"report-purchase_report","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T00:44:06.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"purchase_reports.index","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:21:10.000000Z"}', '2024-12-15 20:21:10', '2024-12-15 20:21:10'),
	(855, 'Role', 1, 'Update', '2024-12-15 20:21:28', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list"]}', '2024-12-15 20:21:28', '2024-12-15 20:21:28'),
	(856, 'Menu Group', 11, 'Update', '2024-12-15 20:22:07', '1', '{"id":11,"name":"Laporan","status":"Aktif","permission_name":"laporan-list","position":4,"created_at":"2024-12-15T23:49:21.000000Z","updated_at":"2024-12-15T23:49:21.000000Z"}', '{"id":11,"name":"Laporan","status":"Aktif","permission_name":"report-list","position":"4","created_at":"2024-12-15T23:49:21.000000Z","updated_at":"2024-12-16T03:22:07.000000Z"}', '2024-12-15 20:22:07', '2024-12-15 20:22:07'),
	(857, 'Menu Item', 39, 'Update', '2024-12-15 20:22:56', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"purchase_reports.index","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:21:10.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"reports\\/purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:22:56.000000Z"}', '2024-12-15 20:22:56', '2024-12-15 20:22:56'),
	(858, 'Menu Item', 39, 'Update', '2024-12-15 20:24:36', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"adjustments.index","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:22:56.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"report\\/purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:24:36.000000Z"}', '2024-12-15 20:24:36', '2024-12-15 20:24:36'),
	(859, 'Menu Item', 39, 'Update', '2024-12-15 20:27:47', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"adjustments.index","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:24:36.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"report\\/purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:27:47.000000Z"}', '2024-12-15 20:27:47', '2024-12-15 20:27:47'),
	(860, 'Menu Item', 39, 'Update', '2024-12-15 20:30:42', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"adjustments.index","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:27:47.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"purchase_reports.index","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:30:42.000000Z"}', '2024-12-15 20:30:42', '2024-12-15 20:30:42'),
	(861, 'Menu Item', 39, 'Update', '2024-12-15 20:34:39', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:30:42.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"report\\/purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:34:39.000000Z"}', '2024-12-15 20:34:39', '2024-12-15 20:34:39'),
	(862, 'Menu Item', 39, 'Update', '2024-12-15 20:37:21', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-brand-blogger","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:34:39.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-layout-grid","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:37:21.000000Z"}', '2024-12-15 20:37:21', '2024-12-15 20:37:21'),
	(863, 'Menu Item', 39, 'Update', '2024-12-15 20:37:47', '1', '{"id":39,"name":"Laporan Pembelian","icon":"ti ti-layout-grid","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:37:21.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"fa fa-folder","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:37:47.000000Z"}', '2024-12-15 20:37:47', '2024-12-15 20:37:47'),
	(864, 'Menu Item', 39, 'Update', '2024-12-15 20:38:01', '1', '{"id":39,"name":"Laporan Pembelian","icon":"fa fa-folder","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":11,"position":1,"parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:37:47.000000Z"}', '{"id":39,"name":"Laporan Pembelian","icon":"fa fa-file","route":"report.purchase_reports","status":"Aktif","permission_name":"purchasereport-list","menu_group_id":"11","position":"1","parent_id":null,"created_at":"2024-12-16T00:44:06.000000Z","updated_at":"2024-12-16T03:38:01.000000Z"}', '2024-12-15 20:38:01', '2024-12-15 20:38:01'),
	(865, 'Permission', 122, 'Create', '2024-12-15 23:44:38', '1', NULL, '{"name":"orderreport-list","urutan":null,"guard_name":"web","updated_at":"2024-12-16T06:44:38.000000Z","created_at":"2024-12-16T06:44:38.000000Z","id":122}', '2024-12-15 23:44:38', '2024-12-15 23:44:38'),
	(866, 'Role', 1, 'Update', '2024-12-15 23:45:03', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list"]}', '2024-12-15 23:45:03', '2024-12-15 23:45:03'),
	(867, 'Menu Item', 40, 'Create', '2024-12-15 23:46:41', '1', NULL, '{"name":"Laporan Penjualan","icon":"fa-fa-file","route":"report.order_reports","permission_name":"orderreport-list","status":"Aktif","position":"2","menu_group_id":"11","parent_id":null,"updated_at":"2024-12-16T06:46:41.000000Z","created_at":"2024-12-16T06:46:41.000000Z","id":40}', '2024-12-15 23:46:41', '2024-12-15 23:46:41'),
	(868, 'Menu Item', 40, 'Update', '2024-12-15 23:48:10', '1', '{"id":40,"name":"Laporan Penjualan","icon":"fa-fa-file","route":"report.order_reports","status":"Aktif","permission_name":"orderreport-list","menu_group_id":11,"position":4,"parent_id":null,"created_at":"2024-12-16T06:46:41.000000Z","updated_at":"2024-12-16T06:46:47.000000Z"}', '{"id":40,"name":"Laporan Penjualan","icon":"fa fa-file","route":"report.order_reports","status":"Aktif","permission_name":"orderreport-list","menu_group_id":"11","position":"4","parent_id":null,"created_at":"2024-12-16T06:46:41.000000Z","updated_at":"2024-12-16T06:48:10.000000Z"}', '2024-12-15 23:48:10', '2024-12-15 23:48:10'),
	(869, 'Produk', 18, 'Create', '2024-12-17 05:13:20', '1', NULL, '{"name":"Beng Beng","code_product":"B001","barcode":null,"category_id":"3","unit_id":"1","purchase_price":"2300","cost_price":"3500","stock":"0","reminder":"0","description":"BENG BENG VARIAN BARU","image":"20241217121319_db572b217ce298e397ea8fc452302f8a.webp","updated_at":"2024-12-17T12:13:20.000000Z","created_at":"2024-12-17T12:13:20.000000Z","id":18}', '2024-12-17 05:13:20', '2024-12-17 05:13:20'),
	(870, 'Purchase', 121, 'Create', '2024-12-17 05:14:46', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2024-12-17","no_purchase":"MST-20241217-000006-PCS","supplier_id":"2","user_id":1,"cash_id":"1","total_cost":"23000","status":"Lunas","description":null,"updated_at":"2024-12-17T12:14:45.000000Z","created_at":"2024-12-17T12:14:45.000000Z","id":121}', '2024-12-17 05:14:46', '2024-12-17 05:14:46'),
	(871, 'Order', 43, 'Create', '2024-12-17 05:15:21', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-17","no_order":"MST-20241217-000004-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"28000","status":"Pesanan Penjualan","total_cost_before":"28000","percent_discount":"0","amount_discount":"0","input_payment":"28000","return_payment":null,"description":null,"updated_at":"2024-12-17T12:15:20.000000Z","created_at":"2024-12-17T12:15:20.000000Z","id":43}', '2024-12-17 05:15:21', '2024-12-17 05:15:21'),
	(872, 'Permission', 123, 'Create', '2024-12-17 09:26:43', '1', NULL, '{"name":"productreport-list","urutan":null,"guard_name":"web","updated_at":"2024-12-17T16:26:43.000000Z","created_at":"2024-12-17T16:26:43.000000Z","id":123}', '2024-12-17 09:26:43', '2024-12-17 09:26:43'),
	(873, 'Role', 1, 'Update', '2024-12-17 09:27:07', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list","productreport-list"]}', '2024-12-17 09:27:07', '2024-12-17 09:27:07'),
	(874, 'Menu Item', 41, 'Create', '2024-12-17 09:28:05', '1', NULL, '{"name":"Laporan Produk","icon":"fa fa-file","route":"report.product_reports","permission_name":"productreport-list","status":"Aktif","position":"3","menu_group_id":"11","parent_id":null,"updated_at":"2024-12-17T16:28:05.000000Z","created_at":"2024-12-17T16:28:05.000000Z","id":41}', '2024-12-17 09:28:05', '2024-12-17 09:28:05'),
	(875, 'Order', 44, 'Create', '2024-12-17 12:53:04', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-17","no_order":"MST-20241217-000005-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"118500","status":"Pesanan Penjualan","total_cost_before":"118500","percent_discount":"0","amount_discount":"0","input_payment":"118500","return_payment":null,"description":null,"updated_at":"2024-12-17T19:53:03.000000Z","created_at":"2024-12-17T19:53:03.000000Z","id":44}', '2024-12-17 12:53:04', '2024-12-17 12:53:04'),
	(876, 'Order', 44, 'Update', '2024-12-17 13:04:39', '1', '{"id":44,"order_date":"2024-12-17","no_order":"MST-20241217-000005-ORD","customer_id":2,"user_id":1,"cash_id":1,"total_cost_before":118500,"percent_discount":0,"amount_discount":0,"input_payment":118500,"return_payment":null,"total_cost":118500,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-17T19:53:03.000000Z","updated_at":"2024-12-17T19:53:03.000000Z"}', '{"id":44,"order_date":"2024-12-17","no_order":"MST-20241217-000005-ORD","customer_id":2,"user_id":1,"cash_id":1,"total_cost_before":118500,"percent_discount":0,"amount_discount":0,"input_payment":118500,"return_payment":null,"total_cost":118500,"status":"Lunas","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-17T19:53:03.000000Z","updated_at":"2024-12-17T20:04:39.000000Z"}', '2024-12-17 13:04:39', '2024-12-17 13:04:39'),
	(877, 'Order', 43, 'Update', '2024-12-17 13:04:54', '1', '{"id":43,"order_date":"2024-12-17","no_order":"MST-20241217-000004-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":28000,"percent_discount":0,"amount_discount":0,"input_payment":28000,"return_payment":null,"total_cost":28000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-17T12:15:20.000000Z","updated_at":"2024-12-17T12:15:20.000000Z"}', '{"id":43,"order_date":"2024-12-17","no_order":"MST-20241217-000004-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":28000,"percent_discount":0,"amount_discount":0,"input_payment":28000,"return_payment":null,"total_cost":28000,"status":"Lunas","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-17T12:15:20.000000Z","updated_at":"2024-12-17T20:04:54.000000Z"}', '2024-12-17 13:04:54', '2024-12-17 13:04:54'),
	(878, 'Order', 45, 'Create', '2024-12-18 02:43:59', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-18","no_order":"MST-20241218-000006-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"161000","status":"Lunas","total_cost_before":"161000","percent_discount":"0","amount_discount":"0","input_payment":"161.000","return_payment":"0","description":null,"updated_at":"2024-12-18T09:43:59.000000Z","created_at":"2024-12-18T09:43:59.000000Z","id":45}', '2024-12-18 02:43:59', '2024-12-18 02:43:59'),
	(879, 'Purchase', 122, 'Create', '2024-12-18 03:42:13', '1', NULL, '{"image":"","type_payment":"TRANSFER","purchase_date":"2024-12-18","no_purchase":"MST-20241218-000007-PCS","supplier_id":"3","user_id":1,"cash_id":"2","total_cost":"70000","status":"Lunas","description":null,"updated_at":"2024-12-18T10:42:13.000000Z","created_at":"2024-12-18T10:42:13.000000Z","id":122}', '2024-12-18 03:42:13', '2024-12-18 03:42:13'),
	(880, 'Order', 46, 'Create', '2024-12-18 03:43:00', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-18","no_order":"MST-20241218-000007-ORD","customer_id":"3","user_id":1,"cash_id":"2","total_cost":"154000","status":"Lunas","total_cost_before":"154000","percent_discount":"0","amount_discount":"0","input_payment":"154000","return_payment":null,"description":null,"updated_at":"2024-12-18T10:42:59.000000Z","created_at":"2024-12-18T10:42:59.000000Z","id":46}', '2024-12-18 03:43:00', '2024-12-18 03:43:00'),
	(881, 'Produk', 9, 'Update', '2024-12-18 10:27:47', '1', '{"id":9,"code_product":"182109276","barcode":"17051127504","name":"Makaroni Layla","unit_id":"1","category_id":"3","description":"Makaroni Layla Deskripsi","purchase_price":"3000","cost_price":"5000","stock":"28","image":"20241127165559_makaroni.webp","reminder":"10","created_at":"2024-11-23T16:27:51.000000Z","updated_at":"2024-12-18T17:27:46.000000Z"}', '{"_token":"fACk2zOLUFzZlfGkmJIYKPjht6tCQ5p5WNekquUj","_method":"PUT","name":"Makaroni Layla","code_product":"182109276","barcode":"17051127504","category_id":"3","unit_id":"1","purchase_price":"3000","cost_price":"5000","stock":"28","reminder":"10","description":"Makaroni Layla Deskripsi","image":"20241127165559_makaroni.webp"}', '2024-12-18 10:27:47', '2024-12-18 10:27:47'),
	(882, 'Produk', 9, 'Update', '2024-12-18 10:28:04', '1', '{"id":9,"code_product":"17051127504","barcode":"17051127504","name":"Makaroni Layla","unit_id":"1","category_id":"3","description":"Makaroni Layla Deskripsi","purchase_price":"3000","cost_price":"5000","stock":"28","image":"20241127165559_makaroni.webp","reminder":"10","created_at":"2024-11-23T16:27:51.000000Z","updated_at":"2024-12-18T17:28:04.000000Z"}', '{"_token":"fACk2zOLUFzZlfGkmJIYKPjht6tCQ5p5WNekquUj","_method":"PUT","name":"Makaroni Layla","code_product":"17051127504","barcode":"17051127504","category_id":"3","unit_id":"1","purchase_price":"3000","cost_price":"5000","stock":"28","reminder":"10","description":"Makaroni Layla Deskripsi","image":"20241127165559_makaroni.webp"}', '2024-12-18 10:28:04', '2024-12-18 10:28:04'),
	(883, 'Produk', 10, 'Update', '2024-12-18 10:28:51', '1', '{"id":10,"code_product":"7017890778899","barcode":"8809687005481","name":"Keripik Pisang","unit_id":"1","category_id":"3","description":"Keripik Pisang Deskripsi","purchase_price":"4000","cost_price":"6000","stock":"26","image":"20241127165521_astronauts-id.webp","reminder":"10","created_at":"2024-11-24T06:55:26.000000Z","updated_at":"2024-12-18T17:28:51.000000Z"}', '{"_token":"fACk2zOLUFzZlfGkmJIYKPjht6tCQ5p5WNekquUj","_method":"PUT","name":"Keripik Pisang","code_product":"7017890778899","barcode":"8809687005481","category_id":"3","unit_id":"1","purchase_price":"4000","cost_price":"6000","stock":"26","reminder":"10","description":"Keripik Pisang Deskripsi","image":"20241127165521_astronauts-id.webp"}', '2024-12-18 10:28:51', '2024-12-18 10:28:51'),
	(884, 'Produk', 10, 'Update', '2024-12-18 10:29:06', '1', '{"id":10,"code_product":"8809687005481","barcode":"8809687005481","name":"Keripik Pisang","unit_id":"1","category_id":"3","description":"Keripik Pisang Deskripsi","purchase_price":"4000","cost_price":"6000","stock":"26","image":"20241127165521_astronauts-id.webp","reminder":"10","created_at":"2024-11-24T06:55:26.000000Z","updated_at":"2024-12-18T17:29:05.000000Z"}', '{"_token":"fACk2zOLUFzZlfGkmJIYKPjht6tCQ5p5WNekquUj","_method":"PUT","name":"Keripik Pisang","code_product":"8809687005481","barcode":"8809687005481","category_id":"3","unit_id":"1","purchase_price":"4000","cost_price":"6000","stock":"26","reminder":"10","description":"Keripik Pisang Deskripsi","image":"20241127165521_astronauts-id.webp"}', '2024-12-18 10:29:06', '2024-12-18 10:29:06'),
	(885, 'Produk', 12, 'Update', '2024-12-18 10:29:30', '1', '{"id":12,"code_product":"K003","barcode":"6998658420186","name":"Coca-cola","unit_id":"6","category_id":"2","description":"Coca cola Deskripsi","purchase_price":"25000","cost_price":"35000","stock":"16","image":"20241127090127_cocacoal.webp","reminder":"10","created_at":"2024-11-27T09:01:27.000000Z","updated_at":"2024-12-18T17:29:30.000000Z"}', '{"_token":"fACk2zOLUFzZlfGkmJIYKPjht6tCQ5p5WNekquUj","_method":"PUT","name":"Coca-cola","code_product":"K003","barcode":"6998658420186","category_id":"2","unit_id":"6","purchase_price":"25000","cost_price":"35000","stock":"16","reminder":"10","description":"Coca cola Deskripsi","image":"20241127090127_cocacoal.webp"}', '2024-12-18 10:29:30', '2024-12-18 10:29:30'),
	(886, 'Produk', 12, 'Update', '2024-12-18 10:29:44', '1', '{"id":12,"code_product":"6998658420186","barcode":"6998658420186","name":"Coca-cola","unit_id":"6","category_id":"2","description":"Coca cola Deskripsi","purchase_price":"25000","cost_price":"35000","stock":"16","image":"20241127090127_cocacoal.webp","reminder":"10","created_at":"2024-11-27T09:01:27.000000Z","updated_at":"2024-12-18T17:29:44.000000Z"}', '{"_token":"fACk2zOLUFzZlfGkmJIYKPjht6tCQ5p5WNekquUj","_method":"PUT","name":"Coca-cola","code_product":"6998658420186","barcode":"6998658420186","category_id":"2","unit_id":"6","purchase_price":"25000","cost_price":"35000","stock":"16","reminder":"10","description":"Coca cola Deskripsi","image":"20241127090127_cocacoal.webp"}', '2024-12-18 10:29:44', '2024-12-18 10:29:44'),
	(887, 'Order', 47, 'Create', '2024-12-18 10:30:43', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-18","no_order":"MST-20241218-000008-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"183000","status":"Pesanan Penjualan","total_cost_before":"183000","percent_discount":"0","amount_discount":"0","input_payment":"183000","return_payment":null,"description":null,"updated_at":"2024-12-18T17:30:43.000000Z","created_at":"2024-12-18T17:30:43.000000Z","id":47}', '2024-12-18 10:30:43', '2024-12-18 10:30:43'),
	(888, 'Order', 47, 'Update', '2024-12-18 10:36:21', '1', '{"id":47,"order_date":"2024-12-18","no_order":"MST-20241218-000008-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":183000,"percent_discount":0,"amount_discount":0,"input_payment":183000,"return_payment":null,"total_cost":183000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-18T17:30:43.000000Z","updated_at":"2024-12-18T17:30:43.000000Z"}', '{"id":47,"order_date":"2024-12-18","no_order":"MST-20241218-000008-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":183000,"percent_discount":0,"amount_discount":0,"input_payment":183000,"return_payment":null,"total_cost":183000,"status":"Lunas","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-18T17:30:43.000000Z","updated_at":"2024-12-18T17:36:21.000000Z"}', '2024-12-18 10:36:21', '2024-12-18 10:36:21'),
	(889, 'Order', 48, 'Create', '2024-12-19 07:49:20', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-19","no_order":"MST-20241219-000009-ORD","customer_id":"3","user_id":1,"cash_id":"1","total_cost":"153500","status":"Pesanan Penjualan","total_cost_before":"153500","percent_discount":"0","amount_discount":"0","input_payment":"153500","return_payment":null,"description":null,"updated_at":"2024-12-19T14:49:19.000000Z","created_at":"2024-12-19T14:49:19.000000Z","id":48}', '2024-12-19 07:49:20', '2024-12-19 07:49:20'),
	(890, 'Order', 48, 'Update', '2024-12-19 07:51:04', '1', '{"id":48,"order_date":"2024-12-19","no_order":"MST-20241219-000009-ORD","customer_id":3,"user_id":1,"cash_id":1,"total_cost_before":153500,"percent_discount":0,"amount_discount":0,"input_payment":153500,"return_payment":null,"total_cost":153500,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T14:49:19.000000Z","updated_at":"2024-12-19T14:49:19.000000Z"}', '{"id":48,"order_date":"2024-12-19","no_order":"MST-20241219-000009-ORD","customer_id":3,"user_id":1,"cash_id":1,"total_cost_before":153500,"percent_discount":0,"amount_discount":0,"input_payment":153500,"return_payment":null,"total_cost":153500,"status":"Lunas","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T14:49:19.000000Z","updated_at":"2024-12-19T14:51:04.000000Z"}', '2024-12-19 07:51:04', '2024-12-19 07:51:04'),
	(891, 'Order', 49, 'Create', '2024-12-19 09:04:52', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-19","no_order":"MST-20241219-000010-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"50000","status":"Pesanan Penjualan","total_cost_before":"53000","percent_discount":"0","amount_discount":"3.000","input_payment":"50000","return_payment":null,"description":null,"updated_at":"2024-12-19T16:04:52.000000Z","created_at":"2024-12-19T16:04:52.000000Z","id":49}', '2024-12-19 09:04:52', '2024-12-19 09:04:52'),
	(892, 'Order', 50, 'Create', '2024-12-19 09:07:52', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-19","no_order":"MST-20241219-000011-ORD","customer_id":"2","user_id":1,"cash_id":"1","total_cost":"54500","status":"Pesanan Penjualan","total_cost_before":"54500","percent_discount":"0","amount_discount":"0","input_payment":"54500","return_payment":null,"description":null,"updated_at":"2024-12-19T16:07:50.000000Z","created_at":"2024-12-19T16:07:50.000000Z","id":50}', '2024-12-19 09:07:52', '2024-12-19 09:07:52'),
	(893, 'Order', 51, 'Create', '2024-12-19 09:10:36', '1', NULL, '{"image":"20241219161035_Thumbnail_YouTube__(1).webp","type_payment":"TRANSFER","order_date":"2024-12-19","no_order":"MST-20241219-000012-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"97000","status":"Pesanan Penjualan","total_cost_before":"97000","percent_discount":"0","amount_discount":"0","input_payment":"97000","return_payment":null,"description":null,"updated_at":"2024-12-19T16:10:35.000000Z","created_at":"2024-12-19T16:10:35.000000Z","id":51}', '2024-12-19 09:10:36', '2024-12-19 09:10:36'),
	(894, 'Order', 52, 'Create', '2024-12-19 09:11:43', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-19","no_order":"MST-20241219-000013-ORD","customer_id":"2","user_id":1,"cash_id":"1","total_cost":"59400","status":"Lunas","total_cost_before":"60000","percent_discount":"1","amount_discount":"0","input_payment":"59400","return_payment":null,"description":null,"updated_at":"2024-12-19T16:11:43.000000Z","created_at":"2024-12-19T16:11:43.000000Z","id":52}', '2024-12-19 09:11:43', '2024-12-19 09:11:43'),
	(895, 'Order', 53, 'Create', '2024-12-19 09:13:14', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-19","no_order":"MST-20241219-000014-ORD","customer_id":"1","user_id":1,"cash_id":null,"total_cost":"35000","status":"Pesanan Penjualan","total_cost_before":"35000","percent_discount":"0","amount_discount":"0","input_payment":"35000","return_payment":null,"description":null,"updated_at":"2024-12-19T16:13:13.000000Z","created_at":"2024-12-19T16:13:13.000000Z","id":53}', '2024-12-19 09:13:14', '2024-12-19 09:13:14'),
	(896, 'Order', 53, 'Update', '2024-12-21 02:55:43', '1', '{"id":53,"order_date":"2024-12-19","no_order":"MST-20241219-000014-ORD","customer_id":1,"user_id":1,"cash_id":null,"total_cost_before":35000,"percent_discount":0,"amount_discount":0,"input_payment":35000,"return_payment":null,"total_cost":35000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-19T16:13:13.000000Z","updated_at":"2024-12-19T16:13:13.000000Z"}', '{"id":53,"order_date":"2024-12-19","no_order":"MST-20241219-000014-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":35000,"percent_discount":0,"amount_discount":0,"input_payment":35000,"return_payment":null,"total_cost":35000,"status":"Lunas","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-19T16:13:13.000000Z","updated_at":"2024-12-21T09:55:43.000000Z"}', '2024-12-21 02:55:43', '2024-12-21 02:55:43'),
	(897, 'Order', 51, 'Update', '2024-12-21 02:55:58', '1', '{"id":51,"order_date":"2024-12-19","no_order":"MST-20241219-000012-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":97000,"percent_discount":0,"amount_discount":0,"input_payment":97000,"return_payment":null,"total_cost":97000,"status":"Pesanan Penjualan","image":"20241219161035_Thumbnail_YouTube__(1).webp","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:10:35.000000Z","updated_at":"2024-12-19T16:10:35.000000Z"}', '{"id":51,"order_date":"2024-12-19","no_order":"MST-20241219-000012-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":97000,"percent_discount":0,"amount_discount":0,"input_payment":97000,"return_payment":null,"total_cost":97000,"status":"Lunas","image":"20241219161035_Thumbnail_YouTube__(1).webp","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:10:35.000000Z","updated_at":"2024-12-21T09:55:58.000000Z"}', '2024-12-21 02:55:58', '2024-12-21 02:55:58'),
	(898, 'Order', 54, 'Create', '2024-12-21 02:59:21', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-21","no_order":"MST-20241221-000015-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"42000","status":"Lunas","total_cost_before":"42000","percent_discount":"0","amount_discount":"0","input_payment":"42000","return_payment":null,"description":null,"updated_at":"2024-12-21T09:59:21.000000Z","created_at":"2024-12-21T09:59:21.000000Z","id":54}', '2024-12-21 02:59:21', '2024-12-21 02:59:21'),
	(899, 'Transaksi', 12, 'Create', '2024-12-21 08:38:29', '1', NULL, '{"date":"2024-12-21","transaction_category_id":"2","cash_id":"1","name":"Donasi Kasir","description":"Donasi Kasir","amount":200000,"image":"20241221153828_miqot_haji-Sampul.webp","updated_at":"2024-12-21T15:38:29.000000Z","created_at":"2024-12-21T15:38:29.000000Z","id":12}', '2024-12-21 08:38:29', '2024-12-21 08:38:29'),
	(900, 'Transaksi', 13, 'Create', '2024-12-21 08:39:26', '1', NULL, '{"date":"2024-12-21","transaction_category_id":"1","cash_id":"1","name":"Listrik","description":"Listrik Kantor","amount":100000,"image":"20241221153925_Thumbnail_YouTube__(1).webp","updated_at":"2024-12-21T15:39:26.000000Z","created_at":"2024-12-21T15:39:26.000000Z","id":13}', '2024-12-21 08:39:26', '2024-12-21 08:39:26'),
	(901, 'Permission', 124, 'Create', '2024-12-21 08:59:20', '1', NULL, '{"name":"profitreport-list","urutan":null,"guard_name":"web","updated_at":"2024-12-21T15:59:19.000000Z","created_at":"2024-12-21T15:59:19.000000Z","id":124}', '2024-12-21 08:59:20', '2024-12-21 08:59:20'),
	(902, 'Role', 1, 'Update', '2024-12-21 08:59:53', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list","productreport-list"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list","productreport-list","profitreport-list"]}', '2024-12-21 08:59:53', '2024-12-21 08:59:53'),
	(903, 'Menu Item', 42, 'Create', '2024-12-21 09:00:58', '1', NULL, '{"name":"Laporan Laba Rugi","icon":"fa fa-file","route":"report.profit_reports","permission_name":"profitreport-list","status":"Aktif","position":"-13","menu_group_id":"11","parent_id":null,"updated_at":"2024-12-21T16:00:58.000000Z","created_at":"2024-12-21T16:00:58.000000Z","id":42}', '2024-12-21 09:00:58', '2024-12-21 09:00:58'),
	(904, 'Purchase', 123, 'Create', '2024-12-22 05:43:10', '1', NULL, '{"image":"","type_payment":"TRANSFER","purchase_date":"2024-12-22","no_purchase":"MST-20241222-000008-PCS","supplier_id":"3","user_id":1,"cash_id":"1","total_cost":"30000","status":"Lunas","description":null,"updated_at":"2024-12-22T12:43:09.000000Z","created_at":"2024-12-22T12:43:09.000000Z","id":123}', '2024-12-22 05:43:10', '2024-12-22 05:43:10'),
	(905, 'Order', 55, 'Create', '2024-12-22 05:47:00', '1', NULL, '{"image":"","type_payment":"TRANSFER","order_date":"2024-12-22","no_order":"MST-20241222-000016-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"125000","status":"Pesanan Penjualan","total_cost_before":"125000","percent_discount":"0","amount_discount":"0","input_payment":"125000","return_payment":null,"description":"Percobaan PEnjualan","updated_at":"2024-12-22T12:46:59.000000Z","created_at":"2024-12-22T12:46:59.000000Z","id":55}', '2024-12-22 05:47:00', '2024-12-22 05:47:00'),
	(906, 'Order', 55, 'Update', '2024-12-22 05:47:36', '1', '{"id":55,"order_date":"2024-12-22","no_order":"MST-20241222-000016-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":125000,"percent_discount":0,"amount_discount":0,"input_payment":125000,"return_payment":null,"total_cost":125000,"status":"Pesanan Penjualan","image":"","description":"Percobaan PEnjualan","type_payment":"TRANSFER","created_at":"2024-12-22T12:46:59.000000Z","updated_at":"2024-12-22T12:46:59.000000Z"}', '{"id":55,"order_date":"2024-12-22","no_order":"MST-20241222-000016-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":125000,"percent_discount":0,"amount_discount":0,"input_payment":125000,"return_payment":null,"total_cost":125000,"status":"Lunas","image":"","description":"Percobaan PEnjualan","type_payment":"TRANSFER","created_at":"2024-12-22T12:46:59.000000Z","updated_at":"2024-12-22T12:47:36.000000Z"}', '2024-12-22 05:47:36', '2024-12-22 05:47:36'),
	(907, 'Order', 56, 'Create', '2024-12-22 05:48:22', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-22","no_order":"MST-20241222-000017-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"156500","status":"Lunas","total_cost_before":"156500","percent_discount":"0","amount_discount":"0","input_payment":"156500","return_payment":null,"description":"Penjualan Baru","updated_at":"2024-12-22T12:48:20.000000Z","created_at":"2024-12-22T12:48:20.000000Z","id":56}', '2024-12-22 05:48:22', '2024-12-22 05:48:22'),
	(908, 'Order', 50, 'Update', '2024-12-22 08:42:30', '1', '{"id":50,"order_date":"2024-12-19","no_order":"MST-20241219-000011-ORD","customer_id":2,"user_id":1,"cash_id":1,"total_cost_before":54500,"percent_discount":0,"amount_discount":0,"input_payment":54500,"return_payment":null,"total_cost":54500,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:07:50.000000Z","updated_at":"2024-12-19T16:07:50.000000Z"}', '{"id":50,"order_date":"2024-12-19","no_order":"MST-20241219-000011-ORD","customer_id":2,"user_id":1,"cash_id":1,"total_cost_before":54500,"percent_discount":0,"amount_discount":0,"input_payment":54500,"return_payment":null,"total_cost":54500,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:07:50.000000Z","updated_at":"2024-12-19T16:07:50.000000Z"}', '2024-12-22 08:42:30', '2024-12-22 08:42:30'),
	(909, 'Order', 50, 'Update', '2024-12-22 08:42:50', '1', '{"id":50,"order_date":"2024-12-19","no_order":"MST-20241219-000011-ORD","customer_id":2,"user_id":1,"cash_id":1,"total_cost_before":54500,"percent_discount":0,"amount_discount":0,"input_payment":54500,"return_payment":null,"total_cost":54500,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:07:50.000000Z","updated_at":"2024-12-19T16:07:50.000000Z"}', '{"id":50,"order_date":"2024-12-19","no_order":"MST-20241219-000011-ORD","customer_id":2,"user_id":1,"cash_id":1,"total_cost_before":54500,"percent_discount":0,"amount_discount":0,"input_payment":54500,"return_payment":null,"total_cost":54500,"status":"Lunas","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:07:50.000000Z","updated_at":"2024-12-22T15:42:50.000000Z"}', '2024-12-22 08:42:50', '2024-12-22 08:42:50'),
	(910, 'Purchase', 124, 'Create', '2024-12-22 08:45:23', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2024-12-22","no_purchase":"MST-20241222-000009-PCS","supplier_id":"2","user_id":1,"cash_id":"1","total_cost":"24000","status":"Pesanan Pembelian","description":null,"updated_at":"2024-12-22T15:45:23.000000Z","created_at":"2024-12-22T15:45:23.000000Z","id":124}', '2024-12-22 08:45:23', '2024-12-22 08:45:23'),
	(911, 'Purchase', 124, 'Update', '2024-12-22 08:45:45', '1', '{"id":124,"purchase_date":"2024-12-22","no_purchase":"MST-20241222-000009-PCS","user_id":1,"supplier_id":2,"cash_id":1,"total_cost":24000,"status":"Pesanan Pembelian","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-22T15:45:23.000000Z","updated_at":"2024-12-22T15:45:23.000000Z"}', '{"id":124,"purchase_date":"2024-12-22","no_purchase":"MST-20241222-000009-PCS","user_id":1,"supplier_id":2,"cash_id":1,"total_cost":24000,"status":"Lunas","image":"","description":null,"type_payment":"CASH","created_at":"2024-12-22T15:45:23.000000Z","updated_at":"2024-12-22T15:45:45.000000Z"}', '2024-12-22 08:45:45', '2024-12-22 08:45:45'),
	(912, 'Transaksi', 14, 'Create', '2024-12-22 09:20:00', '1', NULL, '{"date":"2024-12-22","transaction_category_id":"1","cash_id":"2","name":"Gaji Karyawan","description":"Gahi Karyawan Baru","amount":2000000,"image":"20241222161959_ilhad-Sampul.webp","updated_at":"2024-12-22T16:20:00.000000Z","created_at":"2024-12-22T16:20:00.000000Z","id":14}', '2024-12-22 09:20:00', '2024-12-22 09:20:00'),
	(913, 'Transaksi', 14, 'Delete', '2024-12-22 09:35:42', '1', '{"id":14,"date":"2024-12-22","transaction_category_id":1,"cash_id":2,"name":"Gaji Karyawan","amount":2000000,"description":"Gahi Karyawan Baru","image":"20241222161959_ilhad-Sampul.webp","created_at":"2024-12-22T16:20:00.000000Z","updated_at":"2024-12-22T16:20:00.000000Z"}', NULL, '2024-12-22 09:35:42', '2024-12-22 09:35:42'),
	(914, 'Profil', 1, 'Update', '2024-12-22 16:41:00', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-09T16:56:06.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:00', '2024-12-22 16:41:00'),
	(915, 'Profil', 1, 'Update', '2024-12-22 16:41:05', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-09T16:56:06.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:05', '2024-12-22 16:41:05'),
	(916, 'Profil', 1, 'Update', '2024-12-22 16:41:10', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-09T16:56:06.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:10', '2024-12-22 16:41:10'),
	(917, 'Profil', 1, 'Update', '2024-12-22 16:41:10', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-09T16:56:06.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:10', '2024-12-22 16:41:10'),
	(918, 'Profil', 1, 'Update', '2024-12-22 16:41:10', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-09T16:56:06.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:10', '2024-12-22 16:41:10'),
	(919, 'Profil', 1, 'Update', '2024-12-22 16:41:37', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-09T16:56:06.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:37', '2024-12-22 16:41:37'),
	(920, 'Profil', 1, 'Update', '2024-12-22 16:41:55', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:41:37.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:41:55', '2024-12-22 16:41:55'),
	(921, 'Profil', 1, 'Update', '2024-12-22 16:44:12', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:41:56.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:44:12', '2024-12-22 16:44:12'),
	(922, 'Profil', 1, 'Update', '2024-12-22 16:44:37', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Green_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:41:56.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Orange_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:44:37', '2024-12-22 16:44:37'),
	(923, 'Profil', 1, 'Update', '2024-12-22 16:44:53', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Orange_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:44:37.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Orange_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:44:53', '2024-12-22 16:44:53'),
	(924, 'Profil', 1, 'Update', '2024-12-22 16:45:55', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Orange_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:44:53.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Orange_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:45:55', '2024-12-22 16:45:55'),
	(925, 'Order', 49, 'Update', '2024-12-22 16:47:22', '1', '{"id":49,"order_date":"2024-12-19","no_order":"MST-20241219-000010-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":53000,"percent_discount":0,"amount_discount":3,"input_payment":50000,"return_payment":null,"total_cost":50000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:04:52.000000Z","updated_at":"2024-12-19T16:04:52.000000Z"}', '{"id":49,"order_date":"2024-12-19","no_order":"MST-20241219-000010-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":50000,"percent_discount":0,"amount_discount":3,"input_payment":50000,"return_payment":null,"total_cost":50000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:04:52.000000Z","updated_at":"2024-12-22T23:47:22.000000Z"}', '2024-12-22 16:47:22', '2024-12-22 16:47:22'),
	(926, 'Profil', 1, 'Update', '2024-12-22 16:47:34', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Orange_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:44:53.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Cyan_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:47:34', '2024-12-22 16:47:34'),
	(927, 'Profil', 1, 'Update', '2024-12-22 16:47:51', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Cyan_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:47:34.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:47:51', '2024-12-22 16:47:51'),
	(928, 'Profil', 1, 'Update', '2024-12-22 16:51:25', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:47:51.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:51:25', '2024-12-22 16:51:25'),
	(929, 'Profil', 1, 'Update', '2024-12-22 16:51:49', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:51:25.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:51:49', '2024-12-22 16:51:49'),
	(930, 'Profil', 1, 'Update', '2024-12-22 16:52:12', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:51:50.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:52:12', '2024-12-22 16:52:12'),
	(931, 'Profil', 1, 'Update', '2024-12-22 16:52:29', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"true","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:52:12.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:52:29', '2024-12-22 16:52:29'),
	(932, 'Profil', 1, 'Update', '2024-12-22 16:54:33', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:52:29.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:54:33', '2024-12-22 16:54:33'),
	(933, 'Profil', 1, 'Update', '2024-12-22 16:55:09', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:52:29.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 16:55:09', '2024-12-22 16:55:09'),
	(934, 'Supplier', 1, 'Update', '2024-12-22 16:59:31', '1', '{"id":1,"name":"Supplier Umum","email":"supplierumum@gmail.com","phone":"085320555394","address":"Perumahan CGM Sukarindik Kecamatan Bungursari. Blok C31. RT\\/RW 02\\/11. Kota Tasikmalaya\\r\\nJl. Tajur Indah","created_at":"2024-11-24T04:34:09.000000Z","updated_at":"2024-11-28T15:24:22.000000Z"}', '{"id":1,"name":"Supplier Umum","email":"supplierumum@gmail.com","phone":"085320555394","address":"Perumahan CGM Sukarindik Kecamatan Bungursari. Blok C31. RT\\/RW 02\\/11. Kota Tasikmalaya\\r\\nJl. Tajur Indah","created_at":"2024-11-24T04:34:09.000000Z","updated_at":"2024-11-28T15:24:22.000000Z"}', '2024-12-22 16:59:31', '2024-12-22 16:59:31'),
	(935, 'Profil', 1, 'Update', '2024-12-22 17:00:03', '1', '{"id":1,"nama_profil":"eL-POS","alias":"MST","no_id":null,"alamat":"Jl. Tajur Indah No 121 Indihiang","no_telp":"085320555394","no_wa":"085320555394","email":"elpos@gmail.com","instagram":null,"facebook":null,"youtube":null,"website":null,"deskripsi_1":null,"deskripsi_2":null,"deskripsi_3":null,"logo":"20241203013833_ELECTRO_MUSIC.webp","logo_dark":"20241209063302_ELECTRO_MUSIC2.webp","favicon":"20241130110136_Desain_tanpa_judul.webp","banner":"20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp","bg_login":"20241209063838_login-bg.webp","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false","direction":"ltr","embed_youtube":null,"embed_map":null,"created_at":"2024-11-11T12:51:01.000000Z","updated_at":"2024-12-22T23:52:29.000000Z"}', '{"_token":"LQpinIdYTugQYuQ8s3VSrE1gOctjlgNjece0iq35","_method":"PUT","theme":"light","theme_color":"Aqua_Theme","boxed_layout":"false","sidebar_type":"full","card_border":"false"}', '2024-12-22 17:00:03', '2024-12-22 17:00:03'),
	(936, 'Transaksi', 15, 'Create', '2024-12-23 05:00:41', '1', NULL, '{"date":"2024-12-23","transaction_category_id":"1","cash_id":"1","name":"Proposal Karang Taruna","description":"Proposal Karang Taruna Kemerdekaan","amount":230000,"image":"20241223120040_Thumbnail_YouTube__(5).webp","updated_at":"2024-12-23T12:00:41.000000Z","created_at":"2024-12-23T12:00:41.000000Z","id":15}', '2024-12-23 05:00:41', '2024-12-23 05:00:41'),
	(937, 'Purchase', 125, 'Create', '2024-12-23 05:02:51', '1', NULL, '{"image":"20241223120250_Thumbnail_YouTube_.webp","type_payment":"CASH","purchase_date":"2024-12-23","no_purchase":"MST-20241223-000010-PCS","supplier_id":"3","user_id":1,"cash_id":"1","total_cost":"70000","status":"Lunas","description":"20 Produk","updated_at":"2024-12-23T12:02:50.000000Z","created_at":"2024-12-23T12:02:50.000000Z","id":125}', '2024-12-23 05:02:51', '2024-12-23 05:02:51'),
	(938, 'Order', 49, 'Update', '2024-12-23 05:04:15', '1', '{"id":49,"order_date":"2024-12-19","no_order":"MST-20241219-000010-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":50000,"percent_discount":0,"amount_discount":3,"input_payment":50000,"return_payment":null,"total_cost":50000,"status":"Pesanan Penjualan","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:04:52.000000Z","updated_at":"2024-12-22T23:47:22.000000Z"}', '{"id":49,"order_date":"2024-12-19","no_order":"MST-20241219-000010-ORD","customer_id":1,"user_id":1,"cash_id":1,"total_cost_before":50000,"percent_discount":0,"amount_discount":3,"input_payment":64,"return_payment":3,"total_cost":63997,"status":"Lunas","image":"","description":null,"type_payment":"TRANSFER","created_at":"2024-12-19T16:04:52.000000Z","updated_at":"2024-12-23T12:04:15.000000Z"}', '2024-12-23 05:04:15', '2024-12-23 05:04:15'),
	(939, 'Order', 57, 'Create', '2024-12-23 05:04:48', '1', NULL, '{"image":"","type_payment":"CASH","order_date":"2024-12-23","no_order":"MST-20241223-000018-ORD","customer_id":"1","user_id":1,"cash_id":"1","total_cost":"74000","status":"Lunas","total_cost_before":"74000","percent_discount":"0","amount_discount":"0","input_payment":"74000","return_payment":null,"description":null,"updated_at":"2024-12-23T12:04:47.000000Z","created_at":"2024-12-23T12:04:47.000000Z","id":57}', '2024-12-23 05:04:48', '2024-12-23 05:04:48'),
	(940, 'Purchase', 126, 'Create', '2024-12-23 16:25:20', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2025-01-23","no_purchase":"MST-20241223-000011-PCS","supplier_id":"1","user_id":1,"cash_id":"1","total_cost":"99000","status":"Lunas","description":null,"updated_at":"2024-12-23T23:25:18.000000Z","created_at":"2024-12-23T23:25:18.000000Z","id":126}', '2024-12-23 16:25:20', '2024-12-23 16:25:20'),
	(941, 'Purchase', 127, 'Create', '2024-12-23 16:27:28', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2024-11-07","no_purchase":"MST-20241223-000012-PCS","supplier_id":"2","user_id":1,"cash_id":"1","total_cost":"32200","status":"Lunas","description":null,"updated_at":"2024-12-23T23:27:28.000000Z","created_at":"2024-12-23T23:27:28.000000Z","id":127}', '2024-12-23 16:27:28', '2024-12-23 16:27:28'),
	(942, 'Transaksi', 16, 'Create', '2024-12-24 16:47:41', '1', NULL, '{"date":"2024-12-24","transaction_category_id":"1","cash_id":"2","name":"Koperasi Satu","description":null,"amount":340000,"updated_at":"2024-12-24T23:47:41.000000Z","created_at":"2024-12-24T23:47:41.000000Z","id":16}', '2024-12-24 16:47:41', '2024-12-24 16:47:41'),
	(943, 'Purchase', 128, 'Create', '2024-12-25 05:15:46', '1', NULL, '{"image":"","type_payment":"CASH","purchase_date":"2024-12-25","no_purchase":"MST-20241225-000013-PCS","supplier_id":"3","user_id":1,"cash_id":"2","total_cost":"115800","status":"Lunas","description":null,"updated_at":"2024-12-25T12:15:45.000000Z","created_at":"2024-12-25T12:15:45.000000Z","id":128}', '2024-12-25 05:15:46', '2024-12-25 05:15:46'),
	(944, 'Permission', 125, 'Create', '2024-12-25 06:28:13', '1', NULL, '{"name":"topproductreport-list","urutan":null,"guard_name":"web","updated_at":"2024-12-25T13:28:13.000000Z","created_at":"2024-12-25T13:28:13.000000Z","id":125}', '2024-12-25 06:28:13', '2024-12-25 06:28:13'),
	(945, 'Role', 1, 'Update', '2024-12-25 06:28:37', '1', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list","productreport-list","profitreport-list"]}', '{"name":"Admin","permissions":["user-list","user-create","user-edit","user-delete","permission-list","permission-create","permission-edit","permission-delete","role-list","role-create","role-edit","role-delete","profil-list","general-list","dashboard-list","pengaturan-list","menugroup-list","menugroup-create","menugroup-edit","menugroup-delete","master-list","blog-list","menuitem-list","menuitem-create","menuitem-edit","menuitem-delete","profil-edit","create-resource","loghistori-list","loghistori-deleteall","advance-list","route-list","route-create","menu-list","permissionrole-list","unit-list","unit-create","unit-edit","unit-delete","category-list","category-create","category-edit","category-delete","product-list","product-create","product-edit","product-delete","supplier-list","supplier-create","supplier-edit","supplier-delete","purchase-list","purchase-create","purchase-edit","purchase-delete","cash-list","cash-edit","cash-create","cash-delete","transact-list","order-list","order-create","order-edit","order-delete","customer-list","customer-create","customer-edit","customer-delete","transactioncategory-list","transactioncategory-create","transactioncategory-edit","transactioncategory-delete","transaction-list","transaction-create","transaction-edit","transaction-delete","stockopname-list","stockopname-create","stockopname-edit","stockopname-delete","adjustment-list","adjustment-create","adjustment-edit","adjustment-delete","report-list","purchasereport-list","orderreport-list","productreport-list","profitreport-list","topproductreport-list"]}', '2024-12-25 06:28:37', '2024-12-25 06:28:37'),
	(946, 'Menu Item', 43, 'Create', '2024-12-25 06:34:03', '1', NULL, '{"name":"Laporan Produk Terlaris","icon":"fa fa-file","route":"report.top_product_reports","permission_name":"topproductreport-list","status":"Aktif","position":"5","menu_group_id":"11","parent_id":null,"updated_at":"2024-12-25T13:34:02.000000Z","created_at":"2024-12-25T13:34:02.000000Z","id":43}', '2024-12-25 06:34:03', '2024-12-25 06:34:03');

-- Dumping structure for table db_master_pos.menu_groups
CREATE TABLE IF NOT EXISTS `menu_groups` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.menu_groups: ~4 rows (approximately)
INSERT INTO `menu_groups` (`id`, `name`, `status`, `permission_name`, `position`, `created_at`, `updated_at`) VALUES
	(2, 'General', 'Aktif', 'general-list', 1, '2024-11-11 00:20:07', '2024-11-11 10:50:30'),
	(3, 'Setting', 'Aktif', 'pengaturan-list', 6, '2024-11-11 00:20:07', '2024-12-15 16:49:33'),
	(5, 'Master', 'Aktif', 'master-list', 2, '2024-11-11 02:56:39', '2024-11-25 02:07:19'),
	(6, 'Advance', 'Aktif', 'advance-list', 5, '2024-11-12 03:25:33', '2024-12-15 16:49:33'),
	(10, 'Transaksi', 'Aktif', 'transaction-list', 3, '2024-11-25 02:04:51', '2024-11-25 02:07:19'),
	(11, 'Laporan', 'Aktif', 'report-list', 4, '2024-12-15 16:49:21', '2024-12-15 20:22:07');

-- Dumping structure for table db_master_pos.menu_items
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_group_id` bigint unsigned NOT NULL,
  `position` int NOT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_group_id_foreign` (`menu_group_id`),
  KEY `menu_items_parent_id_foreign` (`parent_id`),
  CONSTRAINT `menu_items_menu_group_id_foreign` FOREIGN KEY (`menu_group_id`) REFERENCES `menu_groups` (`id`),
  CONSTRAINT `menu_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `menu_items` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.menu_items: ~19 rows (approximately)
INSERT INTO `menu_items` (`id`, `name`, `icon`, `route`, `status`, `permission_name`, `menu_group_id`, `position`, `parent_id`, `created_at`, `updated_at`) VALUES
	(2, 'Dashboard', 'ti ti-layout-dashboard', 'home', 'Aktif', 'dashboard-list', 2, 1, NULL, '2024-11-11 00:20:07', '2024-12-10 23:26:59'),
	(3, 'User', 'fa fa-address-book', 'users.index', 'Aktif', 'user-list', 6, 29, NULL, '2024-11-11 00:20:07', '2024-12-25 06:34:17'),
	(4, 'Role', 'ti ti-layout-grid', 'roles.index', 'Aktif', 'role-list', 3, 2, 20, '2024-11-11 00:20:07', '2024-11-15 04:50:24'),
	(5, 'Permission', 'ti ti-menu', 'permissions.index', 'Aktif', 'permission-list', 3, 1, 20, '2024-11-11 00:20:07', '2024-11-15 04:50:24'),
	(6, 'Menu Group', 'ti ti-package', 'menu_groups.index', 'Aktif', 'menugroup-list', 3, 7, 19, '2024-11-11 07:48:06', '2024-11-13 01:41:20'),
	(8, 'Menu Item', 'ti ti-layout', 'menu_items.index', 'Aktif', 'menuitem-list', 3, 8, 19, '2024-11-11 10:17:52', '2024-11-13 01:41:47'),
	(13, 'Profil', 'fa fa-university', 'profil.index', 'Aktif', 'profil-list', 6, 26, NULL, '2024-11-11 09:11:45', '2024-12-25 06:34:16'),
	(14, 'Modul', 'fa fa-book', 'resource.create', 'Aktif', 'create-resource', 3, 18, NULL, '2024-11-11 11:34:58', '2024-12-25 06:34:16'),
	(15, 'Log Histori', 'fa fa-history', 'log_histori.index', 'Aktif', 'loghistori-list', 6, 30, NULL, '2024-11-12 02:35:41', '2024-12-25 06:34:17'),
	(18, 'Generate Route', 'fa fa-truck', 'routes.index', 'Aktif', 'route-list', 3, 19, NULL, '2024-11-13 00:49:17', '2024-12-25 06:34:16'),
	(19, 'Menu', 'fa fa-bullseye', 'menu_items.index', 'Aktif', 'menu-list', 3, 16, NULL, '2024-11-13 01:40:48', '2024-12-25 06:34:15'),
	(20, 'Permission & Role', 'fa fa-server', 'permissions.index', 'Aktif', 'permissionrole-list', 3, 17, NULL, '2024-11-13 01:46:20', '2024-12-25 06:34:16'),
	(23, 'Produk', 'fa fa-cubes', 'products.index', 'Aktif', 'product-list', 5, 24, NULL, '2024-11-16 21:12:57', '2024-12-25 06:34:16'),
	(27, 'Satuan', 'ti ti-tag', 'units.index', 'Aktif', 'unit-list', 5, 3, 23, '2024-11-22 22:55:52', '2024-11-25 01:58:52'),
	(28, 'Kategori Produk', 'ti ti-files', 'categories.index', 'Aktif', 'category-list', 5, 5, 23, '2024-11-22 23:46:27', '2024-11-25 01:58:36'),
	(29, 'Supplier', 'fa fa-user-circle', 'suppliers.index', 'Aktif', 'supplier-list', 5, 20, NULL, '2024-11-23 21:11:56', '2024-12-25 06:34:16'),
	(30, 'Pembelian', 'fas fa-shopping-cart', 'purchases.index', 'Aktif', 'purchase-list', 10, 25, NULL, '2024-11-23 23:06:05', '2024-12-25 06:34:16'),
	(31, 'Kas', 'fa fa-gift', 'cash.index', 'Aktif', 'cash-list', 6, 27, NULL, '2024-11-25 01:35:22', '2024-12-25 06:34:16'),
	(32, 'Data Produk', 'ti ti-brand-blogger', 'products.index', 'Aktif', 'product-list', 5, 7, 23, '2024-11-25 01:57:59', '2024-11-25 01:59:07'),
	(33, 'Penjualan', 'fas fa-cart-plus', 'orders.index', 'Aktif', 'order-list', 10, 28, NULL, '2024-11-26 22:46:26', '2024-12-25 06:34:17'),
	(34, 'Pelanggan', 'fa fa-user', 'customers.index', 'Aktif', 'customer-list', 5, 21, NULL, '2024-12-02 08:09:24', '2024-12-25 06:34:16'),
	(35, 'Kategori Transaksi', 'fa fa-adjust', 'transaction_categories.index', 'Aktif', 'transactioncategory-list', 10, 22, NULL, '2024-12-02 21:02:32', '2024-12-25 06:34:16'),
	(36, 'Transaksi', 'fas fa-database', 'transactions.index', 'Aktif', 'transaction-list', 10, 23, NULL, '2024-12-03 01:01:37', '2024-12-25 06:34:16'),
	(37, 'Stock Opname', 'fa fa-podcast', 'stock_opname.index', 'Aktif', 'stockopname-list', 10, 14, NULL, '2024-12-10 09:14:13', '2024-12-25 06:34:15'),
	(38, 'Adjustment', 'fa fa-battery-full', 'adjustments.index', 'Aktif', 'adjustment-list', 10, 15, NULL, '2024-12-12 03:42:04', '2024-12-25 06:34:15'),
	(39, 'Laporan Pembelian', 'fa fa-file', 'report.purchase_reports', 'Aktif', 'purchasereport-list', 11, 9, NULL, '2024-12-15 17:44:06', '2024-12-21 09:01:35'),
	(40, 'Laporan Penjualan', 'fa fa-file', 'report.order_reports', 'Aktif', 'orderreport-list', 11, 10, NULL, '2024-12-15 23:46:41', '2024-12-21 09:01:27'),
	(41, 'Laporan Produk', 'fa fa-file', 'report.product_reports', 'Aktif', 'productreport-list', 11, 11, NULL, '2024-12-17 09:28:05', '2024-12-21 09:01:35'),
	(42, 'Laporan Laba Rugi', 'fa fa-file', 'report.profit_reports', 'Aktif', 'profitreport-list', 11, 13, NULL, '2024-12-21 09:00:58', '2024-12-25 06:34:15'),
	(43, 'Laporan Produk Terlaris', 'fa fa-file', 'report.top_product_reports', 'Aktif', 'topproductreport-list', 11, 12, NULL, '2024-12-25 06:34:02', '2024-12-25 06:34:15');

-- Dumping structure for table db_master_pos.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.migrations: ~2 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(183, '2024_12_12_082259_create_adjusments_table', 1),
	(184, '2024_12_12_090236_create_adjustment_details_table', 2),
	(187, '2024_12_21_163651_create_profit_loss_table', 3);

-- Dumping structure for table db_master_pos.model_has_permissions
CREATE TABLE IF NOT EXISTS `model_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.model_has_permissions: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.model_has_roles
CREATE TABLE IF NOT EXISTS `model_has_roles` (
  `role_id` bigint unsigned NOT NULL,
  `model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.model_has_roles: ~1 rows (approximately)
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
	(1, 'App\\Models\\User', 1),
	(2, 'App\\Models\\User', 9);

-- Dumping structure for table db_master_pos.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_date` date NOT NULL,
  `no_order` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `cash_id` bigint unsigned DEFAULT NULL,
  `total_cost_before` bigint NOT NULL DEFAULT '0',
  `percent_discount` bigint NOT NULL DEFAULT '0',
  `amount_discount` bigint NOT NULL DEFAULT '0',
  `input_payment` bigint NOT NULL DEFAULT '0',
  `return_payment` bigint DEFAULT NULL,
  `total_cost` bigint NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type_payment` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `cash_id` (`cash_id`),
  CONSTRAINT `cash` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`) ON DELETE CASCADE,
  CONSTRAINT `customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.orders: ~18 rows (approximately)
INSERT INTO `orders` (`id`, `order_date`, `no_order`, `customer_id`, `user_id`, `cash_id`, `total_cost_before`, `percent_discount`, `amount_discount`, `input_payment`, `return_payment`, `total_cost`, `status`, `image`, `description`, `type_payment`, `created_at`, `updated_at`) VALUES
	(40, '2024-12-15', 'MST-20241215-000001-ORD', 1, 1, 1, 49000, 0, 0, 50, 1, 49000, 'Lunas', '20241215114430_ELECTRO_MUSIC.webp', 'Penjualan Pertama', 'CASH', '2024-12-15 04:44:30', '2024-12-15 04:44:30'),
	(41, '2024-12-15', 'MST-20241215-000002-ORD', 1, 1, 1, 268000, 0, 0, 268000, NULL, 268000, 'Lunas', '', NULL, 'CASH', '2024-12-15 04:46:06', '2024-12-15 04:46:40'),
	(42, '2024-12-15', 'MST-20241215-000003-ORD', 1, 1, 1, 103000, 0, 0, 103000, NULL, 103000, 'Lunas', '', NULL, 'CASH', '2024-12-15 16:42:36', '2024-12-15 16:44:05'),
	(43, '2024-12-17', 'MST-20241217-000004-ORD', 1, 1, 1, 28000, 0, 0, 28000, NULL, 28000, 'Lunas', '', NULL, 'CASH', '2024-12-17 05:15:20', '2024-12-17 13:04:54'),
	(44, '2024-12-17', 'MST-20241217-000005-ORD', 2, 1, 1, 118500, 0, 0, 118500, NULL, 118500, 'Lunas', '', NULL, 'CASH', '2024-12-17 12:53:03', '2024-12-17 13:04:39'),
	(45, '2024-12-18', 'MST-20241218-000006-ORD', 1, 1, 1, 161000, 0, 0, 161, 0, 161000, 'Lunas', '', NULL, 'CASH', '2024-12-18 02:43:59', '2024-12-18 02:43:59'),
	(46, '2024-12-18', 'MST-20241218-000007-ORD', 3, 1, 2, 154000, 0, 0, 154000, NULL, 154000, 'Lunas', '', NULL, 'TRANSFER', '2024-12-18 03:42:59', '2024-12-18 03:42:59'),
	(47, '2024-12-18', 'MST-20241218-000008-ORD', 1, 1, 1, 183000, 0, 0, 183000, NULL, 183000, 'Lunas', '', NULL, 'TRANSFER', '2024-12-18 10:30:43', '2024-12-18 10:36:21'),
	(48, '2024-12-19', 'MST-20241219-000009-ORD', 3, 1, 1, 153500, 0, 0, 153500, NULL, 153500, 'Lunas', '', NULL, 'TRANSFER', '2024-12-19 07:49:19', '2024-12-19 07:51:04'),
	(49, '2024-12-19', 'MST-20241219-000010-ORD', 1, 1, 1, 50000, 0, 3, 64, 3, 63997, 'Lunas', '', NULL, 'TRANSFER', '2024-12-19 09:04:52', '2024-12-23 05:04:15'),
	(50, '2024-12-19', 'MST-20241219-000011-ORD', 2, 1, 1, 54500, 0, 0, 54500, NULL, 54500, 'Lunas', '', NULL, 'TRANSFER', '2024-12-19 09:07:50', '2024-12-22 08:42:50'),
	(51, '2024-12-19', 'MST-20241219-000012-ORD', 1, 1, 1, 97000, 0, 0, 97000, NULL, 97000, 'Lunas', '20241219161035_Thumbnail_YouTube__(1).webp', NULL, 'TRANSFER', '2024-12-19 09:10:35', '2024-12-21 02:55:58'),
	(52, '2024-12-19', 'MST-20241219-000013-ORD', 2, 1, 1, 60000, 1, 0, 59400, NULL, 59400, 'Lunas', '', NULL, 'TRANSFER', '2024-12-19 09:11:43', '2024-12-19 09:11:43'),
	(53, '2024-12-19', 'MST-20241219-000014-ORD', 1, 1, 1, 35000, 0, 0, 35000, NULL, 35000, 'Lunas', '', NULL, 'CASH', '2024-12-19 09:13:13', '2024-12-21 02:55:43'),
	(54, '2024-12-21', 'MST-20241221-000015-ORD', 1, 1, 1, 42000, 0, 0, 42000, NULL, 42000, 'Lunas', '', NULL, 'CASH', '2024-12-21 02:59:21', '2024-12-21 02:59:21'),
	(55, '2024-12-22', 'MST-20241222-000016-ORD', 1, 1, 1, 125000, 0, 0, 125000, NULL, 125000, 'Lunas', '', 'Percobaan PEnjualan', 'TRANSFER', '2024-12-22 05:46:59', '2024-12-22 05:47:36'),
	(56, '2024-12-22', 'MST-20241222-000017-ORD', 1, 1, 1, 156500, 0, 0, 156500, NULL, 156500, 'Lunas', '', 'Penjualan Baru', 'CASH', '2024-12-22 05:48:20', '2024-12-22 05:48:20'),
	(57, '2024-12-23', 'MST-20241223-000018-ORD', 1, 1, 1, 74000, 0, 0, 74000, NULL, 74000, 'Lunas', '', NULL, 'CASH', '2024-12-23 05:04:47', '2024-12-23 05:04:47');

-- Dumping structure for table db_master_pos.order_items
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `order_price` bigint NOT NULL DEFAULT '0',
  `total_price` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_product_id_foreign` (`product_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.order_items: ~54 rows (approximately)
INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `order_price`, `total_price`, `created_at`, `updated_at`) VALUES
	(56, 40, 9, 5, 5000, 25000, '2024-12-15 04:44:30', '2024-12-15 04:44:30'),
	(57, 40, 10, 4, 6000, 24000, '2024-12-15 04:44:30', '2024-12-15 04:44:30'),
	(58, 41, 15, 6, 38000, 228000, '2024-12-15 04:46:07', '2024-12-15 04:46:07'),
	(59, 41, 16, 10, 4000, 40000, '2024-12-15 04:46:07', '2024-12-15 04:46:07'),
	(60, 42, 9, 11, 5000, 55000, '2024-12-15 16:42:36', '2024-12-15 16:42:36'),
	(61, 42, 10, 8, 6000, 48000, '2024-12-15 16:42:36', '2024-12-15 16:42:36'),
	(62, 43, 18, 8, 3500, 28000, '2024-12-17 05:15:21', '2024-12-17 05:15:21'),
	(63, 44, 9, 1, 5000, 5000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(64, 44, 10, 1, 6000, 6000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(65, 44, 12, 1, 35000, 35000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(66, 44, 13, 1, 7000, 7000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(67, 44, 14, 1, 17000, 17000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(68, 44, 15, 1, 38000, 38000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(69, 44, 16, 1, 4000, 4000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(70, 44, 17, 1, 3000, 3000, '2024-12-17 12:53:03', '2024-12-17 12:53:03'),
	(71, 44, 18, 1, 3500, 3500, '2024-12-17 12:53:04', '2024-12-17 12:53:04'),
	(72, 45, 12, 4, 35000, 140000, '2024-12-18 02:43:59', '2024-12-18 02:43:59'),
	(73, 45, 13, 3, 7000, 21000, '2024-12-18 02:43:59', '2024-12-18 02:43:59'),
	(74, 46, 15, 3, 38000, 114000, '2024-12-18 03:42:59', '2024-12-18 03:42:59'),
	(75, 46, 16, 10, 4000, 40000, '2024-12-18 03:42:59', '2024-12-18 03:42:59'),
	(76, 47, 12, 4, 35000, 140000, '2024-12-18 10:30:43', '2024-12-18 10:30:43'),
	(77, 47, 9, 5, 5000, 25000, '2024-12-18 10:30:43', '2024-12-18 10:30:43'),
	(78, 47, 10, 3, 6000, 18000, '2024-12-18 10:30:43', '2024-12-18 10:30:43'),
	(79, 48, 15, 3, 38000, 114000, '2024-12-19 07:49:20', '2024-12-19 07:49:20'),
	(80, 48, 16, 4, 4000, 16000, '2024-12-19 07:49:20', '2024-12-19 07:49:20'),
	(81, 48, 17, 1, 3000, 3000, '2024-12-19 07:49:20', '2024-12-19 07:49:20'),
	(82, 48, 18, 1, 3500, 3500, '2024-12-19 07:49:20', '2024-12-19 07:49:20'),
	(83, 48, 14, 1, 17000, 17000, '2024-12-19 07:49:20', '2024-12-19 07:49:20'),
	(84, 49, 12, 1, 35000, 35000, '2024-12-19 09:04:52', '2024-12-19 09:04:52'),
	(85, 49, 13, 1, 7000, 7000, '2024-12-19 09:04:52', '2024-12-19 09:04:52'),
	(86, 49, 10, 2, 6000, 12000, '2024-12-19 09:04:52', '2024-12-23 05:04:15'),
	(87, 49, 9, 2, 5000, 10000, '2024-12-19 09:04:52', '2024-12-23 05:04:15'),
	(88, 50, 18, 1, 3500, 3500, '2024-12-19 09:07:51', '2024-12-19 09:07:51'),
	(89, 50, 17, 1, 3000, 3000, '2024-12-19 09:07:51', '2024-12-19 09:07:51'),
	(90, 50, 16, 1, 4000, 4000, '2024-12-19 09:07:51', '2024-12-19 09:07:51'),
	(91, 50, 15, 1, 38000, 38000, '2024-12-19 09:07:51', '2024-12-19 09:07:51'),
	(92, 50, 10, 1, 6000, 6000, '2024-12-19 09:07:51', '2024-12-19 09:07:51'),
	(93, 51, 14, 1, 17000, 17000, '2024-12-19 09:10:35', '2024-12-19 09:10:35'),
	(94, 51, 15, 2, 38000, 76000, '2024-12-19 09:10:36', '2024-12-19 09:10:36'),
	(95, 51, 16, 1, 4000, 4000, '2024-12-19 09:10:36', '2024-12-19 09:10:36'),
	(96, 52, 15, 1, 38000, 38000, '2024-12-19 09:11:43', '2024-12-19 09:11:43'),
	(97, 52, 14, 1, 15000, 15000, '2024-12-19 09:11:43', '2024-12-19 09:11:43'),
	(98, 52, 16, 1, 4000, 4000, '2024-12-19 09:11:43', '2024-12-19 09:11:43'),
	(99, 52, 17, 1, 3000, 3000, '2024-12-19 09:11:43', '2024-12-19 09:11:43'),
	(100, 53, 12, 1, 35000, 35000, '2024-12-19 09:13:14', '2024-12-19 09:13:14'),
	(101, 54, 12, 1, 35000, 35000, '2024-12-21 02:59:21', '2024-12-21 02:59:21'),
	(102, 54, 13, 1, 7000, 7000, '2024-12-21 02:59:21', '2024-12-21 02:59:21'),
	(103, 55, 10, 1, 6000, 6000, '2024-12-22 05:46:59', '2024-12-22 05:46:59'),
	(104, 55, 12, 3, 35000, 105000, '2024-12-22 05:46:59', '2024-12-22 05:46:59'),
	(105, 55, 13, 1, 7000, 7000, '2024-12-22 05:46:59', '2024-12-22 05:46:59'),
	(106, 55, 16, 1, 4000, 4000, '2024-12-22 05:46:59', '2024-12-22 05:46:59'),
	(107, 55, 17, 1, 3000, 3000, '2024-12-22 05:47:00', '2024-12-22 05:47:00'),
	(108, 56, 12, 3, 35000, 105000, '2024-12-22 05:48:20', '2024-12-22 05:48:20'),
	(109, 56, 16, 1, 4000, 4000, '2024-12-22 05:48:20', '2024-12-22 05:48:20'),
	(110, 56, 17, 2, 3000, 6000, '2024-12-22 05:48:20', '2024-12-22 05:48:20'),
	(111, 56, 18, 1, 3500, 3500, '2024-12-22 05:48:20', '2024-12-22 05:48:20'),
	(112, 56, 15, 1, 38000, 38000, '2024-12-22 05:48:21', '2024-12-22 05:48:21'),
	(113, 57, 15, 1, 38000, 38000, '2024-12-23 05:04:48', '2024-12-23 05:04:48'),
	(114, 57, 16, 9, 4000, 36000, '2024-12-23 05:04:48', '2024-12-23 05:04:48');

-- Dumping structure for table db_master_pos.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.permissions
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `urutan` bigint DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.permissions: ~75 rows (approximately)
INSERT INTO `permissions` (`id`, `name`, `guard_name`, `urutan`, `created_at`, `updated_at`) VALUES
	(1, 'user-list', 'web', 21, '2024-11-11 06:38:20', '2024-11-11 06:38:21'),
	(2, 'user-create', 'web', 22, '2024-11-11 06:38:37', '2024-11-11 06:38:38'),
	(3, 'user-edit', 'web', 23, '2024-11-11 06:39:04', '2024-11-11 06:39:05'),
	(4, 'user-delete', 'web', 24, '2024-11-11 06:42:16', '2024-11-11 06:42:17'),
	(5, 'permission-list', 'web', 13, '2024-11-11 06:46:36', '2024-11-11 06:46:37'),
	(6, 'permission-create', 'web', 14, '2024-11-11 06:46:37', '2024-11-11 06:46:38'),
	(7, 'permission-edit', 'web', 15, '2024-11-11 06:46:39', '2024-11-11 06:46:41'),
	(8, 'permission-delete', 'web', 16, '2024-11-11 06:46:42', '2024-11-11 06:46:43'),
	(9, 'role-list', 'web', 17, '2024-11-11 06:47:56', '2024-11-11 06:47:57'),
	(10, 'role-create', 'web', 18, '2024-11-11 06:47:58', '2024-11-11 06:47:59'),
	(11, 'role-edit', 'web', 19, '2024-11-11 06:48:00', '2024-11-11 06:48:00'),
	(12, 'role-delete', 'web', 20, '2024-11-11 06:48:01', '2024-11-11 06:48:02'),
	(13, 'profil-list', 'web', 33, '2024-11-11 06:52:05', '2024-11-11 09:23:24'),
	(14, 'general-list', 'web', 1, '2024-11-11 07:33:23', '2024-11-11 08:38:32'),
	(15, 'dashboard-list', 'web', 2, '2024-11-11 00:34:33', '2024-11-11 08:47:48'),
	(16, 'pengaturan-list', 'web', 12, '2024-11-11 00:40:26', '2024-11-11 08:52:40'),
	(17, 'menugroup-list', 'web', 25, '2024-11-11 00:48:54', '2024-11-11 01:42:31'),
	(18, 'menugroup-create', 'web', 26, '2024-11-11 01:41:58', '2024-11-11 01:42:47'),
	(19, 'menugroup-edit', 'web', 27, '2024-11-11 01:42:07', '2024-11-11 01:42:55'),
	(20, 'menugroup-delete', 'web', 28, '2024-11-11 01:42:15', '2024-11-11 01:43:04'),
	(21, 'master-list', 'web', 3, '2024-11-11 02:33:19', '2024-11-11 02:33:19'),
	(22, 'blog-list', 'web', 4, '2024-11-11 02:57:18', '2024-11-11 02:57:18'),
	(23, 'menuitem-list', 'web', 29, '2024-11-11 03:14:49', '2024-11-11 03:14:49'),
	(24, 'menuitem-create', 'web', 30, '2024-11-11 03:14:59', '2024-11-11 03:14:59'),
	(25, 'menuitem-edit', 'web', 31, '2024-11-11 03:15:08', '2024-11-11 03:15:08'),
	(26, 'menuitem-delete', 'web', 32, '2024-11-11 03:15:16', '2024-11-11 03:15:16'),
	(34, 'profil-edit', 'web', 34, '2024-11-11 09:23:38', '2024-11-11 09:23:38'),
	(35, 'create-resource', 'web', 40, '2024-11-11 11:33:44', '2024-11-11 11:33:44'),
	(37, 'loghistori-list', 'web', 46, '2024-11-12 02:38:37', '2024-11-12 02:38:37'),
	(44, 'loghistori-deleteall', 'web', 46, '2024-11-12 03:18:15', '2024-11-12 03:18:15'),
	(45, 'advance-list', 'web', 45, '2024-11-12 03:24:59', '2024-11-12 03:24:59'),
	(46, 'route-list', 'web', 46, '2024-11-13 00:47:06', '2024-11-13 00:47:06'),
	(47, 'route-create', 'web', 50, '2024-11-13 00:52:45', '2024-11-13 00:58:39'),
	(48, 'menu-list', 'web', 50, '2024-11-13 01:39:04', '2024-11-13 01:39:16'),
	(49, 'permissionrole-list', 'web', 50, '2024-11-13 01:46:42', '2024-11-13 01:46:42'),
	(71, 'unit-list', 'web', NULL, '2024-11-22 22:54:17', '2024-11-22 22:54:17'),
	(72, 'unit-create', 'web', NULL, '2024-11-22 22:54:27', '2024-11-22 22:54:27'),
	(73, 'unit-edit', 'web', NULL, '2024-11-22 22:54:37', '2024-11-22 22:54:37'),
	(74, 'unit-delete', 'web', NULL, '2024-11-22 22:54:45', '2024-11-22 22:54:45'),
	(75, 'category-list', 'web', NULL, '2024-11-22 23:42:08', '2024-11-22 23:42:08'),
	(76, 'category-create', 'web', NULL, '2024-11-22 23:42:35', '2024-11-22 23:42:35'),
	(77, 'category-edit', 'web', NULL, '2024-11-22 23:43:07', '2024-11-22 23:43:07'),
	(78, 'category-delete', 'web', NULL, '2024-11-22 23:43:17', '2024-11-22 23:43:17'),
	(79, 'product-list', 'web', NULL, '2024-11-23 00:55:07', '2024-11-23 00:55:07'),
	(80, 'product-create', 'web', NULL, '2024-11-23 00:55:22', '2024-11-23 00:55:22'),
	(81, 'product-edit', 'web', NULL, '2024-11-23 00:55:33', '2024-11-23 00:55:33'),
	(82, 'product-delete', 'web', NULL, '2024-11-23 00:55:47', '2024-11-23 00:55:47'),
	(83, 'supplier-list', 'web', NULL, '2024-11-23 21:10:37', '2024-11-23 21:10:37'),
	(84, 'supplier-create', 'web', NULL, '2024-11-23 21:10:48', '2024-11-23 21:10:48'),
	(85, 'supplier-edit', 'web', NULL, '2024-11-23 21:10:56', '2024-11-23 21:10:56'),
	(86, 'supplier-delete', 'web', NULL, '2024-11-23 21:11:06', '2024-11-23 21:11:06'),
	(87, 'purchase-list', 'web', NULL, '2024-11-23 23:03:16', '2024-11-23 23:03:16'),
	(88, 'purchase-create', 'web', NULL, '2024-11-23 23:03:28', '2024-11-23 23:03:28'),
	(89, 'purchase-edit', 'web', NULL, '2024-11-23 23:04:04', '2024-11-23 23:04:04'),
	(90, 'purchase-delete', 'web', NULL, '2024-11-23 23:04:17', '2024-11-23 23:04:17'),
	(91, 'cash-list', 'web', NULL, '2024-11-25 01:32:02', '2024-11-25 01:32:02'),
	(92, 'cash-edit', 'web', NULL, '2024-11-25 01:32:13', '2024-11-25 01:32:13'),
	(93, 'cash-create', 'web', NULL, '2024-11-25 01:32:54', '2024-11-25 01:32:54'),
	(94, 'cash-delete', 'web', NULL, '2024-11-25 01:33:05', '2024-11-25 01:33:05'),
	(95, 'transact-list', 'web', 2, '2024-11-25 02:04:24', '2024-12-03 00:59:18'),
	(96, 'order-list', 'web', NULL, '2024-11-26 22:29:38', '2024-11-26 22:29:38'),
	(97, 'order-create', 'web', NULL, '2024-11-26 22:29:50', '2024-11-26 22:29:50'),
	(98, 'order-edit', 'web', NULL, '2024-11-26 22:30:01', '2024-11-26 22:30:01'),
	(99, 'order-delete', 'web', NULL, '2024-11-26 22:30:11', '2024-11-26 22:30:11'),
	(100, 'customer-list', 'web', NULL, '2024-12-02 08:07:33', '2024-12-02 08:07:33'),
	(101, 'customer-create', 'web', NULL, '2024-12-02 08:07:44', '2024-12-02 08:07:44'),
	(102, 'customer-edit', 'web', NULL, '2024-12-02 08:07:53', '2024-12-02 08:07:53'),
	(103, 'customer-delete', 'web', NULL, '2024-12-02 08:08:07', '2024-12-02 08:08:07'),
	(104, 'transactioncategory-list', 'web', NULL, '2024-12-02 20:57:04', '2024-12-02 20:57:04'),
	(105, 'transactioncategory-create', 'web', NULL, '2024-12-02 20:57:36', '2024-12-02 20:57:36'),
	(106, 'transactioncategory-edit', 'web', NULL, '2024-12-02 20:57:49', '2024-12-02 20:57:49'),
	(107, 'transactioncategory-delete', 'web', NULL, '2024-12-02 20:58:03', '2024-12-02 20:58:03'),
	(108, 'transaction-list', 'web', NULL, '2024-12-03 00:59:42', '2024-12-03 00:59:42'),
	(109, 'transaction-create', 'web', NULL, '2024-12-03 00:59:55', '2024-12-03 00:59:55'),
	(110, 'transaction-edit', 'web', NULL, '2024-12-03 01:00:06', '2024-12-03 01:00:06'),
	(111, 'transaction-delete', 'web', NULL, '2024-12-03 01:00:18', '2024-12-03 01:00:18'),
	(112, 'stockopname-list', 'web', NULL, '2024-12-10 09:12:02', '2024-12-10 09:12:02'),
	(113, 'stockopname-create', 'web', NULL, '2024-12-10 09:12:14', '2024-12-10 09:12:14'),
	(114, 'stockopname-edit', 'web', NULL, '2024-12-10 09:12:28', '2024-12-10 09:12:28'),
	(115, 'stockopname-delete', 'web', NULL, '2024-12-10 09:12:39', '2024-12-10 09:12:39'),
	(116, 'adjustment-list', 'web', NULL, '2024-12-12 03:38:02', '2024-12-12 03:38:02'),
	(117, 'adjustment-create', 'web', NULL, '2024-12-12 03:38:24', '2024-12-12 03:38:24'),
	(118, 'adjustment-edit', 'web', NULL, '2024-12-12 03:38:39', '2024-12-12 03:38:39'),
	(119, 'adjustment-delete', 'web', NULL, '2024-12-12 03:38:50', '2024-12-12 03:38:50'),
	(120, 'report-list', 'web', 4, '2024-12-15 16:48:27', '2024-12-15 20:19:05'),
	(121, 'purchasereport-list', 'web', NULL, '2024-12-15 17:42:48', '2024-12-15 20:19:37'),
	(122, 'orderreport-list', 'web', NULL, '2024-12-15 23:44:38', '2024-12-15 23:44:38'),
	(123, 'productreport-list', 'web', NULL, '2024-12-17 09:26:43', '2024-12-17 09:26:43'),
	(124, 'profitreport-list', 'web', NULL, '2024-12-21 08:59:19', '2024-12-21 08:59:19'),
	(125, 'topproductreport-list', 'web', NULL, '2024-12-25 06:28:13', '2024-12-25 06:28:13');

-- Dumping structure for table db_master_pos.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code_product` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `barcode` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit_id` bigint unsigned NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `purchase_price` bigint NOT NULL,
  `cost_price` bigint NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reminder` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_unit_id_foreign` (`unit_id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_unit_id_foreign` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.products: ~9 rows (approximately)
INSERT INTO `products` (`id`, `code_product`, `barcode`, `name`, `unit_id`, `category_id`, `description`, `purchase_price`, `cost_price`, `stock`, `image`, `reminder`, `created_at`, `updated_at`) VALUES
	(9, '17051127504', '17051127504', 'Makaroni Layla', 1, 3, 'Makaroni Layla Deskripsi', 3000, 5000, 52, '20241127165559_makaroni.webp', 10, '2024-11-23 09:27:51', '2024-12-23 05:02:51'),
	(10, '8809687005481', '8809687005481', 'Keripik Pisang', 1, 3, 'Keripik Pisang Deskripsi', 4000, 6000, 39, '20241127165521_astronauts-id.webp', 10, '2024-11-23 23:55:26', '2024-12-23 05:02:51'),
	(12, '6998658420186', '6998658420186', 'Coca-cola', 6, 2, 'Coca cola Deskripsi', 25000, 35000, 12, '20241127090127_cocacoal.webp', 10, '2024-11-27 02:01:27', '2024-12-22 05:48:21'),
	(13, 'K004', 'K004', 'Teh Pucuk', 1, 2, 'Teh Pucuk Deskripsi', 4500, 7000, 16, '20241130091534_3784a72bc481fb93b9f94876aa3fcc77.webp', 10, '2024-11-30 02:15:34', '2024-12-21 02:59:21'),
	(14, 'K005', 'K005', 'Roti O', 1, 1, 'Roti O Deskripsi', 15000, 17000, 6, '20241130100515_ccd869e7-85ba-4fb3-b0e2-791770e2c765.webp', 10, '2024-11-30 03:05:15', '2024-12-25 05:15:45'),
	(15, 'K006', 'K006', 'Buku Tulis Sidu 38 10 Pcs', 8, 5, 'Buku Tulis Sidu Deskripsi', 33000, 38000, 3, '20241204102859_87530b59-b3a8-408e-961d-2b8e8f263f47.webp', 10, '2024-12-04 03:29:00', '2024-12-23 16:25:19'),
	(16, '4970129727521', '4970129727521', 'Pulpen 2 B', 1, 5, 'Pulpen 2B Deskripsi', 2000, 4000, 9, '20241205092648_1606f1be-f7ee-49cf-8a0a-19c8c942d03b.webp', 10, '2024-12-05 02:26:48', '2024-12-23 05:04:48'),
	(17, 'K010', 'K010', 'Taro Snack', 1, 3, 'Taro Snack Deskripsi', 2000, 3000, 7, '20241210073222_Screenshot_5.webp', 10, '2024-12-10 00:32:23', '2024-12-25 05:15:45'),
	(18, 'B001', 'B001', 'Beng Beng', 1, 3, 'BENG BENG VARIAN BARU', 2300, 3500, 29, '20241217121319_db572b217ce298e397ea8fc452302f8a.webp', 0, '2024-12-17 05:13:20', '2024-12-25 05:15:45');

-- Dumping structure for table db_master_pos.product_prices
CREATE TABLE IF NOT EXISTS `product_prices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `customer_category_id` bigint unsigned NOT NULL,
  `price` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_prices_product_id_foreign` (`product_id`),
  KEY `product_prices_customer_category_id_foreign` (`customer_category_id`),
  CONSTRAINT `product_prices_customer_category_id_foreign` FOREIGN KEY (`customer_category_id`) REFERENCES `customer_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_prices_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.product_prices: ~3 rows (approximately)
INSERT INTO `product_prices` (`id`, `product_id`, `customer_category_id`, `price`, `created_at`, `updated_at`) VALUES
	(18, 9, 2, 4000, '2024-11-23 20:45:45', '2024-11-23 20:45:45'),
	(20, 10, 1, 10000, '2024-11-23 23:55:26', '2024-11-23 23:55:26'),
	(21, 12, 2, 30000, '2024-11-27 02:01:27', '2024-11-27 02:01:27'),
	(22, 13, 2, 6000, '2024-11-30 02:15:35', '2024-11-30 02:15:35'),
	(23, 14, 2, 15000, '2024-12-01 20:35:09', '2024-12-01 20:35:09'),
	(24, 18, 2, 3000, '2024-12-17 05:13:20', '2024-12-17 05:13:20');

-- Dumping structure for table db_master_pos.profil
CREATE TABLE IF NOT EXISTS `profil` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_profil` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alamat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_telp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `no_wa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi_1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `deskripsi_2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `deskripsi_3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo_dark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `favicon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bg_login` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme` enum('light','dark') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `theme_color` enum('Blue_Theme','Aqua_Theme','Purple_Theme','Green_Theme','Cyan_Theme','Orange_Theme') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `boxed_layout` enum('true','false') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sidebar_type` enum('full','mini-sidebar') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_border` enum('true','false') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direction` enum('ltr','rtl') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `embed_youtube` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `embed_map` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.profil: ~0 rows (approximately)
INSERT INTO `profil` (`id`, `nama_profil`, `alias`, `no_id`, `alamat`, `no_telp`, `no_wa`, `email`, `instagram`, `facebook`, `youtube`, `website`, `deskripsi_1`, `deskripsi_2`, `deskripsi_3`, `logo`, `logo_dark`, `favicon`, `banner`, `bg_login`, `theme`, `theme_color`, `boxed_layout`, `sidebar_type`, `card_border`, `direction`, `embed_youtube`, `embed_map`, `created_at`, `updated_at`) VALUES
	(1, 'eL-POS', 'MST', NULL, 'Jl. Tajur Indah No 121 Indihiang', '085320555394', '085320555394', 'elpos@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '20241203013833_ELECTRO_MUSIC.webp', '20241209063302_ELECTRO_MUSIC2.webp', '20241130110136_Desain_tanpa_judul.webp', '20241111163129_THUMBNAIL_AS-SUNDAWY_MENGAJI_(2).webp', '20241209063838_login-bg.webp', 'light', 'Aqua_Theme', 'false', 'full', 'false', 'ltr', NULL, NULL, '2024-11-11 05:51:01', '2024-12-22 16:52:29');

-- Dumping structure for table db_master_pos.profit_loss
CREATE TABLE IF NOT EXISTS `profit_loss` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cash_id` bigint unsigned NOT NULL,
  `transaction_id` bigint unsigned DEFAULT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `purchase_id` bigint unsigned DEFAULT NULL,
  `date` date NOT NULL,
  `category` enum('kurang','tambah') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `profit_loss_cash_id_foreign` (`cash_id`),
  KEY `profit_loss_transaction_id_foreign` (`transaction_id`),
  KEY `profit_loss_order_id_foreign` (`order_id`),
  KEY `profit_loss_purchase_id_foreign` (`purchase_id`),
  CONSTRAINT `profit_loss_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`) ON DELETE CASCADE,
  CONSTRAINT `profit_loss_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `profit_loss_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE,
  CONSTRAINT `profit_loss_transaction_id_foreign` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.profit_loss: ~9 rows (approximately)
INSERT INTO `profit_loss` (`id`, `cash_id`, `transaction_id`, `order_id`, `purchase_id`, `date`, `category`, `amount`, `created_at`, `updated_at`) VALUES
	(1, 1, 12, NULL, NULL, '2024-12-22', 'kurang', 300000, '2024-12-22 01:27:37', '2024-12-22 01:27:38'),
	(2, 2, NULL, 40, NULL, '2024-12-22', 'tambah', 400000, '2024-12-22 01:27:53', '2024-12-22 01:27:54'),
	(3, 1, NULL, NULL, 118, '2024-12-22', 'kurang', 400000, '2024-12-22 01:28:11', '2024-12-22 01:28:10'),
	(4, 1, NULL, NULL, 123, '2024-12-22', 'kurang', 30000, '2024-12-22 05:43:09', '2024-12-22 05:43:09'),
	(5, 1, NULL, 56, NULL, '2024-12-22', 'tambah', 156500, '2024-12-22 05:48:22', '2024-12-22 05:48:22'),
	(6, 1, NULL, 50, NULL, '2024-12-19', 'tambah', 54500, '2024-12-22 08:42:50', '2024-12-22 08:42:50'),
	(7, 1, NULL, NULL, 124, '2024-12-22', 'kurang', 24000, '2024-12-22 08:45:45', '2024-12-22 08:45:45'),
	(9, 1, 15, NULL, NULL, '2024-12-23', 'kurang', 230000, '2024-12-23 05:00:41', '2024-12-23 05:00:41'),
	(10, 1, NULL, NULL, 125, '2024-12-23', 'kurang', 70000, '2024-12-23 05:02:51', '2024-12-23 05:02:51'),
	(11, 1, NULL, 49, NULL, '2024-12-19', 'tambah', 63997, '2024-12-23 05:04:15', '2024-12-23 05:04:15'),
	(12, 1, NULL, 57, NULL, '2024-12-23', 'tambah', 74000, '2024-12-23 05:04:48', '2024-12-23 05:04:48'),
	(13, 1, NULL, NULL, 126, '2025-01-23', 'kurang', 99000, '2024-12-23 16:25:19', '2024-12-23 16:25:19'),
	(14, 1, NULL, NULL, 127, '2024-11-07', 'kurang', 32200, '2024-12-23 16:27:28', '2024-12-23 16:27:28'),
	(15, 2, 16, NULL, NULL, '2024-12-24', 'kurang', 340000, '2024-12-24 16:47:41', '2024-12-24 16:47:41'),
	(16, 2, NULL, NULL, 128, '2024-12-25', 'kurang', 115800, '2024-12-25 05:15:45', '2024-12-25 05:15:45');

-- Dumping structure for table db_master_pos.purchases
CREATE TABLE IF NOT EXISTS `purchases` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_date` date NOT NULL,
  `no_purchase` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint unsigned NOT NULL,
  `supplier_id` bigint unsigned DEFAULT NULL,
  `cash_id` bigint unsigned DEFAULT NULL,
  `total_cost` bigint NOT NULL DEFAULT '0',
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type_payment` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchases_supplier_id_foreign` (`supplier_id`),
  KEY `purchases_user_id_foreign` (`user_id`),
  KEY `cash_id` (`cash_id`),
  CONSTRAINT `purchases_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`),
  CONSTRAINT `purchases_supplier_id_foreign` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.purchases: ~9 rows (approximately)
INSERT INTO `purchases` (`id`, `purchase_date`, `no_purchase`, `user_id`, `supplier_id`, `cash_id`, `total_cost`, `status`, `image`, `description`, `type_payment`, `created_at`, `updated_at`) VALUES
	(116, '2024-12-15', 'MST-20241215-000001-PCS', 1, 1, 1, 128000, 'Lunas', '20241215092139_ELECTRO_MUSIC.webp', 'Pembelian Pada Supplier Baru', 'CASH', '2024-12-15 02:21:39', '2024-12-15 02:22:08'),
	(117, '2024-12-15', 'MST-20241215-000002-PCS', 1, 2, 1, 590000, 'Lunas', '20241215092317_ELECTRO_MUSIC2.webp', 'Prima Rasa Abadi', 'CASH', '2024-12-15 02:23:17', '2024-12-15 02:23:17'),
	(118, '2024-12-15', 'MST-20241215-000003-PCS', 1, 3, 1, 258000, 'Lunas', '20241215092523_IMG-20220630-WA0000.webp', 'ATK', 'CASH', '2024-12-15 02:25:23', '2024-12-15 02:25:23'),
	(119, '2024-12-15', 'MST-20241215-000004-PCS', 1, 1, 1, 23000, 'Lunas', '', 'Sementara', 'CASH', '2024-12-15 02:26:40', '2024-12-15 02:26:40'),
	(120, '2024-12-15', 'MST-20241215-000005-PCS', 1, 1, 1, 21000, 'Lunas', '', NULL, 'CASH', '2024-12-15 16:42:00', '2024-12-15 16:42:00'),
	(121, '2024-12-17', 'MST-20241217-000006-PCS', 1, 2, 1, 23000, 'Lunas', '', NULL, 'CASH', '2024-12-17 05:14:45', '2024-12-17 05:14:45'),
	(122, '2024-12-18', 'MST-20241218-000007-PCS', 1, 3, 2, 70000, 'Lunas', '', NULL, 'TRANSFER', '2024-12-18 03:42:13', '2024-12-18 03:42:13'),
	(123, '2024-12-22', 'MST-20241222-000008-PCS', 1, 3, 1, 30000, 'Lunas', '', NULL, 'TRANSFER', '2024-12-22 05:43:09', '2024-12-22 05:43:09'),
	(124, '2024-12-22', 'MST-20241222-000009-PCS', 1, 2, 1, 24000, 'Lunas', '', NULL, 'CASH', '2024-12-22 08:45:23', '2024-12-22 08:45:45'),
	(125, '2024-12-23', 'MST-20241223-000010-PCS', 1, 3, 1, 70000, 'Lunas', '20241223120250_Thumbnail_YouTube_.webp', '20 Produk', 'CASH', '2024-12-23 05:02:50', '2024-12-23 05:02:50'),
	(126, '2025-01-23', 'MST-20241223-000011-PCS', 1, 1, 1, 99000, 'Lunas', '', NULL, 'CASH', '2024-12-23 16:25:18', '2024-12-23 16:25:18'),
	(127, '2024-11-07', 'MST-20241223-000012-PCS', 1, 2, 1, 32200, 'Lunas', '', NULL, 'CASH', '2024-12-23 16:27:28', '2024-12-23 16:27:28'),
	(128, '2024-12-25', 'MST-20241225-000013-PCS', 1, 3, 2, 115800, 'Lunas', '', NULL, 'CASH', '2024-12-25 05:15:45', '2024-12-25 05:15:45');

-- Dumping structure for table db_master_pos.purchase_items
CREATE TABLE IF NOT EXISTS `purchase_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `purchase_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `purchase_price` bigint NOT NULL,
  `total_price` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_items_purchase_id_foreign` (`purchase_id`),
  KEY `purchase_items_product_id_foreign` (`product_id`),
  CONSTRAINT `purchase_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchase_items_purchase_id_foreign` FOREIGN KEY (`purchase_id`) REFERENCES `purchases` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.purchase_items: ~8 rows (approximately)
INSERT INTO `purchase_items` (`id`, `purchase_id`, `product_id`, `quantity`, `purchase_price`, `total_price`, `created_at`, `updated_at`) VALUES
	(199, 116, 9, 20, 3000, 60000, '2024-12-15 02:21:39', '2024-12-15 02:21:39'),
	(200, 116, 10, 17, 4000, 68000, '2024-12-15 02:21:39', '2024-12-15 02:21:39'),
	(201, 117, 12, 20, 25000, 500000, '2024-12-15 02:23:17', '2024-12-15 02:23:17'),
	(202, 117, 13, 20, 4500, 90000, '2024-12-15 02:23:17', '2024-12-15 02:23:17'),
	(203, 118, 15, 6, 33000, 198000, '2024-12-15 02:25:23', '2024-12-15 02:25:23'),
	(204, 118, 16, 30, 2000, 60000, '2024-12-15 02:25:23', '2024-12-15 02:25:23'),
	(205, 119, 14, 1, 15000, 15000, '2024-12-15 02:26:40', '2024-12-15 02:26:40'),
	(206, 119, 17, 4, 2000, 8000, '2024-12-15 02:26:40', '2024-12-15 02:26:40'),
	(207, 120, 9, 3, 3000, 9000, '2024-12-15 16:42:00', '2024-12-15 16:42:00'),
	(208, 120, 10, 3, 4000, 12000, '2024-12-15 16:42:00', '2024-12-15 16:42:00'),
	(209, 121, 18, 10, 2300, 23000, '2024-12-17 05:14:46', '2024-12-17 05:14:46'),
	(210, 122, 9, 10, 3000, 30000, '2024-12-18 03:42:13', '2024-12-18 03:42:13'),
	(211, 122, 10, 10, 4000, 40000, '2024-12-18 03:42:13', '2024-12-18 03:42:13'),
	(212, 123, 9, 10, 3000, 30000, '2024-12-22 05:43:09', '2024-12-22 05:43:09'),
	(213, 124, 9, 4, 3000, 12000, '2024-12-22 08:45:23', '2024-12-22 08:45:23'),
	(214, 124, 10, 3, 4000, 12000, '2024-12-22 08:45:23', '2024-12-22 08:45:23'),
	(215, 125, 9, 10, 3000, 30000, '2024-12-23 05:02:51', '2024-12-23 05:02:51'),
	(216, 125, 10, 10, 4000, 40000, '2024-12-23 05:02:51', '2024-12-23 05:02:51'),
	(217, 126, 15, 3, 33000, 99000, '2024-12-23 16:25:18', '2024-12-23 16:25:18'),
	(218, 127, 18, 14, 2300, 32200, '2024-12-23 16:27:28', '2024-12-23 16:27:28'),
	(219, 128, 18, 6, 2300, 13800, '2024-12-25 05:15:45', '2024-12-25 05:15:45'),
	(220, 128, 14, 6, 15000, 90000, '2024-12-25 05:15:45', '2024-12-25 05:15:45'),
	(221, 128, 17, 6, 2000, 12000, '2024-12-25 05:15:45', '2024-12-25 05:15:45');

-- Dumping structure for table db_master_pos.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.roles: ~2 rows (approximately)
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
	(1, 'Admin', 'web', '2024-11-10 22:51:56', '2024-11-10 22:51:56'),
	(2, 'Pengguna', 'web', '2024-11-11 08:13:23', '2024-11-11 08:13:23');

-- Dumping structure for table db_master_pos.role_has_permissions
CREATE TABLE IF NOT EXISTS `role_has_permissions` (
  `permission_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.role_has_permissions: ~93 rows (approximately)
INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1),
	(10, 1),
	(11, 1),
	(12, 1),
	(13, 1),
	(14, 1),
	(15, 1),
	(16, 1),
	(17, 1),
	(18, 1),
	(19, 1),
	(20, 1),
	(21, 1),
	(22, 1),
	(23, 1),
	(24, 1),
	(25, 1),
	(26, 1),
	(34, 1),
	(35, 1),
	(37, 1),
	(44, 1),
	(45, 1),
	(46, 1),
	(47, 1),
	(48, 1),
	(49, 1),
	(71, 1),
	(72, 1),
	(73, 1),
	(74, 1),
	(75, 1),
	(76, 1),
	(77, 1),
	(78, 1),
	(79, 1),
	(80, 1),
	(81, 1),
	(82, 1),
	(83, 1),
	(84, 1),
	(85, 1),
	(86, 1),
	(87, 1),
	(88, 1),
	(89, 1),
	(90, 1),
	(91, 1),
	(92, 1),
	(93, 1),
	(94, 1),
	(95, 1),
	(96, 1),
	(97, 1),
	(98, 1),
	(99, 1),
	(100, 1),
	(101, 1),
	(102, 1),
	(103, 1),
	(104, 1),
	(105, 1),
	(106, 1),
	(107, 1),
	(108, 1),
	(109, 1),
	(110, 1),
	(111, 1),
	(112, 1),
	(113, 1),
	(114, 1),
	(115, 1),
	(116, 1),
	(117, 1),
	(118, 1),
	(119, 1),
	(120, 1),
	(121, 1),
	(122, 1),
	(123, 1),
	(124, 1),
	(125, 1),
	(14, 2),
	(15, 2),
	(21, 2),
	(22, 2);

-- Dumping structure for table db_master_pos.routes
CREATE TABLE IF NOT EXISTS `routes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.routes: ~193 rows (approximately)
INSERT INTO `routes` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'debugbar.openhandler', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(2, 'debugbar.clockwork', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(3, 'debugbar.assets.css', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(4, 'debugbar.assets.js', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(5, 'debugbar.cache.delete', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(6, 'debugbar.queries.explain', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(7, 'up', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(8, 'login', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(9, 'login', '2024-12-25 06:30:31', '2024-12-25 06:30:31'),
	(10, 'logout', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(11, 'register', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(12, 'register', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(13, 'password.request', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(14, 'password.email', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(15, 'password.reset', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(16, 'password.update', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(17, 'password.confirm', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(18, 'password/confirm', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(19, '/', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(20, 'home', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(21, 'tutorial-status', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(22, 'set-tutorial-status', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(23, 'adjustments.index', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(24, 'adjustments.create', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(25, 'adjustments.store', '2024-12-25 06:30:32', '2024-12-25 06:30:32'),
	(26, 'adjustments.show', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(27, 'adjustments.edit', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(28, 'adjustments.update', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(29, 'adjustments.destroy', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(30, 'adjustments.print', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(31, 'stock_opname.index', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(32, 'stock_opname.create', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(33, 'stock_opname.store', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(34, 'stock_opname.show', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(35, 'stock_opname.edit', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(36, 'stock_opname.update', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(37, 'stock_opname.destroy', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(38, 'stock_opname.print', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(39, 'report.purchase_reports', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(40, 'report.purchase_reports.export', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(41, 'report.purchase_reports.export_pdf', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(42, 'report.purchase_reports.preview_pdf', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(43, 'report.order_reports', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(44, 'report.order_reports.export', '2024-12-25 06:30:33', '2024-12-25 06:30:33'),
	(45, 'report.order_reports.export_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(46, 'report.order_reports.preview_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(47, 'report.product_reports', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(48, 'report.product_reports.export', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(49, 'report.product_reports.export_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(50, 'report.product_reports.preview_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(51, 'report.profit_reports', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(52, 'report.profit_reports.export', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(53, 'report.profit_reports.export_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(54, 'report.profit_reports.preview_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(55, 'report.top_product_reports', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(56, 'report.top_product_reports.export', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(57, 'report.top_product_reports.export_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(58, 'report.top_product_reports.preview_pdf', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(59, 'transactions.index', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(60, 'transactions.create', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(61, 'transactions.store', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(62, 'transactions.show', '2024-12-25 06:30:34', '2024-12-25 06:30:34'),
	(63, 'transactions.edit', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(64, 'transactions.update', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(65, 'transactions.destroy', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(66, 'transaction_categories.index', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(67, 'transaction_categories.create', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(68, 'transaction_categories.store', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(69, 'transaction_categories.show', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(70, 'transaction_categories.edit', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(71, 'transaction_categories.update', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(72, 'transaction_categories.destroy', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(73, 'cash.index', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(74, 'cash.create', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(75, 'cash.store', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(76, 'cash.show', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(77, 'cash.edit', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(78, 'cash.update', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(79, 'cash.destroy', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(80, 'purchases.index', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(81, 'purchases.create', '2024-12-25 06:30:35', '2024-12-25 06:30:35'),
	(82, 'purchases.store', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(83, 'purchases.show', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(84, 'purchases.edit', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(85, 'purchases.update', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(86, 'purchases.destroy', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(87, 'purchases.print_invoice', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(88, 'purchases.update', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(89, 'suppliers.index', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(90, 'suppliers.create', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(91, 'suppliers.store', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(92, 'suppliers.show', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(93, 'suppliers.edit', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(94, 'suppliers.update', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(95, 'suppliers.destroy', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(96, 'customers.index', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(97, 'customers.create', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(98, 'customers.store', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(99, 'customers.show', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(100, 'customers.edit', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(101, 'customers.update', '2024-12-25 06:30:36', '2024-12-25 06:30:36'),
	(102, 'customers.destroy', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(103, 'orders.index', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(104, 'orders.create', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(105, 'orders.store', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(106, 'orders.show', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(107, 'orders.edit', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(108, 'orders.update', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(109, 'orders.destroy', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(110, 'orders.print_invoice', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(111, 'orders.print_struk', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(112, 'orders.update', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(113, 'units.index', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(114, 'units.create', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(115, 'units.store', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(116, 'units.show', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(117, 'units.edit', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(118, 'units.update', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(119, 'units.destroy', '2024-12-25 06:30:37', '2024-12-25 06:30:37'),
	(120, 'products.index', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(121, 'products.create', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(122, 'products.store', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(123, 'products.show', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(124, 'products.edit', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(125, 'products.update', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(126, 'products.destroy', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(127, 'get-product-price', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(128, 'products.generate_barcode', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(129, 'get-product-by-barcode', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(130, 'categories.index', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(131, 'categories.create', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(132, 'categories.store', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(133, 'categories.show', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(134, 'categories.edit', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(135, 'categories.update', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(136, 'categories.destroy', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(137, 'routes.index', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(138, 'routes.create', '2024-12-25 06:30:38', '2024-12-25 06:30:38'),
	(139, 'routes.store', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(140, 'routes.show', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(141, 'routes.edit', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(142, 'routes.update', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(143, 'routes.destroy', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(144, 'routes.generate', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(145, 'log_histori.index', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(146, 'log_histori.create', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(147, 'log_histori.store', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(148, 'log_histori.show', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(149, 'log_histori.edit', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(150, 'log_histori.update', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(151, 'log_histori.destroy', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(152, 'log-histori.delete-all', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(153, 'roles.index', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(154, 'roles.create', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(155, 'roles.store', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(156, 'roles.show', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(157, 'roles.edit', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(158, 'roles.update', '2024-12-25 06:30:39', '2024-12-25 06:30:39'),
	(159, 'roles.destroy', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(160, 'users.index', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(161, 'users.create', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(162, 'users.store', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(163, 'users.show', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(164, 'users.edit', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(165, 'users.update', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(166, 'users.destroy', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(167, 'permissions.index', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(168, 'permissions.create', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(169, 'permissions.store', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(170, 'permissions.show', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(171, 'permissions.edit', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(172, 'permissions.update', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(173, 'permissions.destroy', '2024-12-25 06:30:40', '2024-12-25 06:30:40'),
	(174, 'profil.index', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(175, 'profil.create', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(176, 'profil.store', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(177, 'profil.show', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(178, 'profil.edit', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(179, 'profil.update', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(180, 'profil.destroy', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(181, 'profil.update_setting', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(182, 'menu_groups.index', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(183, 'menu_groups.create', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(184, 'menu_groups.store', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(185, 'menu_groups.show', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(186, 'menu_groups.edit', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(187, 'menu_groups.update', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(188, 'menu_groups.destroy', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(189, 'menu_items.index', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(190, 'menu_items.create', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(191, 'menu_items.store', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(192, 'menu_items.show', '2024-12-25 06:30:41', '2024-12-25 06:30:41'),
	(193, 'menu_items.edit', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(194, 'menu_items.update', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(195, 'menu_items.destroy', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(196, 'menu_items.update_positions', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(197, 'menu_groups.update_positions', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(198, 'resource.create', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(199, 'resource.store', '2024-12-25 06:30:42', '2024-12-25 06:30:42'),
	(200, 'storage.local', '2024-12-25 06:30:42', '2024-12-25 06:30:42');

-- Dumping structure for table db_master_pos.sessions
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.sessions: ~4 rows (approximately)
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
	('iGpuvScVZGfLJzLIbfyBuZjJfw3yt8IVolDb0iAA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiNW9HRDRGejF4VlU1MGtPeXhKY3E2UkVEZjBsNEJ6Tm8xWnpOeUxSayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDk6Imh0dHA6Ly9tYXN0ZXItcG9zLnRlc3QvcmVwb3J0L3RvcF9wcm9kdWN0X3JlcG9ydHMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTczNTEyMTY1MDt9fQ==', 1735138825);

-- Dumping structure for table db_master_pos.stock_opname
CREATE TABLE IF NOT EXISTS `stock_opname` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `opname_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `opname_date` date DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `stock_opname_no_stock_opname_unique` (`opname_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.stock_opname: ~0 rows (approximately)

-- Dumping structure for table db_master_pos.stock_opname_detail
CREATE TABLE IF NOT EXISTS `stock_opname_detail` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stock_opname_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `system_stock` int NOT NULL DEFAULT '0',
  `physical_stock` int NOT NULL DEFAULT '0',
  `difference` int NOT NULL DEFAULT '0',
  `description_detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_opname_detail_stock_opname_id_foreign` (`stock_opname_id`),
  KEY `stock_opname_detail_product_id_foreign` (`product_id`),
  CONSTRAINT `stock_opname_detail_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `stock_opname_detail_stock_opname_id_foreign` FOREIGN KEY (`stock_opname_id`) REFERENCES `stock_opname` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.stock_opname_detail: ~16 rows (approximately)

-- Dumping structure for table db_master_pos.suppliers
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.suppliers: ~2 rows (approximately)
INSERT INTO `suppliers` (`id`, `name`, `email`, `phone`, `address`, `created_at`, `updated_at`) VALUES
	(1, 'Supplier Umum', 'supplierumum@gmail.com', '085320555394', 'Perumahan CGM Sukarindik Kecamatan Bungursari. Blok C31. RT/RW 02/11. Kota Tasikmalaya\r\nJl. Tajur Indah', '2024-11-23 21:34:09', '2024-11-28 08:24:22'),
	(2, 'CV. Prima rasa Abadi', 'pra@gmail.com', '085320555333', 'Jl. Tajur Indah', '2024-11-23 22:17:50', '2024-11-23 22:17:50'),
	(3, 'PT. Triguna', 'triguna@gmail.com', NULL, NULL, '2024-12-04 10:16:45', '2024-12-04 10:16:45');

-- Dumping structure for table db_master_pos.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `transaction_category_id` bigint unsigned NOT NULL,
  `cash_id` bigint unsigned NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint NOT NULL DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_cash_id_foreign` (`cash_id`),
  KEY `transactions_category_id_foreign` (`transaction_category_id`) USING BTREE,
  CONSTRAINT `transactions_cash_id_foreign` FOREIGN KEY (`cash_id`) REFERENCES `cash` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_category_id_foreign` FOREIGN KEY (`transaction_category_id`) REFERENCES `transaction_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.transactions: ~2 rows (approximately)
INSERT INTO `transactions` (`id`, `date`, `transaction_category_id`, `cash_id`, `name`, `amount`, `description`, `image`, `created_at`, `updated_at`) VALUES
	(12, '2024-12-21', 2, 1, 'Donasi Kasir', 200000, 'Donasi Kasir', '20241221153828_miqot_haji-Sampul.webp', '2024-12-21 08:38:29', '2024-12-21 08:38:29'),
	(13, '2024-12-21', 1, 1, 'Listrik', 100000, 'Listrik Kantor', '20241221153925_Thumbnail_YouTube__(1).webp', '2024-12-21 08:39:26', '2024-12-21 08:39:26'),
	(15, '2024-12-23', 1, 1, 'Proposal Karang Taruna', 230000, 'Proposal Karang Taruna Kemerdekaan', '20241223120040_Thumbnail_YouTube__(5).webp', '2024-12-23 05:00:41', '2024-12-23 05:00:41'),
	(16, '2024-12-24', 1, 2, 'Koperasi Satu', 340000, NULL, NULL, '2024-12-24 16:47:41', '2024-12-24 16:47:41');

-- Dumping structure for table db_master_pos.transaction_categories
CREATE TABLE IF NOT EXISTS `transaction_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.transaction_categories: ~2 rows (approximately)
INSERT INTO `transaction_categories` (`id`, `name`, `parent_type`, `description`, `created_at`, `updated_at`) VALUES
	(1, 'Expenses', 'kurang', 'Kategori Expenses', '2024-12-02 22:47:45', '2024-12-03 00:40:56'),
	(2, 'Income', 'tambah', 'Kategori Income', '2024-12-02 22:48:44', '2024-12-03 00:41:07');

-- Dumping structure for table db_master_pos.units
CREATE TABLE IF NOT EXISTS `units` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.units: ~6 rows (approximately)
INSERT INTO `units` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Pcs', '2024-11-22 23:03:07', '2024-11-22 23:05:38'),
	(2, 'Kg', '2024-11-22 23:03:15', '2024-11-22 23:03:15'),
	(3, 'Gram', '2024-11-22 23:03:22', '2024-11-22 23:03:22'),
	(4, 'Box', '2024-11-22 23:03:29', '2024-11-22 23:03:29'),
	(5, 'Dus', '2024-11-22 23:03:41', '2024-11-22 23:03:41'),
	(6, 'Karton', '2024-11-22 23:03:49', '2024-11-22 23:03:49'),
	(8, 'Pack', '2024-12-04 03:27:44', '2024-12-04 03:27:44');

-- Dumping structure for table db_master_pos.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table db_master_pos.users: ~1 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `image`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Muhammad Rafi Heryadi', 'muhammadrafiheryadi94@gmail.com', NULL, '$2y$12$vFfwv6GhKGvZlqH5FpMfCeBhdSb.DhQ/VyGIjetPRfzkMV/MiBF72', '20241209003632_5.webp', 'FRtF76Xqm0c8U91fwYjJ7IGpMOscTlDjitJk7jC6RpY00LhdAJfqzmdEDEJo', '2024-11-10 22:51:56', '2024-12-08 17:36:32'),
	(9, 'Maryam Layla Alfathunissa', 'alfathunissamaryamlayla@gmail.com', NULL, '$2y$12$dn8qiKAf1eIbZQA5yUMb.ORs6B38JLXCyXES3PGk.GU8jrZ1PxAz6', '20241209004251_6.webp', NULL, '2024-12-08 17:42:52', '2024-12-08 17:42:52');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
