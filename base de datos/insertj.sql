-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 30-11-2015 a las 13:16:34
-- Versión del servidor: 5.5.20
-- Versión de PHP: 5.3.10
SET foreign_key_checks = 0;
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

INSERT IGNORE INTO `archivo` (`id`, `nombre`, `mime_type`, `tamano`, `ruta`, `usuario_id`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `fecha_eliminacion`, `lectura`, `escritura`, `descarga`, `eliminacion`, `contenedor_id`, `contenedor_tabla`) VALUES
(56, '220657-red-planet-wallpaper-14428.jpg', 'image/jpeg', 392762, '/reko-archivos/utem/repositorio-id-1/glosario/glosario-id-8/', 1, '2015-11-27 12:23:46', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 8, 'glosario');

--
-- Volcado de datos para la tabla `archivo_recurso`
--

INSERT IGNORE INTO `archivo_recurso` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_elminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(4, '4 archivo recurso', '4 descripcion archivo recurso', '2015-11-26 16:38:52', '2015-11-27 10:25:49', NULL, NULL, 1),
(5, '5 archivo recurso', '5 descripcion archivo recurso', '2015-11-26 17:06:15', '2015-11-27 10:26:13', NULL, NULL, 1);

--
-- Volcado de datos para la tabla `authassignment_administrador`
--

INSERT IGNORE INTO `authassignment_administrador` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('administracion_rol_administrador', '1', NULL, NULL),
('administracion_rol_usuario', '1', NULL, NULL),
('administracion_rol_usuario', '2', NULL, 'N;'),
('administracion_usuario', '1', NULL, NULL),
('administracion_usuario', '2', NULL, 'N;'),
('administracion_usuario_administrador', '1', NULL, NULL),
('admin_rol_usuario', '2', NULL, 'N;'),
('admin_usuario', '2', NULL, 'N;');

--
-- Volcado de datos para la tabla `authassignment_usuario`
--

INSERT IGNORE INTO `authassignment_usuario` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('aula', '1', NULL, NULL),
('aula', '2', NULL, NULL),
('aula', '3', NULL, NULL),
('aula', '4', NULL, NULL),
('aula', '5', NULL, NULL),
('repositorio', '1', NULL, NULL),
('repositorio', '4', NULL, NULL),
('repositorio', '5', NULL, NULL);

--
-- Volcado de datos para la tabla `authitem_permiso_administrador`
--

INSERT IGNORE INTO `authitem_permiso_administrador` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('administracion_rol_administrador', 2, '', '', ''),
('administracion_rol_usuario', 2, NULL, NULL, NULL),
('administracion_usuario', 2, '', NULL, 'N;'),
('administracion_usuario_administrador', 2, '', NULL, 'N;'),
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

INSERT IGNORE INTO `authitem_permiso_usuario` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('aula', 2, NULL, NULL, NULL),
('mesa_de_ayuda', 2, NULL, NULL, NULL),
('repositorio', 2, NULL, NULL, NULL);

--
-- Volcado de datos para la tabla `controlador_administrador`
--

INSERT IGNORE INTO `controlador_administrador` (`id`, `nombre`, `authitem_permiso_administrador_name`) VALUES
(1, 'AuthitemPermisoAdministrador', 'admin_rol_administrador'),
(2, 'ControladorAdministrador', 'admin_rol_administrador'),
(3, 'Default', 'admin_rol_administrador'),
(4, 'PrivilegioAdministrador', 'admin_rol_administrador'),
(5, 'RolAdministrador', 'admin_rol_administrador'),
(6, 'UsuarioAdministrador', 'admin_usuario_administrador'),
(7, 'Default', 'admin_usuario_administrador'),
(8, 'Usuario', 'admin_usuario'),
(9, 'Default', 'admin_usuario'),
(10, 'RolUsuario', 'admin_rol_usuario'),
(11, 'default', 'admin_rol_usuario'),
(12, 'AuthitemPermisoUsuario', 'admin_rol_usuario'),
(13, 'ControladorUsuario', 'admin_rol_usuario'),
(14, 'PrivilegioUsuario', 'admin_rol_usuario');

--
-- Volcado de datos para la tabla `controlador_usuario`
--

INSERT IGNORE INTO `controlador_usuario` (`id`, `nombre`, `authitem_permiso_usuario_name`) VALUES
(1, 'Aula', 'aula'),
(2, 'Default', 'aula'),
(3, 'Repositorio', 'repositorio'),
(4, 'Default', 'repositorio');

--
-- Volcado de datos para la tabla `dato_academico`
--

INSERT IGNORE INTO `dato_academico` (`id`, `universidad`, `carrera`, `ano_cursado`, `duracion_carrera`, `sede`, `direccion_sede`, `comuna_sede`, `ciudad_sede`, `usuario_id`) VALUES
(1, 'akjassa', 'askjak', 5, 5, 'skldj', 'sakjhd', 'sakjdhd', 'sakjdh', 9),
(2, 'wuyeywueuiy', 'nmbcnxmnmcz', 45454, 0, 'sadsad', 'sadsad', 'sadsad', 'sdsdsda', 2),
(3, 'utem', 'ingenieria informatica', 3, 6, 'macul', 'macul 123 ', 'santiago', 'santiago', 234);

--
-- Volcado de datos para la tabla `dato_laboral`
--

INSERT IGNORE INTO `dato_laboral` (`id`, `nombre_empresa`, `ano_antiguedad`, `cargo`, `actividad`, `comuna_empresa`, `ciudad_empresa`, `telefono_empresa`, `celular_empresa`, `rut_numero`, `digito_verificador`, `usuario_id`) VALUES
(1, 'empresa', 3, 'analista', 'informatica', 'santiago', 'santiago', 5826584, 45256987, 11589125, 1, 234),
(2, 'dvcvcvcxvcv', 12121, 'efefefef', 'saxsadsads', 'sakjhdsakjsk', 'sakhdskjhdsak', 212121, 212121, 21212, 21212, 2);

--
-- Volcado de datos para la tabla `dato_login`
--

INSERT IGNORE INTO `dato_login` (`id`, `usuario_id`, `codigo_seguridad_id`) VALUES
(1, 1, 0),
(2, 1, 0),
(3, 5, 0);

--
-- Volcado de datos para la tabla `dato_personal`
--

INSERT IGNORE INTO `dato_personal` (`id`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `edad`, `rut`, `digito_verificador`, `direccion_personal`, `numero_casa`, `telefono_personal`, `celular_personal`, `comuna_personal`, `ciudad_personal`, `interes`, `estado_civil`, `idioma`, `nacionalidad`, `usuario_id`) VALUES
(2, 'kjhxjhzkj<xhKHZ<KJXH', 'askjhaskh', 'skjdhskjsdh', 'askjha', '2015-08-10 17:04:11', 2121, 2121, 2121, 'askjaks', 454, 5454, 545, 'ajhsajsajhsk', 'akjshajksh', 'akjshakjsh', 'kjahsakjhs', 'kajshkjasjh', 'kjhakjshaks', 234),
(100, 'christian', NULL, 'reyes', 'arellano', NULL, 11, 11111111, 1, NULL, NULL, NULL, NULL, 'maipu', 'santiago', NULL, NULL, 'espanol', 'chileno', 1),
(200, 'francisco', NULL, 'carvajal', NULL, NULL, 22, 22222222, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(300, 'victor', NULL, 'guzman', NULL, NULL, 33, 33333333, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(400, 'marcelo', NULL, NULL, NULL, NULL, 44, 44444444, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4),
(500, 'patricio', NULL, 'iriarte', NULL, NULL, 55, 55555555, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5);

--
-- Volcado de datos para la tabla `entidad`
--

INSERT IGNORE INTO `entidad` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `institucion_id`, `entidad_id`, `estado_entidad_id`) VALUES
(1, 'centro de alumno', 'des-centro', '2015-11-06 15:34:44', NULL, 14, NULL, NULL),
(2, 'sdsad', 'sdsasad', NULL, NULL, 15, NULL, NULL),
(3, 'sdsd', 'sadsad', NULL, NULL, 16, NULL, NULL),
(4, 'facultad', 'facul-des', '2015-09-04 16:40:13', '2015-09-04 16:40:13', 2, 1, 1),
(5, 'prueba1', 'des1', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 4, 2),
(6, 'prueba2', 'des2', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 4, 2),
(7, 'prueba3', 'des3', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 4, 2),
(8, 'prueba4', 'des4', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 1, 2),
(9, 'prueba5', 'des5', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 1, 2);

--
-- Volcado de datos para la tabla `estado_codigo_seguridad`
--

INSERT IGNORE INTO `estado_codigo_seguridad` (`id`, `estado`, `codigo_seguridad_id`) VALUES
(1, 'bloqueadostodos', 0);

--
-- Volcado de datos para la tabla `estado_entidad`
--

INSERT IGNORE INTO `estado_entidad` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `estado_institucion`
--

INSERT IGNORE INTO `estado_institucion` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `estado_modulo`
--

INSERT IGNORE INTO `estado_modulo` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

--
-- Volcado de datos para la tabla `estado_programa_academico`
--

INSERT IGNORE INTO `estado_programa_academico` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

--
-- Volcado de datos para la tabla `estado_seccion`
--

INSERT IGNORE INTO `estado_seccion` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

--
-- Volcado de datos para la tabla `estado_usuario`
--

INSERT IGNORE INTO `estado_usuario` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'en espera'),
(3, 'eliminado');

--
-- Volcado de datos para la tabla `glosario`
--

INSERT IGNORE INTO `glosario` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_eliminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(8, 'nuevo glosariooooooooooooooo', 'descripcion nuevo glosario', '2015-11-26 17:04:32', '2015-11-26 17:40:26', NULL, NULL, 1);

--
-- Volcado de datos para la tabla `herramienta`
--

INSERT IGNORE INTO `herramienta` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `recurso_id`, `recurso_tabla`, `repositorio_id`, `tipo_herramienta_id`) VALUES
(45, '4 archivo recurso', '4 descripcion archivo recurso', NULL, '2015-11-27 10:25:49', '2015-11-26 16:38:52', NULL, 4, 'archivo_recurso', 1, 1),
(47, 'nuevo glosariooooooooooooooo', 'descripcion nuevo glosario', NULL, '2015-11-26 17:40:26', '2015-11-26 17:04:32', NULL, 8, 'glosario', 1, 1),
(48, '5 archivo recurso', '5 descripcion archivo recurso', NULL, '2015-11-27 10:26:13', '2015-11-26 17:06:15', NULL, 5, 'archivo_recurso', 1, 1);

--
-- Volcado de datos para la tabla `icono_aplicacion_administrador`
--

INSERT IGNORE INTO `icono_aplicacion_administrador` (`id`, `estilo`, `authitem_permiso_administrador_name`) VALUES
(1, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario_administrador";?>" >\n            <div class="tile-wide bg-teal fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-user"></span>\n                </div>\n                <span class="tile-label">\n                    <?php \n                        $pizza  = CHtml::encode(''administracion_usuario_administrador'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>\n                </span>\n            </div>\n        </a>', 'admin_usuario_administrador'),
(2, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador";?>" >\n            <div class="tile bg-darkBlue fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-security"></span>\n                </div>\n                <span class="tile-label">            \n                    <?php \n                        $pizza  = CHtml::encode(''administracion_rol_administrador'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>                \n                </span>\n            </div>\n        </a>', 'admin_rol_administrador'),
(3, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_usuario";?>" >\n            <div class="tile bg-darkCyan fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-security"></span>\n                </div>\n                <span class="tile-label">            \n                    <?php \n                        $pizza  = CHtml::encode(''administracion_rol_usuario'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>                \n                </span>\n            </div>\n        </a>', 'admin_rol_usuario'),
(4, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario";?>" >\n            <div class="tile-wide bg-darkGreen fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-users"></span>\n                </div>\n                <span class="tile-label">\n                    <?php \n                        $pizza  = CHtml::encode(''administracion_usuario'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>\n                </span>\n            </div>\n        </a>', 'admin_usuario'),
(5, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_institucion";?>" >\n            <div class="tile-large bg-darkPink fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-library"></span>\n                </div>\n                <span class="tile-label">\n                    <?php \n                        $pizza  = CHtml::encode(''administracion_institucion'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>\n                </span>\n            </div>\n        </a>', 'admin_institucion'),
(6, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_curricular";?>" >\n            <div class="tile-wide bg-darkViolet fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-school"></span>\n                </div>\n                <span class="tile-label">            \n                    <?php \n                        $pizza  = CHtml::encode(''administracion_curricular'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>                \n                </span>\n            </div>\n        </a>', 'admin_curricular'),
(7, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_escritorio";?>" >\n            <div class="tile-wide bg-green fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-display"></span>\n                </div>\n                <span class="tile-label">\n                    <?php \n                        $pizza  = CHtml::encode(''administracion_escritorio'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>\n                </span>\n            </div>\n        </a>', 'admin_escritorio'),
(8, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_aplicacion";?>" >\n            <div class="tile bg-amber fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-widgets"></span>\n                </div>\n                <span class="tile-label">            \n                    <?php \n                        $pizza  = CHtml::encode(''administracion_aplicacion'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>                \n                </span>\n            </div>\n        </a>', 'admin_aplicacion'),
(9, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_aula";?>"><div class="tile-wide bg-lime fg-white" data-role="tile"><div class="tile-content iconic"><span class="icon mif-books"></span></div><span class="tile-label"><?php $pizza=CHtml::encode(''administracion_aula'');$porciones=explode("_", $pizza);foreach($porciones as $p){echo $p." ";} ?></span></div></a>', 'admin_aula'),
(10, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_repositorio";?>" >\n            <div class="tile-large bg-brown fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-cabinet"></span>\n                </div>\n                <span class="tile-label">            \n                    <?php \n                        $pizza  = CHtml::encode(''administracion_repositorio'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>                \n                </span>\n            </div>  \n        </a>', 'admin_repositorio'),
(11, '<a href="<?php echo Yii::app()->getBaseUrl()."/admin_error_log_mensaje";?>" >\n            <div class="tile-large bg-red fg-white" data-role="tile">\n                <div class="tile-content iconic">\n                    <span class="icon mif-history"></span>\n                </div>\n                <span class="tile-label">\n                    <?php \n                        $pizza  = CHtml::encode(''administracion_error_log_mensaje'');\n                        $porciones = explode("_", $pizza);\n                        foreach ($porciones as $p)\n                        echo $p." "; // porción\n                    ?>\n                </span>\n            </div>  \n        </a>', 'admin_error_log_mensaje');

--
-- Volcado de datos para la tabla `institucion`
--

INSERT IGNORE INTO `institucion` (`id`, `nombre`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_institucion_id`) VALUES
(1, 'utem', 'vision', 'mision', b'0', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 'ajhsjah', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 2),
(2, 'duoc', 'vision', 'mision', b'1', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 'kjahsa', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 1),
(3, 'usash', 'vision', 'mision', b'1', '2015-08-10 11:48:35', '2015-08-10 11:48:35', 'descripcion', NULL, NULL, 1),
(4, 'catolica', 'vision', 'sakjhdksj', b'1', '2015-08-10 12:11:56', '2015-08-10 12:11:56', 'sdsdsdasd', '2015-08-10 12:16:53', '2015-08-10 12:22:20', NULL),
(5, 'udp', 'kljsakdljsadl', 'olaolaolaolaola', b'1', '2015-08-12 10:28:29', '2015-08-12 10:28:29', 'kjsdjkjsahdkjsd', '2015-08-12 10:33:26', '2015-08-12 10:33:47', NULL),
(6, 'kjksjaklsadklj', 'salkjdskljd', 'djlskdj', b'1', NULL, NULL, 'sdsadsadasd', '2015-09-21 16:11:06', NULL, NULL),
(7, 'tvn', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'chv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'c13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'mega', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'la red', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'telecanal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'etc tv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'utem', 'vision', 'mision', b'1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'des-utem', '2015-11-06 11:05:31', '2015-11-06 15:33:49', 3),
(15, 'sdsadsad', 'sdsadsa', 'sadasd', b'1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'sadsdsadsadsadasd', '2015-11-06 13:12:08', NULL, 1),
(16, 'dfdfdf', 'dfsdfdsf', 'sdfsdfsdfdf', b'1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'dsfdsfdfdf', '2015-11-06 13:14:05', NULL, NULL);

--
-- Volcado de datos para la tabla `institucion_has_repositorio`
--

INSERT IGNORE INTO `institucion_has_repositorio` (`institucion_id`, `repositorio_id`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2);

--
-- Volcado de datos para la tabla `institucion_has_rol_usuario`
--

INSERT IGNORE INTO `institucion_has_rol_usuario` (`institucion_id`, `rol_usuario_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 186),
(1, 187),
(1, 188);

--
-- Volcado de datos para la tabla `modelo_aprendizaje`
--

INSERT IGNORE INTO `modelo_aprendizaje` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`) VALUES
(1, 'A1 modelo de aprendizaje ', 'A1 descripcion modelo aprendizaje', NULL, NULL, NULL, NULL),
(2, 'B2 modelo de aprendizaje', 'B2 descripcion modelo de aprendizaje', NULL, NULL, NULL, NULL),
(3, 'C3 modelo aprendizaje', 'C3 descripcion modelo aprendizaje', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(36, 'BART', 'HOMERO', NULL, '2015-10-26 16:24:52', '2015-10-23 11:27:15', NULL),
(37, 'MOU', 'DUFF', NULL, NULL, '2015-10-26 12:13:27', NULL),
(38, 'HERMOSO', 'HERMOSURA', NULL, '2015-10-26 16:18:07', '2015-10-26 13:22:15', NULL),
(39, 'AHH SIII', 'WOM', NULL, '2015-10-26 16:33:11', '2015-10-26 16:23:21', NULL),
(40, 'CLARO ', 'MARTIN CARCAMO', NULL, NULL, '2015-10-26 16:33:45', NULL),
(41, 'NEXTEL', 'TONKA', NULL, '2015-10-26 16:35:28', '2015-10-26 16:35:07', NULL),
(42, 'e-learning', 'descripcion modelo aprendizaje  e-learning', NULL, NULL, '2015-11-03 12:57:37', NULL),
(43, 'full', 'descripcion modelo aprendizaje full', NULL, NULL, '2015-11-03 16:15:00', NULL);

--
-- Volcado de datos para la tabla `modelo_aprendizaje_has_herramienta`
--

INSERT IGNORE INTO `modelo_aprendizaje_has_herramienta` (`id`, `trabajo_grupal`, `archivo_recurso`, `link_interes`, `glosario`, `contenido_libre`, `foro`, `evaluacion`, `autoevaluacion`, `proyecto`, `recepcion_trabajo`, `evaluacion_no_objetiva`, `modelo_aprendizaje_id`) VALUES
(32, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 36),
(33, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 37),
(34, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 38),
(35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 39),
(36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 40),
(37, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 41),
(38, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 42),
(39, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 43);

--
-- Volcado de datos para la tabla `modulo`
--

INSERT IGNORE INTO `modulo` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_modulo_id`, `entidad_id`, `institucion_id`) VALUES
(1, 'matematicas', 'des-matematicas', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL),
(2, 'lenguaje', 'des-lenguaje', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL),
(3, 'calculo', 'des-calculo', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL),
(4, 'historia', 'des-historia', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL),
(5, 'algebra', 'des-algebra', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL),
(6, 'dibujo', 'des-dibujo', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL),
(7, 'estadistica', 'des-estadistica', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, NULL, NULL);

--
-- Volcado de datos para la tabla `pais`
--

INSERT IGNORE INTO `pais` (`id`, `nombre`, `codigo`) VALUES
(1, 'chile', 'chile02'),
(2, 'brasil', 'ar34'),
(3, 'dasdsadsad', 'sadsadsad'),
(4, 'uiituiooru', 'oriuiorutre');

--
-- Volcado de datos para la tabla `pregunta_login`
--

INSERT IGNORE INTO `pregunta_login` (`id`, `pregunta`) VALUES
(1, 'donde naciste'),
(2, 'nombre de tu mama'),
(3, 'nombre de tu perro'),
(4, 'mejor amigo '),
(5, 'interes'),
(6, 'ola que haces'),
(7, 'fgdsfgdfgdfgdfd');

--
-- Volcado de datos para la tabla `privilegio_administrador`
--

INSERT IGNORE INTO `privilegio_administrador` (`id`, `nombre`, `controlador_administrador_id`) VALUES
(1, 'index', 1),
(2, 'view', 1),
(3, 'admin', 1),
(4, 'create', 1),
(5, 'update', 1),
(6, 'delete', 1),
(7, 'index', 2),
(8, 'view', 2),
(9, 'admin', 2),
(10, 'create', 2),
(11, 'update', 2),
(12, 'delete', 2),
(13, 'index', 3),
(14, 'view', 3),
(15, 'admin', 3),
(16, 'create', 3),
(17, 'update', 3),
(18, 'delete', 3),
(19, 'index', 4),
(20, 'view', 4),
(21, 'admin', 4),
(22, 'create', 4),
(23, 'update', 4),
(24, 'delete', 4),
(25, 'index', 5),
(26, 'view', 5),
(27, 'admin', 5),
(28, 'create', 5),
(29, 'update', 5),
(30, 'delete', 5),
(31, 'index', 6),
(32, 'view', 6),
(33, 'admin', 6),
(34, 'create', 6),
(35, 'update', 6),
(36, 'delete', 6),
(37, 'index', 7),
(38, 'view', 7),
(39, 'admin', 7),
(40, 'create', 7),
(41, 'update', 7),
(42, 'delete', 7),
(43, 'index', 8),
(44, 'view', 8),
(45, 'admin', 8),
(46, 'create', 8),
(47, 'update', 8),
(48, 'delete', 8),
(49, 'index', 9),
(50, 'view', 9),
(51, 'admin', 9),
(52, 'create', 9),
(53, 'update', 9),
(54, 'delete', 9),
(55, 'index', 10),
(56, 'view', 10),
(57, 'admin', 10),
(58, 'create', 10),
(59, 'update', 10),
(60, 'delete', 10),
(61, 'index', 11),
(62, 'view', 11),
(63, 'admin', 11),
(64, 'create', 11),
(65, 'update', 11),
(66, 'delete', 11),
(67, 'index', 12),
(68, 'view', 12),
(69, 'admin', 12),
(70, 'create', 12),
(71, 'update', 12),
(72, 'delete', 12),
(73, 'index', 13),
(74, 'view', 13),
(75, 'admin', 13),
(76, 'create', 13),
(77, 'update', 13),
(78, 'delete', 13),
(79, 'index', 14),
(80, 'view', 14),
(81, 'admin', 14),
(82, 'create', 14),
(83, 'update', 14),
(84, 'delete', 14);

--
-- Volcado de datos para la tabla `privilegio_usuario`
--

INSERT IGNORE INTO `privilegio_usuario` (`id`, `nombre`, `controlador_usuario_id`) VALUES
(1, 'index', 1),
(2, 'view', 1),
(3, 'admiin', 1),
(4, 'create', 1),
(5, 'update', 1),
(6, 'delete', 1),
(7, 'index', 2),
(8, 'view', 2),
(9, 'admin', 2),
(10, 'create', 2),
(11, 'update', 2),
(12, 'delete', 2),
(13, 'index', 3),
(14, 'view', 3),
(15, 'admin', 3),
(16, 'create', 3),
(17, 'update', 3),
(18, 'delete', 3),
(19, 'index', 4),
(20, 'view', 4),
(21, 'admin', 4),
(22, 'create', 4),
(23, 'update', 4),
(24, 'delete', 4);

--
-- Volcado de datos para la tabla `programa_academico`
--

INSERT IGNORE INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`, `entidad_id`, `institucion_id`, `estado_programa_academico_id`) VALUES
(1, 'ingenieria en informatica', 'des-info', '1.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', 1, NULL, NULL),
(2, 'diseño', 'des-diseño', '1.5', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, 2, NULL),
(3, 'derecho', 'des-derecho', '2.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', 2, NULL, NULL),
(4, 'juegos', 'des-juegos', '3.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, 5, NULL),
(5, 'redes', 'des-redes', '4.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, 2, NULL);

--
-- Volcado de datos para la tabla `programa_academico_has_modulo`
--

INSERT IGNORE INTO `programa_academico_has_modulo` (`programa_academico_id`, `modulo_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7);

--
-- Volcado de datos para la tabla `region`
--

INSERT IGNORE INTO `region` (`id`, `nombre`, `codigo`, `pais_id`) VALUES
(1, 'Arica y Parinacota', 'XV', 1),
(2, 'Tarapaca', 'I', 1),
(3, 'Antofagasta', 'II', 1),
(4, 'Atacama', 'III', 1),
(5, 'Coquimbo', 'IV', 1),
(6, 'Valparaiso', 'V', 1),
(7, 'Metropolitana de Santiago', 'RM', 1),
(8, 'Ohiggins', 'VI', 1),
(9, 'Maule', 'VII', 1),
(10, 'Biobio', 'VIII', 1),
(11, 'La Araucania', 'IX', 1),
(12, 'Los Rios', 'XIV', 1),
(13, 'Los Lagos', 'X', 1),
(14, 'Aysen', 'XI', 1),
(15, 'Magallanes', 'XII', 1);

--
-- Volcado de datos para la tabla `reko_session`
--

INSERT IGNORE INTO `reko_session` (`id`, `expire`, `data`) VALUES
('octu3humc25jog0spbbl4gf4a5', 1451245356, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a313a2231223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2230223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d30382d30362031353a34303a3332223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d30382d30362031353a34303a3332223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31303a7b733a323a226964223b733a313a2231223b733a363a226e6f6d627265223b733a31343a223141207265706f7369746f72696f223b733a31313a226465736372697063696f6e223b733a31343a223141207265706f7369746f72696f223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b4e3b733a31343a2266656368615f6372656163696f6e223b4e3b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223433223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a313a2231223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d);

--
-- Volcado de datos para la tabla `repositorio`
--

INSERT IGNORE INTO `repositorio` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `tipo_repositorio_id`, `modelo_aprendizaje_id`, `guia_instruccional_id`) VALUES
(1, '1A repositorio', '1A repositorio', NULL, NULL, NULL, NULL, 1, 43, NULL),
(2, '2B repositorio', '2B repositorio', NULL, NULL, NULL, NULL, 1, 42, NULL),
(3, 'repositorio 1 ', 'descripcion repositorio q', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, NULL, NULL, NULL),
(4, 'repositorio 2', 'descripcion repositorio 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL, NULL, NULL, NULL);

--
-- Volcado de datos para la tabla `rol_administrador`
--

INSERT IGNORE INTO `rol_administrador` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superadministrador', NULL),
(5, 'root', ''),
(6, 'supervisor usuario', 'usuario y rol usuario'),
(7, 'mantenedor', 'descripcion mantenedor'),
(8, '', '');

--
-- Volcado de datos para la tabla `rol_administrador_has_authitem_permiso_administrador`
--

INSERT IGNORE INTO `rol_administrador_has_authitem_permiso_administrador` (`rol_administrador_id`, `authitem_permiso_administrador_name`) VALUES
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
(1, 'admin_usuario_administrador'),
(5, 'admin_aplicacion'),
(5, 'admin_rol_usuario'),
(5, 'admin_usuario'),
(5, 'admin_usuario_administrador'),
(6, 'admin_rol_usuario'),
(6, 'admin_usuario');

--
-- Volcado de datos para la tabla `rol_administrador_has_privilegio_administrador`
--

INSERT IGNORE INTO `rol_administrador_has_privilegio_administrador` (`rol_administrador_id`, `privilegio_administrador_id`) VALUES
(1, 31),
(5, 31),
(1, 32),
(5, 32),
(1, 33),
(5, 33),
(1, 34),
(5, 34),
(1, 35),
(5, 35),
(1, 36),
(5, 36),
(1, 37),
(5, 37),
(1, 38),
(5, 38),
(1, 39),
(5, 39),
(1, 40),
(5, 40),
(1, 41),
(5, 41),
(1, 42),
(5, 42),
(1, 43),
(5, 43),
(6, 43),
(1, 44),
(5, 44),
(6, 44),
(1, 45),
(5, 45),
(6, 45),
(1, 46),
(5, 46),
(6, 46),
(1, 47),
(5, 47),
(6, 47),
(1, 48),
(5, 48),
(6, 48),
(1, 49),
(5, 49),
(6, 49),
(1, 50),
(5, 50),
(6, 50),
(1, 51),
(5, 51),
(6, 51),
(1, 52),
(5, 52),
(6, 52),
(1, 53),
(5, 53),
(6, 53),
(1, 54),
(5, 54),
(6, 54),
(1, 55),
(5, 55),
(6, 55),
(1, 56),
(6, 56),
(1, 57),
(5, 57),
(6, 57),
(1, 58),
(5, 58),
(6, 58),
(1, 59),
(5, 59),
(6, 59),
(1, 60),
(5, 60),
(6, 60),
(1, 61),
(5, 61),
(6, 61),
(1, 62),
(5, 62),
(6, 62),
(1, 63),
(5, 63),
(6, 63),
(1, 64),
(5, 64),
(6, 64),
(1, 65),
(5, 65),
(6, 65),
(1, 66),
(5, 66),
(6, 66),
(1, 67),
(5, 67),
(6, 67),
(1, 68),
(5, 68),
(6, 68),
(1, 69),
(5, 69),
(6, 69),
(1, 70),
(5, 70),
(6, 70),
(1, 71),
(5, 71),
(6, 71),
(1, 72),
(5, 72),
(6, 72),
(1, 73),
(5, 73),
(6, 73),
(1, 74),
(5, 74),
(6, 74),
(1, 75),
(5, 75),
(6, 75),
(1, 76),
(5, 76),
(6, 76),
(1, 77),
(5, 77),
(6, 77),
(1, 78),
(5, 78),
(6, 78),
(1, 79),
(5, 79),
(6, 79),
(1, 80),
(5, 80),
(6, 80),
(1, 81),
(5, 81),
(6, 81),
(1, 82),
(5, 82),
(6, 82),
(1, 83),
(5, 83),
(6, 83),
(1, 84),
(5, 84),
(6, 84);

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT IGNORE INTO `rol_usuario` (`id`, `nombre`, `descripcion`, `tipo`, `rol_usuario_general_id`, `fecha_creacion`, `fecha_eliminacion`, `fecha_acceso`, `fecha_modificacion`) VALUES
(1, 'superusuario', 'rol superusuario', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'profesor', 'rol profesor', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'alumno', 'rol alumno', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'ayudante', 'rol ayudante', 'rol_usuario_general', NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'inspector', 'rol inspector', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(6, 'percutor', 'rol percutor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(7, 'constructor', 'rol constructor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(88, 'profesor', 'rol profesor', 'rol_usuario_institucion', 2, '2015-10-09 18:13:43', NULL, NULL, '2015-10-09 18:13:43'),
(89, 'alumno', 'rol alumno', 'rol_usuario_institucion', 3, '2015-10-09 18:13:44', NULL, NULL, '2015-10-09 18:13:44'),
(90, 'ayudante', 'rol ayudante', 'rol_usuario_institucion', 4, '2015-10-09 18:13:45', NULL, NULL, '2015-10-09 18:13:45'),
(186, 'profesor', 'rol profesor', 'rol_usuario_institucion', 2, '2015-10-15 11:31:41', NULL, NULL, '2015-10-15 11:31:41'),
(187, 'alumno', 'rol alumno', 'rol_usuario_institucion', 3, '2015-10-15 11:31:42', NULL, NULL, '2015-10-15 11:31:42'),
(188, 'ayudante', 'rol ayudante', 'rol_usuario_institucion', 4, '2015-10-15 11:31:44', NULL, NULL, '2015-10-15 11:31:44'),
(189, 'destructor', 'rol destructor', 'rol_usuario_general', NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Volcado de datos para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

INSERT IGNORE INTO `rol_usuario_has_authitem_permiso_usuario` (`rol_usuario_id`, `authitem_permiso_usuario_name`) VALUES
(1, 'aula'),
(1, 'mesa_de_ayuda'),
(1, 'repositorio'),
(2, 'aula'),
(2, 'repositorio'),
(3, 'aula'),
(3, 'repositorio'),
(4, 'mesa_de_ayuda'),
(186, 'aula'),
(186, 'repositorio'),
(187, 'aula'),
(187, 'repositorio'),
(188, 'mesa_de_ayuda');

--
-- Volcado de datos para la tabla `rol_usuario_has_privilegio_usuario`
--

INSERT IGNORE INTO `rol_usuario_has_privilegio_usuario` (`rol_usuario_id`, `privilegio_usuario_id`) VALUES
(1, 1),
(2, 1),
(88, 1),
(186, 1),
(1, 2),
(2, 2),
(88, 2),
(186, 2),
(1, 3),
(2, 3),
(88, 3),
(186, 3),
(1, 4),
(2, 4),
(88, 4),
(186, 4),
(1, 5),
(2, 5),
(88, 5),
(186, 5),
(1, 6),
(2, 6),
(88, 6),
(186, 6),
(1, 7),
(2, 7),
(88, 7),
(186, 7),
(1, 8),
(2, 8),
(88, 8),
(186, 8),
(1, 9),
(2, 9),
(88, 9),
(186, 9),
(1, 10),
(2, 10),
(88, 10),
(186, 10),
(1, 11),
(2, 11),
(88, 11),
(186, 11),
(1, 12),
(2, 12),
(88, 12),
(186, 12),
(1, 13),
(3, 13),
(187, 13),
(1, 14),
(3, 14),
(187, 14),
(1, 15),
(3, 15),
(187, 15),
(1, 16),
(3, 16),
(187, 16),
(1, 17),
(3, 17),
(187, 17),
(1, 18),
(3, 18),
(187, 18),
(1, 19),
(3, 19),
(187, 19),
(1, 20),
(3, 20),
(187, 20),
(1, 21),
(3, 21),
(187, 21),
(1, 22),
(3, 22),
(187, 22),
(1, 23),
(3, 23),
(187, 23),
(1, 24),
(3, 24),
(187, 24);

--
-- Volcado de datos para la tabla `seccion`
--

INSERT IGNORE INTO `seccion` (`id`, `nombre`, `jornada`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `modulo_id`, `estado_seccion_id`) VALUES
(6, 'mnbvbnmvc', 'nmcvbbnmvxc', 'cmnvbnmcbvx', '2015-08-12 11:38:53', '2015-08-12 11:39:57', 1, NULL);

--
-- Volcado de datos para la tabla `tipo_herramienta`
--

INSERT IGNORE INTO `tipo_herramienta` (`id`, `nombre`) VALUES
(1, 'herramienta_troncal');

--
-- Volcado de datos para la tabla `tipo_repositorio`
--

INSERT IGNORE INTO `tipo_repositorio` (`id`, `descripcion`) VALUES
(1, 'repositorio_troncal');

--
-- Volcado de datos para la tabla `usuario`
--

INSERT IGNORE INTO `usuario` (`id`, `usuario`, `clave`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `estado_usuario_id`) VALUES
(1, 'creyes', '123', '2015-09-09 12:23:17', '2015-11-06 11:00:30', '2015-09-09 12:23:17', 1),
(2, 'francisco', '123', '2015-09-09 12:23:17', '2015-11-11 11:20:24', '2015-09-09 12:23:17', NULL),
(3, 'victor', '123', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(4, 'marcelo', '123', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(5, 'patricio', '123', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(6, 'usuario6', 'clave6', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(7, 'usuario7', 'clave7', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(8, 'usuario8', 'clave8', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(9, 'usuario9', 'clave9', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 3),
(10, 'andres', '123', NULL, NULL, '2015-08-25 10:16:24', NULL),
(11, 'carlos', '123', NULL, NULL, '2015-08-25 10:16:31', NULL),
(12, 'ricardo', '123', NULL, NULL, '2015-08-25 10:16:41', NULL),
(13, 'rodrigo', '123', NULL, NULL, '2015-08-25 10:16:52', NULL),
(14, 'daniel', '123', NULL, NULL, '2015-08-25 10:17:00', NULL),
(15, 'matias', '123', NULL, NULL, '2015-08-25 10:19:12', NULL),
(186, 'usuario viejo', 'viejo clave', NULL, '2015-08-10 16:09:43', '2015-08-10 16:09:16', NULL),
(187, 'nbnvmcvmc', 'nmcbvnmcxvnv', NULL, '2015-08-12 09:57:23', '2015-08-12 09:57:11', NULL),
(189, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(190, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(191, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(192, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(193, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(194, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(195, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(196, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(197, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(198, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(199, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(200, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(201, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(202, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(203, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL),
(233, 'dmorales', '123456', NULL, '2015-11-06 11:00:21', '2015-11-06 10:59:52', 3),
(234, 'kof', '123456', NULL, '2015-11-09 18:00:16', '2015-11-06 11:02:20', NULL),
(235, 'iaiai', 'aiiaiaii', NULL, NULL, '2015-11-09 17:53:09', NULL);

--
-- Volcado de datos para la tabla `usuario_administrador`
--

INSERT IGNORE INTO `usuario_administrador` (`id`, `usuario`, `clave`) VALUES
(1, 'creyes', '123'),
(2, 'jlopez', '123'),
(3, 'dmorales', '123');

--
-- Volcado de datos para la tabla `usuario_administrador_has_rol_administrador`
--

INSERT IGNORE INTO `usuario_administrador_has_rol_administrador` (`usuario_administrador_id`, `rol_administrador_id`) VALUES
(1, 1),
(2, 6);

--
-- Volcado de datos para la tabla `usuario_has_institucion`
--

INSERT IGNORE INTO `usuario_has_institucion` (`usuario_id`, `institucion_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 2),
(6, 1);

--
-- Volcado de datos para la tabla `usuario_has_rol_usuario`
--

INSERT IGNORE INTO `usuario_has_rol_usuario` (`usuario_id`, `rol_usuario_id`) VALUES
(1, 1),
(4, 2),
(5, 2),
(2, 3),
(3, 3),
(3, 186),
(4, 186);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
