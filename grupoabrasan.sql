-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-07-2022 a las 06:31:18
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
) ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `app_customuser_groups`
--

CREATE TABLE `app_customuser_groups` (
  `id` bigint(20) NOT NULL,
  `customuser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'Can add user', 1, 'add_customuser'),
(2, 'Can change user', 1, 'change_customuser'),
(3, 'Can delete user', 1, 'delete_customuser'),
(4, 'Can view user', 1, 'view_customuser'),
(5, 'Can add producto', 2, 'add_producto'),
(6, 'Can change producto', 2, 'change_producto'),
(7, 'Can delete producto', 2, 'delete_producto'),
(8, 'Can view producto', 2, 'view_producto'),
(9, 'Can add obra', 3, 'add_obra'),
(10, 'Can change obra', 3, 'change_obra'),
(11, 'Can delete obra', 3, 'delete_obra'),
(12, 'Can view obra', 3, 'view_obra'),
(13, 'Can add villa', 4, 'add_villa'),
(14, 'Can change villa', 4, 'change_villa'),
(15, 'Can delete villa', 4, 'delete_villa'),
(16, 'Can view villa', 4, 'view_villa'),
(17, 'Can add bodega', 5, 'add_bodega'),
(18, 'Can change bodega', 5, 'change_bodega'),
(19, 'Can delete bodega', 5, 'delete_bodega'),
(20, 'Can view bodega', 5, 'view_bodega'),
(21, 'Can add bodega productos', 6, 'add_bodegaproductos'),
(22, 'Can change bodega productos', 6, 'change_bodegaproductos'),
(23, 'Can delete bodega productos', 6, 'delete_bodegaproductos'),
(24, 'Can view bodega productos', 6, 'view_bodegaproductos'),
(25, 'Can add insumos', 7, 'add_insumos'),
(26, 'Can change insumos', 7, 'change_insumos'),
(27, 'Can delete insumos', 7, 'delete_insumos'),
(28, 'Can view insumos', 7, 'view_insumos'),
(29, 'Can add solicitud', 8, 'add_solicitud'),
(30, 'Can change solicitud', 8, 'change_solicitud'),
(31, 'Can delete solicitud', 8, 'delete_solicitud'),
(32, 'Can view solicitud', 8, 'view_solicitud'),
(33, 'Can add compra', 9, 'add_compra'),
(34, 'Can change compra', 9, 'change_compra'),
(35, 'Can delete compra', 9, 'delete_compra'),
(36, 'Can view compra', 9, 'view_compra'),
(37, 'Can add recepcion', 10, 'add_recepcion'),
(38, 'Can change recepcion', 10, 'change_recepcion'),
(39, 'Can delete recepcion', 10, 'delete_recepcion'),
(40, 'Can view recepcion', 10, 'view_recepcion'),
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
(5, 'app', 'bodega'),
(6, 'app', 'bodegaproductos'),
(9, 'app', 'compra'),
(1, 'app', 'customuser'),
(7, 'app', 'insumos'),
(3, 'app', 'obra'),
(2, 'app', 'producto'),
(10, 'app', 'recepcion'),
(8, 'app', 'solicitud'),
(4, 'app', 'villa'),
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
(1, 'contenttypes', '0001_initial', '2022-07-14 03:02:02.420102'),
(2, 'contenttypes', '0002_remove_content_type_name', '2022-07-14 03:02:03.151711'),
(3, 'auth', '0001_initial', '2022-07-14 03:02:04.899276'),
(4, 'auth', '0002_alter_permission_name_max_length', '2022-07-14 03:02:05.376173'),
(5, 'auth', '0003_alter_user_email_max_length', '2022-07-14 03:02:05.394119'),
(6, 'auth', '0004_alter_user_username_opts', '2022-07-14 03:02:05.428817'),
(7, 'auth', '0005_alter_user_last_login_null', '2022-07-14 03:02:05.462812'),
(8, 'auth', '0006_require_contenttypes_0002', '2022-07-14 03:02:05.514209'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2022-07-14 03:02:05.551133'),
(10, 'auth', '0008_alter_user_username_max_length', '2022-07-14 03:02:05.590004'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2022-07-14 03:02:05.652059'),
(12, 'auth', '0010_alter_group_name_max_length', '2022-07-14 03:02:05.759943'),
(13, 'auth', '0011_update_proxy_permissions', '2022-07-14 03:02:05.787939'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2022-07-14 03:02:05.820943'),
(15, 'app', '0001_initial', '2022-07-14 03:02:16.171123'),
(16, 'admin', '0001_initial', '2022-07-14 03:02:17.296044'),
(17, 'admin', '0002_logentry_remove_auto_add', '2022-07-14 03:02:17.340912'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2022-07-14 03:02:17.387916'),
(19, 'app', '0002_alter_customuser_user_type', '2022-07-14 03:02:17.705607'),
(20, 'app', '0003_alter_customuser_user_type', '2022-07-14 03:02:18.456700'),
(21, 'app', '0004_alter_customuser_user_type', '2022-07-14 03:02:19.501352'),
(22, 'app', '0005_obra_status', '2022-07-14 03:02:19.662648'),
(23, 'app', '0006_insumos_notas', '2022-07-14 03:02:19.755569'),
(24, 'app', '0007_remove_producto_ubicacion_bodegaproductos_ubicacion', '2022-07-14 03:02:19.900171'),
(25, 'app', '0008_alter_insumos_notas', '2022-07-14 03:02:19.934723'),
(26, 'app', '0009_solicitud_unidad', '2022-07-14 03:02:20.016716'),
(27, 'sessions', '0001_initial', '2022-07-14 03:02:20.255288');

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `app_customuser_groups`
--
ALTER TABLE `app_customuser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
