DROP DATABASE IF EXISTS `pufferpanel`;
CREATE DATABASE IF NOT EXISTS `pufferpanel`
USE `pufferpanel`;

CREATE TABLE IF NOT EXISTS `locations` (
  `id` binary(16) NOT NULL DEFAULT 'UUID()',
  `code` varchar(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `nodes` (
  `id` binary(16) NOT NULL DEFAULT 'UUID()',
  `location_id` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__locations` (`location_id`),
  CONSTRAINT `FK__locations` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `servers` (
  `id` binary(16) NOT NULL DEFAULT 'UUID()',
  `node_id` binary(16) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sftp_id` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__nodes` (`node_id`),
  CONSTRAINT `FK__nodes` FOREIGN KEY (`node_id`) REFERENCES `nodes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` binary(12) NOT NULL DEFAULT 'UUID()',
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` binary(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;