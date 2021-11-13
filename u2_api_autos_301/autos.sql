-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-06-2021 a las 17:04:53
-- Versión del servidor: 10.4.19-MariaDB
-- Versión de PHP: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `api_autos`
--

--
-- Volcado de datos para la tabla `autos`
--

INSERT INTO `autos` (`patente`, `modelo`, `precio`, `marca_id`) VALUES
('FFBG56', 'Sail', 6590000, 1),
('BDPK11', 'Spark GT', 7990000, 1),
('LVBD38', 'Morning', 7990000, 3),
('RDHW93', 'Rio 5', 11290000, 3),
('CCDL07', 'Sportage', 17990000, 3),
('HHYL56', 'Ranger Raptor', 40790000, 4),
('KBTR12', 'Santa Fe', 22490000, 5),
('JLYY67', 'Accent', 9990000, 5),
('LKRT34', 'Mazda 3', 13990000, 6),
('BHTF55', 'CX-5', 18990000, 6),
('FFPL26', 'Rav4', 16390000, 8),
('KLFX99', 'Corolla', 13990000, 8),
('BYBR99', 'L200', 19590000, 10);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
