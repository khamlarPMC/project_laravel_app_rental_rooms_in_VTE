-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 26, 2026 at 08:34 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_rental_rooms`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` bigint(20) UNSIGNED NOT NULL,
  `village` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_id`, `village`, `district`, `province`) VALUES
(1, 'kuy', 'brbrk', 'vte'),
(2, 'Village B', 'North', 'Vientiane'),
(3, 'Village C', 'South', 'Vientiane'),
(4, 'Village C', 'West', 'Vientiane'),
(5, 'Village D', 'South', 'Vientiane'),
(6, 'Village A', 'Central', 'Vientiane'),
(7, 'Non tar', 'nn', 'sdksdss'),
(8, 'Village B', 'North', 'Vientiane'),
(9, 'aaaa', 'kkkk', 'llll'),
(10, 'spt', 'sst', 'vte'),
(11, 'Village A', 'Central', 'Vientiane'),
(12, 'spt', 'sst', 'vte'),
(13, 'spt', 'sst', 'vte'),
(14, 'Village C', 'South', 'Vientiane'),
(15, 'spt', 'sst', 'vte'),
(16, 'spt', 'sst', 'vte'),
(17, 'Village D', 'South', 'Vientiane'),
(18, 'Village A', 'Central', 'Vientiane'),
(19, 'Test Village', 'Test District', 'Test Province'),
(20, 'Test Village', 'Test District', 'Test Province'),
(21, 'Test Village 2', 'Test District 2', 'Test Province 2'),
(22, 'Test Village 2', 'Test District 2', 'Test Province 2'),
(23, 'gg', 'gg', 'gg'),
(24, 'Village B', 'North', 'Vientiane'),
(25, 'spt', 'sat', 'vte'),
(26, 'Village B', 'South', 'Vientiane'),
(27, 'Village A', 'North', 'Vientiane');

-- --------------------------------------------------------

--
-- Table structure for table `amenity`
--

CREATE TABLE `amenity` (
  `amenity_id` bigint(20) UNSIGNED NOT NULL,
  `amenity_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `amenity`
--

INSERT INTO `amenity` (`amenity_id`, `amenity_name`) VALUES
(1, 'Free Wi-Fi'),
(2, 'Air Conditioning'),
(3, 'Kitchen'),
(4, 'Washing Machine'),
(5, 'TV'),
(6, 'Parking'),
(7, 'Swimming Pool'),
(8, 'Gym'),
(9, 'Pet Friendly'),
(10, 'Security');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` bigint(20) UNSIGNED NOT NULL,
  `tenant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `room_id` bigint(20) UNSIGNED DEFAULT NULL,
  `booking_date` datetime NOT NULL DEFAULT current_timestamp(),
  `move_in_date` date NOT NULL,
  `move_out_date` date DEFAULT NULL,
  `total_months` int(11) DEFAULT NULL,
  `booking_status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `tenant_id`, `room_id`, `booking_date`, `move_in_date`, `move_out_date`, `total_months`, `booking_status`) VALUES
(6, 10, 9, '2026-05-25 14:18:12', '2026-05-30', '2026-11-30', 6, 'confirmed');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '2026_05_10_024846_create_personal_access_tokens_table', 1),
(3, '2026_05_10_114600_create_rental_tables', 1),
(4, '2026_05_18_112110_add_is_approved_to_room_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', 'b2f917f9d389ab0aa26e1513a35e05fbfa70bf8022c6c90ede334c48f048add4', '[\"*\"]', NULL, NULL, '2026-05-10 06:00:30', '2026-05-10 06:00:30'),
(2, 'App\\Models\\User', 1, 'auth_token', '91d922ac04c41198cfcdae2c0e5b81d0b99f1e6b3536ed44be1b8fd27c9a5276', '[\"*\"]', NULL, NULL, '2026-05-10 06:02:12', '2026-05-10 06:02:12'),
(3, 'App\\Models\\User', 1, 'auth_token', '154c3a19f0db8fad5a5e4eca0434661fb0565bf2f175200a823ece0f2e61d29c', '[\"*\"]', '2026-05-10 06:45:22', NULL, '2026-05-10 06:26:43', '2026-05-10 06:45:22'),
(4, 'App\\Models\\User', 1, 'auth_token', 'bcf630932d0cd8f37d1f390d23a6cff9d8229791dee497de6a09699933179c71', '[\"*\"]', '2026-05-10 06:55:53', NULL, '2026-05-10 06:55:50', '2026-05-10 06:55:53'),
(5, 'App\\Models\\User', 1, 'auth_token', '7da028576cf805c21cb624dc8dd53b29f5db9b90cbec26175aec404510a8b380', '[\"*\"]', '2026-05-10 08:34:39', NULL, '2026-05-10 07:43:14', '2026-05-10 08:34:39'),
(6, 'App\\Models\\User', 1, 'auth_token', 'f66966364a056655940782bf2b327a55d543cbb1029aa28f355c37bae7c0ff19', '[\"*\"]', '2026-05-10 08:44:25', NULL, '2026-05-10 08:43:17', '2026-05-10 08:44:25'),
(7, 'App\\Models\\User', 1, 'auth_token', '313efa8b41d089124cd3a12034e0b1f860ac2d5f382e180cc61c59cf4561848d', '[\"*\"]', '2026-05-11 01:40:33', NULL, '2026-05-11 01:40:11', '2026-05-11 01:40:33'),
(8, 'App\\Models\\User', 1, 'auth_token', 'aacd739517d24701a2e97d9e618ecf524420e29fdeeb66dfb862d51f1415e5ab', '[\"*\"]', '2026-05-11 01:41:59', NULL, '2026-05-11 01:41:52', '2026-05-11 01:41:59'),
(9, 'App\\Models\\User', 1, 'auth_token', '75c43789caba466746f93ffc79103e15e5a718bd769d4de24c1c8e5c88970022', '[\"*\"]', '2026-05-11 01:43:58', NULL, '2026-05-11 01:42:50', '2026-05-11 01:43:58'),
(10, 'App\\Models\\User', 1, 'auth_token', 'f77f9aa29b723be27d6bfe132f0f150a854a876aedb2f47ca54ab59f73323b5d', '[\"*\"]', NULL, NULL, '2026-05-11 01:46:12', '2026-05-11 01:46:12'),
(11, 'App\\Models\\User', 1, 'auth_token', 'bf38a0735bf30ef96221919fd647100ed6822f0fe09839341bbfdf56a628b725', '[\"*\"]', '2026-05-11 02:05:44', NULL, '2026-05-11 02:04:45', '2026-05-11 02:05:44'),
(12, 'App\\Models\\User', 1, 'auth_token', 'e0412eec4c72f18d44d8db144973a84ba0c676427ce106f1008e0b38d3694435', '[\"*\"]', '2026-05-11 02:14:56', NULL, '2026-05-11 02:12:43', '2026-05-11 02:14:56'),
(13, 'App\\Models\\User', 1, 'auth_token', 'e85fc9898517629cc60c2641e5990195e402f32c8678f8ae6aaa49fdf68b778c', '[\"*\"]', NULL, NULL, '2026-05-11 02:25:59', '2026-05-11 02:25:59'),
(14, 'App\\Models\\User', 1, 'auth_token', '252c49a6686d51d8b58fe34089301f86d90a74e739106b62c7b78737f1491195', '[\"*\"]', '2026-05-11 02:34:03', NULL, '2026-05-11 02:26:48', '2026-05-11 02:34:03'),
(15, 'App\\Models\\User', 2, 'auth_token', '86b4adf28d27d7541b0981088eab87de4682ec378987a31d86a977b6bbc08e29', '[\"*\"]', '2026-05-11 23:03:44', NULL, '2026-05-11 23:01:42', '2026-05-11 23:03:44'),
(16, 'App\\Models\\User', 1, 'auth_token', '259a69f21e570ddcb78e0cac10aba044e9d0df92a51347403fabca38235ba967', '[\"*\"]', '2026-05-11 23:22:06', NULL, '2026-05-11 23:04:05', '2026-05-11 23:22:06'),
(17, 'App\\Models\\User', 2, 'auth_token', '8230fefab02e4c43c8a498075a33dac9bcd7705009c6c4bfa8b253ca0cb50e50', '[\"*\"]', '2026-05-11 23:28:11', NULL, '2026-05-11 23:22:34', '2026-05-11 23:28:11'),
(18, 'App\\Models\\User', 1, 'auth_token', '47ee3e65b4a1a0811196e7aa60f43adf6087c3d23ca1226da50cc243744e08aa', '[\"*\"]', '2026-05-11 23:35:16', NULL, '2026-05-11 23:28:56', '2026-05-11 23:35:16'),
(19, 'App\\Models\\User', 3, 'auth_token', '3b65dbc972e7ce7d5908f4c9203b96c51728c30495407c3929bf27e26b196674', '[\"*\"]', '2026-05-11 23:36:53', NULL, '2026-05-11 23:36:34', '2026-05-11 23:36:53'),
(20, 'App\\Models\\User', 3, 'auth_token', '890aea16b8d52c9b03355aacdc3a4dbb98360db6b9ceee50d4b43eb0083b297c', '[\"*\"]', '2026-05-11 23:42:33', NULL, '2026-05-11 23:41:56', '2026-05-11 23:42:33'),
(21, 'App\\Models\\User', 3, 'auth_token', 'b5e323ccacd1616cfa7da4388c5f8fa020947f7a51c193620d26e614bee2983c', '[\"*\"]', NULL, NULL, '2026-05-11 23:48:47', '2026-05-11 23:48:47'),
(22, 'App\\Models\\User', 3, 'auth_token', '1fdbeb693f92133ffa9f2a2a81abacd78b357149d4c3393421a541c1dc69f81c', '[\"*\"]', NULL, NULL, '2026-05-11 23:49:44', '2026-05-11 23:49:44'),
(23, 'App\\Models\\User', 3, 'auth_token', '6d00f3e75f6fed5ae3df6ea65801f5924d21147feb822fd95a3ebe4eb9301264', '[\"*\"]', '2026-05-12 00:03:01', NULL, '2026-05-11 23:53:29', '2026-05-12 00:03:01'),
(24, 'App\\Models\\User', 1, 'auth_token', 'e559085034d7405e588b9ac2bbf5d2a43e3e3d79d8e224555192252e6b446046', '[\"*\"]', '2026-05-12 00:19:40', NULL, '2026-05-12 00:07:28', '2026-05-12 00:19:40'),
(25, 'App\\Models\\User', 1, 'auth_token', '6d9bb2998874df69054722c4017355b9e3bfb4b1e5048c1dc2c2d538807c8ced', '[\"*\"]', '2026-05-13 00:32:15', NULL, '2026-05-13 00:32:06', '2026-05-13 00:32:15'),
(26, 'App\\Models\\User', 1, 'auth_token', '47fc746259641dda2a2e4992199e11000c0aebc42d7f97e6814cd311bd52bed3', '[\"*\"]', '2026-05-13 02:17:59', NULL, '2026-05-13 02:17:54', '2026-05-13 02:17:59'),
(27, 'App\\Models\\User', 4, 'auth_token', '9f98e53e2248484c0a4c231be345ce6c57aa450ebd5f7b510dbea7d292786e07', '[\"*\"]', NULL, NULL, '2026-05-14 07:37:22', '2026-05-14 07:37:22'),
(28, 'App\\Models\\User', 4, 'auth_token', 'f25421fb82f593170f2c6c3e4a65eca0dd5801a4c360aafc2a3c0b31f8d994e7', '[\"*\"]', '2026-05-14 07:40:29', NULL, '2026-05-14 07:38:35', '2026-05-14 07:40:29'),
(29, 'App\\Models\\User', 5, 'auth_token', 'a30ba06c9f168d7899e6c8487cf5c8b40e9723d007f7fc5ec207147217a4eb20', '[\"*\"]', '2026-05-14 07:43:29', NULL, '2026-05-14 07:41:44', '2026-05-14 07:43:29'),
(30, 'App\\Models\\User', 4, 'auth_token', '3ac256e5572bec9cbe51955fde2ad6d93de4620aaf215b1b9cedd35f34eca017', '[\"*\"]', '2026-05-14 07:45:05', NULL, '2026-05-14 07:44:14', '2026-05-14 07:45:05'),
(31, 'App\\Models\\User', 5, 'auth_token', 'b7de3331d5e7d80c34bb4d4c8b8e2eb0095bbee7482b4e791c4ef5cc681dfa76', '[\"*\"]', '2026-05-14 07:48:49', NULL, '2026-05-14 07:48:01', '2026-05-14 07:48:49'),
(32, 'App\\Models\\User', 6, 'auth_token', '6fd43b8e5e97ca06add53b803c8d7e5791aacd64c07ba84f9f980eb8539247df', '[\"*\"]', '2026-05-14 13:01:25', NULL, '2026-05-14 12:55:43', '2026-05-14 13:01:25'),
(33, 'App\\Models\\User', 7, 'auth_token', '06622712718d1097a3e9babb93781634085aa310cd37218dd106920919148f1b', '[\"*\"]', '2026-05-14 13:03:58', NULL, '2026-05-14 13:02:48', '2026-05-14 13:03:58'),
(34, 'App\\Models\\User', 6, 'auth_token', '93b1e919a6f5d8b336e1b1254f93ce67601bd784c9eeeaf573e9471feeb80158', '[\"*\"]', '2026-05-14 13:04:43', NULL, '2026-05-14 13:04:21', '2026-05-14 13:04:43'),
(35, 'App\\Models\\User', 7, 'auth_token', '808ffb453f294a8a0efc2b8a5847970722a2688d3c26830a95a1a37a4bc507a9', '[\"*\"]', '2026-05-14 13:05:43', NULL, '2026-05-14 13:05:06', '2026-05-14 13:05:43'),
(36, 'App\\Models\\User', 1, 'auth_token', 'b5481969b53b71e8ddefefe6380c345cdedef6708eae13ba49fee8bdb78832a7', '[\"*\"]', '2026-05-14 16:07:28', NULL, '2026-05-14 16:07:23', '2026-05-14 16:07:28'),
(37, 'App\\Models\\User', 1, 'auth_token', 'c8650e7d13edab2d747150cc2ef3372584f8716fdec9e35bd0b9bdf24cc59b63', '[\"*\"]', '2026-05-14 19:06:16', NULL, '2026-05-14 19:05:10', '2026-05-14 19:06:16'),
(38, 'App\\Models\\User', 1, 'auth_token', '3c59e03b2819b94a471a4a0df1f45e7eef8f5fa43a9e23e2178ae9b874844573', '[\"*\"]', '2026-05-14 19:20:14', NULL, '2026-05-14 19:07:08', '2026-05-14 19:20:14'),
(39, 'App\\Models\\User', 1, 'auth_token', '7324e20da9b26e3a9b64e356b4441bb3540932900df12faf7f67cefef4b93f0d', '[\"*\"]', NULL, NULL, '2026-05-14 19:21:58', '2026-05-14 19:21:58'),
(40, 'App\\Models\\User', 1, 'auth_token', 'b83f74cd4ca33e7eeb5ae34da21cb8f138ec97a6abc048afe846a13c1d9514f4', '[\"*\"]', '2026-05-14 19:39:03', NULL, '2026-05-14 19:27:20', '2026-05-14 19:39:03'),
(41, 'App\\Models\\User', 1, 'auth_token', '272f0f55082b89dc0ad3e760cf00bda98e2faad4627a88a4c67ea7481ce6938c', '[\"*\"]', NULL, NULL, '2026-05-14 19:55:03', '2026-05-14 19:55:03'),
(42, 'App\\Models\\User', 1, 'auth_token', 'd71551ccc28ce9eb27c6a2c7e22da81734a27790e7f0d7061b74cd41474117a4', '[\"*\"]', NULL, NULL, '2026-05-14 20:42:40', '2026-05-14 20:42:40'),
(43, 'App\\Models\\User', 1, 'auth_token', 'bb6d22d0f8ce677158b1049c3b3c8f8a20823f5040a80aa82b3f3f8d54c1f4ef', '[\"*\"]', NULL, NULL, '2026-05-14 21:06:01', '2026-05-14 21:06:01'),
(44, 'App\\Models\\User', 1, 'auth_token', 'fa1506d573c09ac8996760492ea0f2651b6830876de148986ae69b106924392f', '[\"*\"]', '2026-05-14 21:20:00', NULL, '2026-05-14 21:19:40', '2026-05-14 21:20:00'),
(45, 'App\\Models\\User', 1, 'auth_token', '19aa3d0f32ac6926500759c8dcd948349dc560160372e939072b7c5401dc98e1', '[\"*\"]', '2026-05-14 21:35:25', NULL, '2026-05-14 21:35:08', '2026-05-14 21:35:25'),
(46, 'App\\Models\\User', 1, 'auth_token', '504b6def05937a48d11230843935ce7e6d5394d1c814b80917303b34086e1a2d', '[\"*\"]', '2026-05-15 01:57:53', NULL, '2026-05-15 01:55:40', '2026-05-15 01:57:53'),
(47, 'App\\Models\\User', 1, 'auth_token', 'a81015d9d5e31f4bc4e9ff274a4840b317b2be521b26608639beb644c10c2906', '[\"*\"]', '2026-05-15 03:08:35', NULL, '2026-05-15 02:18:44', '2026-05-15 03:08:35'),
(49, 'App\\Models\\User', 8, 'auth_token', 'ea7a8b80a1026dbb62e3a4a212b806cb303a3e8bc98ce8f0b1f967511cbc68b9', '[\"*\"]', '2026-05-18 03:41:34', NULL, '2026-05-18 02:59:51', '2026-05-18 03:41:34'),
(51, 'App\\Models\\User', 9, 'auth_token', '86db71152bf8fa82bac6e1c8e29f825c5ecec421b3146e15e5ace5528711755a', '[\"*\"]', '2026-05-18 04:13:52', NULL, '2026-05-18 03:53:27', '2026-05-18 04:13:52'),
(53, 'App\\Models\\User', 9, 'auth_token', '04ab84e40d8d6cd1f7bc39e914cc18c574c436d9bb6560bd78b6b4674358802b', '[\"*\"]', '2026-05-18 04:31:14', NULL, '2026-05-18 04:29:55', '2026-05-18 04:31:14'),
(55, 'App\\Models\\User', 9, 'auth_token', '55e718925630d4d6d5a5c2124dc14874894b34bcfb744fb781b2b9c68c23d207', '[\"*\"]', '2026-05-18 04:33:00', NULL, '2026-05-18 04:32:44', '2026-05-18 04:33:00'),
(57, 'App\\Models\\User', 9, 'auth_token', 'ea76935ce78b9c1ef176739de4d00ef5c9dd6bc00a8d567e440a5901228b8b87', '[\"*\"]', '2026-05-22 00:35:55', NULL, '2026-05-21 21:19:12', '2026-05-22 00:35:55'),
(58, 'App\\Models\\User', 9, 'auth_token', '80a66592798925c4039f5ae3bd744fed653305d7aab807bd6e5b9b2b554214f2', '[\"*\"]', '2026-05-24 00:54:46', NULL, '2026-05-24 00:25:07', '2026-05-24 00:54:46'),
(59, 'App\\Models\\User', 9, 'auth_token', '8ee8d4fa8fd431ade19e81fa00de4ca2761631b5a8706e3c6f19eeb1d46f79ac', '[\"*\"]', '2026-05-24 01:08:07', NULL, '2026-05-24 01:08:03', '2026-05-24 01:08:07'),
(60, 'App\\Models\\User', 9, 'auth_token', '3aa44b4d6bb400bae344357c11cc4156271822d6098793218c971a947cfada8a', '[\"*\"]', '2026-05-24 23:13:13', NULL, '2026-05-24 22:39:09', '2026-05-24 23:13:13'),
(61, 'App\\Models\\User', 9, 'auth_token', '22a4e5b7ee84b5b6414fc127882b6acbe52ba6a3236184a58272a13e1eed309a', '[\"*\"]', '2026-05-24 23:20:05', NULL, '2026-05-24 23:18:44', '2026-05-24 23:20:05'),
(62, 'App\\Models\\User', 8, 'auth_token', 'bd43f13bc2fb99e75a7162607467f54aa44c7fbadb43dded3a2ce5c466e36cd0', '[\"*\"]', NULL, NULL, '2026-05-25 07:00:16', '2026-05-25 07:00:16'),
(63, 'App\\Models\\User', 8, 'auth_token', 'db0be8c7489ad3eed6738e68180bbdbe192b3de328c7c7b4357013f0d8464e78', '[\"*\"]', NULL, NULL, '2026-05-25 07:07:56', '2026-05-25 07:07:56'),
(64, 'App\\Models\\User', 9, 'auth_token', '75a660247c2c7ef89becfbded2dfb296b459a4e2ed9ca0d738a0d79cdaa72b4a', '[\"*\"]', NULL, NULL, '2026-05-25 07:14:16', '2026-05-25 07:14:16'),
(65, 'App\\Models\\User', 9, 'auth_token', '3c4c8f8e53af835e3a2b7f1e8ee7c8d9fb7d725585f6a71524571f907e2bd0a7', '[\"*\"]', '2026-05-25 07:16:40', NULL, '2026-05-25 07:14:46', '2026-05-25 07:16:40'),
(66, 'App\\Models\\User', 10, 'auth_token', '26a88baea60ad66a4d9d587647b66e9c5c0cf5149d904bb48f2c1d2069cd1793', '[\"*\"]', '2026-05-25 07:18:12', NULL, '2026-05-25 07:17:32', '2026-05-25 07:18:12'),
(67, 'App\\Models\\User', 9, 'auth_token', 'f3e8636bfa660d236e8b32eeec63797abae527716ac5ead348670b7c9d236cad', '[\"*\"]', '2026-05-25 07:18:47', NULL, '2026-05-25 07:18:28', '2026-05-25 07:18:47'),
(68, 'App\\Models\\User', 10, 'auth_token', '0de49e793f8063f7ad412fe364ba9e26053ab0cc24d7b5f9692eea4613bc0aee', '[\"*\"]', '2026-05-25 07:19:16', NULL, '2026-05-25 07:19:05', '2026-05-25 07:19:16'),
(70, 'App\\Models\\User', 9, 'auth_token', '9c319ff6b024213234fea5f4a8b185934a299e2aa07606f487e3364fbfdef7e0', '[\"*\"]', '2026-05-25 07:25:00', NULL, '2026-05-25 07:21:13', '2026-05-25 07:25:00'),
(71, 'App\\Models\\User', 11, 'auth_token', '1910c1aa0568bb1a475daae39b2e31417cdb25760a1b5483ea0e3ea291f1502f', '[\"*\"]', '2026-05-25 07:57:39', NULL, '2026-05-25 07:26:36', '2026-05-25 07:57:39'),
(72, 'App\\Models\\User', 8, 'auth_token', '1e8c7990d534dbc87675c9110423472e605a73a13f03a6e551bb1a807a6013de', '[\"*\"]', NULL, NULL, '2026-05-25 07:38:37', '2026-05-25 07:38:37');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`) VALUES
(1, 'User'),
(2, 'Owner'),
(3, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED DEFAULT NULL,
  `room_name` varchar(100) NOT NULL,
  `price_per_month` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `room_status` enum('available','occupied') NOT NULL DEFAULT 'available',
  `address_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_approved` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`room_id`, `owner_id`, `room_name`, `price_per_month`, `description`, `room_status`, `address_id`, `created_at`, `is_approved`) VALUES
(9, 9, 'NoMercy', 100.00, 'roomss', 'occupied', 17, '2026-05-18 03:54:30', 1),
(10, 9, 'no mercy', 200.00, 'gg', 'available', 18, '2026-05-18 04:30:51', 1),
(15, 9, 'Test', 200.00, 'no more', 'available', 24, '2026-05-25 07:22:50', 1),
(16, 11, 'no_more', 100.00, '1', 'available', 26, '2026-05-25 07:27:31', 1),
(17, 11, 'ho', 100.00, 'as', 'available', 27, '2026-05-25 07:57:37', 1);

-- --------------------------------------------------------

--
-- Table structure for table `room_amenity`
--

CREATE TABLE `room_amenity` (
  `room_id` bigint(20) UNSIGNED NOT NULL,
  `amenity_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_amenity`
--

INSERT INTO `room_amenity` (`room_id`, `amenity_id`) VALUES
(9, 2),
(9, 4),
(9, 5),
(10, 10),
(15, 2),
(15, 3),
(16, 2),
(17, 4);

-- --------------------------------------------------------

--
-- Table structure for table `room_image`
--

CREATE TABLE `room_image` (
  `image_id` bigint(20) UNSIGNED NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `room_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `room_image`
--

INSERT INTO `room_image` (`image_id`, `image_url`, `room_id`, `is_main`) VALUES
(32, 'rooms/akoeNQDpP3rdXaMek3BgF5fnVF0JpCQlWGuOieT1.jpg', 9, 0),
(37, 'rooms/d1Ye5pHO8UDrdK8UoavfzzGIkYytFU5x4Cx78wse.jpg', 15, 0),
(38, 'rooms/Nu1ggqtn4eCgysMYk3yHeiS0mFZy5LrbS0F313lr.jpg', 15, 0),
(39, 'rooms/b49b6JaBOO2uY5H0rQ26ZG41cVImTcx7KbLDKtf3.jpg', 9, 0),
(44, 'rooms/6a146340d14eb_1779721024.jpg', 16, 0),
(45, 'rooms/6a146361b06cc_1779721057.jpg', 17, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `address_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `name`, `email`, `password`, `phone`, `age`, `gender`, `role_id`, `address_id`, `created_at`, `updated_at`) VALUES
(8, 'Administrator', 'admin@mail.com', '$2y$12$ouEch8HoDd17ffHeJu9jRO5rgCyM17wKyn5JHjURHuANEzx0h8g4q', '02099999999', 30, 'Other', 3, NULL, '2026-05-18 02:44:32', '2026-05-18 02:44:32'),
(9, 'lala', 'lala@gmail.com', '$2y$12$eWwNdpSvP02uX01xekCM.emaWrQnUidZa/WJav6WnfqiCVYBnbWCy', '2098284603', 25, 'Male', 2, 16, '2026-05-18 03:53:27', '2026-05-24 23:18:34'),
(10, 'Jojo', 'jojo@gmail.com', '$2y$12$xTGgSVIVmpmkgsn2kW2TOuozm2K59U5q8zHWaliC8avjh2SmCMW6S', '2098284603', 15, 'Male', 1, 23, '2026-05-25 07:17:32', '2026-05-25 07:17:32'),
(11, 'Mama', 'mama@gmail.com', '$2y$12$nsylmB22oejMePAHYQPNb.MHE9C6izCEaoJMviFuPdjUR.SHlqjha', '2098284603', 30, 'Female', 2, 25, '2026-05-25 07:26:36', '2026-05-25 07:26:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `amenity`
--
ALTER TABLE `amenity`
  ADD PRIMARY KEY (`amenity_id`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `booking_tenant_id_foreign` (`tenant_id`),
  ADD KEY `booking_room_id_foreign` (`room_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `room_owner_id_foreign` (`owner_id`),
  ADD KEY `room_address_id_foreign` (`address_id`);

--
-- Indexes for table `room_amenity`
--
ALTER TABLE `room_amenity`
  ADD PRIMARY KEY (`room_id`,`amenity_id`),
  ADD KEY `room_amenity_amenity_id_foreign` (`amenity_id`);

--
-- Indexes for table `room_image`
--
ALTER TABLE `room_image`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `room_image_room_id_foreign` (`room_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_email_unique` (`email`),
  ADD KEY `user_role_id_foreign` (`role_id`),
  ADD KEY `user_address_id_foreign` (`address_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `amenity`
--
ALTER TABLE `amenity`
  MODIFY `amenity_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `room_image`
--
ALTER TABLE `room_image`
  MODIFY `image_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `booking_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `room_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `user` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `room_amenity`
--
ALTER TABLE `room_amenity`
  ADD CONSTRAINT `room_amenity_amenity_id_foreign` FOREIGN KEY (`amenity_id`) REFERENCES `amenity` (`amenity_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `room_amenity_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE CASCADE;

--
-- Constraints for table `room_image`
--
ALTER TABLE `room_image`
  ADD CONSTRAINT `room_image_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE CASCADE;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  ADD CONSTRAINT `user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
