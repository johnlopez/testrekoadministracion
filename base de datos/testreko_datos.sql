-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 02-12-2015 a las 10:07:12
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
-- Volcado de datos para la tabla `archivo`
--

INSERT INTO `archivo` (`id`, `nombre`, `mime_type`, `tamano`, `ruta`, `usuario_id`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `fecha_eliminacion`, `lectura`, `escritura`, `descarga`, `eliminacion`, `contenedor_id`, `contenedor_tabla`) VALUES
(1, '952841-Modelo de probabilidad Normal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 24435, '/reko-archivos/Universidad Tecnológica Metropolitana/repositorio-id-1/glosario/glosario-id-6/', 248, '2015-12-01 11:57:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 'glosario'),
(2, '431567-Modelo de probabilidad Normal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 24435, '/reko-archivos/Universidad Tecnológica Metropolitana/repositorio-id-1/archivo_recurso/archivo_recurso-id-1/', 248, '2015-12-01 11:58:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'archivo_recurso');

--
-- Volcado de datos para la tabla `archivo_recurso`
--

INSERT INTO `archivo_recurso` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_elminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(1, 'archivo_recurso_1', 'des-archivo_recurso_1', '2015-12-01 11:58:23', NULL, NULL, NULL, 1);

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
-- Volcado de datos para la tabla `controlador_usuario`
--

INSERT INTO `controlador_usuario` (`id`, `nombre`, `authitem_permiso_usuario_name`) VALUES
(1, 'Default', 'aula'),
(2, 'Default', 'repositorio');

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
-- Volcado de datos para la tabla `estado_institucion`
--

INSERT INTO `estado_institucion` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

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
-- Volcado de datos para la tabla `estado_usuario`
--

INSERT INTO `estado_usuario` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `glosario`
--

INSERT INTO `glosario` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_eliminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(6, 'glosario1', 'glosario1', '2015-12-01 11:55:55', NULL, NULL, NULL, 1);

--
-- Volcado de datos para la tabla `glosario_termino_definicion`
--

INSERT INTO `glosario_termino_definicion` (`id`, `termino`, `definicion`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `fecha_eliminacion`, `glosario_id`) VALUES
(7, 'termino1', 'deficion1', '2015-12-01 11:56:52', NULL, NULL, NULL, 6);

--
-- Volcado de datos para la tabla `herramienta`
--

INSERT INTO `herramienta` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `recurso_id`, `recurso_tabla`, `repositorio_id`, `tipo_herramienta_id`) VALUES
(1, 'glosario1', 'glosario1', NULL, NULL, '2015-12-01 11:55:55', NULL, 6, 'glosario', 1, 1),
(2, 'skljdsadjkl', 'skljdsadjkl', NULL, '2015-12-01 12:00:27', '2015-12-01 11:58:23', NULL, 1, 'archivo_recurso', 1, 1),
(3, 'skljdsadjkl', 'skljdsadjkl', NULL, '2015-12-01 12:00:27', '2015-12-01 11:59:55', NULL, 1, NULL, 1, 1),
(4, 'osodosdo', 'osodosdo', NULL, '2015-12-02 09:51:24', '2015-12-02 09:42:48', NULL, 2, NULL, 1, 1),
(5, 'sdad', 'sasddsdsdsadsadsadsadsaddsssd', NULL, NULL, '2015-12-02 09:49:24', NULL, 3, NULL, 1, 1);

--
-- Volcado de datos para la tabla `institucion`
--

INSERT INTO `institucion` (`id`, `nombre`, `sigla`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_institucion_id`, `pais_id`, `region_id`) VALUES
(1, 'Universidad Tecnológica Metropolitana', 'Utem', 'vision', 'mision', b'1', '2015-11-24 17:15:19', '2015-11-24 17:15:19', 'des-utem', '2015-11-24 17:22:25', '2015-11-25 10:20:17', NULL, NULL, NULL);

--
-- Volcado de datos para la tabla `institucion_has_repositorio`
--

INSERT INTO `institucion_has_repositorio` (`institucion_id`, `repositorio_id`) VALUES
(1, 1);

--
-- Volcado de datos para la tabla `institucion_has_rol_usuario`
--

INSERT INTO `institucion_has_rol_usuario` (`institucion_id`, `rol_usuario_id`) VALUES
(1, 1),
(1, 2);

--
-- Volcado de datos para la tabla `link_interes`
--

INSERT INTO `link_interes` (`id`, `titulo`, `nombre`, `url`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(1, 'kljskljadkljsadjkl', 'skljdsadjkl', 'https://', 'mnmmmmnn,m,', '2015-12-01 11:59:54', '2015-12-01 12:00:27', NULL, 1),
(2, 'aoaoaoo', 'osodosdo', 'https://', 'hola mundo', '2015-12-02 09:42:48', '2015-12-02 09:51:24', NULL, 1),
(3, 'sasasasad', 'sdad', 'https://dssas', 'sasddsdsdsadsadsadsadsaddsssd', '2015-12-02 09:49:24', NULL, NULL, 1);

--
-- Volcado de datos para la tabla `modelo_aprendizaje`
--

INSERT INTO `modelo_aprendizaje` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`) VALUES
(44, 'modelo-full', 'des-modelo-full', NULL, NULL, '2015-11-30 16:09:24', NULL);

--
-- Volcado de datos para la tabla `modelo_aprendizaje_has_herramienta`
--

INSERT INTO `modelo_aprendizaje_has_herramienta` (`id`, `trabajo_grupal`, `archivo_recurso`, `link_interes`, `glosario`, `contenido_libre`, `foro`, `evaluacion`, `autoevaluacion`, `proyecto`, `recepcion_trabajo`, `evaluacion_no_objetiva`, `modelo_aprendizaje_id`) VALUES
(40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 44);

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`id`, `nombre`, `codigo`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_modulo_id`, `entidad_id`, `institucion_id`) VALUES
(9, 'Apresto uso plataforma', NULL, 'des-Apresto-uso-plataforma', '2015-11-20 16:08:35', NULL, 1, NULL, NULL),
(10, 'Determinacion huella de carbono', NULL, 'des-Determinacion-huella-de-carbono', '2015-11-20 16:09:19', NULL, 1, NULL, NULL),
(11, 'Determinacion huella hidrica', NULL, 'des-Determinacion-huella-hidrica', '2015-11-20 16:10:10', NULL, 1, NULL, NULL),
(12, 'Apresto plataforma', NULL, 'des-Apresto-plataforma', '2015-11-20 16:10:42', NULL, 1, NULL, NULL),
(13, NULL, NULL, NULL, '2015-11-25 11:42:26', NULL, 3, NULL, NULL),
(14, NULL, NULL, NULL, '2015-11-25 11:47:15', NULL, 3, NULL, NULL),
(15, 'ola', 'ola', 'ola', '2015-11-25 11:47:29', NULL, 1, NULL, 1);

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `nombre`, `codigo`) VALUES
(2, 'argentina', 'arg123');

--
-- Volcado de datos para la tabla `privilegio_usuario`
--

INSERT INTO `privilegio_usuario` (`id`, `nombre`, `controlador_usuario_id`) VALUES
(1, 'index', 1),
(2, 'index', 2);

--
-- Volcado de datos para la tabla `programa_academico`
--

INSERT INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`, `entidad_id`, `institucion_id`, `estado_programa_academico_id`) VALUES
(8, 'Ingenieria en subtentabilidad', 'des-Ingenieria-en-subtentabilidad', '1.0', '2015-11-20 16:07:33', '2015-11-26 11:53:26', NULL, 1, 1),
(9, 'Ingenieria en informatica', 'des-Ingenieria-en-informatica', '1.0', '2015-11-26 11:50:15', '2015-11-26 11:53:43', NULL, 1, 1),
(10, 'Diseño', 'des-diseño', '1.0', '2015-11-26 11:50:39', '2015-11-26 11:53:50', NULL, 1, 1),
(11, 'derecho', 'des-derecho', '1.0', '2015-11-26 11:50:56', NULL, NULL, NULL, 1),
(12, 'Ingenieria en redes', 'des-Ingenieria-en-redes', '1.0', '2015-11-26 11:51:31', NULL, NULL, NULL, 1);

--
-- Volcado de datos para la tabla `programa_academico_has_modulo`
--

INSERT INTO `programa_academico_has_modulo` (`programa_academico_id`, `modulo_id`) VALUES
(8, 9),
(8, 10),
(8, 11),
(8, 12),
(8, 15);

--
-- Volcado de datos para la tabla `reko_session`
--

INSERT INTO `reko_session` (`id`, `expire`, `data`) VALUES
('18pmg9ggn45hmu67tfsgu9q7u6', 1451592075, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b),
('6i1iguo8dphbs5849uk1dhidc5', 1449061592, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323337223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a226a6c6f70657a223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b),
('c1jm7hmu6rgesmli99p3mb4sd4', 1449061608, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b),
('k0uij5hoh6lvn5pcsnqlg46sc1', 1449061582, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323336223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a383a22646d6f72616c6573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d),
('leocktimso2uv1vfska7bhqc82', 1451591191, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b);

--
-- Volcado de datos para la tabla `repositorio`
--

INSERT INTO `repositorio` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `tipo_repositorio_id`, `modelo_aprendizaje_id`, `guia_instruccional_id`) VALUES
(1, 'repositorio-full', 'des-repositorio-full', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 44, NULL);

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
(1, 'superadministrador', 'descripcion superadministrador', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(2, 'superadministrador', 'descripcion superadministrador', 'rol_usuario_institucion', 1, '2015-12-01 16:11:26', NULL, NULL, '2015-12-01 16:11:26');

--
-- Volcado de datos para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

INSERT INTO `rol_usuario_has_authitem_permiso_usuario` (`rol_usuario_id`, `authitem_permiso_usuario_name`) VALUES
(1, 'aula'),
(1, 'repositorio'),
(2, 'aula'),
(2, 'repositorio');

--
-- Volcado de datos para la tabla `rol_usuario_has_privilegio_usuario`
--

INSERT INTO `rol_usuario_has_privilegio_usuario` (`rol_usuario_id`, `privilegio_usuario_id`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2);

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`id`, `nombre`, `codigo`, `jornada`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_seccion_id`, `modulo_id`) VALUES
(6, 'seccion 8', 'dfdsfdsf', 'sdfsdfsfd', 'dfsdfsdfsdf', '2015-11-25 12:32:04', '2015-11-25 12:34:07', NULL, 15),
(9, 'sadsad', 'sadsadas', 'asdsada', 'asdsadsad', '2015-11-25 16:56:09', NULL, 1, 9),
(11, 'sadsad', 'sadsadas', 'asdsada', 'asdsadsad', '2015-11-25 16:56:52', NULL, 1, 10),
(13, 'seccion13', 'seccion13', 'vespertina', 'rtrtrtretre', '2015-11-25 17:04:11', '2015-11-25 17:07:26', NULL, 15),
(16, 'sdsdsadsadjhsajdh', 'sjhdkjsahdksak', 'sajkhdkjsadhskadkh', 'sakjhdkjsahdkjsadk', '2015-11-25 17:09:43', NULL, 3, 9),
(21, 'ioiorueour', 'wiouewueqouo', 'wqueiu', 'wueweio', '2015-11-26 10:40:32', '2015-11-26 10:50:02', 3, 12);

--
-- Volcado de datos para la tabla `tipo_herramienta`
--

INSERT INTO `tipo_herramienta` (`id`, `nombre`) VALUES
(1, 'herramienta_troncal');

--
-- Volcado de datos para la tabla `tipo_repositorio`
--

INSERT INTO `tipo_repositorio` (`id`, `descripcion`) VALUES
(1, 'repositorio_troncal');

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
(250, 'jperez', '123', NULL, NULL, '2015-11-20 15:54:15', NULL),
(251, 'sdsdsad', 'sdsadd', NULL, NULL, '2015-11-24 11:55:22', NULL);

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
(236, 1),
(237, 1),
(238, 1),
(239, 1),
(240, 1),
(241, 1),
(248, 1);

--
-- Volcado de datos para la tabla `usuario_has_modulo`
--

INSERT INTO `usuario_has_modulo` (`usuario_id`, `modulo_id`, `rol_usuario_id`) VALUES
(248, 9, 198),
(236, 15, 195),
(236, 15, 196),
(236, 15, 197);

--
-- Volcado de datos para la tabla `usuario_has_programa_academico`
--

INSERT INTO `usuario_has_programa_academico` (`usuario_id`, `programa_academico_id`, `rol_usuario_id`) VALUES
(236, 8, 195),
(236, 8, 196),
(236, 8, 197),
(248, 8, 198);

--
-- Volcado de datos para la tabla `usuario_has_rol_usuario`
--

INSERT INTO `usuario_has_rol_usuario` (`usuario_id`, `rol_usuario_id`) VALUES
(248, 2);

--
-- Volcado de datos para la tabla `usuario_has_seccion`
--

INSERT INTO `usuario_has_seccion` (`usuario_id`, `rol_usuario_id`, `seccion_id`) VALUES
(236, 195, 6);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
