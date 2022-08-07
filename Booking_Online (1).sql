-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 07 Agu 2022 pada 08.56
-- Versi server: 10.4.8-MariaDB
-- Versi PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Booking_Online`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `airports`
--

CREATE TABLE `airports` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `airport_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `airports`
--

INSERT INTO `airports` (`id`, `code`, `city`, `airport_name`, `created_at`, `updated_at`) VALUES
(1, 'vfyQq', 'Aliviastad', 'Waldo Airport', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(2, 'X4j20', 'East Jarred', 'Jakayla Airport', '2022-08-06 14:38:38', '2022-08-06 14:38:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `bank`, `account_name`, `account_number`, `created_at`, `updated_at`) VALUES
(1, 'BCA', 'EzGooBCA', '30639', '2022-08-06 14:38:34', '2022-08-06 14:38:34'),
(2, 'BRI', 'EzGooBRI', '85557', '2022-08-06 14:38:34', '2022-08-06 14:38:34'),
(3, 'Mandiri', 'EzGooMandiri', '33806', '2022-08-06 14:38:34', '2022-08-06 14:38:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `bookings`
--

CREATE TABLE `bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `booking_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vehicle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bill` decimal(10,2) NOT NULL,
  `expire` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `schedule_id`, `booking_code`, `vehicle`, `bill`, `expire`, `created_at`, `updated_at`) VALUES
(1, 1, 21, 'WIKb', 'train', '5561.00', '2022-08-07 20:30:05', '2022-08-07 05:30:05', '2022-08-07 05:30:05'),
(2, 1, 22, 'OaNF', 'train', '150666.00', '2022-08-07 21:49:40', '2022-08-07 06:49:40', '2022-08-07 06:49:40'),
(3, 1, 22, 't9tu', 'train', '150666.00', '2022-08-07 21:49:41', '2022-08-07 06:49:41', '2022-08-07 06:49:41'),
(4, 1, 22, 'H9tI', 'train', '150666.00', '2022-08-07 21:49:41', '2022-08-07 06:49:41', '2022-08-07 06:49:41');

--
-- Trigger `bookings`
--
DELIMITER $$
CREATE TRIGGER `restore_booking` BEFORE DELETE ON `bookings` FOR EACH ROW BEGIN
          SET @oldP = (SELECT passenger FROM detail_bookings WHERE booking_id = OLD.id);
          SET @oldC = (SELECT class FROM detail_bookings WHERE booking_id = OLD.id);
          IF old.vehicle = 'plane' THEN
            IF @oldC = 'eco_seat' THEN
              UPDATE plane_schedules SET eco_seat = eco_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'bus_seat' THEN
              UPDATE plane_schedules SET bus_seat = bus_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'first_seat' THEN
              UPDATE plane_schedules SET first_seat = first_seat + @oldP WHERE id = OLD.schedule_id;
            END IF;
          ELSEIF old.vehicle = 'train' THEN
            IF @oldC = 'eco_seat' THEN
              UPDATE train_schedules SET eco_seat = eco_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'bus_seat' THEN
              UPDATE train_schedules SET bus_seat = bus_seat + @oldP WHERE id = OLD.schedule_id;
            ELSEIF @oldC = 'exec_seat' THEN
              UPDATE train_schedules SET exec_seat = exec_seat + @oldP WHERE id = OLD.schedule_id;
            END IF;
          END IF;
        END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `detail_bookings`
--

CREATE TABLE `detail_bookings` (
  `id` int(10) UNSIGNED NOT NULL,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `passenger` int(11) NOT NULL,
  `class` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `detail_bookings`
--

INSERT INTO `detail_bookings` (`id`, `booking_id`, `passenger`, `class`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'eco_seat', '2022-08-07 05:30:05', '2022-08-07 05:30:05'),
(2, 2, 1, 'bus_seat', '2022-08-07 06:49:40', '2022-08-07 06:49:40'),
(3, 3, 1, 'bus_seat', '2022-08-07 06:49:41', '2022-08-07 06:49:41'),
(4, 4, 1, 'bus_seat', '2022-08-07 06:49:41', '2022-08-07 06:49:41');

-- --------------------------------------------------------

--
-- Struktur dari tabel `groups`
--

CREATE TABLE `groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `groups`
--

INSERT INTO `groups` (`id`, `group`, `created_at`, `updated_at`) VALUES
(1, 'member', '2022-08-06 14:38:33', '2022-08-06 14:38:33'),
(2, 'admin', '2022-08-06 14:38:33', '2022-08-06 14:38:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `group_user`
--

CREATE TABLE `group_user` (
  `id` int(10) UNSIGNED NOT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `group_user`
--

INSERT INTO `group_user` (`id`, `group_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2022-08-06 14:38:34', '2022-08-06 14:38:34'),
(2, 2, 2, '2022-08-06 14:38:34', '2022-08-06 14:38:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_100001_create_groups_table', 1),
(4, '2014_10_12_100002_create_group_user_table', 1),
(5, '2018_01_25_154144_create_bookings_table', 1),
(6, '2018_01_25_154250_create_detail_bookings_table', 1),
(7, '2018_01_25_154251_create_transactions_table', 1),
(8, '2018_01_25_154314_create_passengers_table', 1),
(9, '2018_01_25_154441_create_planes_table', 1),
(10, '2018_01_25_154442_create_plane_fares_table', 1),
(11, '2018_01_25_154443_create_airports_table', 1),
(12, '2018_01_25_154453_create_plane_schedules_table', 1),
(13, '2018_02_11_150535_create_trains_table', 1),
(14, '2018_02_11_150536_create_train_stations', 1),
(15, '2018_02_11_150537_create_train_fares', 1),
(16, '2018_02_11_150620_create_train_schedules', 1),
(17, '2018_02_21_084438_create_bank_accounts_table', 1),
(18, '2018_03_10_210210_create_trigger_booking', 1),
(19, '2022_08_06_213539_entrust_setup_tables', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `passengers`
--

CREATE TABLE `passengers` (
  `id` int(10) UNSIGNED NOT NULL,
  `detail_booking_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `passengers`
--

INSERT INTO `passengers` (`id`, `detail_booking_id`, `name`, `created_at`, `updated_at`) VALUES
(1, 1, 'denis sAPUTRA', '2022-08-07 05:30:05', '2022-08-07 05:30:05'),
(2, 2, 'Afiffudin', '2022-08-07 06:49:40', '2022-08-07 06:49:40'),
(3, 3, 'Afiffudin', '2022-08-07 06:49:41', '2022-08-07 06:49:41'),
(4, 4, 'Afiffudin', '2022-08-07 06:49:41', '2022-08-07 06:49:41');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `planes`
--

CREATE TABLE `planes` (
  `id` int(10) UNSIGNED NOT NULL,
  `plane_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `first_seat` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `planes`
--

INSERT INTO `planes` (`id`, `plane_name`, `eco_seat`, `bus_seat`, `first_seat`, `created_at`, `updated_at`) VALUES
(1, 'Plane Abbey', 20, 8, 14, '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(2, 'Plane Brooklyn', 4, 18, 6, '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(3, 'Plane Dayne', 4, 16, 11, '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(4, 'Plane Bridget', 12, 16, 10, '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(5, 'Plane Beryl', 7, 4, 6, '2022-08-06 14:38:38', '2022-08-06 14:38:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `plane_fares`
--

CREATE TABLE `plane_fares` (
  `id` int(10) UNSIGNED NOT NULL,
  `plane_id` int(10) UNSIGNED NOT NULL,
  `eco_seat` decimal(10,2) NOT NULL,
  `bus_seat` decimal(10,2) NOT NULL,
  `first_seat` decimal(10,2) NOT NULL,
  `unique_code` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `plane_fares`
--

INSERT INTO `plane_fares` (`id`, `plane_id`, `eco_seat`, `bus_seat`, `first_seat`, `unique_code`, `created_at`, `updated_at`) VALUES
(1, 1, '10000.00', '10000.00', '10000.00', '657.00', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(2, 2, '10000.00', '10000.00', '10000.00', '410.00', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(3, 3, '15000.00', '15000.00', '15000.00', '142.00', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(4, 4, '15000.00', '15000.00', '15000.00', '385.00', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(5, 5, '5000.00', '5000.00', '5000.00', '588.00', '2022-08-06 14:38:39', '2022-08-06 14:38:39');

-- --------------------------------------------------------

--
-- Struktur dari tabel `plane_schedules`
--

CREATE TABLE `plane_schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `airport_id` int(10) UNSIGNED NOT NULL,
  `plane_id` int(10) UNSIGNED NOT NULL,
  `from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `first_seat` int(11) NOT NULL,
  `boarding_time` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `gate` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `plane_schedules`
--

INSERT INTO `plane_schedules` (`id`, `airport_id`, `plane_id`, `from`, `destination`, `from_code`, `destination_code`, `eco_seat`, `bus_seat`, `first_seat`, `boarding_time`, `duration`, `gate`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 'Waldo Airport', 'Jakayla Airport', 'vfyQq', 'X4j20', 8, 7, 4, '2018-07-06 21:38:39', 56, '40', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(2, 1, 3, 'Waldo Airport', 'Jakayla Airport', 'vfyQq', 'X4j20', 8, 6, 4, '2018-05-13 21:38:39', 96, '34', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(3, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 7, 3, 9, '2018-06-09 21:38:39', 18, '29', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(4, 2, 5, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 6, 6, 1, '2018-05-25 21:38:39', 44, '53', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(5, 2, 3, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 7, 2, 7, '2018-06-18 21:38:39', 74, '50', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(6, 1, 3, 'Waldo Airport', 'Jakayla Airport', 'vfyQq', 'X4j20', 8, 1, 6, '2018-06-19 21:38:39', 40, '11', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(7, 2, 2, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 6, 7, 10, '2018-07-11 21:38:39', 5, '89', '2022-08-06 14:38:39', '2022-08-06 14:38:39'),
(8, 2, 1, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 5, 2, 5, '2018-05-27 21:38:39', 22, '82', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(9, 1, 1, 'Waldo Airport', 'Jakayla Airport', 'vfyQq', 'X4j20', 10, 6, 9, '2018-06-02 21:38:39', 40, '49', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(10, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 9, 6, 5, '2018-06-12 21:38:39', 86, '33', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(11, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 3, 5, 1, '2018-06-13 21:38:39', 21, '12', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(12, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 7, 5, 3, '2018-06-11 21:38:39', 9, '63', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(13, 2, 1, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 4, 1, 6, '2018-06-15 21:38:39', 46, '9', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(14, 2, 2, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 5, 2, 1, '2018-05-31 21:38:39', 68, '69', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(15, 1, 4, 'Waldo Airport', 'Jakayla Airport', 'vfyQq', 'X4j20', 5, 6, 6, '2018-05-30 21:38:39', 36, '11', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(16, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 3, 7, 8, '2018-06-26 21:38:39', 2, '72', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(17, 2, 5, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 8, 5, 7, '2018-07-11 21:38:39', 79, '31', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(18, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 10, 10, 4, '2018-06-04 21:38:39', 78, '29', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(19, 1, 1, 'Waldo Airport', 'Jakayla Airport', 'vfyQq', 'X4j20', 6, 4, 3, '2018-06-11 21:38:39', 19, '99', '2022-08-06 14:38:40', '2022-08-06 14:38:40'),
(20, 2, 4, 'Jakayla Airport', 'Waldo Airport', 'X4j20', 'vfyQq', 6, 8, 1, '2018-06-08 21:38:39', 21, '52', '2022-08-06 14:38:40', '2022-08-06 14:38:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Member EzGoo', 'Administration', 'Only one and only admin', '2022-08-06 14:46:18', '2022-08-06 14:46:18'),
(2, 'user', 'Registed User', 'Access for registed user', '2022-08-06 14:46:18', '2022-08-06 14:46:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `role_user`
--

CREATE TABLE `role_user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `role_user`
--

INSERT INTO `role_user` (`user_id`, `role_id`) VALUES
(1, 1),
(2, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `trains`
--

CREATE TABLE `trains` (
  `id` int(10) UNSIGNED NOT NULL,
  `train_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `exec_seat` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `trains`
--

INSERT INTO `trains` (`id`, `train_name`, `eco_seat`, `bus_seat`, `exec_seat`, `created_at`, `updated_at`) VALUES
(1, 'Agro Melati', 13, 2, 10, '2022-08-06 14:38:34', '2022-08-07 06:24:18'),
(2, 'Agro Parahyangan', 20, 4, 18, '2022-08-06 14:38:34', '2022-08-07 06:24:55'),
(3, 'Agro Balapan', 4, 1, 17, '2022-08-06 14:38:34', '2022-08-07 06:25:25'),
(4, 'Agra Kencana', 11, 12, 3, '2022-08-06 14:38:34', '2022-08-07 06:26:02'),
(5, 'Agro Bromo Anggrek Pagi', 5, 16, 5, '2022-08-06 14:38:34', '2022-08-07 06:27:53'),
(6, 'Agro Lawu', 15, 13, 13, '2022-08-06 14:38:34', '2022-08-07 06:28:32'),
(7, 'Agro Sindoro', 13, 16, 11, '2022-08-06 14:38:35', '2022-08-07 06:29:39'),
(8, 'Agro Jati Fakulatif', 5, 9, 8, '2022-08-06 14:38:35', '2022-08-07 06:30:36'),
(9, 'Gajayana', 12, 19, 9, '2022-08-06 14:38:35', '2022-08-07 06:31:19'),
(10, 'Jayabaya', 10, 7, 10, '2022-08-06 14:38:35', '2022-08-07 06:32:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `train_fares`
--

CREATE TABLE `train_fares` (
  `id` int(10) UNSIGNED NOT NULL,
  `train_id` int(10) UNSIGNED NOT NULL,
  `eco_seat` decimal(10,2) NOT NULL,
  `bus_seat` decimal(10,2) NOT NULL,
  `exec_seat` decimal(10,2) NOT NULL,
  `unique_code` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `train_fares`
--

INSERT INTO `train_fares` (`id`, `train_id`, `eco_seat`, `bus_seat`, `exec_seat`, `unique_code`, `created_at`, `updated_at`) VALUES
(1, 1, '120000.00', '150000.00', '250000.00', '666.00', '2022-08-06 14:38:35', '2022-08-07 06:24:18'),
(2, 2, '170000.00', '180000.00', '190000.00', '714.00', '2022-08-06 14:38:35', '2022-08-07 06:24:55'),
(3, 3, '100000.00', '150000.00', '170000.00', '590.00', '2022-08-06 14:38:35', '2022-08-07 06:25:25'),
(4, 4, '250000.00', '285000.00', '295000.00', '601.00', '2022-08-06 14:38:35', '2022-08-07 06:26:02'),
(5, 5, '186000.00', '198000.00', '200000.00', '561.00', '2022-08-06 14:38:35', '2022-08-07 06:27:53'),
(6, 6, '275000.00', '295000.00', '315000.00', '400.00', '2022-08-06 14:38:36', '2022-08-07 06:28:32'),
(7, 7, '2150000.00', '3150000.00', '3170000.00', '783.00', '2022-08-06 14:38:36', '2022-08-07 06:29:39'),
(8, 8, '219000.00', '2192000.00', '315000.00', '574.00', '2022-08-06 14:38:36', '2022-08-07 06:30:36'),
(9, 9, '265000.00', '295000.00', '375000.00', '963.00', '2022-08-06 14:38:36', '2022-08-07 06:31:19'),
(10, 10, '315000.00', '317000.00', '319000.00', '437.00', '2022-08-06 14:38:36', '2022-08-07 06:32:15');

-- --------------------------------------------------------

--
-- Struktur dari tabel `train_schedules`
--

CREATE TABLE `train_schedules` (
  `id` int(10) UNSIGNED NOT NULL,
  `station_id` int(10) UNSIGNED NOT NULL,
  `train_id` int(10) UNSIGNED NOT NULL,
  `from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `destination_code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `boarding_time` datetime NOT NULL,
  `duration` int(11) NOT NULL,
  `eco_seat` int(11) NOT NULL,
  `bus_seat` int(11) NOT NULL,
  `exec_seat` int(11) NOT NULL,
  `platform` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `train_schedules`
--

INSERT INTO `train_schedules` (`id`, `station_id`, `train_id`, `from`, `destination`, `from_code`, `destination_code`, `boarding_time`, `duration`, `eco_seat`, `bus_seat`, `exec_seat`, `platform`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-11 21:38:36', 1334, 9, 9, 9, '8', '2022-08-06 14:38:36', '2022-08-06 14:38:36'),
(2, 2, 4, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-06-22 21:38:36', 1707, 10, 1, 8, '92', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(3, 1, 9, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-19 21:38:36', 1378, 4, 7, 10, '26', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(4, 1, 9, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-04 21:38:36', 1367, 2, 6, 8, '77', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(5, 2, 10, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-06-12 21:38:36', 1399, 2, 6, 1, '29', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(6, 2, 9, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-06-02 21:38:36', 1283, 8, 6, 8, '10', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(7, 2, 7, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-05-30 21:38:36', 1333, 4, 8, 8, '96', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(8, 1, 10, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-08 21:38:36', 1113, 8, 1, 10, '94', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(9, 1, 9, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-05-25 21:38:36', 1394, 2, 4, 2, '37', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(11, 2, 9, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-06-15 21:38:36', 1673, 3, 9, 8, '43', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(12, 2, 3, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-06-08 21:38:36', 1642, 8, 10, 4, '96', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(13, 2, 8, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-05-13 21:38:36', 1588, 3, 1, 2, '98', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(14, 2, 5, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-07-01 21:38:36', 1835, 5, 6, 6, '35', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(15, 1, 8, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-07-05 21:38:36', 1108, 9, 6, 1, '40', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(16, 1, 8, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-10 21:38:36', 1939, 5, 3, 4, '10', '2022-08-06 14:38:37', '2022-08-06 14:38:37'),
(17, 2, 6, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-07-03 21:38:36', 1601, 10, 10, 10, '91', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(18, 1, 8, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-28 21:38:36', 1232, 4, 8, 7, '24', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(19, 1, 8, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2018-06-14 21:38:36', 1561, 6, 10, 7, '31', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(20, 2, 7, 'Collinston Station', 'Eltonshire Station', 'QTJQK', 'sbhVB', '2018-06-20 21:38:36', 1595, 6, 10, 4, '92', '2022-08-06 14:38:38', '2022-08-06 14:38:38'),
(21, 1, 5, 'Eltonshire Station', 'Collinston Station', 'sbhVB', 'QTJQK', '2022-08-08 00:00:00', 1659726300, 4, 16, 5, 'G26', '2022-08-06 14:48:41', '2022-08-07 05:30:05'),
(22, 3, 1, 'Pasar Sene', 'Jombang', 'PSS', 'JMB', '2022-08-09 01:03:59', 1659859200, 13, -1, 10, 'PS72', '2022-08-07 06:33:37', '2022-08-07 06:49:41'),
(23, 4, 2, 'Jombang', 'Pasar Sene', 'JMB', 'PSS', '2022-08-10 06:03:00', 1659875580, 20, 4, 18, 'PS73', '2022-08-07 06:34:28', '2022-08-07 06:34:28'),
(24, 3, 5, 'Pasar Sene', 'Batu Urip', 'PSS', 'JMB', '2022-08-11 04:00:00', 1659829140, 5, 16, 5, 'J2', '2022-08-07 06:35:26', '2022-08-07 06:35:26'),
(25, 5, 5, 'Batu Urip', 'Pasar Sene', 'JMB', 'PSS', '2022-08-12 19:00:00', 1659869220, 3, 16, 5, '3', '2022-08-07 06:36:32', '2022-08-07 06:51:36');

-- --------------------------------------------------------

--
-- Struktur dari tabel `train_stations`
--

CREATE TABLE `train_stations` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `station_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `train_stations`
--

INSERT INTO `train_stations` (`id`, `code`, `city`, `station_name`, `created_at`, `updated_at`) VALUES
(1, 'sbhVB', 'North Ramiroborough', 'Eltonshire Station', '2022-08-06 14:38:35', '2022-08-06 14:38:35'),
(2, 'QTJQK', 'Lake Lyricville', 'Collinston Station', '2022-08-06 14:38:35', '2022-08-06 14:38:35'),
(3, 'PSS', 'JAKARTA PUSAT', 'Pasar Sene', '2022-08-07 06:22:50', '2022-08-07 06:22:50'),
(4, 'JMB', 'Jawa Timur', 'Jombang', '2022-08-07 06:23:12', '2022-08-07 06:23:12'),
(5, 'JMB', 'Jember Jawa TImur', 'Batu Urip', '2022-08-07 06:23:34', '2022-08-07 06:23:34');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `booking_id` int(10) UNSIGNED NOT NULL,
  `bank` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ammount` decimal(10,2) DEFAULT NULL,
  `receipt` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `transactions`
--

INSERT INTO `transactions` (`id`, `booking_id`, `bank`, `sender_name`, `ammount`, `receipt`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'BCA', 'Wikb', '5561.00', NULL, 1, '2022-08-07 05:30:05', '2022-08-07 06:07:34'),
(2, 2, 'BCA', NULL, NULL, NULL, 0, '2022-08-07 06:49:40', '2022-08-07 06:49:40'),
(3, 3, 'BCA', NULL, NULL, NULL, 0, '2022-08-07 06:49:41', '2022-08-07 06:49:41'),
(4, 4, 'BCA', 'AFIFFUDIN', '150666.00', NULL, 1, '2022-08-07 06:49:41', '2022-08-07 06:53:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` enum('Tuan','Nyonya','Nona') COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  `verification_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `first_name`, `last_name`, `title`, `phone`, `email`, `password`, `verified`, `verification_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Member ', 'Member', 'Travel', 'Tuan', '082220279970', 'member@member.com', '$2y$10$fHG1kWKzWsNnZ25ZgtuLR.c//Jqsk1Rsqio0r1WXPfZ5uZHCzuZ1u', 1, '123tokenm', '7aUP1gXOiJvrCWnmLfjg845XMND7UT3gtuWfhOeTsKPHEo85Ppl5Ie6vEUvT', '2022-08-06 14:38:34', '2022-08-06 14:38:34'),
(2, 'Admin ', 'Admin', 'Travel', 'Tuan', '082220279970', 'admin@admin.com', '$2y$10$cQsVHrxLF3vhIoXZ75dN/uc4NsQtuH7GIYJfZC3putQk2VvU1wHM.', 1, '123tokena', 'nD0LqK64VO76OItiVvTKMH05snVrnXc6d1l4i3lSdGBC5JclaEGk0i4DOqwJ', '2022-08-06 14:38:34', '2022-08-06 14:38:34');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `airports`
--
ALTER TABLE `airports`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `detail_bookings`
--
ALTER TABLE `detail_bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `detail_bookings_booking_id_foreign` (`booking_id`);

--
-- Indeks untuk tabel `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `group_user`
--
ALTER TABLE `group_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_user_group_id_foreign` (`group_id`),
  ADD KEY `group_user_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `passengers_detail_booking_id_foreign` (`detail_booking_id`);

--
-- Indeks untuk tabel `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_unique` (`name`);

--
-- Indeks untuk tabel `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `planes`
--
ALTER TABLE `planes`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `plane_fares`
--
ALTER TABLE `plane_fares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plane_fares_plane_id_foreign` (`plane_id`);

--
-- Indeks untuk tabel `plane_schedules`
--
ALTER TABLE `plane_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plane_schedules_plane_id_foreign` (`plane_id`),
  ADD KEY `plane_schedules_airport_id_foreign` (`airport_id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indeks untuk tabel `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_user_role_id_foreign` (`role_id`);

--
-- Indeks untuk tabel `trains`
--
ALTER TABLE `trains`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `train_fares`
--
ALTER TABLE `train_fares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `train_fares_train_id_foreign` (`train_id`);

--
-- Indeks untuk tabel `train_schedules`
--
ALTER TABLE `train_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `train_schedules_train_id_foreign` (`train_id`),
  ADD KEY `train_schedules_station_id_foreign` (`station_id`);

--
-- Indeks untuk tabel `train_stations`
--
ALTER TABLE `train_stations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_booking_id_foreign` (`booking_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `airports`
--
ALTER TABLE `airports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `detail_bookings`
--
ALTER TABLE `detail_bookings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `group_user`
--
ALTER TABLE `group_user`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `passengers`
--
ALTER TABLE `passengers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `planes`
--
ALTER TABLE `planes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `plane_fares`
--
ALTER TABLE `plane_fares`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `plane_schedules`
--
ALTER TABLE `plane_schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `trains`
--
ALTER TABLE `trains`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `train_fares`
--
ALTER TABLE `train_fares`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `train_schedules`
--
ALTER TABLE `train_schedules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `train_stations`
--
ALTER TABLE `train_stations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `detail_bookings`
--
ALTER TABLE `detail_bookings`
  ADD CONSTRAINT `detail_bookings_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `group_user`
--
ALTER TABLE `group_user`
  ADD CONSTRAINT `group_user_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `group_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `passengers`
--
ALTER TABLE `passengers`
  ADD CONSTRAINT `passengers_detail_booking_id_foreign` FOREIGN KEY (`detail_booking_id`) REFERENCES `detail_bookings` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `plane_fares`
--
ALTER TABLE `plane_fares`
  ADD CONSTRAINT `plane_fares_plane_id_foreign` FOREIGN KEY (`plane_id`) REFERENCES `planes` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `plane_schedules`
--
ALTER TABLE `plane_schedules`
  ADD CONSTRAINT `plane_schedules_airport_id_foreign` FOREIGN KEY (`airport_id`) REFERENCES `airports` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `plane_schedules_plane_id_foreign` FOREIGN KEY (`plane_id`) REFERENCES `planes` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `train_fares`
--
ALTER TABLE `train_fares`
  ADD CONSTRAINT `train_fares_train_id_foreign` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `train_schedules`
--
ALTER TABLE `train_schedules`
  ADD CONSTRAINT `train_schedules_station_id_foreign` FOREIGN KEY (`station_id`) REFERENCES `train_stations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `train_schedules_train_id_foreign` FOREIGN KEY (`train_id`) REFERENCES `trains` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_booking_id_foreign` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
