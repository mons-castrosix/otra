-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-07-2022 a las 17:02:43
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `grupoabrasan`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_bodega`
--

CREATE TABLE `app_bodega` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `ubicacion` varchar(600) NOT NULL,
  `encargado` varchar(300) NOT NULL,
  `obra_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_bodegaproductos`
--

CREATE TABLE `app_bodegaproductos` (
  `id` bigint(20) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `minimo` int(11) DEFAULT NULL,
  `bodega_id` bigint(20) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `ubicacion` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_compra`
--

CREATE TABLE `app_compra` (
  `id` bigint(20) NOT NULL,
  `compra` int(11) DEFAULT NULL,
  `solicitud_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_customuser`
--

CREATE TABLE `app_customuser` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `user_type` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `app_customuser`
--

INSERT INTO `app_customuser` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `user_type`) VALUES
(1, 'pbkdf2_sha256$320000$504Hsf4aWgsGhSRIn5ah4p$/wlynU/crId7PnNsA9/mlNPn98r2LHLrFh7+W7Fb+M8=', '2022-07-13 14:59:43.590692', 1, 'Adriana', '', '', 'adriana@gmail.com', 1, 1, '2022-07-13 00:53:57.915957', NULL),
(2, 'pbkdf2_sha256$320000$mRdGAzZcobHDMRZt2s5tvT$wkN6yqWaUizj6fg0IsX630hD8I2oOrliSp7qEssugww=', '2022-07-13 15:02:32.913997', 0, 'Bodega', '', '', '', 0, 1, '2022-07-13 13:51:55.403956', 2),
(3, 'pbkdf2_sha256$320000$cJEFZtggKqDSqp8uk7CITn$AMx50ybbzvzzJjtY21vCCGbEgZOX3KzmUzIU1aY0uqQ=', '2022-07-13 13:54:21.606759', 0, 'Residente', '', '', '', 0, 1, '2022-07-13 13:52:13.462652', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_customuser_groups`
--

CREATE TABLE `app_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `app_customuser_groups`
--

INSERT INTO `app_customuser_groups` (`id`, `customuser_id`, `group_id`) VALUES
(1, 2, 1),
(2, 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_customuser_user_permissions`
--

CREATE TABLE `app_customuser_user_permissions` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_insumos`
--

CREATE TABLE `app_insumos` (
  `id` bigint(20) NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `bodegaproducto_id` bigint(20) DEFAULT NULL,
  `obra_id` bigint(20) NOT NULL,
  `villa_id` bigint(20) NOT NULL,
  `notas` varchar(800) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_obra`
--

CREATE TABLE `app_obra` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(300) NOT NULL,
  `ubicacion` varchar(300) NOT NULL,
  `total_villas` int(11) DEFAULT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_producto`
--

CREATE TABLE `app_producto` (
  `id` int(11) NOT NULL,
  `clave` varchar(30) NOT NULL,
  `categoria` varchar(80) NOT NULL,
  `descripcion` varchar(200) NOT NULL,
  `proveedor` varchar(500) NOT NULL,
  `unidad` varchar(50) NOT NULL,
  `disp` int(11) DEFAULT NULL,
  `minimo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `app_producto`
--

INSERT INTO `app_producto` (`id`, `clave`, `categoria`, `descripcion`, `proveedor`, `unidad`, `disp`, `minimo`) VALUES
(1, 'INV-1', '1', 'TINACO IUSA TRICAPA C/ACCESORIOS S/ FILTRO BEIGE 1100 L', 'MATERAMA', '1', 0, 0),
(2, 'INV-2', '1', 'HIDRONEUMATICO 1 HP  52 LITROS (TINACO)', 'HOMEDEPOT', '1', 0, 0),
(3, 'INV-3', '1', 'FLOTADOR ELECTRICO PARA TINACO 15 A  A 127 V 2 METROS DE LONGITUD MARCA EVANS', 'BOXITIO', '1', 0, 0),
(4, 'INV-4', '1', 'BOMBA RECIRCULADORA PARA PISCINA MARCA ACUPAK SERIE SILVER 3/4 HP 115 V', 'BRUNI', '1', 0, 0),
(5, 'INV-5', '1', 'CLIMAS  INVERTER DE 1 TONELADA 220 V', 'BOXITIO', '1', 0, 0),
(6, 'INV-6', '1', 'CLIMAS  INVERTER DE 2 TONELADA 220 V', 'BOXITIO', '1', 0, 0),
(7, 'INV-7', '1', 'BOMBA SUMERGIBLE CJA CONTRO 1/2 HP/ OAKBS1250 4SDM2/3 (HP/4SDM2/5)', 'BOXITIO', '1', 0, 0),
(8, 'INV-8', '1', 'CALENTADOR ELECTRICO RHEEM DE 3 SERVICIOS 113 LITROS 220 V', 'HOMEDEPOT', '1', 0, 0),
(9, 'INV-9', '1', 'ASADOR ACERO INOXIDABLE MARCA CUISINART', 'AMAZON', '1', 0, 0),
(10, 'INV-10', '1', 'PARRILLA ELECTRICA VITROCERAMICA  MODELO TT6420 MARCA TEKA', 'ALFER', '1', 0, 0),
(11, 'INV-11', '1', 'HORNO ELECTRICO MULTIFUNCIO MODELO HBB 605 INOX, MARCA TEKA', 'ALFER', '1', 0, 0),
(12, 'INV-12', '2', 'WC HERMES PRO BLANCO 3 649/WC HERMES CASTEL', 'MATERAMA', '1', 0, 0),
(13, 'INV-13', '2', 'LAVABO SANTANDER INTERCERAMIC DE SOCUBIERTA BLANCO', 'INTERCERAMIC', '1', 0, 0),
(14, 'INV-14', '2', 'LAVABO MINSKDE SOBRECUBIERTA OVALADO BLANCO', 'INTERCERAMIC', '1', 0, 0),
(15, 'INV-15', '2', 'FREGADERO MARCA TEKA 508.533 1C (20.21),  CONTRACANASTA PARA COCINA, MARCA MOEN 11T', 'SAHA', '1', 0, 0),
(16, 'INV-16', '3', 'DREN DE FONDO ANTIVORTEX (CHICO)', 'ALBERCAFACIL', '1', 0, 0),
(17, 'INV-17', '3', 'DREN DE FONDO ANTIVORTEX (GRANDE)', 'ALBERCAFACIL', '1', 0, 0),
(18, 'INV-18', '3', 'DESNATADOR BLANCO PARA HIDROMASAJE', 'ALBERCAFACIL', '1', 0, 0),
(19, 'INV-19', '3', 'BOQUILLAS DE RETORNO DE 1.5\" A 3/4\" MARCA PANDA (ALBERCA)', 'BRUNI', '1', 0, 0),
(20, 'INV-20', '3', 'BOQUILLAS DE ASPIRADO (PILETA)', 'ALBERCAFACIL', '1', 0, 0),
(21, 'INV-21', '3', 'CENTRO DE CARGA (12 MODULOS) (PARA EXTERIOR)', 'BRUNI', '1', 0, 0),
(22, 'INV-22', '3', 'CENTRO DE CARGA EMPOTRABLE TAPA AHUMADA 24 POLOS RIEL WEG', 'BRUNI', '1', 0, 0),
(23, 'INV-23', '3', 'CENTRO DE CARGA (4 MODULOS) PARA EXTERIOR', 'BRUNI', '1', 0, 0),
(24, 'INV-24', '3', 'FILTRO DE CARTUCHO DE CARBON ACTIVADO BLOCK DE 4.5\" X 10 \" DE 5 MICRAS', 'ALBERCAFACIL', '1', 0, 0),
(25, 'INV-25', '3', 'FILTRO DE CARTUCHO PARA ALBERCA', 'BRUNI/ALBERCAFACIL', '1', 0, 0),
(26, 'INV-26', '3', 'FILTRO DE CARTUCHO (SEDIMENTOS)', 'ALBERCAFACIL', '1', 0, 0),
(27, 'INV-27', '3', 'TIMER/RELOJ 115 V INTERMATIC 15 A', 'BRUNI', '1', 0, 0),
(28, 'INV-28', '3', 'TRANSFORMADOR LED 20W/15W 12V DC', 'ALBERCAFACIL/POOL', '1', 0, 0),
(29, 'INV-29', '3', 'LAMPARA LED SUMERGIBLE BLANCA LUZ AZUL  . 8w, 12vdc,6500k', 'ALBERCAFACIL/POOL', '1', 0, 0),
(30, 'INV-30', '3', 'COLADERAS DE ACERO DE  PRETIL, TUBO DE 4\"/ COLADERA DE HELVEX', 'BRUNI', '1', 0, 0),
(31, 'INV-31', '3', 'LUMINARIA DE CORTESIA NEGRO PARA EXTERIOR, MARCA TECNOLITE', 'SAHA', '1', 0, 0),
(32, 'INV-32', '3', 'APAGADOR SENCILLO NEGRO', 'BOXITIO', '1', 0, 0),
(33, 'INV-33', '3', 'APAGADOR DE ESCALERA NEGRO', 'BOXITIO', '1', 0, 0),
(34, 'INV-34', '3', 'CONTACTO SENCILLO NEGRO', 'BOXITIO', '1', 0, 0),
(35, 'INV-35', '3', 'CONTACTO DUPLEX NEGRO', 'BOXITIO', '1', 0, 0),
(36, 'INV-36', '3', 'CONTACTO DUPLEX POLARIZADO CON TAPA DE INTERPERIE', 'BOXITIO', '1', 0, 0),
(37, 'INV-37', '3', 'CHASIS CON TAPA GRIS TAPA DE INTERPERIE', 'SELCA', '1', 0, 0),
(38, 'INV-38', '3', 'CHASIS CON TAPA NEGRA DE 3 MODULOS', 'SELCA', '1', 0, 0),
(39, 'INV-39', '3', 'MODULO CIEGO NEGRO MATE', 'SELCA', '1', 0, 0),
(40, 'INV-40', '3', 'ARBOTANTE DE SOBREPONER TIPO BARRA (LUMINARIA BAÑO)', 'MERCADO LIBRE', '1', 0, 0),
(41, 'INV-41', '3', 'ILLUX DE MÉXICO TL-2815.N30 LUMINARIO REDONDO SLIM PARA SOBREPONER EN TECHO, BLACK, MEDIANO', 'MERCADO LIBRE', '1', 0, 0),
(42, 'INV-42', '3', 'LAMPARA TIPO REFLECTOR DE EXTERIOR NEGRO SUMERGIBLE FUENTE MR16 MARCA TECNOLITE', 'MERCADO LIBRE', '1', 0, 0),
(43, 'INV-43', '3', 'FOCOS MARCA TECNOLITE MODELO MR16-LED/5.5.W/30', 'MERCADO LIBRE', '1', 0, 0),
(44, 'INV-44', '3', 'VENTILADOR DE 3 ASPAS EN MADERA', 'HOMEDEPOT', '1', 0, 0),
(45, 'INV-45', '3', 'REGADERA NEGRO MATE EXTERIOR', 'SAHA', '1', 0, 0),
(46, 'INV-46', '3', 'COLADERA NEGRO MATE PARA DUCHA Y TERRAZA CUADRADA DE 0.10X0.10', 'SAHA', '1', 0, 0),
(47, 'INV-47', '3', 'COLADERA 0.10X0.10 DE PLASTICO CON REJILLA INOXIDABLE', 'SAHA', '1', 0, 0),
(48, 'INV-48', '3', 'MONOMANDO PARA REGADERA, MARCA MOEN, MODELO ARLYS 2775, CON ACABADO NEGRO MATE', 'INTERCERAMIC', '1', 0, 0),
(49, 'INV-49', '3', 'LLAVE DUBLIN DE PARED MONOMANDO NEGRO MATE, MARCA INTERCERAMIC, MODELO V4315-2', 'INTERCERAMIC', '1', 0, 0),
(50, 'INV-50', '3', 'LLAVE PIVOT MONOMANDO DE COCINA CON MANGUERA RETRACTIL NEGRO MATE MARCA INTERCERAMIC', 'INTERCERAMIC', '1', 0, 0),
(51, 'INV-51', '3', 'TIRADORES CUADRADOS (TOALLERO) DE ACERO INOXIDABLE 192 MM, COLOR NEGRO MATE', 'GOLDENWARM', '1', 0, 0),
(52, 'INV-52', '3', 'HANGER PARA TOALLA (GANCHO)', 'SAHA', '1', 0, 0),
(53, 'INV-53', '3', 'PORTAPAPEL MARCA MARCA HELVEX, CON ACABADO NEGRO MATE', 'SAHA', '1', 0, 0),
(54, 'INV-54', '3', 'Tope universal para puerta: el tope cilíndrico para puerta de suelo es de 2-1/2 pulgadas de alto y 1-1/4 pulgadas de diámetro MARCA KOLAKO', 'AMAZON', '1', 0, 0),
(55, 'INV-55', '3', 'CERROJO CHAPA DOBLE CUADRADO NEGRO MATE (LOCK OFF)', 'MERCADO LIBRE Y EL MUNDO DE LAS PUERTAS', '1', 0, 0),
(56, 'INV-56', '3', 'LUMINARIA DE SOBREPONER EN TECHO 15 W  (REDONDA PASILLO) MARCA CANMEJIA', 'MERCADO LIBRE', '1', 0, 0),
(57, 'INV-57', '3', 'LAMPARA TIPO ESTACA MOD. H-750/VN MCA. TECNOLITE', 'MERCADO LIBRE', '1', 0, 0),
(58, 'INV-58', '3', 'LAMPARA DE CORTESIA EN ESCALERA', 'MERCADO LIBRE', '1', 0, 0),
(59, 'INV-59', '3', 'LAMPARA SOLAR CON SENSOR DE MOVIMIENTOS LUZ FRIA MS-3104', 'ILLUX', '1', 0, 0),
(60, 'INV-60', '3', 'INTERRUPTOR AUTOMÁTICO PIR SENSOR MOVIMIENTO JL-003B ARDUINO', 'MERCADO LIBRE', '1', 0, 0),
(61, 'INV-61', '3', 'EXTRACTOR AIRE CUADR ECON 4-PG', 'BOXITIO', '1', 0, 0),
(62, 'INV-62', '7', 'IMPERMAXI 5 BLANCO. FIBRATADO  (IMPERMEABILIZANTE ACRILICO BLANCO) CUBETA 19 LITROS', 'OBREK', '2', 0, 0),
(63, 'INV-63', '7', 'PEGAMENTO TORO SELLADOR 18 KG (ANTES DE IMPERMEABILIZANTE CEMENTOSO)', 'BEREL', '2', 0, 0),
(64, 'INV-64', '7', 'IMPERMEABILIZANTE CEMENTOSO (SELLOTEK) GRIS 25 KG MARCA FESTER', 'SOLUCIONES DEL CARIBE', '4', 0, 0),
(65, 'INV-65', '7', 'PISO CERÁMICO RUIDOSO FORMATO 17.5X91CM TONO CAFE OSCURO PEGADO CON ADHESIVO PERDURA O SIMILAR.', 'INTERCERAMIC', '12', 0, 0),
(66, 'INV-66', '7', 'PISO PORCELANATO 59.3X59.3 ZEMENTI GRIS RECTIFICADO PORCELANITE', 'ALFER', '12', 0, 0),
(67, 'INV-67', '7', 'SUMINISTRO E INSTALACION DE PIEDRA GALARZA  EN FACHADAS SELECCIONADAS', 'TEJAS EL AGUILA', '12', 0, 0),
(68, 'INV-68', '7', 'FORRO EN MESETAS PARA LAVABO DE BAÑOS CON FORRO DE MARMOL TRAVERTINO TIPO FIORELA (MEDIDAS SEGÚN ÁREA)', 'TEJAS EL AGUILA', '1', 0, 0),
(69, 'INV-69', '7', 'CUBIERTA EN COCINA A BASE DE MARMOL TRAVERTINO', 'TEJAS EL AGUILA', '1', 0, 0),
(70, 'INV-70', '7', 'CUBIERTA EN ISLA A BASE DE MARMOL TRAVERTINO', 'TEJAS EL AGUILA', '1', 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_recepcion`
--

CREATE TABLE `app_recepcion` (
  `id` bigint(20) NOT NULL,
  `llegada` int(11) DEFAULT NULL,
  `pendiente` int(11) DEFAULT NULL,
  `utilizado` int(11) DEFAULT NULL,
  `saldo` int(11) DEFAULT NULL,
  `solicitud_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_solicitud`
--

CREATE TABLE `app_solicitud` (
  `id` bigint(20) NOT NULL,
  `solicitud` varchar(300) NOT NULL,
  `fecha` date NOT NULL,
  `solicita` varchar(300) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `bodegaproducto_id` bigint(20) NOT NULL,
  `obra_id` bigint(20) NOT NULL,
  `unidad` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_villa`
--

CREATE TABLE `app_villa` (
  `id` bigint(20) NOT NULL,
  `identificador` varchar(20) NOT NULL,
  `obra_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(2, 'admin'),
(1, 'bodega'),
(3, 'residente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auth_group_permissions`
--

INSERT INTO `auth_group_permissions` (`id`, `group_id`, `permission_id`) VALUES
(2, 1, 2),
(3, 1, 4),
(72, 1, 5),
(4, 1, 6),
(5, 1, 8),
(73, 1, 25),
(74, 1, 26),
(75, 1, 28),
(71, 1, 29),
(6, 2, 1),
(7, 2, 2),
(8, 2, 3),
(9, 2, 4),
(10, 2, 5),
(11, 2, 6),
(12, 2, 7),
(13, 2, 8),
(14, 2, 9),
(15, 2, 10),
(16, 2, 11),
(17, 2, 12),
(18, 2, 13),
(19, 2, 14),
(20, 2, 15),
(21, 2, 16),
(22, 2, 17),
(23, 2, 18),
(24, 2, 19),
(25, 2, 20),
(26, 2, 21),
(27, 2, 22),
(28, 2, 23),
(29, 2, 24),
(30, 2, 25),
(31, 2, 26),
(32, 2, 27),
(33, 2, 28),
(34, 2, 29),
(35, 2, 30),
(36, 2, 31),
(37, 2, 32),
(38, 2, 33),
(39, 2, 34),
(40, 2, 35),
(41, 2, 36),
(42, 2, 37),
(43, 2, 38),
(44, 2, 39),
(45, 2, 40),
(46, 2, 41),
(47, 2, 42),
(48, 2, 43),
(49, 2, 44),
(50, 2, 45),
(51, 2, 46),
(52, 2, 47),
(53, 2, 48),
(54, 2, 49),
(55, 2, 50),
(56, 2, 51),
(57, 2, 52),
(58, 2, 53),
(59, 2, 54),
(60, 2, 55),
(61, 2, 56),
(62, 2, 57),
(63, 2, 58),
(64, 2, 59),
(65, 2, 60),
(66, 3, 4),
(67, 3, 8),
(68, 3, 21),
(69, 3, 22),
(70, 3, 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add bodega', 1, 'add_bodega'),
(2, 'Can change bodega', 1, 'change_bodega'),
(3, 'Can delete bodega', 1, 'delete_bodega'),
(4, 'Can view bodega', 1, 'view_bodega'),
(5, 'Can add bodega productos', 2, 'add_bodegaproductos'),
(6, 'Can change bodega productos', 2, 'change_bodegaproductos'),
(7, 'Can delete bodega productos', 2, 'delete_bodegaproductos'),
(8, 'Can view bodega productos', 2, 'view_bodegaproductos'),
(9, 'Can add obra', 3, 'add_obra'),
(10, 'Can change obra', 3, 'change_obra'),
(11, 'Can delete obra', 3, 'delete_obra'),
(12, 'Can view obra', 3, 'view_obra'),
(13, 'Can add producto', 4, 'add_producto'),
(14, 'Can change producto', 4, 'change_producto'),
(15, 'Can delete producto', 4, 'delete_producto'),
(16, 'Can view producto', 4, 'view_producto'),
(17, 'Can add villa', 5, 'add_villa'),
(18, 'Can change villa', 5, 'change_villa'),
(19, 'Can delete villa', 5, 'delete_villa'),
(20, 'Can view villa', 5, 'view_villa'),
(21, 'Can add solicitud', 6, 'add_solicitud'),
(22, 'Can change solicitud', 6, 'change_solicitud'),
(23, 'Can delete solicitud', 6, 'delete_solicitud'),
(24, 'Can view solicitud', 6, 'view_solicitud'),
(25, 'Can add recepcion', 7, 'add_recepcion'),
(26, 'Can change recepcion', 7, 'change_recepcion'),
(27, 'Can delete recepcion', 7, 'delete_recepcion'),
(28, 'Can view recepcion', 7, 'view_recepcion'),
(29, 'Can add insumos', 8, 'add_insumos'),
(30, 'Can change insumos', 8, 'change_insumos'),
(31, 'Can delete insumos', 8, 'delete_insumos'),
(32, 'Can view insumos', 8, 'view_insumos'),
(33, 'Can add compra', 9, 'add_compra'),
(34, 'Can change compra', 9, 'change_compra'),
(35, 'Can delete compra', 9, 'delete_compra'),
(36, 'Can view compra', 9, 'view_compra'),
(37, 'Can add user', 10, 'add_customuser'),
(38, 'Can change user', 10, 'change_customuser'),
(39, 'Can delete user', 10, 'delete_customuser'),
(40, 'Can view user', 10, 'view_customuser'),
(41, 'Can add log entry', 11, 'add_logentry'),
(42, 'Can change log entry', 11, 'change_logentry'),
(43, 'Can delete log entry', 11, 'delete_logentry'),
(44, 'Can view log entry', 11, 'view_logentry'),
(45, 'Can add permission', 12, 'add_permission'),
(46, 'Can change permission', 12, 'change_permission'),
(47, 'Can delete permission', 12, 'delete_permission'),
(48, 'Can view permission', 12, 'view_permission'),
(49, 'Can add group', 13, 'add_group'),
(50, 'Can change group', 13, 'change_group'),
(51, 'Can delete group', 13, 'delete_group'),
(52, 'Can view group', 13, 'view_group'),
(53, 'Can add content type', 14, 'add_contenttype'),
(54, 'Can change content type', 14, 'change_contenttype'),
(55, 'Can delete content type', 14, 'delete_contenttype'),
(56, 'Can view content type', 14, 'view_contenttype'),
(57, 'Can add session', 15, 'add_session'),
(58, 'Can change session', 15, 'change_session'),
(59, 'Can delete session', 15, 'delete_session'),
(60, 'Can view session', 15, 'view_session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2022-07-13 13:50:28.754030', '1', 'bodega', 1, '[{\"added\": {}}]', 13, 1),
(2, '2022-07-13 13:50:42.704109', '2', 'admin', 1, '[{\"added\": {}}]', 13, 1),
(3, '2022-07-13 13:51:29.015082', '3', 'residente', 1, '[{\"added\": {}}]', 13, 1),
(4, '2022-07-13 13:57:14.636595', '1', 'bodega', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 13, 1),
(5, '2022-07-13 14:15:08.944784', '1', 'bodega', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 13, 1),
(6, '2022-07-13 14:15:44.758365', '1', 'bodega', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 13, 1),
(7, '2022-07-13 14:17:09.004101', '1', 'bodega', 2, '[]', 13, 1),
(8, '2022-07-13 14:18:38.147673', '1', 'bodega', 2, '[]', 13, 1),
(9, '2022-07-13 14:58:03.796567', '1', 'bodega', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 13, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(11, 'admin', 'logentry'),
(1, 'app', 'bodega'),
(2, 'app', 'bodegaproductos'),
(9, 'app', 'compra'),
(10, 'app', 'customuser'),
(8, 'app', 'insumos'),
(3, 'app', 'obra'),
(4, 'app', 'producto'),
(7, 'app', 'recepcion'),
(6, 'app', 'solicitud'),
(5, 'app', 'villa'),
(13, 'auth', 'group'),
(12, 'auth', 'permission'),
(14, 'contenttypes', 'contenttype'),
(15, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2022-07-13 00:52:33.242409'),
(2, 'contenttypes', '0002_remove_content_type_name', '2022-07-13 00:52:33.500864'),
(3, 'auth', '0001_initial', '2022-07-13 00:52:35.441360'),
(4, 'auth', '0002_alter_permission_name_max_length', '2022-07-13 00:52:35.768781'),
(5, 'auth', '0003_alter_user_email_max_length', '2022-07-13 00:52:35.801647'),
(6, 'auth', '0004_alter_user_username_opts', '2022-07-13 00:52:35.859644'),
(7, 'auth', '0005_alter_user_last_login_null', '2022-07-13 00:52:35.889644'),
(8, 'auth', '0006_require_contenttypes_0002', '2022-07-13 00:52:35.913450'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2022-07-13 00:52:35.941642'),
(10, 'auth', '0008_alter_user_username_max_length', '2022-07-13 00:52:36.023197'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2022-07-13 00:52:36.087406'),
(12, 'auth', '0010_alter_group_name_max_length', '2022-07-13 00:52:36.221158'),
(13, 'auth', '0011_update_proxy_permissions', '2022-07-13 00:52:36.269024'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2022-07-13 00:52:36.306756'),
(15, 'app', '0001_initial', '2022-07-13 00:52:45.174076'),
(16, 'admin', '0001_initial', '2022-07-13 00:52:46.021738'),
(17, 'admin', '0002_logentry_remove_auto_add', '2022-07-13 00:52:46.069671'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2022-07-13 00:52:46.087701'),
(19, 'app', '0002_alter_customuser_user_type', '2022-07-13 00:52:46.417627'),
(20, 'app', '0003_alter_customuser_user_type', '2022-07-13 00:52:49.339727'),
(21, 'app', '0004_alter_customuser_user_type', '2022-07-13 00:52:50.040834'),
(22, 'app', '0005_obra_status', '2022-07-13 00:52:50.141709'),
(23, 'app', '0006_insumos_notas', '2022-07-13 00:52:50.216741'),
(24, 'app', '0007_remove_producto_ubicacion_bodegaproductos_ubicacion', '2022-07-13 00:52:50.358681'),
(25, 'app', '0008_alter_insumos_notas', '2022-07-13 00:52:50.537036'),
(26, 'app', '0009_solicitud_unidad', '2022-07-13 00:52:50.750546'),
(27, 'sessions', '0001_initial', '2022-07-13 00:52:51.110520');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('l9bhl3kfhchq3mzr5w4jhjtc9enfi8lb', '.eJxVjDsOwjAQBe_iGlnOGv8o6XMGa23v4gBypDipEHeHSCmgfTPzXiLitta4dVriVMRFgDj9bgnzg9oOyh3bbZZ5busyJbkr8qBdjnOh5_Vw_w4q9vqt2UEw2Xi2igyn5AcPSWsmE4IG48BkQhtUQYdKE2O2wUJgGM6eE2vx_gDgKTft:1oBdsm:dioQCiRrV_6s494YRq4NyLutK8k4YZ2RgoJLj5qpswA', '2022-07-27 15:02:32.962207'),
('zv8w4luwfw8eyl97rlruau8ic0g8zti2', '.eJxVjEEOwiAQRe_C2hCgAy0u3XsGwjCDVA0kpV0Z765NutDtf-_9lwhxW0vYOi9hJnEWWpx-N4zpwXUHdI_11mRqdV1mlLsiD9rltRE_L4f7d1BiL98ass6kLYIfMg8DkVVIyeustHFgnUuTV0YxJw0GMllP4EdAT-OEzCDeH-NTN98:1oBd89:n7Mz6Db7TGcfkvIZC4qBkkTpNmOhIGs6ApDKRxEI32Q', '2022-07-27 14:14:21.459818');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `app_bodega`
--
ALTER TABLE `app_bodega`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_bodega_obra_id_99e4f171_fk_app_obra_id` (`obra_id`);

--
-- Indices de la tabla `app_bodegaproductos`
--
ALTER TABLE `app_bodegaproductos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_bodegaproductos_producto_id_f4a011a8_fk_app_producto_id` (`producto_id`),
  ADD KEY `app_bodegaproductos_bodega_id_212948b6_fk_app_bodega_id` (`bodega_id`);

--
-- Indices de la tabla `app_compra`
--
ALTER TABLE `app_compra`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_compra_solicitud_id_3aa7ece4_fk_app_solicitud_id` (`solicitud_id`);

--
-- Indices de la tabla `app_customuser`
--
ALTER TABLE `app_customuser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `app_customuser_groups`
--
ALTER TABLE `app_customuser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_customuser_groups_customuser_id_group_id_a5a0ca22_uniq` (`customuser_id`,`group_id`),
  ADD KEY `app_customuser_groups_group_id_47e49ebd_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `app_customuser_user_permissions`
--
ALTER TABLE `app_customuser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_customuser_user_perm_customuser_id_permission_22e31019_uniq` (`customuser_id`,`permission_id`),
  ADD KEY `app_customuser_user__permission_id_c5920c75_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `app_insumos`
--
ALTER TABLE `app_insumos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_insumos_bodegaproducto_id_f135cc88_fk_app_bodegaproductos_id` (`bodegaproducto_id`),
  ADD KEY `app_insumos_obra_id_f442491c_fk_app_obra_id` (`obra_id`),
  ADD KEY `app_insumos_villa_id_6f4354b3_fk_app_villa_id` (`villa_id`);

--
-- Indices de la tabla `app_obra`
--
ALTER TABLE `app_obra`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `app_producto`
--
ALTER TABLE `app_producto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave` (`clave`);

--
-- Indices de la tabla `app_recepcion`
--
ALTER TABLE `app_recepcion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_recepcion_solicitud_id_96b86610_fk_app_solicitud_id` (`solicitud_id`);

--
-- Indices de la tabla `app_solicitud`
--
ALTER TABLE `app_solicitud`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_solicitud_bodegaproducto_id_12507fe3_fk_app_bodeg` (`bodegaproducto_id`),
  ADD KEY `app_solicitud_obra_id_50562684_fk_app_obra_id` (`obra_id`);

--
-- Indices de la tabla `app_villa`
--
ALTER TABLE `app_villa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_villa_obra_id_25b199ca_fk_app_obra_id` (`obra_id`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_app_customuser_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `app_bodega`
--
ALTER TABLE `app_bodega`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_bodegaproductos`
--
ALTER TABLE `app_bodegaproductos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_compra`
--
ALTER TABLE `app_compra`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_customuser`
--
ALTER TABLE `app_customuser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `app_customuser_groups`
--
ALTER TABLE `app_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `app_customuser_user_permissions`
--
ALTER TABLE `app_customuser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_insumos`
--
ALTER TABLE `app_insumos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_obra`
--
ALTER TABLE `app_obra`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_producto`
--
ALTER TABLE `app_producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `app_recepcion`
--
ALTER TABLE `app_recepcion`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_solicitud`
--
ALTER TABLE `app_solicitud`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_villa`
--
ALTER TABLE `app_villa`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `app_bodega`
--
ALTER TABLE `app_bodega`
  ADD CONSTRAINT `app_bodega_obra_id_99e4f171_fk_app_obra_id` FOREIGN KEY (`obra_id`) REFERENCES `app_obra` (`id`);

--
-- Filtros para la tabla `app_bodegaproductos`
--
ALTER TABLE `app_bodegaproductos`
  ADD CONSTRAINT `app_bodegaproductos_bodega_id_212948b6_fk_app_bodega_id` FOREIGN KEY (`bodega_id`) REFERENCES `app_bodega` (`id`),
  ADD CONSTRAINT `app_bodegaproductos_producto_id_f4a011a8_fk_app_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `app_producto` (`id`);

--
-- Filtros para la tabla `app_compra`
--
ALTER TABLE `app_compra`
  ADD CONSTRAINT `app_compra_solicitud_id_3aa7ece4_fk_app_solicitud_id` FOREIGN KEY (`solicitud_id`) REFERENCES `app_solicitud` (`id`);

--
-- Filtros para la tabla `app_customuser_groups`
--
ALTER TABLE `app_customuser_groups`
  ADD CONSTRAINT `app_customuser_group_customuser_id_164d073f_fk_app_custo` FOREIGN KEY (`customuser_id`) REFERENCES `app_customuser` (`id`),
  ADD CONSTRAINT `app_customuser_groups_group_id_47e49ebd_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `app_customuser_user_permissions`
--
ALTER TABLE `app_customuser_user_permissions`
  ADD CONSTRAINT `app_customuser_user__customuser_id_4bcbaafb_fk_app_custo` FOREIGN KEY (`customuser_id`) REFERENCES `app_customuser` (`id`),
  ADD CONSTRAINT `app_customuser_user__permission_id_c5920c75_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Filtros para la tabla `app_insumos`
--
ALTER TABLE `app_insumos`
  ADD CONSTRAINT `app_insumos_bodegaproducto_id_f135cc88_fk_app_bodegaproductos_id` FOREIGN KEY (`bodegaproducto_id`) REFERENCES `app_bodegaproductos` (`id`),
  ADD CONSTRAINT `app_insumos_obra_id_f442491c_fk_app_obra_id` FOREIGN KEY (`obra_id`) REFERENCES `app_obra` (`id`),
  ADD CONSTRAINT `app_insumos_villa_id_6f4354b3_fk_app_villa_id` FOREIGN KEY (`villa_id`) REFERENCES `app_villa` (`id`);

--
-- Filtros para la tabla `app_recepcion`
--
ALTER TABLE `app_recepcion`
  ADD CONSTRAINT `app_recepcion_solicitud_id_96b86610_fk_app_solicitud_id` FOREIGN KEY (`solicitud_id`) REFERENCES `app_solicitud` (`id`);

--
-- Filtros para la tabla `app_solicitud`
--
ALTER TABLE `app_solicitud`
  ADD CONSTRAINT `app_solicitud_bodegaproducto_id_12507fe3_fk_app_bodeg` FOREIGN KEY (`bodegaproducto_id`) REFERENCES `app_bodegaproductos` (`id`),
  ADD CONSTRAINT `app_solicitud_obra_id_50562684_fk_app_obra_id` FOREIGN KEY (`obra_id`) REFERENCES `app_obra` (`id`);

--
-- Filtros para la tabla `app_villa`
--
ALTER TABLE `app_villa`
  ADD CONSTRAINT `app_villa_obra_id_25b199ca_fk_app_obra_id` FOREIGN KEY (`obra_id`) REFERENCES `app_obra` (`id`);

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_app_customuser_id` FOREIGN KEY (`user_id`) REFERENCES `app_customuser` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
