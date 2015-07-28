-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 28-07-2015 a las 21:04:37
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_usuario_administrador`(
nuevo_id int,
nuevo_usuario varchar(50),
nuevo_clave varchar(50)
)
begin
update usuario_administrador set
id = nuevo_id,
usuario = nuevo_usuario,
clave = nuevo_clave
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `agregar_usuario_administrador`(
nuevo_usuario varchar(50),
nuevo_clave varchar(50),
OUT llave_id int(11)
)
begin
insert into usuario_administrador(
usuario,
clave
)
values(
nuevo_usuario,
nuevo_clave
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_permiso_a_rol`(nuevo_rol_id int , nuevo_permiso_name varchar(50))
begin
INSERT INTO rol_administrador_has_authitem_permiso_administrador (rol_administrador_id,authitem_permiso_administrador_name) 
SELECT RA.id,P.name
FROM 	
		rol_administrador RA,
        authitem_permiso_administrador P
WHERE  RA.id=nuevo_rol_id
AND P.name=nuevo_permiso_name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_permiso_rol`(nuevo_rol_id int , nuevo_permiso_name varchar(50))
begin
INSERT INTO rol_administrador_has_authitem_permiso_administrador (rol_administrador_id,authitem_permiso_administrador_name) 
SELECT RA.id,P.name
FROM 	
		rol_administrador RA,
        authitem_permiso_administrador P
WHERE  RA.id=nuevo_rol_id
AND P.name=nuevo_permiso_name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_permiso_usuario`(nuevo_usuario_id int , nuevo_permiso_name varchar(50))
begin
INSERT INTO authassignment_administrador (userid,itemname) 
SELECT U.id,P.name
FROM 
	   usuario_administrador U,
	   authitem_permiso_administrador P      
      
WHERE U.id=nuevo_usuario_id  
AND P.name = nuevo_permiso_name;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_privilegio_rol`(nuevo_rol_id int , nuevo_privilegio_id int)
begin
INSERT INTO rol_administrador_has_privilegio_administrador (rol_administrador_id,privilegio_administrador_id) 
SELECT R.id,PRIV.id
FROM 
	   rol_administrador R,
	   privilegio_administrador PRIV      
      
WHERE R.id=nuevo_rol_id  
AND PRIV.id = nuevo_privilegio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `asignar_rol_usuario`(nuevo_usuario_id int , nuevo_rol_id varchar(50))
begin
INSERT INTO usuario_administrador_has_rol_administrador (usuario_administrador_id,rol_administrador_id) 
SELECT U.id,R.id
FROM 	
		usuario_administrador U,
        rol_administrador R
WHERE  U.id=nuevo_usuario_id
AND R.id=nuevo_rol_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_rol_permiso`(nuevo_rol_id int , nuevo_permiso_name varchar(50), out retorno BOOL)
BEGIN
DECLARE resultado_rol int(11);
DECLARE resultado_permiso varchar(50);

SET resultado_rol = NULL;
SET resultado_permiso = NULL;

SELECT RP.rol_administrador_id,RP.authitem_permiso_administrador_name INTO resultado_rol,resultado_permiso
FROM 	
		rol_administrador_has_authitem_permiso_administrador RP
WHERE  RP.rol_administrador_id = nuevo_rol_id
AND RP.authitem_permiso_administrador_name = nuevo_permiso_name; 

IF ( (resultado_rol IS NOT NULL) AND (resultado_permiso IS NOT NULL) ) THEN
	SELECT TRUE into retorno;
ELSE 
	SELECT FALSE into retorno;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_rol_privilegio`(nuevo_rol_id int , nuevo_privilegio_id int, out retorno BOOL)
BEGIN
DECLARE resultado_rol int(11);
DECLARE resultado_privilegio int(11);

SET resultado_rol = NULL;
SET resultado_privilegio = NULL;

SELECT RPRIV.rol_administrador_id , RPRIV.privilegio_administrador_id INTO resultado_rol , resultado_privilegio
FROM 	
		rol_administrador_has_privilegio_administrador RPRIV
WHERE  RPRIV.rol_administrador_id = nuevo_rol_id
AND RPRIV.privilegio_administrador_id = nuevo_privilegio_id; 

IF ( (resultado_rol IS NOT NULL) AND (resultado_privilegio IS NOT NULL) ) THEN
	SELECT TRUE into retorno;
ELSE 
	SELECT FALSE into retorno;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_usuario_rol`(nuevo_usuario_id int , nuevo_rol_id int, out retorno BOOL)
BEGIN
DECLARE resultado_usuario int(11);
DECLARE resultado_rol int(11);

SET resultado_usuario = NULL;
SET resultado_rol = NULL;

SELECT UR.usuario_administrador_id,UR.rol_administrador_id INTO resultado_usuario,resultado_rol
FROM 	
		usuario_administrador_has_rol_administrador UR
WHERE  UR.usuario_administrador_id = nuevo_usuario_id
AND UR.rol_administrador_id = nuevo_rol_id; 

IF ( (resultado_usuario IS NOT NULL) AND (resultado_rol IS NOT NULL) ) THEN
	SELECT TRUE into retorno;
ELSE 
	SELECT FALSE into retorno;
END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desasignar_permiso_rol`(nuevo_rol_id int,nuevo_permiso_name varchar(100))
begin
delete from rol_administrador_has_authitem_permiso_administrador 
where rol_administrador_id = nuevo_rol_id
and authitem_permiso_administrador_name = nuevo_permiso_name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desasignar_permiso_usuario`(nuevo_usuario_id int,nuevo_permiso_name varchar(50))
begin
delete from authassignment_administrador 
where userid = nuevo_usuario_id
and itemname = nuevo_permiso_name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desasignar_privilegio`(nuevo_rol_id int,nuevo_privilegio_id int)
begin
delete from rol_administrador_has_privilegio_administrador 
where rol_administrador_id = nuevo_rol_id
and privilegio_administrador_id = nuevo_privilegio_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desasignar_privilegio_rol`(nuevo_rol_id int,nuevo_privilegio_id int)
begin
delete from rol_administrador_has_privilegio_administrador 
where rol_administrador_id = nuevo_rol_id
and privilegio_administrador_id = nuevo_privilegio_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `desasignar_rol_usuario`(nuevo_usuario_id int,nuevo_rol_id int)
begin
delete from usuario_administrador_has_rol_administrador 
where usuario_administrador_id = nuevo_usuario_id
and rol_administrador_id = nuevo_rol_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_usuario_administrador`(
nuevo_id int
)
delete from usuario_administrador where id = nuevo_id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_controlador_permiso`(nuevo_permiso varchar(250))
begin
SELECT C.id,C.nombre
FROM 
		authitem_permiso_administrador P,
		controlador_administrador C        
      
WHERE P.name = C.authitem_permiso_administrador_name
AND P.name = nuevo_permiso;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_permiso`()
begin
select * from authitem_permiso_administrador;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_permiso_rol`(nuevo_rol_id varchar(250))
begin
SELECT P.name
FROM 
		rol_administrador R,
        rol_administrador_has_authitem_permiso_administrador RP,
		authitem_permiso_administrador P      
      
WHERE R.id = RP.rol_administrador_id
AND P.name = RP.authitem_permiso_administrador_name
AND R.id = nuevo_rol_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_privilegio_controlador`(nuevo_controlador_id int)
begin
SELECT PRIV.id,PRIV.nombre
FROM 
		controlador_administrador C,      
        privilegio_administrador PRIV
      
WHERE C.id = PRIV.controlador_administrador_id
AND C.id = nuevo_controlador_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_privilegio_permiso`(nuevo_permiso varchar(250))
begin
SELECT PRIV.id,PRIV.nombre,PRIV.controlador_administrador_id
FROM 
		authitem_permiso_administrador P,
		controlador_administrador C,        
		privilegio_administrador PRIV      
      
WHERE P.name = C.authitem_permiso_administrador_name
AND C.id = PRIV.controlador_administrador_id

AND P.name = nuevo_permiso;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_usuario_administrador`()
select * from usuario_administrador$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `privilegio_permiso`(nuevo_permiso varchar(250))
begin
SELECT PRIV.id
FROM 
authitem_permiso_administrador P,
       controlador_administrador C,        
privilegio_administrador PRIV      
      
WHERE P.name = C.authitem_permiso_administrador_name
AND C.id = PRIV.controlador_administrador_id

AND P.name = nuevo_permiso;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_escritorio_administrador_get_icono_permiso_usuario`(nuevo_usuario_id int)
BEGIN
SELECT I.estilo,P.name
FROM 
		usuario_administrador U,      
        usuario_administrador_has_rol_administrador UR,
        rol_administrador R,
        rol_administrador_has_authitem_permiso_administrador RP,
        authitem_permiso_administrador P,
        icono_aplicacion_administrador I
      
WHERE U.id = UR.usuario_administrador_id
AND R.id = UR.rol_administrador_id
AND R.id = RP.rol_administrador_id
AND P.name = RP.authitem_permiso_administrador_name
AND P.name = I.authitem_permiso_administrador_name
AND U.id = nuevo_usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_escritorio_administrador_get_permiso_usuario`(nuevo_usuario_id int)
BEGIN
SELECT P.name
FROM 
		usuario_administrador U,      
        usuario_administrador_has_rol_administrador UR,
        rol_administrador R,
        rol_administrador_has_authitem_permiso_administrador RP,
        authitem_permiso_administrador P
      
WHERE U.id = UR.usuario_administrador_id
AND R.id = UR.rol_administrador_id
AND R.id = RP.rol_administrador_id
AND P.name = RP.authitem_permiso_administrador_name
AND U.id = nuevo_usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validar_privilegio`(nuevo_usuario_id int , nuevo_permiso_nombre varchar(50) , nuevo_controlador_nombre varchar(50) , nuevo_privilegio_nombre varchar(50),out vista varchar(50))
SELECT PRIV.nombre into vista
FROM
		privilegio_administrador PRIV,
        controlador_administrador C,
        authitem_permiso_administrador P,
        rol_administrador_has_authitem_permiso_administrador RP,
        rol_administrador R,
        usuario_administrador_has_rol_administrador UR,
        usuario_administrador U
        
WHERE PRIV.controlador_administrador_id = C.id
AND C.authitem_permiso_administrador_name = P.name
AND RP.authitem_permiso_administrador_name = P.name
AND RP.rol_administrador_id = R.id
AND UR.rol_administrador_id = R.id
AND UR.usuario_administrador_id = U.id

AND U.id = nuevo_usuario_id
AND P.name = nuevo_permiso_nombre
AND C.nombre = nuevo_controlador_nombre
AND PRIV.nombre = nuevo_privilegio_nombre$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validar_privilegio_usuario`(nuevo_usuario_id int , nuevo_permiso_nombre varchar(50) , nuevo_controlador_nombre varchar(50) , nuevo_privilegio_nombre varchar(50),out vista varchar(50))
SELECT PRIV.nombre into vista
FROM
		privilegio_usuario PRIV,
        controlador_usuario C,
        authitem_permiso_usuario P,
        rol_usuario_has_authitem_permiso_usuario RP,
        rol_usuario R,
        usuario_has_rol_usuario UR,
        usuario U
        
WHERE PRIV.controlador_usuario_id = C.id
AND C.authitem_permiso_usuario_name = P.name
AND RP.authitem_permiso_usuario_name = P.name
AND RP.rol_usuario_id = R.id
AND UR.rol_usuario_id = R.id
AND UR.usuario_id = U.id

AND U.id = nuevo_usuario_id
AND P.name = nuevo_permiso_nombre
AND C.nombre = nuevo_controlador_nombre
AND PRIV.nombre = nuevo_privilegio_nombre$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aula`
--

CREATE TABLE IF NOT EXISTS `aula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authassignment_administrador`
--

CREATE TABLE IF NOT EXISTS `authassignment_administrador` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authassignment_administrador`
--

INSERT INTO `authassignment_administrador` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('administracion_rol_administrador', '1', NULL, NULL),
('administracion_rol_usuario', '1', NULL, NULL),
('administracion_rol_usuario', '2', NULL, 'N;'),
('administracion_usuario', '1', NULL, NULL),
('administracion_usuario', '2', NULL, 'N;'),
('administracion_usuario_administrador', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authassignment_usuario`
--

CREATE TABLE IF NOT EXISTS `authassignment_usuario` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authassignment_usuario`
--

INSERT INTO `authassignment_usuario` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('aula', '1', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitemchild_administrador`
--

CREATE TABLE IF NOT EXISTS `authitemchild_administrador` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitemchild_usuario`
--

CREATE TABLE IF NOT EXISTS `authitemchild_usuario` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `fk_{A42514E0-6FBA-430A-9C03-85AA2195A71C}` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitem_permiso_administrador`
--

CREATE TABLE IF NOT EXISTS `authitem_permiso_administrador` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authitem_permiso_administrador`
--

INSERT INTO `authitem_permiso_administrador` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitem_permiso_usuario`
--

CREATE TABLE IF NOT EXISTS `authitem_permiso_usuario` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authitem_permiso_usuario`
--

INSERT INTO `authitem_permiso_usuario` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('aula', 2, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controlador_administrador`
--

CREATE TABLE IF NOT EXISTS `controlador_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `authitem_permiso_administrador_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_controlador_administrador_authitem_permiso_administrador_idx` (`authitem_permiso_administrador_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `controlador_administrador`
--

INSERT INTO `controlador_administrador` (`id`, `nombre`, `authitem_permiso_administrador_name`) VALUES
(1, 'AuthitemPermisoAdministrador', 'administracion_rol_administrador'),
(2, 'ControladorAdministrador', 'administracion_rol_administrador'),
(3, 'Default', 'administracion_rol_administrador'),
(4, 'PrivilegioAdministrador', 'administracion_rol_administrador'),
(5, 'RolAdministrador', 'administracion_rol_administrador'),
(6, 'UsuarioAdministrador', 'administracion_usuario_administrador'),
(7, 'Default', 'administracion_usuario_administrador'),
(8, 'Usuario', 'administracion_usuario'),
(9, 'Default', 'administracion_usuario'),
(10, 'RolUsuario', 'administracion_rol_usuario'),
(11, 'Default', 'administracion_rol_usuario'),
(12, 'AuthitemPermisoUsuario', 'administracion_rol_usuario'),
(13, 'ControladorUsuario', 'administracion_rol_usuario'),
(14, 'PrivilegioUsuario', 'administracion_rol_usuario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controlador_usuario`
--

CREATE TABLE IF NOT EXISTS `controlador_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `authitem_permiso_usuario_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_controlador_authitem_permiso_usuario1_idx` (`authitem_permiso_usuario_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `controlador_usuario`
--

INSERT INTO `controlador_usuario` (`id`, `nombre`, `authitem_permiso_usuario_name`) VALUES
(1, 'Aula', 'aula'),
(2, 'Default', 'aula');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escritorio_administrador`
--

CREATE TABLE IF NOT EXISTS `escritorio_administrador` (
  `id` int(11) NOT NULL,
  `usuario_administrador_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_escritorio_administrador_usuario_administrador1_idx` (`usuario_administrador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `escritorio_usuario`
--

CREATE TABLE IF NOT EXISTS `escritorio_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_escritorio_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `icono_aplicacion_administrador`
--

CREATE TABLE IF NOT EXISTS `icono_aplicacion_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estilo` longtext,
  `authitem_permiso_administrador_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_icono_aplicacion_administrador_authitem_permiso_administ_idx` (`authitem_permiso_administrador_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `icono_aplicacion_administrador`
--

INSERT INTO `icono_aplicacion_administrador` (`id`, `estilo`, `authitem_permiso_administrador_name`) VALUES
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privilegio_administrador`
--

CREATE TABLE IF NOT EXISTS `privilegio_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `controlador_administrador_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_privilegio_administrador_controlador_administrador1_idx` (`controlador_administrador_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=85 ;

--
-- Volcado de datos para la tabla `privilegio_administrador`
--

INSERT INTO `privilegio_administrador` (`id`, `nombre`, `controlador_administrador_id`) VALUES
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privilegio_usuario`
--

CREATE TABLE IF NOT EXISTS `privilegio_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `controlador_usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_privilegio_controlador_usuario1_idx` (`controlador_usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `privilegio_usuario`
--

INSERT INTO `privilegio_usuario` (`id`, `nombre`, `controlador_usuario_id`) VALUES
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
(12, 'delete', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repositorio`
--

CREATE TABLE IF NOT EXISTS `repositorio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_administrador`
--

CREATE TABLE IF NOT EXISTS `rol_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `rol_administrador`
--

INSERT INTO `rol_administrador` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superadministrador', NULL),
(5, 'root', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_administrador_has_authitem_permiso_administrador`
--

CREATE TABLE IF NOT EXISTS `rol_administrador_has_authitem_permiso_administrador` (
  `rol_administrador_id` int(11) NOT NULL,
  `authitem_permiso_administrador_name` varchar(64) NOT NULL,
  PRIMARY KEY (`rol_administrador_id`,`authitem_permiso_administrador_name`),
  KEY `fk_rol_administrador_has_authitem_permiso_administrador_aut_idx` (`authitem_permiso_administrador_name`),
  KEY `fk_rol_administrador_has_authitem_permiso_administrador_rol_idx` (`rol_administrador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_administrador_has_authitem_permiso_administrador`
--

INSERT INTO `rol_administrador_has_authitem_permiso_administrador` (`rol_administrador_id`, `authitem_permiso_administrador_name`) VALUES
(1, 'administracion_rol_administrador'),
(1, 'administracion_rol_usuario'),
(1, 'administracion_usuario'),
(1, 'administracion_usuario_administrador'),
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
(5, 'admin_aula'),
(5, 'admin_curricular'),
(5, 'admin_escritorio'),
(5, 'admin_institucion'),
(5, 'admin_repositorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_administrador_has_privilegio_administrador`
--

CREATE TABLE IF NOT EXISTS `rol_administrador_has_privilegio_administrador` (
  `rol_administrador_id` int(11) NOT NULL,
  `privilegio_administrador_id` int(11) NOT NULL,
  PRIMARY KEY (`rol_administrador_id`,`privilegio_administrador_id`),
  KEY `fk_rol_administrador_has_privilegio_administrador_privilegi_idx` (`privilegio_administrador_id`),
  KEY `fk_rol_administrador_has_privilegio_administrador_rol_admin_idx` (`rol_administrador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_administrador_has_privilegio_administrador`
--

INSERT INTO `rol_administrador_has_privilegio_administrador` (`rol_administrador_id`, `privilegio_administrador_id`) VALUES
(1, 31),
(1, 32),
(1, 33),
(1, 34),
(1, 35),
(1, 36),
(1, 37),
(1, 38),
(1, 39),
(1, 40),
(1, 41),
(1, 42),
(1, 43),
(1, 44),
(1, 45),
(1, 46),
(1, 47),
(1, 48),
(1, 49),
(1, 50),
(1, 51),
(1, 52),
(1, 53),
(1, 54),
(1, 55),
(1, 56),
(1, 57),
(1, 58),
(1, 59),
(1, 60),
(1, 61),
(1, 62),
(1, 63),
(1, 64),
(1, 65),
(1, 66),
(1, 67),
(1, 68),
(1, 69),
(1, 70),
(1, 71),
(1, 72),
(1, 73),
(1, 74),
(1, 75),
(1, 76),
(1, 77),
(1, 78),
(1, 79),
(1, 80),
(1, 81),
(1, 82),
(1, 83),
(1, 84);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario`
--

CREATE TABLE IF NOT EXISTS `rol_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`id`, `nombre`, `descripcion`) VALUES
(1, 'alumno', 'rol alumno');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

CREATE TABLE IF NOT EXISTS `rol_usuario_has_authitem_permiso_usuario` (
  `rol_usuario_id` int(11) NOT NULL,
  `authitem_permiso_usuario_name` varchar(64) NOT NULL,
  PRIMARY KEY (`rol_usuario_id`,`authitem_permiso_usuario_name`),
  KEY `fk_rol_usuario_has_authitem_permiso_usuario_authitem_permis_idx` (`authitem_permiso_usuario_name`),
  KEY `fk_rol_usuario_has_authitem_permiso_usuario_rol_usuario1_idx` (`rol_usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

INSERT INTO `rol_usuario_has_authitem_permiso_usuario` (`rol_usuario_id`, `authitem_permiso_usuario_name`) VALUES
(1, 'aula');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario_has_privilegio_usuario`
--

CREATE TABLE IF NOT EXISTS `rol_usuario_has_privilegio_usuario` (
  `rol_usuario_id` int(11) NOT NULL,
  `privilegio_usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`rol_usuario_id`,`privilegio_usuario_id`),
  KEY `fk_rol_usuario_has_privilegio_usuario_privilegio_usuario1_idx` (`privilegio_usuario_id`),
  KEY `fk_rol_usuario_has_privilegio_usuario_rol_usuario1_idx` (`rol_usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, `clave`) VALUES
(1, 'francisco', '123'),
(2, 'marcelo', '123'),
(3, 'patricio', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_administrador`
--

CREATE TABLE IF NOT EXISTS `usuario_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario` (`usuario`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `usuario_administrador`
--

INSERT INTO `usuario_administrador` (`id`, `usuario`, `clave`) VALUES
(1, 'creyes', '123'),
(2, 'jlopez', '123'),
(3, 'dmorales', '123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_administrador_has_rol_administrador`
--

CREATE TABLE IF NOT EXISTS `usuario_administrador_has_rol_administrador` (
  `usuario_administrador_id` int(11) NOT NULL,
  `rol_administrador_id` int(11) NOT NULL,
  PRIMARY KEY (`usuario_administrador_id`,`rol_administrador_id`),
  KEY `fk_usuario_administrador_has_rol_administrador_rol_administ_idx` (`rol_administrador_id`),
  KEY `fk_usuario_administrador_has_rol_administrador_usuario_admi_idx` (`usuario_administrador_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_administrador_has_rol_administrador`
--

INSERT INTO `usuario_administrador_has_rol_administrador` (`usuario_administrador_id`, `rol_administrador_id`) VALUES
(1, 1),
(2, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_rol_usuario`
--

CREATE TABLE IF NOT EXISTS `usuario_has_rol_usuario` (
  `usuario_id` int(11) NOT NULL,
  `rol_usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`usuario_id`,`rol_usuario_id`),
  KEY `fk_usuario_has_rol_usuario_rol_usuario1_idx` (`rol_usuario_id`),
  KEY `fk_usuario_has_rol_usuario_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_has_rol_usuario`
--

INSERT INTO `usuario_has_rol_usuario` (`usuario_id`, `rol_usuario_id`) VALUES
(1, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `authassignment_administrador`
--
ALTER TABLE `authassignment_administrador`
  ADD CONSTRAINT `authassignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `authassignment_usuario`
--
ALTER TABLE `authassignment_usuario`
  ADD CONSTRAINT `fk_{5DA5BC00-2AAE-40E5-B1C5-FAE6CD295098}` FOREIGN KEY (`itemname`) REFERENCES `authitem_permiso_usuario` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `authitemchild_administrador`
--
ALTER TABLE `authitemchild_administrador`
  ADD CONSTRAINT `authitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `authitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `authitemchild_usuario`
--
ALTER TABLE `authitemchild_usuario`
  ADD CONSTRAINT `fk_{22EAC8DC-C8D1-4914-85F1-B5A9690F5188}` FOREIGN KEY (`parent`) REFERENCES `authitem_permiso_usuario` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_{A42514E0-6FBA-430A-9C03-85AA2195A71C}` FOREIGN KEY (`child`) REFERENCES `authitem_permiso_usuario` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `controlador_administrador`
--
ALTER TABLE `controlador_administrador`
  ADD CONSTRAINT `fk_controlador_administrador_authitem_permiso_administrador1` FOREIGN KEY (`authitem_permiso_administrador_name`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `controlador_usuario`
--
ALTER TABLE `controlador_usuario`
  ADD CONSTRAINT `fk_controlador_authitem_permiso_usuario1` FOREIGN KEY (`authitem_permiso_usuario_name`) REFERENCES `authitem_permiso_usuario` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `escritorio_administrador`
--
ALTER TABLE `escritorio_administrador`
  ADD CONSTRAINT `fk_escritorio_administrador_usuario_administrador1` FOREIGN KEY (`usuario_administrador_id`) REFERENCES `usuario_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `escritorio_usuario`
--
ALTER TABLE `escritorio_usuario`
  ADD CONSTRAINT `fk_escritorio_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `icono_aplicacion_administrador`
--
ALTER TABLE `icono_aplicacion_administrador`
  ADD CONSTRAINT `fk_icono_aplicacion_administrador_authitem_permiso_administra1` FOREIGN KEY (`authitem_permiso_administrador_name`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `privilegio_administrador`
--
ALTER TABLE `privilegio_administrador`
  ADD CONSTRAINT `fk_privilegio_administrador_controlador_administrador1` FOREIGN KEY (`controlador_administrador_id`) REFERENCES `controlador_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `privilegio_usuario`
--
ALTER TABLE `privilegio_usuario`
  ADD CONSTRAINT `fk_privilegio_controlador_usuario1` FOREIGN KEY (`controlador_usuario_id`) REFERENCES `controlador_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_administrador_has_authitem_permiso_administrador`
--
ALTER TABLE `rol_administrador_has_authitem_permiso_administrador`
  ADD CONSTRAINT `fk_rol_administrador_has_authitem_permiso_administrador_authi1` FOREIGN KEY (`authitem_permiso_administrador_name`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_administrador_has_authitem_permiso_administrador_rol_a1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_administrador_has_privilegio_administrador`
--
ALTER TABLE `rol_administrador_has_privilegio_administrador`
  ADD CONSTRAINT `fk_rol_administrador_has_privilegio_administrador_privilegio_1` FOREIGN KEY (`privilegio_administrador_id`) REFERENCES `privilegio_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_administrador_has_privilegio_administrador_rol_adminis1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_usuario_has_authitem_permiso_usuario`
--
ALTER TABLE `rol_usuario_has_authitem_permiso_usuario`
  ADD CONSTRAINT `fk_rol_usuario_has_authitem_permiso_usuario_authitem_permiso_1` FOREIGN KEY (`authitem_permiso_usuario_name`) REFERENCES `authitem_permiso_usuario` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_usuario_has_authitem_permiso_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_usuario_has_privilegio_usuario`
--
ALTER TABLE `rol_usuario_has_privilegio_usuario`
  ADD CONSTRAINT `fk_rol_usuario_has_privilegio_usuario_privilegio_usuario1` FOREIGN KEY (`privilegio_usuario_id`) REFERENCES `privilegio_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_usuario_has_privilegio_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_administrador_has_rol_administrador`
--
ALTER TABLE `usuario_administrador_has_rol_administrador`
  ADD CONSTRAINT `fk_usuario_administrador_has_rol_administrador_rol_administra1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_administrador_has_rol_administrador_usuario_admini1` FOREIGN KEY (`usuario_administrador_id`) REFERENCES `usuario_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_has_rol_usuario`
--
ALTER TABLE `usuario_has_rol_usuario`
  ADD CONSTRAINT `fk_usuario_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_rol_usuario_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
