-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 20-11-2015 a las 16:47:13
-- Versión del servidor: 5.5.20
-- Versión de PHP: 5.3.10

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `testreko`
--

--
-- Volcado de datos para la tabla `authassignment_administrador`
--

INSERT INTO `authassignment_administrador` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('', '', NULL, NULL),
('administracion_rol_administrador', '1', NULL, NULL),
('administracion_rol_usuario', '1', NULL, NULL),
('administracion_usuario', '1', NULL, NULL),
('administracion_usuario_administrador', '1', NULL, NULL),
('admin_aplicacion', '1', NULL, NULL),
('admin_aula', '1', NULL, NULL),
('admin_curricular', '1', NULL, NULL),
('admin_error_log_mensaje', '1', NULL, NULL),
('admin_escritorio', '1', NULL, NULL),
('admin_institucion', '1', NULL, NULL),
('admin_repositorio', '1', NULL, NULL),
('admin_rol_administrador', '1', NULL, NULL),
('admin_rol_usuario', '1', NULL, NULL),
('admin_usuario', '1', NULL, NULL),
('admin_usuario_administrador', '1', NULL, NULL);

--
-- Volcado de datos para la tabla `authitem_permiso_administrador`
--

INSERT INTO `authitem_permiso_administrador` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('', 0, NULL, NULL, NULL),
('administracion_rol_administrador', 2, NULL, NULL, NULL),
('administracion_rol_usuario', 2, NULL, NULL, NULL),
('administracion_usuario', 2, NULL, NULL, NULL),
('administracion_usuario_administrador', 2, NULL, NULL, NULL),
('admin_aplicacion', 2, NULL, NULL, NULL),
('admin_aula', 2, NULL, NULL, NULL),
('admin_curricular', 2, NULL, NULL, NULL),
('admin_error_log_mensaje', 2, NULL, NULL, NULL),
('admin_escritorio', 2, NULL, NULL, NULL),
('admin_institucion', 2, NULL, NULL, NULL),
('admin_repositorio', 2, NULL, NULL, NULL),
('admin_rol_administrador', 2, NULL, NULL, NULL),
('admin_rol_usuario', 2, NULL, NULL, NULL),
('admin_usuario', 2, NULL, NULL, NULL),
('admin_usuario_administrador', 2, NULL, NULL, NULL);

--
-- Volcado de datos para la tabla `authitem_permiso_usuario`
--

INSERT INTO `authitem_permiso_usuario` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('aula', 2, 'des-aula', NULL, NULL),
('repositorio', 2, 'des-repositorio', NULL, NULL);

--
-- Volcado de datos para la tabla `dato_academico`
--

INSERT INTO `dato_academico` (`id`, `universidad`, `carrera`, `ano_cursado`, `duracion_carrera`, `sede`, `direccion_sede`, `comuna_sede`, `ciudad_sede`, `usuario_id`) VALUES
(4, 'Duoc', 'Ingenieria en informatica', 3, 4, 'Antonio varas', 'antonio varas 666', 'providencia', 'santiago', 236);

--
-- Volcado de datos para la tabla `dato_laboral`
--

INSERT INTO `dato_laboral` (`id`, `nombre_empresa`, `ano_antiguedad`, `cargo`, `actividad`, `comuna_empresa`, `ciudad_empresa`, `telefono_empresa`, `celular_empresa`, `rut_numero`, `digito_verificador`, `usuario_id`) VALUES
(3, 'Utem Virtual', 3, 'Analista', 'creacion de reko 2', 'santiago', 'santiago', 227578121, 2147483647, 1578951, 1, 236);

--
-- Volcado de datos para la tabla `dato_personal`
--

INSERT INTO `dato_personal` (`id`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `edad`, `rut`, `digito_verificador`, `direccion_personal`, `numero_casa`, `telefono_personal`, `celular_personal`, `comuna_personal`, `ciudad_personal`, `interes`, `estado_civil`, `idioma`, `nacionalidad`, `usuario_id`) VALUES
(501, 'Diego ', 'Antonio', 'Morales', 'Hernandez', '2015-11-20 12:33:15', 23, 18087707, 9, 'Avenida el raleo ', 1396, 82460780, 52072575, 'buin', 'santiago', 'nada', 'soltero', 'español', 'chilena', 236),
(503, 'Christian', 'Andres', 'Reyes', 'Arellano', '2015-11-20 13:30:42', 38, 13230098, 4, 'calle 18', 161, 2147483647, 2147483647, 'santiago', 'santiago', 'informatica', 'soltero', 'espanol', 'chilena', 248),
(504, 'John', 'Paul', 'Lopez', 'Suarez', '2015-11-20 13:46:42', 25, 17382459, 9, 'calle 18', 161, 2147483647, 2147483647, 'san bernardo', 'santiago', 'informatica', 'soltero', 'espanol', 'chilena', 237),
(505, 'dfgdfgfgfg', 'fgfg', 'dfgfdg', 'fgfdg', '0000-00-00 00:00:00', 0, 0, 0, '', 0, 0, 0, '', '', '', '', '', '', 238),
(506, 'Francisco', 'Francisco', 'Carvajal', 'Carvajal', '2015-11-20 12:53:05', 30, 11111111, 1, 'calle 18', 161, 2147483647, 52072575, 'santiago', 'santiago', 'diseño', 'soltero', 'espanol', 'chilena', 241);

--
-- Volcado de datos para la tabla `estado_modulo`
--

INSERT INTO `estado_modulo` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `estado_programa_academico`
--

INSERT INTO `estado_programa_academico` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `estado_seccion`
--

INSERT INTO `estado_seccion` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `institucion`
--

INSERT INTO `institucion` (`id`, `nombre`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_institucion_id`) VALUES
(17, 'Universidad Tecnológica Metropolitana', '\r\nLa Universidad Tecnológica Metropolitana, será r', 'Misión', b'1', '2015-11-20 12:33:15', '2015-11-20 12:33:15', 'descripcion utem', '2015-11-20 12:51:24', NULL, NULL),
(18, 'duoc', '', '', b'0', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '2015-11-20 15:14:13', NULL, NULL);

--
-- Volcado de datos para la tabla `institucion_has_rol_usuario`
--

INSERT INTO `institucion_has_rol_usuario` (`institucion_id`, `rol_usuario_id`) VALUES
(17, 190),
(17, 191),
(17, 192),
(17, 193),
(18, 193),
(17, 194),
(17, 195),
(17, 196),
(17, 197),
(17, 198),
(17, 199),
(18, 201);

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_modulo_id`, `entidad_id`, `institucion_id`) VALUES
(9, 'Apresto uso plataforma', 'des-Apresto-uso-plataforma', '2015-11-20 16:08:35', NULL, 1, NULL, 17),
(10, 'Determinacion huella de carbono', 'des-Determinacion-huella-de-carbono', '2015-11-20 16:09:19', NULL, 1, NULL, 17),
(11, 'Determinacion huella hidrica', 'des-Determinacion-huella-hidrica', '2015-11-20 16:10:10', NULL, 1, NULL, 17),
(12, 'Apresto plataforma', 'des-Apresto-plataforma', '2015-11-20 16:10:42', NULL, 1, NULL, 18);

--
-- Volcado de datos para la tabla `programa_academico`
--

INSERT INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`, `entidad_id`, `institucion_id`, `estado_programa_academico_id`) VALUES
(8, 'Ingenieria en subtentabilidad', 'des-Ingenieria-en-subtentabilidad', '1.0', '2015-11-20 16:07:33', NULL, NULL, 17, 1);

--
-- Volcado de datos para la tabla `reko_session`
--

INSERT INTO `reko_session` (`id`, `expire`, `data`) VALUES
('6omkpt95pn065204prfu4r40j3', 1448049396, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a323a223137223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a35323a220d0a4c6120556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e612c20736572c3a12072223b696e737469747563696f6e4d6973696f6e7c733a373a224d697369c3b36e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32302031323a33333a3135223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32302031323a33333a3135223b),
('jk66nsto64vid87fpof1hloje3', 1448050157, 0x30373333353130383865316330316231363262316162353236386465653766615f5f72657475726e55726c7c733a33363a222f7465737472656b6f2f61756c612f61756c612f6c69737461646f50726f6772616d6173223b30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a323a223137223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a35323a220d0a4c6120556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e612c20736572c3a12072223b696e737469747563696f6e4d6973696f6e7c733a373a224d697369c3b36e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32302031323a33333a3135223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32302031323a33333a3135223b),
('vn6vmk38m3iao0rhtqdm39a555', 1448049799, 0x30373333353130383865316330316231363262316162353236386465653766615f5f72657475726e55726c7c733a33363a222f7465737472656b6f2f61756c612f61756c612f6c69737461646f50726f6772616d6173223b30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a323a223137223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a35323a220d0a4c6120556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e612c20736572c3a12072223b696e737469747563696f6e4d6973696f6e7c733a373a224d697369c3b36e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32302031323a33333a3135223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32302031323a33333a3135223b);

--
-- Volcado de datos para la tabla `rol_administrador`
--

INSERT INTO `rol_administrador` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superadministrador', 'super administrador');

--
-- Volcado de datos para la tabla `rol_administrador_has_authitem_permiso_administrador`
--

INSERT INTO `rol_administrador_has_authitem_permiso_administrador` (`rol_administrador_id`, `authitem_permiso_administrador_name`) VALUES
(1, 'administracion_rol_administrador'),
(1, 'administracion_rol_usuario'),
(1, 'administracion_usuario'),
(1, 'administracion_usuario_administrador'),
(1, 'admin_aplicacion'),
(1, 'admin_aula'),
(1, 'admin_curricular'),
(1, 'admin_error_log_mensaje'),
(1, 'admin_escritorio'),
(1, 'admin_institucion'),
(1, 'admin_repositorio'),
(1, 'admin_rol_administrador'),
(1, 'admin_rol_usuario'),
(1, 'admin_usuario'),
(1, 'admin_usuario_administrador');

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`id`, `nombre`, `descripcion`, `tipo`, `rol_usuario_general_id`, `fecha_creacion`, `fecha_eliminacion`, `fecha_acceso`, `fecha_modificacion`) VALUES
(190, 'tutor academico', 'des-tutor-academico', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(191, 'tutor ayundante', 'des-tutor-ayundante', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(192, 'tutor auxiliar', 'des-tutor-auxiliar', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(193, 'alumno', 'des-alumno', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(194, 'tutor seguimiento', 'des-tutor-seguimiento', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(195, 'tutor academico', 'des-tutor-academico', 'rol_usuario_institucion', 190, '2015-11-20 13:14:57', NULL, NULL, '2015-11-20 13:14:57'),
(196, 'tutor ayundante', 'des-tutor-ayundante', 'rol_usuario_institucion', 191, '2015-11-20 13:14:57', NULL, NULL, '2015-11-20 13:14:57'),
(197, 'tutor auxiliar', 'des-tutor-auxiliar', 'rol_usuario_institucion', 192, '2015-11-20 13:14:57', NULL, NULL, '2015-11-20 13:14:57'),
(198, 'alumno', 'des-alumno', 'rol_usuario_institucion', 193, '2015-11-20 13:14:57', NULL, NULL, '2015-11-20 13:14:57'),
(199, 'tutor seguimiento', 'des-tutor-seguimiento', 'rol_usuario_institucion', 194, '2015-11-20 13:14:58', NULL, NULL, '2015-11-20 13:14:58'),
(201, 'alumno', 'des-alumno', 'rol_usuario_institucion', 193, '2015-11-20 15:54:48', NULL, NULL, '2015-11-20 15:54:48');

--
-- Volcado de datos para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

INSERT INTO `rol_usuario_has_authitem_permiso_usuario` (`rol_usuario_id`, `authitem_permiso_usuario_name`) VALUES
(190, 'aula'),
(191, 'aula'),
(192, 'aula'),
(193, 'aula'),
(194, 'aula'),
(195, 'aula'),
(196, 'aula'),
(197, 'aula'),
(199, 'aula'),
(201, 'aula');

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`id`, `nombre`, `jornada`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `modulo_id`, `estado_seccion_id`) VALUES
(1, 'seccion-1', 'diurna', 'des-seccion', NULL, NULL, 9, 1);

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, `clave`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `estado_usuario_id`) VALUES
(236, 'dmorales', '123', NULL, NULL, '2015-11-20 12:53:05', NULL),
(237, 'jlopez', '123', NULL, NULL, '2015-11-20 12:53:16', NULL),
(238, 'piriarte', '123', NULL, NULL, '2015-11-20 12:53:33', NULL),
(239, 'cconcha', '123', NULL, NULL, '2015-11-20 12:53:43', NULL),
(240, 'mgarcia', '123', NULL, NULL, '2015-11-20 12:53:53', NULL),
(241, 'fcarvajal', '123', NULL, NULL, '2015-11-20 12:54:31', NULL),
(242, 'vguzman', '123', NULL, NULL, '2015-11-20 12:54:48', NULL),
(243, 'vinzunza', '123', NULL, NULL, '2015-11-20 12:54:59', NULL),
(244, 'ctorres', '123', NULL, NULL, '2015-11-20 12:55:12', NULL),
(245, 'mzuniga', '123', NULL, NULL, '2015-11-20 12:55:43', NULL),
(246, 'fortiz', '123', NULL, NULL, '2015-11-20 12:55:53', NULL),
(247, 'msanhueza', '123', NULL, NULL, '2015-11-20 12:56:21', NULL),
(248, 'creyes', '123', NULL, NULL, '2015-11-20 12:56:52', NULL),
(249, 'hugo', '123', NULL, NULL, '2015-11-20 15:14:42', NULL),
(250, 'jperez', '123', NULL, NULL, '2015-11-20 15:54:15', NULL);

--
-- Volcado de datos para la tabla `usuario_administrador`
--

INSERT INTO `usuario_administrador` (`id`, `usuario`, `clave`) VALUES
(1, 'creyes', '123');

--
-- Volcado de datos para la tabla `usuario_administrador_has_rol_administrador`
--

INSERT INTO `usuario_administrador_has_rol_administrador` (`usuario_administrador_id`, `rol_administrador_id`) VALUES
(1, 1);

--
-- Volcado de datos para la tabla `usuario_has_institucion`
--

INSERT INTO `usuario_has_institucion` (`usuario_id`, `institucion_id`) VALUES
(244, 17),
(245, 17),
(246, 17),
(247, 17),
(248, 17),
(236, 17),
(249, 18),
(237, 17),
(238, 17),
(239, 17),
(240, 17),
(241, 17),
(242, 17),
(243, 17),
(250, 18);

--
-- Volcado de datos para la tabla `usuario_has_modulo`
--

INSERT INTO `usuario_has_modulo` (`usuario_id`, `modulo_id`, `rol_usuario_id`) VALUES
(248, 9, 198);

--
-- Volcado de datos para la tabla `usuario_has_programa_academico`
--

INSERT INTO `usuario_has_programa_academico` (`usuario_id`, `programa_academico_id`, `rol_usuario_id`) VALUES
(248, 8, 198);

--
-- Volcado de datos para la tabla `usuario_has_rol_usuario`
--

INSERT INTO `usuario_has_rol_usuario` (`usuario_id`, `rol_usuario_id`) VALUES
(236, 198),
(237, 198),
(238, 198),
(239, 198),
(240, 198),
(241, 198),
(242, 198),
(243, 198),
(244, 198),
(245, 198),
(246, 198),
(247, 198),
(248, 198);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
