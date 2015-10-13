-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 13-10-2015 a las 13:36:39
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
(1, 'ola ', 'lola', 12, 12, 'saldksj', 'jdklj', 'saljdklj', 'sajd', 1),
(2, 'wuyeywueuiy', 'nmbcnxmnmcz', 45454, 0, 'sadsad', 'sadsad', 'sadsad', 'sdsdsda', 2);

--
-- Volcado de datos para la tabla `dato_laboral`
--

INSERT IGNORE INTO `dato_laboral` (`id`, `nombre_empresa`, `ano_antiguedad`, `cargo`, `actividad`, `comuna_empresa`, `ciudad_empresa`, `telefono_empresa`, `celular_empresa`, `rut_numero`, `digito_verificador`, `usuario_id`) VALUES
(1, 'empresa', 7, 'skldjsakd', 'sakldjkl', 'saljdsakld', 'sajdkljsd', 45454, 5454, 545454, 5454, 1),
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
(1, 'juan', 'diego', 'kjhdkjskjd', 'sakjdsakj', '2015-08-10 16:55:05', 5454, 54545, 4545, 'asdkj', 454, 545, 545, 'akjsh', 'kjshakjsh', 'askljasklj', 'alsjj', 'alskjasklj', 'asjsajklsaj', 1),
(2, 'kjhxjhzkj<xhKHZ<KJXH', 'askjhaskh', 'skjdhskjsdh', 'askjha', '2015-08-10 17:04:11', 2121, 2121, 2121, 'askjaks', 454, 5454, 545, 'ajhsajsajhsk', 'akjshajksh', 'akjshakjsh', 'kjahsakjhs', 'kajshkjasjh', 'kjhakjshaks', 1),
(3, 'kjhxjhzkj<xhKHZ<KJXH', 'askjhaskh', 'skjdhskjsdh', 'askjha', '2015-08-10 17:04:11', 2121, 2121, 2121, 'askjaks', 454, 5454, 545, 'ajhsajsajhsk', 'akjshajksh', 'akjshakjsh', 'kjahsakjhs', 'kajshkjasjh', 'kjhakjshaks', 1),
(4, 'kljsldkjsadjkl', 'slkjdksjd', 'skljdkljd', 'skldjsakd', '2015-08-11 15:25:14', 45445, 455454, 5454, 'asljajskl', 44, 5454, 5454, 'lksjakjs', 'lasjsj', 'alsjasklj', 'askljajsk', 'akjaskjl', 'asjasljl', 5),
(5, 'klsklsjklsd', 'iowuerwuo', 'iowuoiwueqoi', 'wiqowioe', '2015-08-12 10:28:29', 55454, 54545, 54545, 'skjdwkjkjl', 54545, 545454, 545454, 'sklajdkjsdkl', 'slkjdklsjdkljs', 'sjdskljd', 'wsjdklsjdkl', 'wsajdkljwskld', 'wljewjqeklj', 4);

--
-- Volcado de datos para la tabla `entidad`
--

INSERT IGNORE INTO `entidad` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `institucion_id`, `entidad_id`) VALUES
(3, 'gfgfgfg', 'fgfgfdg', '2015-08-12 11:29:33', '2015-08-12 14:49:20', 2, 3),
(5, 'nmxbzxnmbnmbzxcnmb', 'znmxcbznmxcbznmx', '2015-08-12 12:16:42', NULL, 1, 3);

--
-- Volcado de datos para la tabla `estado_codigo_seguridad`
--

INSERT IGNORE INTO `estado_codigo_seguridad` (`id`, `estado`, `codigo_seguridad_id`) VALUES
(1, 'bloqueadostodos', 0);

--
-- Volcado de datos para la tabla `estado_usuario`
--

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

INSERT IGNORE INTO `institucion` (`id`, `nombre`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`) VALUES
(1, 'utem', 'vision', 'mision', b'0', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 'ajhsjah', '2015-08-06 15:40:32', '2015-08-06 15:40:32'),
(2, 'duoc', 'vision', 'mision', b'1', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 'kjahsa', '2015-08-06 15:40:32', '2015-08-06 15:40:32'),
(3, 'usash', 'vision', 'mision', b'1', '2015-08-10 11:48:35', '2015-08-10 11:48:35', 'descripcion', NULL, NULL),
(4, 'catolica', 'vision', 'sakjhdksj', b'1', '2015-08-10 12:11:56', '2015-08-10 12:11:56', 'sdsdsdasd', '2015-08-10 12:16:53', '2015-08-10 12:22:20'),
(5, 'udp', 'kljsakdljsadl', 'olaolaolaolaola', b'1', '2015-08-12 10:28:29', '2015-08-12 10:28:29', 'kjsdjkjsahdkjsd', '2015-08-12 10:33:26', '2015-08-12 10:33:47'),
(6, 'ucv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'tvn', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'chv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'c13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'mega', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'la red', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'telecanal', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'etc tv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Volcado de datos para la tabla `institucion_has_rol_usuario`
--

INSERT IGNORE INTO `institucion_has_rol_usuario` (`institucion_id`, `rol_usuario_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 88),
(1, 89),
(1, 90);

--
-- Volcado de datos para la tabla `logica_estado_usuario`
--

--
-- Volcado de datos para la tabla `modulo`
--

INSERT IGNORE INTO `modulo` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`) VALUES
(1, 'matematicas', 'des-matematicas', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(2, 'lenguaje', 'des-lenguaje', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(3, 'calculo', 'des-calculo', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(4, 'historia', 'des-historia', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(5, 'algebra', 'des-algebra', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(6, 'dibujo', 'des-dibujo', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(7, 'estadistica', 'des-estadistica', '2015-08-11 15:59:49', '2015-08-11 15:59:49');

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

INSERT IGNORE INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`) VALUES
(1, 'ingenieria en informatica', 'des-info', '1.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(2, 'diseño', 'des-diseño', '1.5', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(3, 'derecho', 'des-derecho', '2.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(4, 'juegos', 'des-juegos', '3.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49');

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
-- Volcado de datos para la tabla `prueba`
--

--
-- Volcado de datos para la tabla `region`
--

INSERT IGNORE INTO `region` (`id`, `nombre`, `codigo`, `pais_id`) VALUES
(2, 'santiago', 'san54', 1),
(3, 'la plata', 'laplata23', 2),
(4, 'kjjdkskdhsakj', 'kjsahdkjsahdak', 1),
(5, 'sadsadad', 'sdsadsad', 2),
(6, 'iowueuweqo', 'owiueiowuqe', 3),
(7, 'akjssajh', 'kjahskjhsk', 2),
(8, 'metropolitana', 'suecia', 1),
(9, 'jhghjsgdsjd', 'jhsdjhhsdhsd', 1);

--
-- Volcado de datos para la tabla `repositorio`
--

INSERT IGNORE INTO `repositorio` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `tipo_repositorio_id`) VALUES
(3, 'repositorio 1 ', 'descripcion repositorio q', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL),
(4, 'repositorio 2', 'descripcion repositorio 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', NULL);

--
-- Volcado de datos para la tabla `repositorio_has_institucion`
--

INSERT IGNORE INTO `repositorio_has_institucion` (`repositorio_id`, `institucion_id`) VALUES
(3, 1),
(4, 1),
(3, 2),
(4, 2);

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
(6, 55),
(1, 56),
(6, 56),
(1, 57),
(6, 57),
(1, 58),
(6, 58),
(1, 59),
(6, 59),
(1, 60),
(6, 60),
(1, 61),
(6, 61),
(1, 62),
(6, 62),
(1, 63),
(6, 63),
(1, 64),
(6, 64),
(1, 65),
(6, 65),
(1, 66),
(6, 66),
(1, 67),
(6, 67),
(1, 68),
(6, 68),
(1, 69),
(6, 69),
(1, 70),
(6, 70),
(1, 71),
(6, 71),
(1, 72),
(6, 72),
(1, 73),
(6, 73),
(1, 74),
(6, 74),
(1, 75),
(6, 75),
(1, 76),
(6, 76),
(1, 77),
(6, 77),
(1, 78),
(6, 78),
(1, 79),
(6, 79),
(1, 80),
(6, 80),
(1, 81),
(6, 81),
(1, 82),
(6, 82),
(1, 83),
(6, 83),
(1, 84),
(6, 84);

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT IGNORE INTO `rol_usuario` (`id`, `nombre`, `descripcion`, `tipo`, `rol_usuario_general_id`, `fecha_creacion`, `fecha_eliminacion`, `fecha_acceso`, `fecha_modificacion`) VALUES
(1, 'superusuario', 'rol superusuario', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(2, 'profesor', 'rol profesor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(3, 'alumno', 'rol alumno', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(4, 'ayudante', 'rol ayudante', 'rol_usuario_general', NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'inspector', 'rol inspector', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(6, 'percutor', 'rol percutor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(7, 'constructor', 'rol constructor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(88, 'profesor', 'rol profesor', 'rol_usuario', 2, '2015-10-09 18:13:43', NULL, NULL, '2015-10-09 18:13:43'),
(89, 'alumno', 'rol alumno', 'rol_usuario', 3, '2015-10-09 18:13:44', NULL, NULL, '2015-10-09 18:13:44'),
(90, 'ayudante', 'rol ayudante', 'rol_usuario', 4, '2015-10-09 18:13:45', NULL, NULL, '2015-10-09 18:13:45');

--
-- Volcado de datos para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

INSERT IGNORE INTO `rol_usuario_has_authitem_permiso_usuario` (`rol_usuario_id`, `authitem_permiso_usuario_name`) VALUES
(1, 'aula'),
(1, 'mesa_de_ayuda'),
(1, 'repositorio'),
(2, 'aula'),
(3, 'repositorio'),
(4, 'mesa_de_ayuda');

--
-- Volcado de datos para la tabla `rol_usuario_has_privilegio_usuario`
--

INSERT IGNORE INTO `rol_usuario_has_privilegio_usuario` (`rol_usuario_id`, `privilegio_usuario_id`) VALUES
(1, 1),
(2, 1),
(88, 1),
(1, 2),
(2, 2),
(88, 2),
(1, 3),
(2, 3),
(88, 3),
(1, 4),
(2, 4),
(88, 4),
(1, 5),
(2, 5),
(88, 5),
(1, 6),
(2, 6),
(88, 6),
(1, 7),
(2, 7),
(88, 7),
(1, 8),
(2, 8),
(88, 8),
(1, 9),
(2, 9),
(88, 9),
(1, 10),
(2, 10),
(88, 10),
(1, 11),
(2, 11),
(88, 11),
(1, 12),
(2, 12),
(88, 12),
(1, 13),
(3, 13),
(1, 14),
(3, 14),
(1, 15),
(3, 15),
(1, 16),
(3, 16),
(1, 17),
(3, 17),
(1, 18),
(3, 18),
(1, 19),
(3, 19),
(1, 20),
(3, 20),
(1, 21),
(3, 21),
(1, 22),
(3, 22),
(1, 23),
(3, 23),
(1, 24),
(3, 24);

--
-- Volcado de datos para la tabla `seccion`
--

INSERT IGNORE INTO `seccion` (`id`, `nombre`, `jornada`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `modulo_id`) VALUES
(6, 'mnbvbnmvc', 'nmcvbbnmvxc', 'cmnvbnmcbvx', '2015-08-12 11:38:53', '2015-08-12 11:39:57', 1);

--
-- Volcado de datos para la tabla `usuario`
--

INSERT IGNORE INTO `usuario` (`id`, `usuario`, `clave`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`) VALUES
(1, 'creyes', '123', NULL, NULL, NULL),
(2, 'francisco', '123', NULL, NULL, NULL),
(3, 'victor', '123', NULL, NULL, NULL),
(4, 'marcelo', '123', NULL, NULL, NULL),
(5, 'patricio', '123', NULL, NULL, NULL),
(6, 'bruno', '123', '0000-00-00 00:00:00', '2015-08-10 16:09:43', '2015-08-10 16:09:16'),
(7, 'cristobal', '123', NULL, '2015-08-25 10:21:14', '2015-08-12 09:57:11'),
(8, 'camilo', '123', NULL, NULL, '2015-08-25 10:16:05'),
(9, 'manuel', '123', NULL, NULL, '2015-08-25 10:16:14'),
(10, 'andres', '123', NULL, NULL, '2015-08-25 10:16:24'),
(11, 'carlos', '123', NULL, NULL, '2015-08-25 10:16:31'),
(12, 'ricardo', '123', NULL, NULL, '2015-08-25 10:16:41'),
(13, 'rodrigo', '123', NULL, NULL, '2015-08-25 10:16:52'),
(14, 'daniel', '123', NULL, NULL, '2015-08-25 10:17:00'),
(15, 'matias', '123', NULL, NULL, '2015-08-25 10:19:12'),
(186, 'usuario viejo', 'viejo clave', NULL, '2015-08-10 16:09:43', '2015-08-10 16:09:16'),
(187, 'nbnvmcvmc', 'nmcbvnmcxvnv', NULL, '2015-08-12 09:57:23', '2015-08-12 09:57:11'),
(189, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(190, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(191, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(192, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(193, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(194, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(195, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(196, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(197, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(198, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(199, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(200, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(201, '1', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(202, '2', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41'),
(203, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41');

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
(1, 2),
(2, 2),
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(1, 2),
(2, 2),
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(1, 2),
(2, 2),
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(1, 2),
(2, 2);

--
-- Volcado de datos para la tabla `usuario_has_rol_usuario`
--

INSERT IGNORE INTO `usuario_has_rol_usuario` (`usuario_id`, `rol_usuario_id`) VALUES
(1, 1),
(4, 2),
(5, 2),
(2, 3),
(3, 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
