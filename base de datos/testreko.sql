-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 21-01-2016 a las 15:15:07
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_entidad_por_institucion`(nuevo_id_institucion int)
BEGIN
SELECT en.id,en.nombre,en.descripcion,en.fecha_creacion,en.fecha_modificacion 
FROM entidad en, institucion ins
WHERE ins.id = en.institucion_id
AND ins.id = nuevo_id_institucion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_estados_usuario`()
begin
select estado from logica_estado_usuario;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `lista_rol_permiso`(rol_id int(11))
BEGIN

SELECT A.roldesc,B.* FROM `rol` A, `rolpermiso` B 
WHERE A.idrol = B.rolid
AND A.idrol = rol_id UNION SELECT null,null,A.idpermiso FROM (`permiso` A LEFT JOIN `rolpermiso` B ON A.idpermiso = B.permisoid AND B.rolid = rol_id)
WHERE B.rolid is NULL;

END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_aplicacion_actualizar_aplicacion`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_ocultar bit(1),
nuevo_fecha_modificacion datetime
)
begin
update aplicacion set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
ocultar = nuevo_ocultar,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_aplicacion_agregar_aplicacion`(
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_ocultar bit(1),
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into aplicacion(
nombre,
descripcion,
ocultar,
fecha_creacion
)
values(
nuevo_nombre,
nuevo_descripcion,
nuevo_ocultar,
now()
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_aceptar_contrato`(
nuevo_contrato_ficha_tecnica_id INT,
nuevo_modulo_id INT,
nuevo_programa_academico_id INT,
nuevo_usuario_id INT,
nuevo_institucion_id INT
)
BEGIN
	INSERT INTO aceptacion_contrato (contrato_ficha_tecnica_id,modulo_id,programa_academico_id,usuario_id,institucion_id)
    VALUES(nuevo_contrato_ficha_tecnica_id,nuevo_modulo_id,nuevo_programa_academico_id,nuevo_usuario_id,nuevo_institucion_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_contrato_ficha_tecnica`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion text,
nuevo_ficha_tecnica_id int
)
begin
update contrato_ficha_tecnica set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
fecha_modificacion = now(),
ficha_tecnica_id = nuevo_ficha_tecnica_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_ficha_tecnica`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion text
)
begin
update ficha_tecnica set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_item_ficha_tecnica`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion text,
nuevo_ficha_tecnica_id int
)
begin
update item_ficha_tecnica set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
fecha_modificacion = now(),
ficha_tecnica_id = nuevo_ficha_tecnica_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_modulo`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
nuevo_descripcion text,
nuevo_fecha_modificacion datetime,
nuevo_estado_modulo_id int,
nuevo_entidad_id int,
nuevo_institucion_id int
)
begin
update modulo set 
id = nuevo_id,
nombre = nuevo_nombre,
codigo = nuevo_codigo,
descripcion = nuevo_descripcion,
fecha_modificacion = nuevo_fecha_modificacion,
estado_modulo_id = nuevo_estado_modulo_id,
entidad_id = nuevo_entidad_id,
institucion_id = nuevo_institucion_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_programa_academico`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_version varchar(50),
nuevo_entidad int,
nuevo_institucion int,
nuevo_estado_programa_academico_id int,
nuevo_fecha_modificacion datetime
)
begin
update programa_academico set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
version = nuevo_version,
entidad_id = nuevo_entidad,
institucion_id = nuevo_institucion,
estado_programa_academico_id = nuevo_estado_programa_academico_id,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_seccion`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
nuevo_jornada varchar(50),
nuevo_descripcion text,
nuevo_fecha_modificacion datetime,
nuevo_estado_seccion_id int,
nuevo_modulo_id int
)
begin
update seccion set
id = nuevo_id,
nombre = nuevo_nombre,
codigo = nuevo_codigo,
jornada = nuevo_jornada,
descripcion = nuevo_descripcion,
fecha_modificacion = now(),
estado_seccion_id = nuevo_estado_seccion_id,
modulo_id = nuevo_modulo_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_contrato_ficha_tecnica`(
nuevo_nombre varchar(50),
nuevo_descripcion text,
nuevo_ficha_tecnica_id int,
OUT llave_id int(11)
)
begin
insert into contrato_ficha_tecnica(
nombre,
descripcion,
fecha_creacion,
ficha_tecnica_id
)
values(
nuevo_nombre,
nuevo_descripcion,
now(),
nuevo_ficha_tecnica_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_ficha_tecnica`(
nuevo_nombre varchar(50),
nuevo_descripcion text,
OUT llave_id int(11)
)
begin
insert into ficha_tecnica(
nombre,
descripcion,
fecha_creacion
)
values(
nuevo_nombre,
nuevo_descripcion,
now()
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_item_ficha_tecnica`(
nuevo_nombre varchar(50),
nuevo_descripcion text,
nuevo_ficha_tecnica_id int,
OUT llave_id int(11)
)
begin
insert into item_ficha_tecnica(
nombre,
descripcion,
fecha_creacion,
ficha_tecnica_id
)
values(
nuevo_nombre,
nuevo_descripcion,
now(),
nuevo_ficha_tecnica_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_modulo`(
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
nuevo_descripcion text,
nuevo_fecha_creacion datetime,
nuevo_estado_modulo_id int,
nuevo_entidad_id int,
nuevo_institucion_id int,
OUT llave_id int(11)
)
begin
insert into modulo(
nombre,
codigo,
descripcion,
fecha_creacion,
estado_modulo_id,
entidad_id,
institucion_id
)
values(
nuevo_nombre,
nuevo_codigo,
nuevo_descripcion,
now(),
nuevo_estado_modulo_id,
nuevo_entidad_id ,
nuevo_institucion_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_programa_academico`(
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_version varchar(50),
nuevo_entidad int,
nuevo_institucion int,
nuevo_estado_programa_academico_id int,
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into programa_academico(
nombre,
descripcion,
version,
entidad_id,
institucion_id,
estado_programa_academico_id,
fecha_creacion
)
values(
nuevo_nombre,
nuevo_descripcion,
nuevo_version,
nuevo_entidad,
nuevo_institucion,
nuevo_estado_programa_academico_id,
now()
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_seccion`(
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
nuevo_jornada varchar(50),
nuevo_descripcion text,
nuevo_fecha_creacion datetime,
nuevo_estado_seccion_id int,
nuevo_modulo_id int,
OUT llave_id int(11)
)
begin
insert into seccion(
nombre,
codigo,
jornada,
descripcion,
fecha_creacion,
estado_seccion_id,
modulo_id
)
values(
nuevo_nombre,
nuevo_codigo,
nuevo_jornada,
nuevo_descripcion,
now(),
nuevo_estado_seccion_id,
nuevo_modulo_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_ficha_modulo`(lista_modulo_id varchar(255), lista_largo int, nuevo_ficha_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);	
    SELECT modulo_id INTO modulo_id_tmp FROM ficha_tecnica_has_modulo WHERE modulo_id = nuevo_modulo_id AND ficha_tecnica_id = nuevo_ficha_id;
    IF ( modulo_id_tmp IS NULL) THEN
		INSERT INTO ficha_tecnica_has_modulo (`modulo_id`,`ficha_tecnica_id`) VALUES (nuevo_modulo_id,nuevo_ficha_id);
	ELSE
		SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_ficha_programa`(lista_programa_id varchar(255), lista_largo int, nuevo_ficha_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_programa_id int default NULL;
DECLARE programa_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
    SET nuevo_programa_id = getValueFromArray(lista_programa_id, ',', x);   
    SELECT programa_academico_id INTO programa_id_tmp FROM ficha_tecnica_has_programa_academico WHERE programa_academico_id = nuevo_programa_id AND ficha_tecnica_id = nuevo_ficha_id;
    IF ( programa_id_tmp IS NULL) THEN
        INSERT INTO ficha_tecnica_has_programa_academico (`programa_academico_id`,`ficha_tecnica_id`) VALUES (nuevo_programa_id,nuevo_ficha_id);
    ELSE
        SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_modulo_entidad`(lista_modulo_id varchar(255), lista_largo int, nuevo_entidad_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);	
    SELECT id INTO modulo_id_tmp FROM modulo WHERE id = nuevo_modulo_id AND institucion_id = nuevo_entidad_id;
    IF ( modulo_id_tmp IS NULL) THEN
		UPDATE modulo
        SET entidad_id = nuevo_entidad_id
        WHERE id = nuevo_modulo_id;
	ELSE
		SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_modulo_institucion`(lista_modulo_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);	
    SELECT id INTO modulo_id_tmp FROM modulo WHERE id = nuevo_modulo_id AND institucion_id = nuevo_institucion_id;
    IF ( modulo_id_tmp IS NULL) THEN
		UPDATE modulo
        SET institucion_id = nuevo_institucion_id
        WHERE id = nuevo_modulo_id;
	ELSE
		SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_modulo_programa_academico`(lista_modulo_id varchar(255), lista_largo int, nuevo_programa_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);	
    SELECT modulo_id INTO modulo_id_tmp FROM programa_academico_has_modulo WHERE modulo_id = nuevo_modulo_id AND programa_academico_id = nuevo_programa_id;
    IF ( modulo_id_tmp IS NULL) THEN
		INSERT INTO programa_academico_has_modulo (`modulo_id`,`programa_academico_id`) VALUES (nuevo_modulo_id,nuevo_programa_id);
	ELSE
		SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_programa_entidad`(lista_programa_id varchar(255), lista_largo int, nuevo_entidad_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_programa_id int default NULL;
DECLARE programa_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_programa_id = getValueFromArray(lista_programa_id, ',', x);	
    SELECT id INTO programa_id_tmp FROM programa_academico WHERE id = nuevo_programa_id AND entidad_id = nuevo_entidad_id;
    IF ( programa_id_tmp IS NULL) THEN
		UPDATE programa_academico
        SET entidad_id = nuevo_entidad_id
        WHERE id = nuevo_programa_id;
	ELSE
		SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_programa_institucion`(lista_programa_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_programa_id int default NULL;
DECLARE programa_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_programa_id = getValueFromArray(lista_programa_id, ',', x);	
    SELECT id INTO programa_id_tmp FROM programa_academico WHERE id = nuevo_programa_id AND institucion_id = nuevo_institucion_id;
    IF ( programa_id_tmp IS NULL) THEN
		UPDATE programa_academico
        SET institucion_id = nuevo_institucion_id
        WHERE id = nuevo_programa_id;
	ELSE
		SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_usuario_con_rol_modulo`(lista_usuario_id varchar(255), lista_largo int, nuevo_modulo_id int,nuevo_rol_id int)
BEGIN
	DECLARE x int DEFAULT 0;
	DECLARE nuevo_usuario_id int default NULL;
	DECLARE usuario_id_tmp int default NULL;
	DECLARE resultado BOOLEAN DEFAULT TRUE;
	
    WHILE x < lista_largo DO
		SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
		
        SELECT usuario_id INTO usuario_id_tmp 
        FROM usuario_has_modulo 
        WHERE usuario_id = nuevo_usuario_id 
        AND modulo_id = nuevo_modulo_id
        AND rol_usuario_id = nuevo_rol_id;
		
        IF ( usuario_id_tmp IS NULL) THEN
			INSERT INTO usuario_has_modulo (`usuario_id`,`modulo_id`,`rol_usuario_id`) 
            VALUES (nuevo_usuario_id,nuevo_modulo_id,nuevo_rol_id);
		ELSE
			SET usuario_id_tmp = NULL;
		END IF;    
		SET x = x +1;
	END WHILE;

	SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_usuario_con_rol_programa`(lista_usuario_id varchar(255), lista_largo int, nuevo_programa_id int,nuevo_rol_id int)
BEGIN
	DECLARE x int DEFAULT 0;
	DECLARE nuevo_usuario_id int default NULL;
	DECLARE usuario_id_tmp int default NULL;
	DECLARE resultado BOOLEAN DEFAULT TRUE;

	WHILE x < lista_largo DO
		SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x); 
		
        SELECT usuario_id INTO usuario_id_tmp 
		FROM usuario_has_programa_academico 
        WHERE usuario_id = nuevo_usuario_id 
		AND programa_academico_id = nuevo_programa_id 
		AND rol_usuario_id = nuevo_rol_id;
		
        IF (usuario_id_tmp IS NULL) THEN
			INSERT INTO usuario_has_programa_academico(`usuario_id`,`programa_academico_id`,`rol_usuario_id`) 
			VALUES (nuevo_usuario_id,nuevo_programa_id,nuevo_rol_id);
		ELSE
			SET usuario_id_tmp = NULL;
		END IF;    
		SET x = x +1;
	END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_usuario_con_rol_seccion`(lista_usuario_id varchar(255), lista_largo int, nuevo_seccion_id int,nuevo_rol_id int)
BEGIN
    DECLARE x int DEFAULT 0;
    DECLARE nuevo_usuario_id int default NULL;
    DECLARE usuario_id_tmp int default NULL;
    DECLARE resultado BOOLEAN DEFAULT TRUE;
    
    WHILE x < lista_largo DO
        SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x); 
        
        SELECT usuario_id INTO usuario_id_tmp 
        FROM usuario_has_seccion 
        WHERE usuario_id = nuevo_usuario_id 
        AND seccion_id = nuevo_seccion_id
        AND rol_usuario_id = nuevo_rol_id;

        IF ( usuario_id_tmp IS NULL) THEN
            INSERT INTO usuario_has_seccion (`usuario_id`,`seccion_id`,`rol_usuario_id`) 
            VALUES (nuevo_usuario_id,nuevo_seccion_id,nuevo_rol_id);
        ELSE
            SET usuario_id_tmp = NULL;
        END IF;    
        SET x = x +1;
    END WHILE;

    SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_usuario_modulo`(lista_usuario_id varchar(255), lista_largo int, nuevo_modulo_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_modulo WHERE usuario_id = nuevo_usuario_id AND modulo_id = nuevo_modulo_id;
    IF ( usuario_id_tmp IS NULL) THEN
		INSERT INTO usuario_has_modulo (`usuario_id`,`modulo_id`) VALUES (nuevo_usuario_id,nuevo_modulo_id);
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_usuario_programa`(lista_usuario_id varchar(255), lista_largo int, nuevo_programa_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT id INTO usuario_id_tmp FROM usuario WHERE id = nuevo_usuario_id AND programa_academico_id = nuevo_programa_id;
    IF ( usuario_id_tmp IS NULL) THEN
		UPDATE usuario 
		SET programa_academico_id = nuevo_programa_id
		WHERE id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_asigna_usuario_seccion`(lista_usuario_id varchar(255), lista_largo int, nuevo_seccion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_seccion WHERE usuario_id = nuevo_usuario_id AND seccion_id = nuevo_seccion_id;
    IF ( usuario_id_tmp IS NULL) THEN
		INSERT INTO usuario_has_seccion (`usuario_id`,`seccion_id`) VALUES (nuevo_usuario_id,nuevo_seccion_id);
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_ficha_modulo`(lista_modulo_id varchar(255), lista_largo int, nuevo_ficha_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);	
    SELECT modulo_id INTO modulo_id_tmp FROM ficha_tecnica_has_modulo WHERE modulo_id = nuevo_modulo_id AND ficha_tecnica_id = nuevo_ficha_id;
    IF ( modulo_id_tmp IS NOT NULL) THEN
        DELETE FROM ficha_tecnica_has_modulo WHERE ficha_tecnica_id = nuevo_ficha_id AND modulo_id = nuevo_modulo_id;
	ELSE
		SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_ficha_programa`(lista_programa_id varchar(255), lista_largo int, nuevo_ficha_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_programa_id int default NULL;
DECLARE programa_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
    SET nuevo_programa_id = getValueFromArray(lista_programa_id, ',', x);   
    SELECT programa_academico_id INTO programa_id_tmp FROM ficha_tecnica_has_programa_academico WHERE programa_academico_id = nuevo_programa_id AND ficha_tecnica_id = nuevo_ficha_id;
    IF ( programa_id_tmp IS NOT NULL) THEN
        DELETE FROM ficha_tecnica_has_programa_academico WHERE ficha_tecnica_id = nuevo_ficha_id AND programa_academico_id = nuevo_programa_id;
    ELSE
        SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_modulo_entidad`(lista_modulo_id varchar(255), lista_largo int, nuevo_entidad_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
    SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);   
    SELECT id INTO modulo_id_tmp FROM modulo WHERE id = nuevo_modulo_id AND institucion_id = nuevo_entidad_id;
    IF ( modulo_id_tmp IS NOT NULL) THEN
        UPDATE modulo
        SET entidad_id = NULL
        WHERE id = nuevo_modulo_id;
    ELSE
        SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_modulo_institucion`(lista_modulo_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
    SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);   
    SELECT id INTO modulo_id_tmp FROM modulo WHERE id = nuevo_modulo_id AND institucion_id = nuevo_institucion_id;
    IF ( modulo_id_tmp IS NOT NULL) THEN
        UPDATE modulo
        SET institucion_id = NULL
        WHERE id = nuevo_modulo_id;
    ELSE
        SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_modulo_programa_academico`(lista_modulo_id varchar(255), lista_largo int, nuevo_programa_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_modulo_id int default NULL;
DECLARE modulo_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_modulo_id = getValueFromArray(lista_modulo_id, ',', x);	
    SELECT modulo_id INTO modulo_id_tmp FROM programa_academico_has_modulo WHERE modulo_id = nuevo_modulo_id AND programa_academico_id = nuevo_programa_id;
    IF ( modulo_id_tmp IS NOT NULL) THEN
		DELETE FROM programa_academico_has_modulo WHERE programa_academico_id = nuevo_programa_id AND modulo_id = nuevo_modulo_id;
	ELSE
		SET modulo_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_modulo_id, modulo_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_programa_entidad`(lista_programa_id varchar(255), lista_largo int, nuevo_entidad_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_programa_id int default NULL;
DECLARE programa_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_programa_id = getValueFromArray(lista_programa_id, ',', x);	
    SELECT id INTO programa_id_tmp FROM programa_academico WHERE id = nuevo_programa_id AND entidad_id = nuevo_entidad_id;
    IF ( programa_id_tmp IS NOT NULL) THEN
		UPDATE programa_academico
        SET entidad_id = null
        WHERE id = nuevo_programa_id;
	ELSE
		SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_programa_institucion`(lista_programa_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_programa_id int default NULL;
DECLARE programa_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_programa_id = getValueFromArray(lista_programa_id, ',', x);	
    SELECT id INTO programa_id_tmp FROM programa_academico WHERE id = nuevo_programa_id AND institucion_id = nuevo_institucion_id;
    IF ( programa_id_tmp IS NOT NULL) THEN
		UPDATE programa_academico
        SET institucion_id = NULL
        WHERE id = nuevo_programa_id;
	ELSE
		SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_usuario_con_rol_modulo`(lista_usuario_id varchar(255), lista_largo int, nuevo_modulo_id int,nuevo_rol_id int)
BEGIN
	DECLARE x int DEFAULT 0;
	DECLARE nuevo_usuario_id int default NULL;
	DECLARE usuario_id_tmp int default NULL;
	DECLARE resultado BOOLEAN DEFAULT TRUE;
	
    WHILE x < lista_largo DO
		SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
		
        SELECT usuario_id INTO usuario_id_tmp 
        FROM usuario_has_modulo 
        WHERE usuario_id = nuevo_usuario_id 
        AND modulo_id = nuevo_modulo_id
        AND rol_usuario_id = nuevo_rol_id;
		
        IF ( usuario_id_tmp IS NOT NULL) THEN
			DELETE FROM usuario_has_modulo WHERE modulo_id = nuevo_modulo_id 
            AND usuario_id = nuevo_usuario_id
            AND rol_usuario_id = nuevo_rol_id;
		ELSE
			SET usuario_id_tmp = NULL;
		END IF;    
		SET x = x +1;
	END WHILE;

	SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_usuario_con_rol_programa`(lista_usuario_id varchar(255), lista_largo int, nuevo_programa_id int,nuevo_rol_id int)
BEGIN
	DECLARE x int DEFAULT 0;
	DECLARE nuevo_usuario_id int default NULL;
	DECLARE usuario_id_tmp int default NULL;
	DECLARE resultado BOOLEAN DEFAULT TRUE;
	
    WHILE x < lista_largo DO
		SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x); 
		
        SELECT usuario_id INTO usuario_id_tmp 
        FROM usuario_has_programa_academico 
        WHERE usuario_id = nuevo_usuario_id 
        AND programa_academico_id = nuevo_programa_id
        AND rol_usuario_id = nuevo_rol_id;
		
        IF (usuario_id_tmp IS NOT NULL) THEN
			DELETE FROM usuario_has_programa_academico 
            WHERE programa_academico_id = nuevo_programa_id 
            AND usuario_id = nuevo_usuario_id
            AND rol_usuario_id = nuevo_rol_id;
		ELSE
			SET usuario_id_tmp = NULL;
		END IF;    
		SET x = x +1;
	END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_usuario_con_rol_seccion`(lista_usuario_id varchar(255), lista_largo int, nuevo_seccion_id int,nuevo_rol_id int)
BEGIN
    DECLARE x int DEFAULT 0;
    DECLARE nuevo_usuario_id int default NULL;
    DECLARE usuario_id_tmp int default NULL;
    DECLARE resultado BOOLEAN DEFAULT TRUE;
    
    WHILE x < lista_largo DO
        SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x); 
        
        SELECT usuario_id INTO usuario_id_tmp 
        FROM usuario_has_seccion 
        WHERE usuario_id = nuevo_usuario_id 
        AND seccion_id = nuevo_seccion_id
        AND rol_usuario_id = nuevo_rol_id;

        IF ( usuario_id_tmp IS NOT NULL) THEN
            DELETE FROM usuario_has_seccion  
            WHERE usuario_id = nuevo_usuario_id 
        	AND seccion_id = nuevo_seccion_id
        	AND rol_usuario_id = nuevo_rol_id;
        ELSE
            SET usuario_id_tmp = NULL;
        END IF;    
        SET x = x +1;
    END WHILE;

    SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_usuario_modulo`(lista_usuario_id varchar(255), lista_largo int, nuevo_modulo_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_modulo WHERE usuario_id = nuevo_usuario_id AND modulo_id = nuevo_modulo_id;
    IF ( usuario_id_tmp IS NOT NULL) THEN
		DELETE FROM usuario_has_modulo WHERE modulo_id = nuevo_modulo_id AND usuario_id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_usuario_programa`(lista_usuario_id varchar(255), lista_largo int, nuevo_programa_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT id INTO usuario_id_tmp FROM usuario WHERE id = nuevo_usuario_id AND programa_academico_id = nuevo_programa_id;
    IF ( usuario_id_tmp IS NOT NULL) THEN
		UPDATE usuario 
		SET programa_academico_id = NULL
		WHERE id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_desasigna_usuario_seccion`(lista_usuario_id varchar(255), lista_largo int, nuevo_seccion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_seccion WHERE usuario_id = nuevo_usuario_id AND seccion_id = nuevo_seccion_id;
    IF ( usuario_id_tmp IS NOT NULL) THEN
		DELETE FROM usuario_has_seccion WHERE seccion_id = nuevo_seccion_id AND usuario_id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_eliminado_logico_modulo`(nuevo_id int)
BEGIN
	update modulo m,estado_modulo em
	set m.estado_modulo_id = em.id 
	where m.id = nuevo_id
	and em.id = 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_eliminado_logico_programa_academico`(nuevo_id int)
BEGIN
	update programa_academico pa,estado_programa_academico epa
	set pa.estado_programa_academico_id = epa.id 
	where pa.id = nuevo_id
	and epa.id = 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_eliminado_logico_seccion`(nuevo_id int)
BEGIN
	update seccion s,estado_seccion es
	set s.estado_seccion_id = es.id 
	where s.id = nuevo_id
	and es.id = 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar2_entidad_entidad`(nuevo_entidad_id int(11))
BEGIN
SELECT A.nombre,A.entidad_id,A.id FROM `entidad` A
WHERE A.id = A.entidad_id
AND A.id = nuevo_entidad_id UNION SELECT null,null,A.id FROM (`entidad` A LEFT JOIN `entidad` B ON A.entidad_id = B.id)
WHERE A.entidad_id is NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_contrato_modulo`(nuevo_id int)
BEGIN
		SELECT D.id,D.nombre, D.descripcion
		FROM modulo A,
			 ficha_tecnica_has_modulo B,
			 ficha_tecnica C,
			 contrato_ficha_tecnica D
		WHERE A.id = B.modulo_id
		AND	  C.id = B.ficha_tecnica_id
		AND   C.id = D.ficha_tecnica_id
		AND   A.id = nuevo_id;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_modulos_por_estado`()
BEGIN
	SELECT 
		A.*,
        B.estado

		FROM 
			 modulo A,
			 estado_modulo B
			 
		WHERE A.estado_modulo_id = B.id
		AND   A.estado_modulo_id !=3
		
		UNION SELECT A.*, B.estado
				FROM 
					modulo A LEFT JOIN estado_modulo B ON A.estado_modulo_id = B.id
				WHERE A.estado_modulo_id IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_modulos_por_institucion`(nuevo_institucion_id int)
BEGIN
	SELECT A.*
		FROM modulo A,
			 institucion B
			 
		WHERE A.institucion_id = B.id
		AND B.id = nuevo_institucion_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_modulos_por_programa`(nuevo_id INT)
BEGIN
	SELECT 
		A.*
		
		FROM modulo A,
			 programa_academico_has_modulo B,
			 programa_academico C
			
		WHERE A.id = B.modulo_id
		AND   C.id = B.programa_academico_id
		AND   C.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_programas_academicos_por_estado`()
BEGIN
	SELECT 
		A.*,
        B.estado,
        C.nombre as nombre_institucion

		FROM 
			 programa_academico A,
			 estado_programa_academico B,
             institucion C
			 
		WHERE A.estado_programa_academico_id = B.id
        AND   A.institucion_id = C.id
		AND   A.estado_programa_academico_id !=3
        
		
		UNION SELECT 
				A.*,
                B.estado,
				C.nombre as nombre_institucion
				
                FROM 
					programa_academico A LEFT JOIN estado_programa_academico B ON A.estado_programa_academico_id = B.id,
                    institucion C
                    				
                WHERE A.estado_programa_academico_id IS NULL
                
			UNION SELECT 
				A.*,
                null,
				B.nombre as nombre_institucion
				
                FROM 
					programa_academico A LEFT JOIN institucion B ON A.institucion_id = B.id
                WHERE A.institucion_id IS NULL;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_programas_por_institucion`(nuevo_id int)
BEGIN
	SELECT A.*
	FROM programa_academico A, institucion B
	WHERE A.institucion_id = B.id
	AND B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_secciones_por_estado`()
BEGIN
	SELECT A.*,B.estado
		FROM 
			 seccion A,
			 estado_seccion B,
             modulo C
			 
		WHERE A.estado_seccion_id = B.id
        AND   A.modulo_id = C.id
		AND   A.estado_seccion_id !=3


  
		UNION SELECT A.*,B.estado
				FROM 
					(seccion A LEFT JOIN estado_seccion B ON A.estado_seccion_id = B.id), modulo C
				WHERE A.estado_seccion_id IS NULL;
                
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_secciones_por_modulo`(nuevo_id INT)
BEGIN
	SELECT 
		A.*
		
		FROM seccion A,
			 modulo B
			
		WHERE A.modulo_id = B.id
		AND   B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_usuarios_por_rol`(nuevo_rol_id int,nuevo_programa_id int)
BEGIN
    SELECT 
        A.nombre,
        B.programa_academico_id, 
        B.usuario_id 
    FROM 
        `programa_academico` A, 
        `usuario_has_programa_academico` B,
         usuario_has_rol_usuario C,
         usuario D,
         rol_usuario E
        
        
    WHERE A.id = B.programa_academico_id
    AND   A.id = nuevo_programa_id
    AND   D.id = C.usuario_id
    AND   E.id = C.rol_usuario_id
    AND   E.id = nuevo_rol_id
    AND   B.rol_usuario_id = E.id

    UNION 

    SELECT 
        null,
        null,
        A.id 
    FROM 
    (
    `usuario` A LEFT JOIN `usuario_has_programa_academico` B 
    ON
    A.id = B.usuario_id 
    AND 
    B.programa_academico_id = nuevo_programa_id
    ),  
    usuario_has_rol_usuario C,
    rol_usuario E

    WHERE A.id = C.usuario_id
    AND   E.id = C.rol_usuario_id
    AND   E.id = nuevo_rol_id
    order by usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_usuarios_por_rol2`(nuevo_rol_id int,nuevo_modulo_id int)
BEGIN
	SELECT 
		A.nombre,
        B.modulo_id, 
        B.usuario_id 
	FROM 
		`modulo` A, 
        `usuario_has_modulo` B,
         usuario_has_rol_usuario C,
         usuario D,
         rol_usuario E
        
        
	WHERE A.id = B.modulo_id
	AND   A.id = nuevo_modulo_id
    AND   D.id = C.usuario_id
    AND   E.id = C.rol_usuario_id
    AND   E.id = nuevo_rol_id
    AND   B.rol_usuario_id = E.id

	UNION 

	SELECT 
		null,
		null,
		A.id 
	FROM 
	(
	`usuario` A LEFT JOIN `usuario_has_modulo` B 
	ON
	A.id = B.usuario_id 
	AND 
	B.modulo_id = nuevo_modulo_id
	),	
    usuario_has_rol_usuario C,
    rol_usuario E

	WHERE A.id = C.usuario_id
    AND   E.id = C.rol_usuario_id
    AND   E.id = nuevo_rol_id
    order by usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar_usuarios_por_rol3`(nuevo_rol_id int,nuevo_seccion_id int(11))
BEGIN
    SELECT 
        A.nombre,
        B.seccion_id, 
        B.usuario_id 

    FROM 
        `seccion` A, 
        `usuario_has_seccion` B,
        usuario_has_rol_usuario C,
        usuario D,
        rol_usuario E

    WHERE A.id = B.seccion_id
    AND A.id = nuevo_seccion_id 
    AND   D.id = C.usuario_id
    AND   E.id = C.rol_usuario_id
    AND   E.id = nuevo_rol_id
    AND   B.rol_usuario_id = E.id

    UNION 

    SELECT 
        null,
        null,
        A.id 
    
    FROM (`usuario` A LEFT JOIN `usuario_has_seccion` B ON A.id = B.usuario_id AND B.seccion_id = nuevo_seccion_id),
    usuario_has_rol_usuario C,
    rol_usuario E
    
    WHERE A.id = C.usuario_id
    AND   E.id = C.rol_usuario_id
    AND   E.id = nuevo_rol_id
    order by usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_entidad_modulo`(nuevo_entidad_id int(11))
BEGIN
SELECT A.nombre,B.entidad_id, B.id,B.nombre FROM `entidad` A, `modulo` B 
WHERE A.id = B.entidad_id
AND A.id = nuevo_entidad_id UNION SELECT null,null,A.id,A.nombre FROM (`modulo` A LEFT JOIN `entidad` B ON A.entidad_id = B.id)
WHERE B.id is NULL
AND A.institucion_id is NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_entidad_programa`(nuevo_entidad_id int(11))
BEGIN
SELECT A.nombre,B.entidad_id, B.id,B.nombre FROM `entidad` A, `programa_academico` B 
WHERE A.id = B.entidad_id
AND A.id = nuevo_entidad_id UNION SELECT null,null,A.id,A.nombre FROM (`programa_academico` A LEFT JOIN `entidad` B ON A.entidad_id = B.id)
WHERE B.id is NULL
AND A.institucion_id is null
AND A.entidad_id is NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_ficha_modulo`(nuevo_ficha_id int(11))
BEGIN
	SELECT 
		A.id, 
        B.ficha_tecnica_id,
        B.modulo_id
	
    FROM 
		`ficha_tecnica` A, 
        `ficha_tecnica_has_modulo` B

	WHERE A.id = B.ficha_tecnica_id
	AND A.id = nuevo_ficha_id
 
	UNION 
		SELECT 	null,
				null,
                A.id
 
        FROM (`modulo` A LEFT JOIN `ficha_tecnica_has_modulo` B ON A.id = B.modulo_id AND B.ficha_tecnica_id = nuevo_ficha_id)
        
        WHERE B.ficha_tecnica_id is NULL
		order by modulo_id asc;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_ficha_programa`(nuevo_ficha_id int(11))
BEGIN
	SELECT 
		A.id, 
        B.ficha_tecnica_id,
        B.programa_academico_id
	
    FROM 
		`ficha_tecnica` A, 
        `ficha_tecnica_has_programa_academico` B

	WHERE A.id = B.ficha_tecnica_id
	AND A.id = nuevo_ficha_id
 
	UNION 
		SELECT 	null,
				null,
                A.id
 
        FROM (`programa_academico` A LEFT JOIN `ficha_tecnica_has_programa_academico` B ON A.id = B.programa_academico_id AND B.ficha_tecnica_id = nuevo_ficha_id)
        
        WHERE B.ficha_tecnica_id is NULL
		order by programa_academico_id asc;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_institucion_modulo`(nuevo_institucion_id int(11))
BEGIN
SELECT A.nombre,B.institucion_id, B.id,B.nombre FROM `institucion` A, `modulo` B 
WHERE A.id = B.institucion_id
AND A.id = nuevo_institucion_id UNION SELECT null,null,A.id,A.nombre FROM (`modulo` A LEFT JOIN `institucion` B ON A.institucion_id = B.id)
WHERE B.id is NULL
AND A.entidad_id is NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_institucion_programa`(nuevo_institucion_id int(11))
BEGIN
SELECT A.nombre,B.institucion_id, B.id,B.nombre FROM `institucion` A, `programa_academico` B 
WHERE A.id = B.institucion_id
AND A.id = nuevo_institucion_id UNION SELECT null,null,A.id,A.nombre FROM (`programa_academico` A LEFT JOIN `institucion` B ON A.institucion_id = B.id)
WHERE B.id is NULL
AND A.entidad_id is NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_modulo_usuario`(nuevo_rol_id int,nuevo_modulo_id int)
BEGIN
	SELECT 
		A.nombre,
        B.modulo_id, 
        B.usuario_id 
	FROM 
		`modulo` A, 
        `usuario_has_modulo` B,
        usuario_has_rol_usuario C,
        usuario D,
        rol_usuario E
	
    WHERE A.id = B.modulo_id
	AND   A.id = nuevo_modulo_id
    AND   D.id = C.usuario_id
	AND   E.id = C.rol_usuario_id 
    AND   E.id = nuevo_rol_id
    AND   B.rol_usuario_id = E.id

	
    UNION SELECT null,null,A.id FROM (`usuario` A LEFT JOIN `usuario_has_modulo` B ON A.id = B.usuario_id AND B.modulo_id = nuevo_modulo_id),
    
	usuario_has_rol_usuario C,
    rol_usuario E

    WHERE A.id = B.modulo_id
	AND   A.id = nuevo_modulo_id
    AND   D.id = C.usuario_id
	AND   E.id = C.rol_usuario_id 
    AND   E.id = nuevo_rol_id
    AND   B.rol_usuario_id = E.id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_programa_modulo`(nuevo_programa_id int(11))
BEGIN
SELECT A.nombre,B.programa_academico_id,B.modulo_id,C.nombre FROM `programa_academico` A, `programa_academico_has_modulo` B, `modulo` C
WHERE A.id = B.programa_academico_id
AND A.id = nuevo_programa_id UNION SELECT null,null,A.id,A.nombre FROM (`modulo` A LEFT JOIN `programa_academico_has_modulo` B ON A.id = B.modulo_id AND B.programa_academico_id = nuevo_programa_id)
WHERE B.modulo_id is NULL
order by modulo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_programa_usuario`(nuevo_programa_id int(11))
BEGIN
	SELECT	A.nombre,
			B.programa_academico_id, 
            B.id 
	FROM 	`programa_academico` A, `usuario` B
    
	WHERE	A.id = B.programa_academico_id

	AND A.id = nuevo_programa_id 
    
    UNION SELECT null,
				 null,
				 A.id 
		  FROM (`usuario` A LEFT JOIN `programa_academico` B ON A.programa_academico_id = B.id)
		  WHERE B.id is NULL
          
	UNION SELECT null,
				 null,
				 null
		  FROM (`usuario` A LEFT JOIN `usuario_has_institucion` B ON A.id = B.usuario_id)
          WHERE B.usuario_id IS NULL
          
	UNION SELECT null,
				 null,
				 null
		  FROM (`institucion` A LEFT JOIN `usuario_has_institucion` B ON A.id = B.institucion_id)
          WHERE B.institucion_id IS NULL;
		  
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_seccion_usuario`(nuevo_seccion_id int(11))
BEGIN
SELECT A.nombre,B.seccion_id, B.usuario_id FROM `seccion` A, `usuario_has_seccion` B
WHERE A.id = B.seccion_id
AND A.id = nuevo_seccion_id 
UNION SELECT null,null,A.id FROM (`usuario` A LEFT JOIN `usuario_has_seccion` B ON A.id = B.usuario_id AND B.seccion_id = nuevo_seccion_id)
WHERE B.usuario_id is NULL
AND A.programa_academico_id IS NULL
ORDER BY usuario_id asc;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_actualizar_entidad`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_institucion_id int,
nuevo_entidad_id int,
nuevo_estado_entidad_id int,
nuevo_fecha_modificacion datetime
)
begin
update entidad set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
institucion_id = nuevo_institucion_id,
entidad_id = nuevo_entidad_id,
estado_entidad_id = nuevo_estado_entidad_id,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_actualizar_institucion`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_sigla varchar(50),
nuevo_vision text,
nuevo_mision text,
nuevo_acreditada bit(1),
nuevo_fecha_inicio_acreditacion datetime,
nuevo_fecha_termino_acreditacion datetime,
nuevo_descripcion text,
nuevo_fecha_modificacion datetime,
nuevo_estado_id int,
nuevo_pais_id int,
nuevo_region_id int
)
begin
update institucion set
id = nuevo_id,
nombre = nuevo_nombre,
sigla = nuevo_sigla,
vision = nuevo_vision,
mision = nuevo_mision,
acreditada = nuevo_acreditada,
fecha_inicio_acreditacion = nuevo_fecha_inicio_acreditacion,
fecha_termino_acreditacion = nuevo_fecha_termino_acreditacion,
descripcion = nuevo_descripcion,
fecha_modificacion = now(),
estado_institucion_id = nuevo_estado_id,
pais_id = nuevo_pais_id,
region_id = nuevo_region_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_agregar_entidad`(
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_institucion_id int,
nuevo_entidad_id int,
nuevo_estado_entidad_id int,
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into entidad(
nombre,
descripcion,
institucion_id,
entidad_id,
estado_entidad_id,
fecha_creacion
)
values(
nuevo_nombre,
nuevo_descripcion,
nuevo_institucion_id,
nuevo_entidad_id,
nuevo_estado_entidad_id,
now()
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_agregar_institucion`(
nuevo_nombre varchar(50),
nuevo_sigla varchar(50),
nuevo_vision text,
nuevo_mision text,
nuevo_acreditada bit(1),
nuevo_fecha_inicio_acreditacion datetime,
nuevo_fecha_termino_acreditacion datetime,
nuevo_descripcion text,
nuevo_fecha_creacion datetime,
nuevo_estado_id int,
nuevo_pais_id int,
nuevo_region_id int,
OUT llave_id int(11)
)
begin
insert into institucion(
nombre,
sigla,
vision,
mision,
acreditada,
fecha_inicio_acreditacion,
fecha_termino_acreditacion,
descripcion,
fecha_creacion,
estado_institucion_id,
pais_id,
region_id
)
values(
nuevo_nombre,
nuevo_sigla,
nuevo_vision, 
nuevo_mision, 
nuevo_acreditada, 
nuevo_fecha_inicio_acreditacion, 
nuevo_fecha_termino_acreditacion, 
nuevo_descripcion, 
now(),
nuevo_estado_id,
nuevo_pais_id,
nuevo_region_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_asigna_entidad_entidad`(lista_entidad_id varchar(255), lista_largo int, nuevo_entidad2_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_entidad_id int default NULL;
DECLARE entidad_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
    SET nuevo_entidad_id = getValueFromArray(lista_entidad_id, ',', x);   
    SELECT id INTO entidad_id_tmp FROM entidad WHERE id = nuevo_entidad_id AND entidad_id = nuevo_entidad2_id;
    IF ( entidad_id_tmp IS NULL) THEN
        UPDATE entidad
        SET entidad_id = nuevo_entidad2_id
        WHERE id = nuevo_entidad_id;
    ELSE
        SET entidad_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_entidad_id, entidad_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_asigna_entidad_institucion`(lista_entidad_id varchar(255), lista_largo int,nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_entidad_id int default NULL;
DECLARE entidad_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_entidad_id = getValueFromArray(lista_entidad_id, ',', x);	
    SELECT institucion_id INTO entidad_id_tmp FROM entidad,institucion WHERE institucion_id = nuevo_entidad_id
    AND institucion.id = nuevo_institucion_id;
    IF (entidad_id_tmp IS NULL) THEN
		INSERT INTO entidad (`institucion_id`) VALUES (nuevo_entidad_id);
	ELSE
		SET entidad_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_entidad_id, entidad_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_desasigna_entidad_entidad`(lista_entidad_id varchar(255), lista_largo int, nuevo_entidad2_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_entidad_id int default NULL;
DECLARE entidad_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
    SET nuevo_entidad_id = getValueFromArray(lista_entidad_id, ',', x);   
    SELECT id INTO entidad_id_tmp FROM entidad WHERE id = nuevo_entidad_id AND entidad_id = nuevo_entidad2_id;
    IF ( entidad_id_tmp IS NOT NULL) THEN
        UPDATE entidad
        SET entidad_id = NULL
        WHERE id = nuevo_entidad_id;
    ELSE
        SET entidad_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_entidad_id, entidad_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_eliminado_logico_entidad`(nuevo_id int)
BEGIN
	update entidad en,estado_entidad ee
	set en.estado_entidad_id = ee.id 
	where en.id = nuevo_id
	and ee.id = 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_eliminado_logico_institucion`(nuevo_id int)
BEGIN
	update institucion ins,estado_institucion ei
	set ins.estado_institucion_id = ei.id 
	where ins.id = nuevo_id
	and ei.id = 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_entidad_entidad`(nuevo_id int)
BEGIN
SELECT en.id,en.nombre,en.descripcion,en.fecha_creacion,en.fecha_modificacion,en.entidad_id
FROM entidad en
where en.entidad_id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_entidad_por_estado`()
BEGIN
	SELECT A.*, B.estado 
	
    FROM 
		entidad A,
        estado_entidad B
	
    WHERE	A.estado_entidad_id = B.id  
	AND 	A.estado_entidad_id !=3
    
    UNION SELECT A.*, B.estado
		FROM (entidad A LEFT JOIN estado_entidad B ON A.estado_entidad_id = B.id), institucion C
        WHERE A.estado_entidad_id IS NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_entidad_por_institucion`(nuevo_id_institucion int)
BEGIN
SELECT en.id,en.nombre,en.descripcion,en.fecha_creacion,en.fecha_modificacion,en.entidad_id 
FROM entidad en, institucion ins
WHERE ins.id = en.institucion_id
AND ins.id = nuevo_id_institucion;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_institucion_por_estado`()
BEGIN
	SELECT
		A.*,
        B.estado

	FROM 
		institucion A,
		estado_institucion B

	WHERE 	B.id = A.estado_institucion_id
	AND 	A.estado_institucion_id !=3
    
    UNION SELECT 
			A.*,
			B.estado 
            
          FROM institucion A LEFT JOIN estado_institucion B ON A.estado_institucion_id = B.id
          WHERE A.estado_institucion_id IS NULL;
          
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_rol_por_institucion`(nuevo_id int)
BEGIN
	SELECT A.*
    FROM 
		rol_usuario A,
        institucion B,
        institucion_has_rol_usuario C,
        programa_academico D
        
	WHERE
		A.id = C.rol_usuario_id
	AND
		B.id = C.institucion_id
	AND 
		D.institucion_id = B.id
	AND
		D.id = nuevo_id
	AND
		A.tipo = 'rol_usuario_institucion';
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_rol_por_institucion2`(nuevo_id int)
BEGIN
	SELECT A.*
    FROM 
		rol_usuario A,
        institucion B,
        institucion_has_rol_usuario C,
        modulo D
        
	WHERE
		A.id = C.rol_usuario_id
	AND
		B.id = C.institucion_id
	AND 
		D.institucion_id = B.id
	AND
		D.id = nuevo_id
	AND
		A.tipo = 'rol_usuario_institucion';
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_rol_por_institucion3`(nuevo_id INT)
BEGIN 
	SELECT A.*

		FROM rol_usuario A,
			 institucion_has_rol_usuario B,
			 institucion C,
			 seccion D,
			 modulo E
			 
		WHERE A.id = B.rol_usuario_id
		AND	  C.id = B.institucion_id
		AND   E.id = D.modulo_id 
		AND   C.id = E.institucion_id  
		AND   D.id = nuevo_id
		AND   A.tipo = 'rol_usuario_institucion';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_lista_institucion_entidad`(nuevo_institucion_id int(11))
BEGIN
SELECT A.nombre,B.institucion_id FROM `institucion` A, `entidad` B 
WHERE A.id = B.institucion_id
AND A.id = nuevo_institucion_id
order by institucion_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_nusuario_listar_usuario`()
begin
select * from usuario;
select * from dato_academico;
select * from dato_laboral;
select * from dato_login;
select * from dato_personal;
select * from logica_estado_usuario;
select * from pais;
select * from region;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_agregar_modelo_aprendizaje_herramienta`(

	nuevo_modelo_aprendizaje_nombre VARCHAR (255),
	nuevo_modelo_aprendizaje_descripcion TEXT,
    
    nuevo_trabajo_grupal BOOL,
    nuevo_archivo_recurso BOOL,
    nuevo_link_interes BOOL,
    nuevo_glosario BOOL,
	nuevo_contenido_libre BOOL,
	nuevo_foro BOOL,
	nuevo_evaluacion BOOL,
	nuevo_autoevaluacion BOOL,
	nuevo_proyecto BOOL,
	nuevo_recepcion_trabajo BOOL,
	nuevo_evaluacion_no_objetiva BOOL,
    OUT last_insert_modelo_aprendizaje_id INT(11),
    OUT last_insert_modelo_aprendizaje_herramienta_id INT(11)

)
BEGIN


	INSERT INTO modelo_aprendizaje(
		nombre,
        descripcion,
        fecha_creacion
        
    )
    VALUES(
		nuevo_modelo_aprendizaje_nombre,
        nuevo_modelo_aprendizaje_descripcion,
        NOW()
    );
	
    SELECT LAST_INSERT_ID () INTO last_insert_modelo_aprendizaje_id;
    
    INSERT INTO modelo_aprendizaje_has_herramienta(
		
		trabajo_grupal,
		archivo_recurso,
		link_interes,
		glosario,
		contenido_libre,
		foro,
		evaluacion,
		autoevaluacion,
		proyecto,
		recepcion_trabajo,
		evaluacion_no_objetiva,
		modelo_aprendizaje_id   
    )
    VALUES(
		
		nuevo_trabajo_grupal,
		nuevo_archivo_recurso,
		nuevo_link_interes,
		nuevo_glosario,
		nuevo_contenido_libre,
		nuevo_foro,
		nuevo_evaluacion,
		nuevo_autoevaluacion,
		nuevo_proyecto,
		nuevo_recepcion_trabajo,
		nuevo_evaluacion_no_objetiva,
		last_insert_modelo_aprendizaje_id
    
    );
    
     SELECT LAST_INSERT_ID () INTO last_insert_modelo_aprendizaje_herramienta_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_agregar_repositorio_troncal`(

	nuevo_repositorio_nombre VARCHAR(255),
    nuevo_repositorio_descripcion VARCHAR(255),
    
    OUT last_insert_repositorio_id INT(11)

)
BEGIN

	INSERT INTO repositorio(
		nombre,
        descripcion,
        fecha_creacion,
        fecha_modificacion,
        tipo_repositorio_id   
        
    )
    VALUES(
		nuevo_repositorio_nombre,
        nuevo_repositorio_descripcion,
        NOW(),
        NOW(),
        1
    );
	
    SELECT LAST_INSERT_ID () INTO last_insert_repositorio_id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_asignar_modelo_aprendizaje_repositorio`(nuevo_repositorio_id int , nuevo_modelo_id int)
BEGIN
UPDATE repositorio SET modelo_aprendizaje_id =  nuevo_modelo_id
WHERE id = nuevo_repositorio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_asignar_mod_aprendizaje_master_rep_master`(nuevo_repositorio_id int , nuevo_modelo_id int)
BEGIN
UPDATE repositorio_master SET modelo_aprendizaje_master_id =  nuevo_modelo_id
WHERE id = nuevo_repositorio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_asignar_mod_aprendizaje_rep_local_admin`(nuevo_repositorio_id int , nuevo_modelo_id int)
begin
UPDATE repositorio_local_admin SET modelo_aprendizaje_id =  nuevo_modelo_id
WHERE id = nuevo_repositorio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_asignar_mod_aprendizaje_rep_troncal_admin`(nuevo_repositorio_id int , nuevo_modelo_id int)
begin
UPDATE repositorio_troncal_admin SET modelo_aprendizaje_id =  nuevo_modelo_id
WHERE id = nuevo_repositorio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_asigna_repositorio_institucion`(lista_repositorio_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_repositorio_id int default NULL;
DECLARE repositorio_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_repositorio_id = getValueFromArray(lista_repositorio_id, ',', x);	
    SELECT repositorio_id INTO repositorio_id_tmp FROM institucion_has_repositorio WHERE repositorio_id = nuevo_repositorio_id AND institucion_id = nuevo_institucion_id;
    IF ( repositorio_id_tmp IS NULL) THEN
		INSERT INTO institucion_has_repositorio (`repositorio_id`,`institucion_id`) VALUES (nuevo_repositorio_id,nuevo_institucion_id);
	ELSE
		SET repositorio_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_repositorio_id, repositorio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_asigna_repositorio_master_institucion`(lista_repositorio_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_repositorio_id int default NULL;
DECLARE repositorio_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_repositorio_id = getValueFromArray(lista_repositorio_id, ',', x);	
    SELECT repositorio_master_id INTO repositorio_id_tmp FROM repositorio_master_has_institucion WHERE repositorio_master_id = nuevo_repositorio_id AND institucion_id = nuevo_institucion_id;
    IF ( repositorio_id_tmp IS NULL) THEN
		INSERT INTO repositorio_master_has_institucion (`repositorio_master_id`,`institucion_id`) VALUES (nuevo_repositorio_id,nuevo_institucion_id);
	ELSE
		SET repositorio_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_repositorio_id, repositorio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_desasigna_repositorio_institucion`(lista_repositorio_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_repositorio_id int default NULL;
DECLARE repositorio_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_repositorio_id = getValueFromArray(lista_repositorio_id, ',', x);	
    SELECT repositorio_id INTO repositorio_id_tmp FROM institucion_has_repositorio WHERE repositorio_id = nuevo_repositorio_id AND institucion_id = nuevo_institucion_id;
    IF ( repositorio_id_tmp IS NOT NULL) THEN
		DELETE FROM institucion_has_repositorio WHERE institucion_id = nuevo_institucion_id AND repositorio_id = nuevo_repositorio_id;
	ELSE
		SET repositorio_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_repositorio_id, repositorio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_desasigna_repositorio_master_institucion`(lista_repositorio_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_repositorio_id int default NULL;
DECLARE repositorio_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_repositorio_id = getValueFromArray(lista_repositorio_id, ',', x);	
    SELECT repositorio_id INTO repositorio_id_tmp FROM repositorio_master_has_institucion WHERE repositorio_id = nuevo_repositorio_id AND institucion_id = nuevo_institucion_id;
    IF ( repositorio_id_tmp IS NOT NULL) THEN
		DELETE FROM repositorio_master_has_institucion WHERE institucion_id = nuevo_institucion_id AND repositorio_id = nuevo_repositorio_id;
	ELSE
		SET repositorio_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_repositorio_id, repositorio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_listar_modelo_aprendizaje_has_herramienta`(nuevo_modelo_aprendizaje_id INT)
BEGIN

	SELECT *
    FROM modelo_aprendizaje_has_herramienta
    WHERE modelo_aprendizaje_id = nuevo_modelo_aprendizaje_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_lista_institucion_repositorio`(nuevo_institucion_id int(11))
BEGIN
SELECT 
		I.nombre,
		IR.institucion_id,
		IR.repositorio_id 
FROM 
		`institucion` I, 
		`institucion_has_repositorio` IR 
		
WHERE I.id = IR.institucion_id
AND I.id = nuevo_institucion_id 

UNION 

SELECT 
		null,
        null,
        R.id 
FROM 
		(`repositorio` R LEFT JOIN `institucion_has_repositorio` IR ON R.id = IR.repositorio_id AND IR.institucion_id = nuevo_institucion_id)
        
WHERE IR.repositorio_id is NULL
order by repositorio_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_lista_institucion_repositorio_master`(nuevo_institucion_id int(11))
BEGIN
SELECT A.nombre,B.institucion_id, B.repositorio_master_id 
FROM 
		`institucion` A, 
        `repositorio_master_has_institucion` B
        
WHERE A.id = B.institucion_id
AND A.id = nuevo_institucion_id 

UNION 

SELECT null,null,A.id 
FROM (`repositorio_master` A LEFT JOIN `repositorio_master_has_institucion` B ON A.id = B.repositorio_master_id AND B.institucion_id = nuevo_institucion_id)
WHERE B.repositorio_master_id is NULL
order by repositorio_master_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_repositorio_modificar_modelo_aprendizaje_herramienta`(

	nuevo_modelo_aprendizaje_id INT,
    nuevo_modelo_aprendizaje_nombre VARCHAR (255),
	nuevo_modelo_aprendizaje_descripcion TEXT,
    
    nuevo_trabajo_grupal BOOL,
    nuevo_archivo_recurso BOOL,
    nuevo_link_interes BOOL,
    nuevo_glosario BOOL,
	nuevo_contenido_libre BOOL,
	nuevo_foro BOOL,
	nuevo_evaluacion BOOL,
	nuevo_autoevaluacion BOOL,
	nuevo_proyecto BOOL,
	nuevo_recepcion_trabajo BOOL,
	nuevo_evaluacion_no_objetiva BOOL,
    OUT last_insert_modelo_aprendizaje_id INT(11),
    OUT last_insert_modelo_aprendizaje_herramienta_id INT(11)

)
BEGIN

	UPDATE modelo_aprendizaje SET
		nombre = nuevo_modelo_aprendizaje_nombre,
        descripcion = nuevo_modelo_aprendizaje_descripcion,
        fecha_modificacion = NOW()
	WHERE modelo_aprendizaje.id = nuevo_modelo_aprendizaje_id;	
	
    SET last_insert_modelo_aprendizaje_id = nuevo_modelo_aprendizaje_id;
    
    UPDATE modelo_aprendizaje_has_herramienta SET
		
		trabajo_grupal = nuevo_trabajo_grupal,
		archivo_recurso = nuevo_archivo_recurso,
		link_interes = nuevo_link_interes,
		glosario = nuevo_glosario,
		contenido_libre = nuevo_contenido_libre,
		foro = nuevo_foro,
		evaluacion = nuevo_evaluacion,
		autoevaluacion = nuevo_autoevaluacion,
		proyecto = nuevo_proyecto,
		recepcion_trabajo = nuevo_recepcion_trabajo,
		evaluacion_no_objetiva = nuevo_evaluacion_no_objetiva
	 WHERE  modelo_aprendizaje_id = nuevo_modelo_aprendizaje_id;
    
     SELECT id  INTO last_insert_modelo_aprendizaje_herramienta_id
     FROM modelo_aprendizaje_has_herramienta 
     WHERE  modelo_aprendizaje_id = nuevo_modelo_aprendizaje_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asignar_privilegio_rol_automatico`( nuevo_rol_id int ,nuevo_permiso_name varchar(255) )
BEGIN

declare i int default 0;
declare i_total int default 0;
declare i_text text default null;
declare id_values int default 0;

-- Contando cantidad de filas de ID de privilegio 
	SELECT COUNT(PRIV.id) into i_total
	FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

	WHERE PRIV.controlador_usuario_id = C.id
	AND C.authitem_permiso_usuario_name= P.name
	AND P.name = nuevo_permiso_name;           
	
-- Obtiendo valores de las filas ID de privilegio

	SELECT GROUP_CONCAT(PRIV.id SEPARATOR ',') into i_text 
	FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

	WHERE PRIV.controlador_usuario_id = C.id
	AND C.authitem_permiso_usuario_name= P.name
	AND P.name = nuevo_permiso_name;
    
    WHILE i < i_total DO
		SET id_values = getValueFromArray(i_text, ',', i);	
		insert into rol_usuario_has_privilegio_usuario (rol_usuario_id,privilegio_usuario_id) values (nuevo_rol_id,id_values);
        SET i = i +1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asignar_roles_generales_a_institucion`(lista_rol_id text, lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x INT DEFAULT 0;
DECLARE nuevo_rol_id INT default NULL;
DECLARE rol_id_tmp INT default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
DECLARE rol_copia INT DEFAULT NULL;

DECLARE permisos_totales INT DEFAULT NULL;
DECLARE permisos_concat VARCHAR (255) DEFAULT NULL;
DECLARE i int DEFAULT 0;
DECLARE nuevo_permiso_name varchar(255) default NULL;
DECLARE permiso_name_tmp varchar (255) default NULL;

DECLARE privilegios_totales INT DEFAULT NULL;
DECLARE privilegios_concat VARCHAR(255) DEFAULT NULL;
DECLARE j int DEFAULT 0;
DECLARE nuevo_privilegio_id varchar(255) default NULL;
DECLARE privilegio_id_tmp varchar (255) default NULL;

WHILE x < lista_largo DO
	SET nuevo_rol_id = getValueFromArray(lista_rol_id, ',', x);	
-- 	ASIGNOR ROL GENERAL A INSTITUCION -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_id AND institucion_id = nuevo_institucion_id;
    IF ( rol_id_tmp IS NULL) THEN
		INSERT INTO institucion_has_rol_usuario (`rol_usuario_id`,`institucion_id`) VALUES (nuevo_rol_id,nuevo_institucion_id);
        
--  	COPIAR ROL GENERAL -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
		INSERT INTO rol_usuario(nombre,descripcion,tipo,rol_usuario_general_id,fecha_creacion,fecha_eliminacion,fecha_acceso,fecha_modificacion) 
		SELECT 
				R.nombre,
				R.descripcion,
				'rol_usuario_institucion',
				R.id,
				now(),
				null,
				null,
				now()
				
		FROM	rol_usuario R		
		WHERE 	R.id= nuevo_rol_id; 
		
		SELECT LAST_INSERT_ID () into rol_copia;
        
-- 		ASIGNAR PERMISOS A ROL COPIA-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --        
		SELECT COUNT(RP.authitem_permiso_usuario_name) into permisos_totales
		FROM rol_usuario_has_authitem_permiso_usuario RP            
		WHERE RP.rol_usuario_id = nuevo_rol_id;
		
		SELECT GROUP_CONCAT(RP.authitem_permiso_usuario_name SEPARATOR ',') into permisos_concat
		FROM rol_usuario_has_authitem_permiso_usuario RP            
		WHERE RP.rol_usuario_id = nuevo_rol_id;
	  
		WHILE i < permisos_totales DO
			SET nuevo_permiso_name = getValueFromArray(permisos_concat, ',', i);	
			SELECT authitem_permiso_usuario_name INTO permiso_name_tmp FROM rol_usuario_has_authitem_permiso_usuario WHERE authitem_permiso_usuario_name = nuevo_permiso_name AND rol_usuario_id = rol_copia;
			IF ( permiso_name_tmp IS NULL) THEN
				INSERT INTO rol_usuario_has_authitem_permiso_usuario (`authitem_permiso_usuario_name`,`rol_usuario_id`) VALUES (nuevo_permiso_name,rol_copia);
			ELSE
				SET permiso_name_tmp = NULL;
			END IF;
			SET i = i + 1;
		END WHILE;
		SET i = 0;
        
--  	CONTANDO CANTIDAD DE FILAS DE ID DE PRIVILEGIO --------------------------------------------------------------------------------
		SELECT COUNT(RPRIV.privilegio_usuario_id) into privilegios_totales
		FROM rol_usuario_has_privilegio_usuario RPRIV
		WHERE RPRIV.rol_usuario_id = nuevo_rol_id;
        
-- 		OBTENIENDO VALORES DE LAS FILAS DE ID DE PRIVILEGIO ----------------------------------------------------------------------------
		SELECT GROUP_CONCAT(RPRIV.privilegio_usuario_id SEPARATOR ',') into privilegios_concat
		FROM rol_usuario_has_privilegio_usuario RPRIV
		WHERE RPRIV.rol_usuario_id = nuevo_rol_id;
        
-- 		ASIGNA TODOS LOS PRIVILEGIOS DE LOS PERMISOS A ROL COPIA---------------------------------------------------------------------------------------------------------------------------------------------------
		WHILE j < privilegios_totales DO
			SET nuevo_privilegio_id = getValueFromArray(privilegios_concat, ',', j);	
			SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = rol_copia;
			IF ( privilegio_id_tmp IS NULL) THEN
				INSERT INTO rol_usuario_has_privilegio_usuario (`privilegio_usuario_id`,`rol_usuario_id`) VALUES (nuevo_privilegio_id,rol_copia);
			ELSE
				SET privilegio_id_tmp = NULL;
			END IF;    
			SET j = j +1;
		END WHILE;		
		SET j = 0;
        
-- 		ASIGNAR ROL COPIA A INSTITUCION --------------------------------------------------------------------------------------------------------------------------------      
		SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = rol_copia AND institucion_id = nuevo_institucion_id;
		IF ( rol_id_tmp IS NULL) THEN
			INSERT INTO institucion_has_rol_usuario (`rol_usuario_id`,`institucion_id`) VALUES (rol_copia,nuevo_institucion_id);
		ELSE
			SET rol_id_tmp = NULL;
		END IF;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
	ELSE
		SET rol_id_tmp = NULL;
    END IF; 
    SET x = x +1;
    SET rol_copia = NULL;
    SET permisos_totales = NULL;
    SET permisos_concat = NULL;
    
END WHILE;
SELECT resultado, nuevo_rol_id, rol_id_tmp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asigna_permiso_rol`(lista_permiso_name text, lista_largo int, nuevo_rol_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_permiso_name varchar(255) default NULL;
DECLARE permiso_name_tmp varchar (255) default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
DECLARE privilegios_totales INT DEFAULT NULL;
DECLARE privilegios_concat VARCHAR(255) DEFAULT NULL;
	
DECLARE i int DEFAULT 0;
DECLARE nuevo_privilegio_id varchar(255) default NULL;
DECLARE privilegio_id_tmp varchar (255) default NULL;
    

WHILE x < lista_largo DO
	SET nuevo_permiso_name = getValueFromArray(lista_permiso_name, ',', x);	
--  ASIGNA PERMISO ROL USUARIO----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
    SELECT authitem_permiso_usuario_name INTO permiso_name_tmp FROM rol_usuario_has_authitem_permiso_usuario WHERE authitem_permiso_usuario_name = nuevo_permiso_name AND rol_usuario_id = nuevo_rol_id;
    IF ( permiso_name_tmp IS NULL) THEN
		INSERT INTO rol_usuario_has_authitem_permiso_usuario (`authitem_permiso_usuario_name`,`rol_usuario_id`) VALUES (nuevo_permiso_name,nuevo_rol_id);
        
        
-- 		CONTANDO CANTIDAD DE FILAS DE ID DE PRIVILEGIO --------------------------------------------------------------------------------
		SELECT COUNT(PRIV.id) into privilegios_totales
		FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

		WHERE PRIV.controlador_usuario_id = C.id
		AND C.authitem_permiso_usuario_name= P.name
		AND P.name = nuevo_permiso_name;           	
-- 		OBTENIENDO VALORES DE LAS FILAS DE ID DE PRIVILEGIO ----------------------------------------------------------------------------
		SELECT GROUP_CONCAT(PRIV.id SEPARATOR ',') into privilegios_concat
		FROM 
				authitem_permiso_usuario P,
				controlador_usuario C,
				privilegio_usuario PRIV 

		WHERE PRIV.controlador_usuario_id = C.id
		AND C.authitem_permiso_usuario_name= P.name
		AND P.name = nuevo_permiso_name;
--  	ASIGNA TODOS LOS PRIVILEGIOS DE LOS PERMISOS A ROL USUARIO---------------------------------------------------------------------------------------------------------------------------------------------------
		WHILE i < privilegios_totales DO
			SET nuevo_privilegio_id = getValueFromArray(privilegios_concat, ',', i);	
			SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = nuevo_rol_id;
			IF ( privilegio_id_tmp IS NULL) THEN
				INSERT INTO rol_usuario_has_privilegio_usuario (`privilegio_usuario_id`,`rol_usuario_id`) VALUES (nuevo_privilegio_id,nuevo_rol_id);
			ELSE
				SET privilegio_id_tmp = NULL;
			END IF;    
			SET i = i +1;
		END WHILE;
		
		SET i = 0;
-- 		-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	ELSE
		SET permiso_name_tmp = NULL;
    END IF;
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_permiso_name, permiso_name_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asigna_privilegio_rol`(lista_privilegio_id text, lista_largo int, nuevo_rol_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_privilegio_id varchar(255) default NULL;
DECLARE privilegio_id_tmp varchar (255) default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_privilegio_id = getValueFromArray(lista_privilegio_id, ',', x);	
    SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = nuevo_rol_id;
    IF ( privilegio_id_tmp IS NULL) THEN
		INSERT INTO rol_usuario_has_privilegio_usuario (`privilegio_usuario_id`,`rol_usuario_id`) VALUES (nuevo_privilegio_id,nuevo_rol_id);
	ELSE
		SET privilegio_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_privilegio_id, privilegio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asigna_rol_institucion`(lista_rol_id text, lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_rol_id int default NULL;
DECLARE rol_id_tmp int (255) default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_rol_id = getValueFromArray(lista_rol_id, ',', x);	
    SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_id AND institucion_id = nuevo_institucion_id;
    IF ( rol_id_tmp IS NULL) THEN
		INSERT INTO institucion_has_rol_usuario (`rol_usuario_id`,`institucion_id`) VALUES (nuevo_rol_id,nuevo_institucion_id);
	ELSE
		SET rol_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_rol_id, rol_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asigna_usuario_institucion_rol_usuario`(lista_usuario_id varchar(255), lista_largo int, nuevo_rol_usuario_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_rol_usuario WHERE usuario_id = nuevo_usuario_id AND rol_usuario_id = nuevo_rol_usuario_id;
    IF ( usuario_id_tmp IS NULL) THEN
		INSERT INTO usuario_has_rol_usuario (`usuario_id`,`rol_usuario_id`) VALUES (nuevo_usuario_id,nuevo_rol_usuario_id);
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_copiar_roles_generales`(lista_rol_id text, lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x INT DEFAULT 0;
DECLARE nuevo_rol_id INT default NULL;
DECLARE rol_id_tmp INT default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
DECLARE rol_copia INT DEFAULT NULL;

DECLARE permisos_totales INT DEFAULT NULL;
DECLARE permisos_concat VARCHAR (255) DEFAULT NULL;
DECLARE i int DEFAULT 0;
DECLARE nuevo_permiso_name varchar(255) default NULL;
DECLARE permiso_name_tmp varchar (255) default NULL;

DECLARE privilegios_totales INT DEFAULT NULL;
DECLARE privilegios_concat VARCHAR(255) DEFAULT NULL;
DECLARE j int DEFAULT 0;
DECLARE nuevo_privilegio_id varchar(255) default NULL;
DECLARE privilegio_id_tmp varchar (255) default NULL;

WHILE x < lista_largo DO
	SET nuevo_rol_id = getValueFromArray(lista_rol_id, ',', x);	
-- 	ASIGNOR ROL GENERAL A INSTITUCION -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_id AND institucion_id = nuevo_institucion_id;
    IF ( rol_id_tmp IS NULL) THEN
		INSERT INTO institucion_has_rol_usuario (`rol_usuario_id`,`institucion_id`) VALUES (nuevo_rol_id,nuevo_institucion_id);
	ELSE
		SET rol_id_tmp = NULL;
    END IF; 
--  COPIAR ROL GENERAL -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    INSERT INTO rol_usuario(nombre,descripcion,tipo,rol_usuario_general_id,fecha_creacion,fecha_eliminacion,fecha_acceso,fecha_modificacion) 
	SELECT 
			R.nombre,
			R.descripcion,
			'rol_usuario_institucion',
            R.id,
			now(),
			null,
			null,
			now()
			
	FROM
		rol_usuario R		
	WHERE R.id= nuevo_rol_id; 
    
	SELECT LAST_INSERT_ID () into rol_copia;

-- 	ASIGNAR PERMISOS A ROL COPIA-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
    
	SELECT COUNT(RP.authitem_permiso_usuario_name) into permisos_totales
    FROM rol_usuario_has_authitem_permiso_usuario RP            
	WHERE RP.rol_usuario_id = nuevo_rol_id;
    
    SELECT GROUP_CONCAT(RP.authitem_permiso_usuario_name SEPARATOR ',') into permisos_concat
    FROM rol_usuario_has_authitem_permiso_usuario RP            
	WHERE RP.rol_usuario_id = nuevo_rol_id;
  
	WHILE i < permisos_totales DO
		SET nuevo_permiso_name = getValueFromArray(permisos_concat, ',', i);	
		SELECT authitem_permiso_usuario_name INTO permiso_name_tmp FROM rol_usuario_has_authitem_permiso_usuario WHERE authitem_permiso_usuario_name = nuevo_permiso_name AND rol_usuario_id = rol_copia;
		IF ( permiso_name_tmp IS NULL) THEN
			INSERT INTO rol_usuario_has_authitem_permiso_usuario (`authitem_permiso_usuario_name`,`rol_usuario_id`) VALUES (nuevo_permiso_name,rol_copia);
		ELSE
			SET permiso_name_tmp = NULL;
		END IF;
        
-- ---- CONTANDO CANTIDAD DE FILAS DE ID DE PRIVILEGIO --------------------------------------------------------------------------------
		SELECT COUNT(PRIV.id) into privilegios_totales
		FROM 
				authitem_permiso_usuario P,
				controlador_usuario C,
				privilegio_usuario PRIV 

		WHERE PRIV.controlador_usuario_id = C.id
		AND C.authitem_permiso_usuario_name= P.name
		AND P.name = nuevo_permiso_name;           	
-- ---- OBTENIENDO VALORES DE LAS FILAS DE ID DE PRIVILEGIO ----------------------------------------------------------------------------
		SELECT GROUP_CONCAT(PRIV.id SEPARATOR ',') into privilegios_concat
		FROM 
				authitem_permiso_usuario P,
				controlador_usuario C,
				privilegio_usuario PRIV 

		WHERE PRIV.controlador_usuario_id = C.id
		AND C.authitem_permiso_usuario_name= P.name
		AND P.name = nuevo_permiso_name;
-- ---- ASIGNA TODOS LOS PRIVILEGIOS DE LOS PERMISOS A ROL COPIA---------------------------------------------------------------------------------------------------------------------------------------------------
		WHILE j < privilegios_totales DO
			SET nuevo_privilegio_id = getValueFromArray(privilegios_concat, ',', j);	
			SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = rol_copia;
			IF ( privilegio_id_tmp IS NULL) THEN
				INSERT INTO rol_usuario_has_privilegio_usuario (`privilegio_usuario_id`,`rol_usuario_id`) VALUES (nuevo_privilegio_id,rol_copia);
			ELSE
				SET privilegio_id_tmp = NULL;
			END IF;    
			SET j = j +1;
		END WHILE;		
		SET j = 0;    
-- --------------------------------------------------------------------------------------------------------------------------------       
		SET i = i + 1;
	END WHILE;

-- 	ASIGNAR ROL COPIA A INSTITUCION --------------------------------------------------------------------------------------------------------------------------------
      
    SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = rol_copia AND institucion_id = nuevo_institucion_id;
    IF ( rol_id_tmp IS NULL) THEN
		INSERT INTO institucion_has_rol_usuario (`rol_usuario_id`,`institucion_id`) VALUES (rol_copia,nuevo_institucion_id);
	ELSE
		SET rol_id_tmp = NULL;
    END IF;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
    SET x = x +1;
    SET rol_copia = NULL;
    SET permisos_totales = NULL;
    SET permisos_concat = NULL;
    SET i = 0;
END WHILE;

SELECT resultado, nuevo_rol_id, rol_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasignar_privilegio_rol_automatico`( nuevo_rol_id int ,nuevo_permiso_name varchar(255) )
BEGIN

declare i int default 0;
declare i_total int default 0;
declare i_text text default null;
declare id_values int default 0;

-- Contando cantidad de filas de ID de privilegio 
	SELECT COUNT(PRIV.id) into i_total
	FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

	WHERE PRIV.controlador_usuario_id = C.id
	AND C.authitem_permiso_usuario_name= P.name
	AND P.name = nuevo_permiso_name;           
	
-- Obtiendo valores de las filas ID de privilegio

	SELECT GROUP_CONCAT(PRIV.id SEPARATOR ',') into i_text 
	FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

	WHERE PRIV.controlador_usuario_id = C.id
	AND C.authitem_permiso_usuario_name= P.name
	AND P.name = nuevo_permiso_name;
    
    WHILE i < i_total DO
		SET id_values = getValueFromArray(i_text, ',', i);	
		DELETE FROM rol_usuario_has_privilegio_usuario 
        WHERE rol_usuario_id = nuevo_rol_id        
        AND privilegio_usuario_id=id_values;
        SET i = i +1;
    END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasignar_roles_generales`(lista_rol_id text, lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_rol_id int default NULL;
DECLARE rol_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;

DECLARE rol_copia INT DEFAULT NULL;

DECLARE permisos_totales INT DEFAULT NULL;
DECLARE permisos_concat VARCHAR (255) DEFAULT NULL;

DECLARE nuevo_permiso_name VARCHAR (255) DEFAULT NULL;
DECLARE permiso_name_tmp VARCHAR (255) DEFAULT NULL;
DECLARE i INT DEFAULT 0;

DECLARE privilegios_totales INT DEFAULT NULL;
DECLARE privilegios_concat VARCHAR (255) DEFAULT NULL;

DECLARE nuevo_privilegio_id INT DEFAULT NULL;
DECLARE privilegio_id_tmp INT DEFAULT NULL;
DECLARE j INT DEFAULT NULL;

WHILE x < lista_largo DO
	SET nuevo_rol_id = getValueFromArray(lista_rol_id, ',', x);	
-- 	SELECCIONANDO ROL COPIA -------------------------------------------------------------------------------------------------    
	SELECT R.id INTO rol_copia
	FROM 	
			rol_usuario R,
			institucion_has_rol_usuario IR
            
	WHERE R.rol_usuario_general_id = nuevo_rol_id
    AND IR.rol_usuario_id = R.id
    AND IR.institucion_id = nuevo_institucion_id;
--  CONTANDO Y AGRUPANDO PERMISOS DE ROL COPIA ------------------------------------------------------------------------------   
    
    SELECT COUNT(RP.authitem_permiso_usuario_name) into permisos_totales
    FROM rol_usuario_has_authitem_permiso_usuario RP            
	WHERE RP.rol_usuario_id = rol_copia;
    
    SELECT GROUP_CONCAT(RP.authitem_permiso_usuario_name SEPARATOR ',') into permisos_concat
    FROM rol_usuario_has_authitem_permiso_usuario RP            
	WHERE RP.rol_usuario_id = rol_copia;
--  DESASIGNANDO PERMISOS DE ROL COPIA --------------------------------------------------------------------------------------    
    
    WHILE i < permisos_totales DO
		SET nuevo_permiso_name = getValueFromArray(permisos_concat,',',i);
        SELECT authitem_permiso_usuario_name INTO permiso_name_tmp FROM rol_usuario_has_authitem_permiso_usuario WHERE authitem_permiso_usuario_name = nuevo_permiso_name AND rol_usuario_id = rol_copia;
		IF( permiso_name_tmp IS NOT NULL) THEN 
			DELETE FROM rol_usuario_has_authitem_permiso_usuario WHERE authitem_permiso_usuario_name = nuevo_permiso_name AND rol_usuario_id = rol_copia;
		ELSE 
			SET permiso_name_tmp = NULL;
		END IF;
        
-- 		CONTANDO Y AGRUPANDO PRIVILEGIOS DEL PERMISO DEL ROL COPIA -----------------------------------------------------------------
		SELECT COUNT(RPRIV.privilegio_usuario_id) INTO privilegios_totales
        FROM 
				rol_usuario_has_privilegio_usuario RPRIV,
				privilegio_usuario PRIV,
				controlador_usuario C,
				authitem_permiso_usuario P
			
		WHERE RPRIV.rol_usuario_id = rol_copia
        AND P.name = nuevo_permiso_name
        AND P.name = C.authitem_permiso_usuario_name
        AND C.id = PRIV.controlador_usuario_id
        AND PRIV.id = RPRIV.privilegio_usuario_id;
        
		SELECT GROUP_CONCAT(RPRIV.privilegio_usuario_id SEPARATOR ',') into privilegios_concat
		FROM 
					rol_usuario_has_privilegio_usuario RPRIV,
					privilegio_usuario PRIV,
					controlador_usuario C,
					authitem_permiso_usuario P
				
		WHERE RPRIV.rol_usuario_id = rol_copia
		AND P.name = nuevo_permiso_name
		AND P.name = C.authitem_permiso_usuario_name
		AND C.id = PRIV.controlador_usuario_id
		AND PRIV.id = RPRIV.privilegio_usuario_id;

-- DESASIGNA PRIVILEGIOS DE ROL COPIA -----------------------------------------------------------------------------------------
        WHILE j < privilegios_totales DO
			SET nuevo_privilegio_id = getValueFromArray(privilegios_concat, ',', j);	
			SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = rol_copia;
			IF ( privilegio_id_tmp IS NOT NULL) THEN
				DELETE FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = rol_copia;
			ELSE
				SET privilegio_id_tmp = NULL;
			END IF;    
			SET j = j +1;
		END WHILE;		
		SET j = 0;
        
-- -----------------------------------------------------------------------------------------------------------------------------
        
        
        
        
        SET i = i + 1;
    END WHILE;
	SET i = 0;  
    

    
    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_rol_id, rol_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasignar_roles_generales_a_institucion`(lista_rol_id text, lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_rol_id int default NULL;
DECLARE rol_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;

DECLARE rol_copia INT DEFAULT NULL;

DECLARE permisos_totales INT DEFAULT NULL;
DECLARE permisos_concat VARCHAR (255) DEFAULT NULL;

DECLARE nuevo_permiso_name VARCHAR (255) DEFAULT NULL;
DECLARE permiso_name_tmp VARCHAR (255) DEFAULT NULL;
DECLARE i INT DEFAULT 0;

DECLARE privilegios_totales INT DEFAULT NULL;
DECLARE privilegios_concat VARCHAR (255) DEFAULT NULL;

DECLARE nuevo_privilegio_id INT DEFAULT NULL;
DECLARE privilegio_id_tmp INT DEFAULT NULL;
DECLARE j INT DEFAULT NULL;

WHILE x < lista_largo DO
	SET nuevo_rol_id = getValueFromArray(lista_rol_id, ',', x);	

	SELECT R.id INTO rol_copia
	FROM
			rol_usuario R,
			institucion_has_rol_usuario IR

	WHERE R.rol_usuario_general_id = nuevo_rol_id
	AND IR.rol_usuario_id = R.id
	AND IR.institucion_id = nuevo_institucion_id;


	DELETE RPRIV.*
	FROM rol_usuario_has_privilegio_usuario RPRIV
	WHERE RPRIV.rol_usuario_id = rol_copia;

	DELETE RP.*
	FROM rol_usuario_has_authitem_permiso_usuario RP
	WHERE RP.rol_usuario_id = rol_copia;

	DELETE IR.*
	FROM institucion_has_rol_usuario IR
	WHERE IR.rol_usuario_id = rol_copia;

	DELETE R.*
	FROM rol_usuario R
	WHERE R.id = rol_copia;

	SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_id AND institucion_id = nuevo_institucion_id;
    IF ( rol_id_tmp IS NOT NULL) THEN
		DELETE FROM institucion_has_rol_usuario WHERE institucion_id = nuevo_institucion_id AND rol_usuario_id = nuevo_rol_id;
	ELSE
		SET rol_id_tmp = NULL;
    END IF;    
    
    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_rol_id, rol_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasigna_permiso_rol`(lista_permiso_name text, lista_largo int, nuevo_rol_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_permiso_name varchar(255) default NULL;
DECLARE permiso_name_tmp varchar(255) default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
DECLARE privilegios_totales INT DEFAULT NULL;
DECLARE privilegios_concat VARCHAR (255) DEFAULT NULL;

DECLARE i int DEFAULT 0;
DECLARE nuevo_privilegio_id varchar(255) default NULL;
DECLARE privilegio_id_tmp varchar(255) default NULL;

WHILE x < lista_largo DO
	SET nuevo_permiso_name = getValueFromArray(lista_permiso_name, ',', x);	
-- DESASIGNA PERMISO DE ROL_USUARIO --------------------------------------------------------------------------------------------------    
    SELECT authitem_permiso_usuario_name INTO permiso_name_tmp FROM rol_usuario_has_authitem_permiso_usuario WHERE authitem_permiso_usuario_name = nuevo_permiso_name AND rol_usuario_id = nuevo_rol_id;
    IF ( permiso_name_tmp IS NOT NULL) THEN
		DELETE FROM rol_usuario_has_authitem_permiso_usuario WHERE rol_usuario_id = nuevo_rol_id AND authitem_permiso_usuario_name = nuevo_permiso_name;
	ELSE
		SET permiso_name_tmp = NULL;
    END IF;
-- 	CONTANDO CANTIDAD DE FILAS DE ID DE PRIVILEGIO --------------------------------------------------------------------------------
	SELECT COUNT(PRIV.id) into privilegios_totales
	FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

	WHERE PRIV.controlador_usuario_id = C.id
	AND C.authitem_permiso_usuario_name= P.name
	AND P.name = nuevo_permiso_name;           	
-- OBTENIENDO VALORES DE LAS FILAS DE ID DE PRIVILEGIO ----------------------------------------------------------------------------
	SELECT GROUP_CONCAT(PRIV.id SEPARATOR ',') into privilegios_concat
	FROM 
			authitem_permiso_usuario P,
			controlador_usuario C,
			privilegio_usuario PRIV 

	WHERE PRIV.controlador_usuario_id = C.id
	AND C.authitem_permiso_usuario_name= P.name
	AND P.name = nuevo_permiso_name;    
--  DESASIGNA TODOS LOS PRIVILEGIOS DEL PERMISO A ROL_USUARIO-------------------------------------------------------------------------------------------------------------------------------------  
	WHILE i < privilegios_totales DO
		SET nuevo_privilegio_id = getValueFromArray(privilegios_concat, ',', i);	
		SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = nuevo_rol_id;
		IF ( privilegio_id_tmp IS NOT NULL) THEN
			DELETE FROM rol_usuario_has_privilegio_usuario WHERE rol_usuario_id = nuevo_rol_id AND privilegio_usuario_id = nuevo_privilegio_id;
		ELSE
			SET privilegio_id_tmp = NULL;
		END IF;    
		SET i = i +1;
	END WHILE;
	SET i = 0;
-- -------------------------------------------------------------------------------------------------------------------------------------
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_permiso_name, permiso_name_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasigna_privilegio_rol`(lista_privilegio_id text, lista_largo int, nuevo_rol_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_privilegio_id varchar(255) default NULL;
DECLARE privilegio_id_tmp varchar(255) default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_privilegio_id = getValueFromArray(lista_privilegio_id, ',', x);	
    SELECT privilegio_usuario_id INTO privilegio_id_tmp FROM rol_usuario_has_privilegio_usuario WHERE privilegio_usuario_id = nuevo_privilegio_id AND rol_usuario_id = nuevo_rol_id;
    IF ( privilegio_id_tmp IS NOT NULL) THEN
		DELETE FROM rol_usuario_has_privilegio_usuario WHERE rol_usuario_id = nuevo_rol_id AND privilegio_usuario_id = nuevo_privilegio_id;
	ELSE
		SET privilegio_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_privilegio_id, privilegio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasigna_rol_institucion`(lista_rol_id text, lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_rol_id int default NULL;
DECLARE rol_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_rol_id = getValueFromArray(lista_rol_id, ',', x);	
    SELECT rol_usuario_id INTO rol_id_tmp FROM institucion_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_id AND institucion_id = nuevo_institucion_id;
    IF ( rol_id_tmp IS NOT NULL) THEN
		DELETE FROM institucion_has_rol_usuario WHERE institucion_id = nuevo_institucion_id AND rol_usuario_id = nuevo_rol_id;
	ELSE
		SET rol_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_rol_id, rol_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasigna_usuario_institucion_rol_usuario`(lista_usuario_id varchar(255), lista_largo int, nuevo_rol_usuario_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_rol_usuario WHERE usuario_id = nuevo_usuario_id AND rol_usuario_id = nuevo_rol_usuario_id;
    IF ( usuario_id_tmp IS NOT NULL) THEN
		DELETE FROM usuario_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_usuario_id AND usuario_id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_listar_rol_usuario_general`()
BEGIN
SELECT R.*
FROM rol_usuario R
WHERE R.tipo = 'rol_usuario_general';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_listar_rol_usuario_institucion`(nuevo_institucion_id int)
BEGIN
SELECT R.*
FROM rol_usuario R,
	institucion_has_rol_usuario IR
WHERE R.tipo = 'rol_usuario_institucion'
AND R.id = IR.rol_usuario_id
AND IR.institucion_id = nuevo_institucion_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_institucion_rol`(nuevo_institucion_id int(11))
BEGIN
SELECT 
		I.id,
        IR.institucion_id, 
        IR.rol_usuario_id,
        R.nombre as rol_usuario_nombre,
        R.tipo as rol_usuario_tipo
FROM 
		`institucion` I, 
        `institucion_has_rol_usuario` IR,
        rol_usuario R
        
WHERE I.id = IR.institucion_id
AND I.id = nuevo_institucion_id
AND R.id = IR.rol_usuario_id 
AND R.tipo = 'rol_usuario_general'

UNION 

SELECT 
		null,
        null,
        R.id, 
        R.nombre as rol_usuario_nombre,
        R.tipo as rol_usuario_tipo
FROM 
(
	`rol_usuario` R LEFT JOIN `institucion_has_rol_usuario` IR 
	ON
	R.id = IR.rol_usuario_id
	AND 
	IR.institucion_id = nuevo_institucion_id
)

WHERE IR.rol_usuario_id is NULL
AND R.tipo = 'rol_usuario_general'
order by rol_usuario_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_rol_institucion`(nuevo_rol_id int(11))
BEGIN
SELECT A.nombre,B.rol_usuario_id,B.institucion_id FROM `rol_usuario` A, `institucion_has_rol_usuario` B 
WHERE A.id = B.rol_usuario_id
AND A.id = nuevo_rol_id UNION SELECT null,null,A.id FROM (`institucion` A LEFT JOIN `institucion_has_rol_usuario` B ON A.id = B.institucion_id AND B.rol_usuario_id = nuevo_rol_id)
WHERE B.institucion_id is NULL
order by institucion_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_rol_permiso`(nuevo_rol_id int(11))
BEGIN
SELECT 
		A.nombre,
        B.rol_usuario_id, 
        B.authitem_permiso_usuario_name 
FROM 
		`rol_usuario` A, 
        `rol_usuario_has_authitem_permiso_usuario` B
        
WHERE A.id = B.rol_usuario_id
AND A.id = nuevo_rol_id 

UNION 

SELECT 
		null,
        null,
        A.name 
FROM 
(
	`authitem_permiso_usuario` A LEFT JOIN `rol_usuario_has_authitem_permiso_usuario` B 
	ON
	A.name = B.authitem_permiso_usuario_name 
	AND 
	B.rol_usuario_id = nuevo_rol_id
)

WHERE B.authitem_permiso_usuario_name is NULL
order by authitem_permiso_usuario_name;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_rol_permiso_privilegio`(nuevo_rol_id int(11),nuevo_permiso_name text)
BEGIN
SELECT 
        RPRIV.rol_usuario_id, 
        RPRIV.privilegio_usuario_id ,
        C.nombre as controlador_usuario_nombre,
        PRIV.nombre as privilegio_usuario_nombre
FROM 
        `rol_usuario_has_privilegio_usuario` RPRIV,
        authitem_permiso_usuario P,
        controlador_usuario C,
        privilegio_usuario PRIV
        
        
        
WHERE  RPRIV.rol_usuario_id = (

	SELECT 
			RP.rol_usuario_id
	FROM
			rol_usuario_has_authitem_permiso_usuario RP


	WHERE RP.authitem_permiso_usuario_name = nuevo_permiso_name
	AND RP.rol_usuario_id = nuevo_rol_id

	)
AND P.name = C.authitem_permiso_usuario_name
AND C.id = PRIV.controlador_usuario_id
AND P.name = nuevo_permiso_name
AND PRIV.id = RPRIV.privilegio_usuario_id


UNION 

SELECT 
        null,
        PRIV.id, 
        C.nombre as controlador_usuario_nombre,
        PRIV.nombre as privilegio_usuario_nombre
FROM 
(
	`privilegio_usuario` PRIV LEFT JOIN `rol_usuario_has_privilegio_usuario` RPRIV 
	ON	PRIV.id = RPRIV.privilegio_usuario_id 
	AND	RPRIV.rol_usuario_id = nuevo_rol_id
),
	controlador_usuario C,
    authitem_permiso_usuario P

WHERE RPRIV.privilegio_usuario_id is NULL

AND P.name = nuevo_permiso_name
AND P.name = C.authitem_permiso_usuario_name
AND C.id = PRIV.controlador_usuario_id

order by privilegio_usuario_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_rol_privilegio`(nuevo_rol_id int(11))
BEGIN
SELECT 
		A.nombre,
        B.rol_usuario_id, 
        B.privilegio_usuario_id 
FROM 
		`rol_usuario` A, 
        `rol_usuario_has_privilegio_usuario` B
        
WHERE A.id = B.rol_usuario_id
AND A.id = nuevo_rol_id 

UNION 

SELECT 
		null,
        null,
        A.id 
FROM 
(
	`privilegio_usuario` A LEFT JOIN `rol_usuario_has_privilegio_usuario` B 
	ON	A.id = B.privilegio_usuario_id 
	AND	B.rol_usuario_id = nuevo_rol_id
)

WHERE B.privilegio_usuario_id is NULL
order by privilegio_usuario_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_usuario_institucion_rol_usuario`(nuevo_rol_usuario_id int, nuevo_institucion_id int)
BEGIN

SELECT 
		R.id,
        UR.rol_usuario_id,
        UR.usuario_id,
        U.usuario,
        DP.rut, 
        DP.primer_nombre,
        DP.apellido_paterno,
        DP.apellido_materno
	
FROM 
	
	`rol_usuario` R, 
	`usuario_has_rol_usuario` UR, 
    usuario U,
    dato_personal DP

WHERE R.id = UR.rol_usuario_id
AND R.id = nuevo_rol_usuario_id
AND U.id = UR.usuario_id
AND DP.usuario_id = U.id

UNION

SELECT 

		null,
        null,
        U.id,
        U.usuario,
        DP.rut,
        DP.primer_nombre,
        DP.apellido_paterno,
        DP.apellido_materno
FROM
	(`usuario` U LEFT JOIN `usuario_has_rol_usuario` UR ON U.id = UR.usuario_id AND UR.rol_usuario_id = nuevo_rol_usuario_id),
    usuario_has_institucion UI,
    dato_personal DP

WHERE UR.usuario_id is NULL
AND UI.institucion_id = nuevo_institucion_id
AND UI.usuario_id = U.id
AND DP.usuario_id = U.id
ORDER BY usuario_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_dato_academico`(
nuevo_id int,
nuevo_universidad varchar(50),
nuevo_carrera varchar(30),
nuevo_ano_cursado int,
nuevo_duracion_carrera int,
nuevo_sede varchar(30),
nuevo_direccion_sede varchar(30),
nuevo_comuna_sede varchar(30),
nuevo_ciudad_sede varchar(30),
nuevo_usuario_id int
)
BEGIN	
UPDATE dato_academico SET
id = nuevo_id,
universidad = nuevo_universidad,
carrera = nuevo_carrera,
ano_cursado = nuevo_ano_cursado,
duracion_carrera = nuevo_duracion_carrera,
sede = nuevo_sede,
direccion_sede = nuevo_direccion_sede,
comuna_sede = nuevo_comuna_sede,
ciudad_sede = nuevo_ciudad_sede,
usuario_id = nuevo_usuario_id
where id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_dato_laboral`(
nuevo_id int,
nuevo_nombre_empresa varchar(50),
nuevo_ano_antiguedad varchar(30),
nuevo_cargo varchar(30),
nuevo_actividad varchar(30),
nuevo_comuna_empresa varchar(30),
nuevo_ciudad_empresa varchar(30),
nuevo_telefono_empresa int,
nuevo_celular_empresa int,
nuevo_rut_numero int,
nuevo_digito_verificador int,
nuevo_usuario_id int
)
BEGIN	
UPDATE dato_laboral set
id = nuevo_id,
nombre_empresa = nuevo_nombre_empresa,
ano_antiguedad = nuevo_ano_antiguedad,
cargo = nuevo_cargo,
actividad = nuevo_actividad,
comuna_empresa = nuevo_comuna_empresa,
ciudad_empresa = nuevo_ciudad_empresa,
telefono_empresa = nuevo_telefono_empresa,
celular_empresa = nuevo_celular_empresa,
rut_numero = nuevo_rut_numero,
digito_verificador = nuevo_digito_verificador,
usuario_id = nuevo_usuario_id
where id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_dato_login`(
nuevo_id int,
nuevo_pregunta_secreta_1 varchar(50),
nuevo_pregunta_secreta_2 varchar(50),
nuevo_respuesta_secreta_1 varchar(50),
nuevo_respuesta_secreta_2 varchar(50),
nuevo_usuario_id int
)
BEGIN
UPDATE dato_login set
id = nuevo_id,
pregunta_secreta_1 = nuevo_pregunta_secreta_1,
pregunta_secreta_2 = nuevo_pregunta_secreta_2,
respuesta_secreta_1 = nuevo_respuesta_secreta_1,
respuesta_secreta_2 = nuevo_respuesta_secreta_2,
usuario_id = nuevo_usuario_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_dato_personal`(
nuevo_id int,
nuevo_primer_nombre varchar(50),
nuevo_segundo_nombre varchar(50),
nuevo_apellido_paterno varchar(50),
nuevo_apellido_materno varchar(50),
nuevo_fecha_nacimiento datetime,
nuevo_edad int,
nuevo_rut int,
nuevo_digito_verificador int,
nuevo_direccion_personal varchar(50),
nuevo_numero_casa int,
nuevo_telefono_personal int,
nuevo_celular_personal int,
nuevo_comuna_personal varchar(50),
nuevo_ciudad_personal varchar(50),
nuevo_interes varchar(50),
nuevo_estado_civil varchar (20),
nuevo_idioma varchar(50),
nuevo_nacionalidad varchar(50),
nuevo_usuario_id int
)
BEGIN
UPDATE dato_personal set
id = nuevo_id,
primer_nombre = nuevo_primer_nombre,
segundo_nombre = nuevo_segundo_nombre,
apellido_paterno = nuevo_apellido_paterno,
apellido_materno = nuevo_apellido_materno,
fecha_nacimiento = nuevo_fecha_nacimiento,
edad = nuevo_edad,
rut = nuevo_rut,
digito_verificador = nuevo_digito_verificador,
direccion_personal = nuevo_direccion_personal,
numero_casa = nuevo_numero_casa,
telefono_personal = nuevo_telefono_personal,
celular_personal = nuevo_celular_personal,
comuna_personal = nuevo_comuna_personal,
ciudad_personal = nuevo_ciudad_personal,
interes = nuevo_interes,
estado_civil = nuevo_estado_civil,
idioma = nuevo_idioma,
nacionalidad = nuevo_nacionalidad,
usuario_id = nuevo_usuario_id
where id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_estado_codigo_seguridad`(
nuevo_id int,
nuevo_estado varchar(50)
)
begin
update estado_codigo_seguridad
set 
id = nuevo_id,
estado = nuevo_estado
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_logica_estado_usuario`(
nuevo_id int,
nuevo_estado varchar(50)
)
begin
update logica_estado_usuario set
id = nuevo_id,
estado = nuevo_estado
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_pais`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_codigo varchar(50)
)
BEGIN
UPDATE pais set
id = nuevo_id,
nombre = nuevo_nombre,
codigo = nuevo_codigo
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_pregunta_login`(
nuevo_id int,
nueva_pregunta varchar(50)
)
begin
update pregunta_login set
id = nuevo_id,
pregunta = nueva_pregunta
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_region`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
nuevo_pais_id int
)
BEGIN
UPDATE pais set
id = nuevo_id,
nombre = nuevo_nombre,
codigo = nuevo_codigo,
pais_id = nuevo_pais_id
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_actualizar_usuario`(
nuevo_id int,
nuevo_usuario varchar(50),
nuevo_clave varchar(50),
nuevo_fecha_modificacion datetime,
nuevo_estado_usuario_id int
)
BEGIN
UPDATE usuario SET
id = nuevo_id,
usuario = nuevo_usuario,
clave = nuevo_clave,
fecha_modificacion = now(),
estado_usuario_id = nuevo_estado_usuario_id
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_dato_academico`(
nuevo_universidad varchar(50),
nuevo_carrera varchar(50),
nuevo_ano_cursado int,
nuevo_duracion_carrera int,
nuevo_sede varchar(50),
nuevo_direccion_sede varchar(50) ,
nuevo_comuna_sede varchar(50),
nuevo_ciudad_sede varchar(50),
nuevo_usuario_id int,
OUT llave_id int(11)
)
begin
INSERT INTO dato_academico(
universidad,
carrera,
ano_cursado,
duracion_carrera,
sede,
direccion_sede,
comuna_sede,
ciudad_sede,
usuario_id
)

VALUES(
nuevo_universidad,
nuevo_carrera,
nuevo_ano_cursado,
nuevo_duracion_carrera,
nuevo_sede,
nuevo_direccion_sede,
nuevo_comuna_sede,
nuevo_ciudad_sede,
nuevo_usuario_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_dato_laboral`(
nuevo_nombre_empresa varchar(50),
nuevo_año_antiguedad int,
nuevo_cargo varchar(50),
nuevo_actividad varchar(200),
nuevo_comuna_empresa varchar(50),
nuevo_ciudad_empresa varchar(50),
nuevo_telefono_empresa int,
nuevo_celular_empresa int,
nuevo_rut_numero int,
nuevo_digito_verificador int,
nuevo_usuario_id int,
OUT llave_id int(11)
)
begin
INSERT INTO dato_laboral(
nombre_empresa,
ano_antiguedad,
cargo,
actividad,
comuna_empresa,
ciudad_empresa,
telefono_empresa,
celular_empresa,
rut_numero,
digito_verificador,
usuario_id
)

VALUES(
nuevo_nombre_empresa,
nuevo_año_antiguedad,
nuevo_cargo,
nuevo_actividad,
nuevo_comuna_empresa,
nuevo_ciudad_empresa,
nuevo_telefono_empresa,
nuevo_celular_empresa,
nuevo_rut_numero,
nuevo_digito_verificador,
nuevo_usuario_id 
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_dato_login`(
nuevo_pregunta_secreta1 varchar(50),
nuevo_pregunta_secreta2 varchar(50),
nuevo_respuesta_secreta1 varchar(50),
nuevo_respuesta_secreta2 varchar(50),
nuevo_usuario_id int,
OUT llave_id int(11)
)
begin
INSERT INTO dato_login(
pregunta_secreta_1,
pregunta_secreta_2,
respuesta_secreta_1,
respuesta_secreta_2,
usuario_id
)

VALUES(
nuevo_pregunta_secreta1,
nuevo_pregunta_secreta2,
nuevo_respuesta_secreta1,
nuevo_respuesta_secreta2,
nuevo_usuario_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_dato_personal`(
nuevo_primer_nombre varchar(50),
nuevo_segundo_nombre varchar(50),
nuevo_apellido_paterno varchar(50),
nuevo_apellido_materno varchar(50),
nuevo_fecha_nacimiento datetime,
nuevo_edad int,
nuevo_rut int,
nuevo_digito_verificador int,
nuevo_direccion_personal varchar(50),
nuevo_numero_casa int,
nuevo_telefono_personal int,
nuevo_celular_personal int,
nuevo_comuna_personal varchar(50),
nuevo_ciudad_personal varchar(50),
nuevo_interes varchar(50),
nuevo_estado_civil varchar (20),
nuevo_idioma varchar(50),
nuevo_nacionalidad varchar(50),
nuevo_usuario_id int,
OUT llave_id int(11)
)
begin
INSERT INTO dato_personal(
 primer_nombre,
 segundo_nombre,
 apellido_paterno,
 apellido_materno,
 fecha_nacimiento,
 edad,
 rut,
 digito_verificador,
 direccion_personal,
 numero_casa,
 telefono_personal,
 celular_personal,
 comuna_personal,
 ciudad_personal,
 interes,
 estado_civil,
 idioma,
 nacionalidad,
 usuario_id
)

VALUES (
 nuevo_primer_nombre,
 nuevo_segundo_nombre,
 nuevo_apellido_paterno,
 nuevo_apellido_materno,
 nuevo_fecha_nacimiento,
 nuevo_edad,
 nuevo_rut,
 nuevo_digito_verificador,
 nuevo_direccion_personal ,
 nuevo_numero_casa ,
 nuevo_telefono_personal ,
 nuevo_celular_personal ,
 nuevo_comuna_personal ,
 nuevo_ciudad_personal ,
 nuevo_interes,
 nuevo_estado_civil,
 nuevo_idioma,
 nuevo_nacionalidad,
 nuevo_usuario_id 
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_estado_codigo_seguridad`(
nuevo_estado varchar(50),
OUT llave_id int(11)
)
begin
insert into estado_codigo_seguridad(
estado
)
values(
nuevo_estado
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_logica_estado_usuario`(
nuevo_estado varchar(50),
OUT llave_id int(11)
)
begin
insert into logica_estado_usuario(
estado
)
values(
nuevo_estado
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_pais`(
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
OUT llave_id int(11)
)
begin
INSERT INTO pais(
nombre,
codigo
)

VALUES(
nuevo_nombre,
nuevo_codigo
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_pregunta_login`(
nueva_pregunta varchar(50),
OUT llave_id int(11)
)
begin
insert into pregunta_login(
pregunta
)
values(
nueva_pregunta
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_region`(
nuevo_nombre varchar(50),
nuevo_codigo varchar(50),
nuevo_pais_id int,
OUT llave_id int(11)
)
begin
INSERT INTO region(
nombre,
codigo,
pais_id
)

VALUES(
nuevo_nombre,
nuevo_codigo,
nuevo_pais_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_agregar_usuario`(
nuevo_usuario varchar(50),
nuevo_clave varchar(50),
nuevo_fecha_creacion datetime,
nuevo_estado_usuario_id int,
OUT llave_id int(11)
)
begin
INSERT INTO usuario(
usuario,
clave,
fecha_creacion,
estado_usuario_id
)
VALUES(
nuevo_usuario,
nuevo_clave,
now(),
nuevo_estado_usuario_id
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_asigna_estado_usuario`(lista_usuario_id varchar(255), lista_largo int, nuevo_estado_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM estado_usuario WHERE usuario_id = nuevo_usuario_id AND logica_estado_usuario_id = nuevo_estado_id;
    IF (usuario_id_tmp IS NULL) THEN
		INSERT INTO estado_usuario (`usuario_id`,`logica_estado_usuario_id`) VALUES (nuevo_usuario_id,nuevo_estado_id);
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_asigna_usuario_institucion`(lista_usuario_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_institucion WHERE usuario_id = nuevo_usuario_id AND institucion_id = nuevo_institucion_id;
    IF ( usuario_id_tmp IS NULL) THEN
		INSERT INTO usuario_has_institucion (`usuario_id`,`institucion_id`) VALUES (nuevo_usuario_id,nuevo_institucion_id);
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_desasigna_estado_usuario`(lista_usuario_id varchar(255), lista_largo int, nuevo_estado_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM estado_usuario WHERE usuario_id = nuevo_usuario_id AND logica_estado_usuario_id = nuevo_estado_id;
    IF (usuario_id_tmp IS NOT NULL) THEN
		DELETE FROM estado_usuario WHERE logica_estado_usuario_id = nuevo_estado_id AND usuario_id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_desasigna_usuario_institucion`(lista_usuario_id varchar(255), lista_largo int, nuevo_institucion_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_usuario_id int default NULL;
DECLARE usuario_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_usuario_id = getValueFromArray(lista_usuario_id, ',', x);	
    SELECT usuario_id INTO usuario_id_tmp FROM usuario_has_institucion WHERE usuario_id = nuevo_usuario_id AND institucion_id = nuevo_institucion_id;
    IF ( usuario_id_tmp IS NOT NULL) THEN
		DELETE FROM usuario_has_institucion WHERE institucion_id = nuevo_institucion_id AND usuario_id = nuevo_usuario_id;
	ELSE
		SET usuario_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_usuario_id, usuario_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_fisico_dato_academico`(nuevo_id int)
BEGIN
DELETE FROM dato_academico 
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_fisico_dato_laboral`(nuevo_id int)
BEGIN
DELETE FROM dato_laboral 
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_fisico_dato_login`(nuevo_id int)
BEGIN
DELETE FROM dato_login
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_fisico_dato_personal`(nuevo_id int)
BEGIN
DELETE FROM dato_personal
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_fisico_pais`(nuevo_id int)
BEGIN
DELETE FROM pais
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_fisico_region`(nuevo_id int)
BEGIN
DELETE FROM region
WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_logico_usuario`(nuevo_id int)
BEGIN
	update usuario usu,estado_usuario ea
	set usu.estado_usuario_id = ea.id 
	where usu.id = nuevo_id
	and ea.id = 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_academicos_por_estado`()
BEGIN
	SELECT A.*, B.usuario
			
    FROM 
		dato_academico A,
        usuario B,
        estado_usuario C
        
	WHERE	A.usuario_id = B.id
	AND   	B.estado_usuario_id = C.id
	AND 	B.estado_usuario_id !=3
    
    UNION SELECT A.*, B.usuario
    
			FROM	(usuario B LEFT JOIN estado_usuario C ON B.estado_usuario_id = C.id), dato_academico A
			WHERE	B.estado_usuario_id IS NULL
            AND  	A.usuario_id = B.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_academicos_por_usuario`(nuevo_id int)
BEGIN
	SELECT 
		A.*
        
	FROM 
		dato_academico A,
		usuario B
        
	WHERE A.usuario_id = B.id
    AND   B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_laborales_por_estado`()
BEGIN
	SELECT A.*, B.usuario
			
    FROM 
		dato_laboral A,
        usuario B,
        estado_usuario C
	
    WHERE	A.usuario_id = B.id
	AND 	B.estado_usuario_id = C.id
	AND 	B.estado_usuario_id !=3
    
    UNION SELECT A.*, B.usuario
    
			FROM	(usuario B LEFT JOIN estado_usuario C ON B.estado_usuario_id = C.id), dato_laboral A
			WHERE	B.estado_usuario_id IS NULL
            AND  	A.usuario_id = B.id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_laborales_por_usuario`(nuevo_id int)
BEGIN
	SELECT 
		A.*
        
	FROM 
		dato_laboral A,
		usuario B
        
	WHERE A.usuario_id = B.id
    AND   B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_login_por_estado`()
BEGIN
	SELECT A.*, B.usuario

	FROM 
		dato_login A,
        usuario B,
        estado_usuario C
	
    WHERE	A.usuario_id = B.id
	AND 	B.estado_usuario_id = C.id
	AND 	B.estado_usuario_id !=3
    
    UNION SELECT A.*, B.usuario
    
			FROM	(usuario B LEFT JOIN estado_usuario C ON B.estado_usuario_id = C.id), dato_login A
			WHERE	B.estado_usuario_id IS NULL
            AND  	A.usuario_id = B.id;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_personales_por_estado`()
BEGIN
	SELECT A.*, B.usuario
			
	FROM 
		dato_personal A,
        usuario B,
        estado_usuario C
	
    WHERE	A.usuario_id = B.id
	AND 	B.estado_usuario_id = C.id
	AND 	B.estado_usuario_id !=3
    
     UNION SELECT A.*, B.usuario 
    
			FROM	(usuario B LEFT JOIN estado_usuario C ON B.estado_usuario_id = C.id), dato_personal A
			WHERE	B.estado_usuario_id IS NULL
            AND  	A.usuario_id = B.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_personales_por_usuario`(nuevo_id int)
BEGIN
	SELECT 
		A.*
        
	FROM 
		dato_personal A,
		usuario B
        
	WHERE A.usuario_id = B.id
    AND   B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_estado_usuario`(nuevo_id_usuario varchar(50))
BEGIN	
	SELECT * FROM (logica_estado_usuario A LEFT JOIN estado_usuario B ON A.id =  B.logica_estado_usuario_id AND B.usuario_id = nuevo_id_usuario);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_por_estado`(nuevo_estado varchar(50))
BEGIN
SELECT usu.id,usu.usuario, usu.clave, lo.estado 
FROM usuario usu, logica_estado_usuario lo, estado_usuario ea
WHERE usu.id = ea.usuario_id
AND lo.id = ea.logica_estado_usuario_id
AND lo.estado = nuevo_estado;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_usuarios_por_estado`()
BEGIN
		SELECT  usu.id,
				usu.usuario,
                usu.clave,
                usu.fecha_acceso,
                usu.fecha_modificacion,
                usu.fecha_creacion,
                eu.estado

                
		FROM 	usuario usu,
				estado_usuario eu
	

		WHERE	eu.id = usu.estado_usuario_id
        AND 	usu.estado_usuario_id !=3
        
		 
		UNION SELECT	usu.id,
						usu.usuario,
						usu.clave,
						usu.fecha_acceso,
						usu.fecha_modificacion,
						usu.fecha_creacion,
						eu.estado

		FROM	usuario usu LEFT JOIN estado_usuario eu ON usu.estado_usuario_id = eu.id
		WHERE	usu.estado_usuario_id IS NULL;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_lista_institucion_usuario`(nuevo_institucion_id int(11))
BEGIN
	SELECT 
		A.nombre,
		B.institucion_id, 
        B.usuario_id,
        C.usuario
	
    FROM 
		`institucion` A, 
        `usuario_has_institucion` B,
        usuario C

	WHERE A.id = B.institucion_id
    AND  C.id = B.usuario_id
	AND A.id = nuevo_institucion_id
 
	UNION 
		SELECT 	null,
				null,
                A.id,
                A.usuario
		
        FROM (`usuario` A LEFT JOIN `usuario_has_institucion` B ON A.id = B.usuario_id AND B.institucion_id = nuevo_institucion_id)
        
        WHERE B.usuario_id is NULL
		order by usuario_id asc;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_lista_usuario_estado`(nuevo_usuario_id int(11))
BEGIN
SELECT A.usuario,B.usuario_id, B.logica_estado_usuario_id FROM `usuario` A, `estado_usuario` B 
WHERE A.id = B.usuario_id
AND A.id = nuevo_usuario_id UNION SELECT null,null,A.id FROM (`logica_estado_usuario` A LEFT JOIN `estado_usuario` B ON A.id = B.logica_estado_usuario_id)
WHERE B.logica_estado_usuario_id is NULL
order by logica_estado_usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aula_listar_modulos_no_asignados_a_programa`(nuevoIdRol int, nuevoIdUsuario int)
BEGIN
	SELECT M.id,M.nombre,M.descripcion
		FROM  
		usuario U,
		usuario_has_modulo UM, 
		rol_usuario RU,
		usuario_has_rol_usuario UR, 
		estado_modulo EM,
		(modulo M LEFT JOIN  programa_academico_has_modulo P ON  M.id = P.modulo_id )

		 WHERE P.modulo_id IS NULL
		 AND U.id = UM.usuario_id
		 AND EM.id = M.estado_modulo_id
		 AND EM.id = 1
		 AND U.id = UR.usuario_id
		 AND RU.id = UR.rol_usuario_id
		 AND UM.modulo_id = M.id
		 AND RU.tipo = 'rol_usuario_institucion'
		 AND RU.id = nuevoIdRol
		 AND U.id = nuevoIdUsuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aula_listar_modulos_por_programa`(nuevo_id int)
BEGIN
	SELECT A.id,A.nombre,A.descripcion
    
    FROM 
		modulo A,
		programa_academico B,
        programa_academico_has_modulo C,
        estado_modulo D
        
	WHERE A.id = C.modulo_id
    AND   B.id = C.programa_academico_id
    AND   A.estado_modulo_id = D.id
    AND   A.estado_modulo_id = 1
    AND   B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aula_listar_programas_por_rol`(nuevo_id int,id_usuario int)
BEGIN
	SELECT A.id,A.nombre,A.descripcion
    
    FROM 
		programa_academico A,
        usuario B,
        rol_usuario C,
        usuario_has_rol_usuario D,
        usuario_has_programa_academico E,
        estado_programa_academico F
        
	WHERE A.id = E.programa_academico_id
    AND   B.id = E.usuario_id
    AND   C.id = E.rol_usuario_id
    AND   B.id = D.usuario_id
    AND   C.id = D.rol_usuario_id
    AND   A.estado_programa_academico_id = F.id
    AND   A.estado_programa_academico_id !=3
    AND   C.id = nuevo_id
    AND   B.id = id_usuario;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aula_listar_roles_por_usuario`(nuevo_id int)
BEGIN
	SELECT 
		A.id,
		A.nombre

	FROM 
		rol_usuario A,
		usuario B,
		institucion C,
		usuario_has_rol_usuario D,
		institucion_has_rol_usuario E,
		usuario_has_institucion F
		
	WHERE A.id = D.rol_usuario_id
	AND   A.id = E.rol_usuario_id
	AND   B.id = D.usuario_id
	AND   B.id = F.usuario_id
	AND   C.id = E.institucion_id
	AND   C.id = F.institucion_id
	AND   A.tipo = 'rol_usuario_institucion'
	AND   B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_aula_listar_secciones_por_modulo`(nuevo_id int)
BEGIN
	SELECT A.id, A.nombre, A.descripcion
    
	FROM
		seccion A,
        Modulo B,
        estado_seccion C

	WHERE B.id = A.modulo_id
    AND   A.estado_seccion_id = C.id
    AND   A.estado_seccion_id =1
    AND   B.id = nuevo_id;    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_components_agregar_archivo`(
	 nuevo_archivo_nombre VARCHAR(255),
     nuevo_archivo_mime_type TEXT,
     nuevo_archivo_tamano INT(11),
     nuevo_archivo_ruta TEXT,
     nuevo_archivo_usuario_id INT(11),
     nuevo_archivo_contenedor_id INT(11),
     nuevo_archivo_contenedor_tabla VARCHAR(255),
	 OUT last_insert_archivo_id INT(11)
)
BEGIN
	
	INSERT INTO archivo(
		nombre,
        mime_type,
        tamano,
        ruta,
        usuario_id,
        fecha_creacion,
        contenedor_id,
        contenedor_tabla        
    )
    VALUES(
		nuevo_archivo_nombre,
        nuevo_archivo_mime_type,
        nuevo_archivo_tamano,
        nuevo_archivo_ruta,
        nuevo_archivo_usuario_id,
        NOW(),
        nuevo_archivo_contenedor_id,
        nuevo_archivo_contenedor_tabla        
    );
    
	SELECT LAST_INSERT_ID () INTO last_insert_archivo_id;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_components_eliminar_archivo`(nuevo_archivo_id INT)
BEGIN

DELETE FROM archivo WHERE id = nuevo_archivo_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_components_obtener_institucion_usuario`(nuevo_usuario_id int)
BEGIN

SELECT I.*
FROM
		institucion I,
        usuario_has_institucion UI,
        usuario U
        
WHERE UI.institucion_id = I.id
AND UI.usuario_id = U.id
AND U.id = nuevo_usuario_id
ORDER BY institucion_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_component_listar_archivos_copia_repositorio`(lista_repositorio_id VARCHAR(255))
BEGIN

SET @sql = CONCAT('SELECT C.*
				FROM 
						archivo_copia_repositorio_modulo_temp C
				WHERE   C.repositorio_id_old IN (',lista_repositorio_id,')');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_component_lista_archivos`(nuevo_contenedor_id INT,nuevo_contenedor_tabla VARCHAR(255))
BEGIN

SELECT A.*

FROM archivo A
WHERE A.contenedor_id = nuevo_contenedor_id
AND A.contenedor_tabla = nuevo_contenedor_tabla

ORDER BY A.id;
END$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_escritorio_usuario_get_permiso_usuario`(nuevo_usuario_id int)
BEGIN
SELECT P.name
FROM 
		usuario U,      
        usuario_has_rol_usuario UR,
        rol_usuario R,
        rol_usuario_has_authitem_permiso_usuario RP,
        authitem_permiso_usuario P
      
WHERE U.id = UR.usuario_id
AND R.id = UR.rol_usuario_id
AND R.id = RP.rol_usuario_id
AND P.name = RP.authitem_permiso_usuario_name
AND U.id = nuevo_usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_actualizar_foro`(
		
        nuevo_id INT,
        nuevo_repositorio_id INT,
        nuevo_tema TEXT, 
		nuevo_descripcion TEXT, 
		nuevo_conclusion TEXT, 
		OUT last_insert_foro_id INT
)
BEGIN 
		
        UPDATE foro SET
        id = nuevo_id,
        tema = nuevo_tema,
        descripcion = nuevo_descripcion,
        conclusion = nuevo_conclusion,
		fecha_modificacion = NOW()
        WHERE foro.id = nuevo_id;
        
        SET last_insert_foro_id = nuevo_id;
        
        
        UPDATE herramienta SET
        nombre = nuevo_tema,
        descripcion = nuevo_descripcion,
        fecha_modificacion = now()
        WHERE herramienta.recurso_id = nuevo_id
        AND herramienta.repositorio_id = nuevo_repositorio_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_actualizar_link_interes`(
	
    nuevo_link_id INT,
    nuevo_repositorio_id INT,
    nuevo_link_titutlo VARCHAR(255),
    nuevo_link_nombre VARCHAR(255),
    nuevo_link_url varchar(50),
    nuevo_link_descripcion TEXT,
    OUT last_insert_link_id INT
)
BEGIN
	UPDATE link_interes SET
		id = nuevo_link_id,
        titulo = nuevo_link_titutlo,
		nombre = nuevo_link_nombre,
        url = nuevo_link_url,
        descripcion = nuevo_link_descripcion,
        fecha_modificacion = NOW()
	
    WHERE link_interes.id = nuevo_link_id;
   
    
    SET last_insert_link_id = nuevo_link_id;
    
    UPDATE herramienta SET
		nombre = nuevo_link_nombre,
        descripcion = nuevo_link_nombre,
        fecha_modificacion = NOW()
	WHERE herramienta.recurso_id = nuevo_link_id
    AND herramienta.repositorio_id = nuevo_repositorio_id;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_archivo_recurso_repositorio_troncal`(

	nuevo_repositorio_id INT,
    nuevo_archivo_recurso_nombre VARCHAR(255),
    nuevo_archivo_recurso_descripcion TEXT,
    nuevo_recurso_tabla VARCHAR (255),
	OUT last_insert_archivo_recurso_id INT    
)
BEGIN

	INSERT INTO archivo_recurso(
		nombre,
        descripcion,
        fecha_creacion,
        tipo_herramienta_id
    )
    VALUES(
		nuevo_archivo_recurso_nombre,
        nuevo_archivo_recurso_descripcion,
        NOW(),
        1
    );
    
	SELECT LAST_INSERT_ID () INTO last_insert_archivo_recurso_id;
 
    INSERT INTO herramienta(
		nombre,
        descripcion,
        fecha_creacion,
        recurso_id,
        recurso_tabla,
        repositorio_id,
        tipo_herramienta_id
    )
    VALUES (
		nuevo_archivo_recurso_nombre,
        nuevo_archivo_recurso_descripcion,
        NOW(),
        last_insert_archivo_recurso_id,
        nuevo_recurso_tabla,
        nuevo_repositorio_id,
        1
    );
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_configuracion_foro`(
	nuevo_cantidad_post INT,
    nuevo_id_foro INT,
	OUT llave_id int(11)
)
BEGIN
	INSERT INTO configuracion_foro(
		cantidad_post,
        foro_id
	)
    
    VALUES(
		nuevo_cantidad_post,
        nuevo_id_foro
    );
    
    SELECT LAST_INSERT_ID () into llave_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_foro`(
		
        nuevo_repositorio_id INT,
        nuevo_tema TEXT, 
		nuevo_descripcion TEXT, 
		nuevo_conclusion TEXT, 
        nuevo_recurso_tabla varchar(50),
		OUT last_insert_foro_id INT
	)
BEGIN
		INSERT INTO foro (
			tema,
            descripcion,
            conclusion,
            fecha_creacion,
			tipo_herramienta_id
		)
        
	VALUES(
			nuevo_tema, 
			nuevo_descripcion, 
			nuevo_conclusion, 
            now(),
            1		
		);
        
	SELECT LAST_INSERT_ID () INTO last_insert_foro_id;
    
    INSERT INTO herramienta(
			nombre,
			descripcion,
			fecha_creacion,
			recurso_id,
			repositorio_id,
			tipo_herramienta_id,
			recurso_tabla
		)
    VALUES(
			nuevo_tema,
			nuevo_descripcion,
			NOW(),
			last_insert_foro_id,
			nuevo_repositorio_id,
			1,
			nuevo_recurso_tabla
		);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_glosario_repositorio_troncal`(
	
    nuevo_repositorio_id INT,
    nuevo_glosario_nombre VARCHAR(255),
    nuevo_glosario_descripcion TEXT,
    nuevo_recurso_tabla VARCHAR (255),
    OUT last_insert_glosario_id INT
)
BEGIN

	INSERT INTO glosario(
		nombre,
        descripcion,
        fecha_creacion,
        tipo_herramienta_id
	)
    VALUES(
		nuevo_glosario_nombre,
        nuevo_glosario_descripcion,
        NOW(),
        1
    );
    
    SELECT LAST_INSERT_ID () INTO last_insert_glosario_id;
    
    INSERT INTO herramienta(
		nombre,
        descripcion,
        fecha_creacion,
        recurso_id,
		recurso_tabla,
        repositorio_id,
        tipo_herramienta_id
    )
    VALUES(
		nuevo_glosario_nombre,
        nuevo_glosario_descripcion,
        NOW(),
        last_insert_glosario_id,
        nuevo_recurso_tabla,
        nuevo_repositorio_id,
        1
    );

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_glosario_termino_definicion`(

	nuevo_glosario_id INT,
    
    nuevo_termino VARCHAR(255),
    nuevo_definicion TEXT  
)
BEGIN

	INSERT INTO glosario_termino_definicion(
		termino,
        definicion,
        fecha_creacion,
        glosario_id
        
    )
    VALUES(
		nuevo_termino,
        nuevo_definicion,
        NOW(),
        nuevo_glosario_id
    );   

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_link_interes`(
	
    nuevo_repositorio_id INT,
    nuevo_link_titutlo varchar(50),
    nuevo_link_nombre VARCHAR(255),
    nuevo_link_url varchar(50),
    nuevo_link_descripcion TEXT,
    nuevo_recurso_tabla varchar(50),
    OUT last_insert_link_id INT
)
BEGIN

	INSERT INTO link_interes(
		titulo,
        nombre,
        url,
        descripcion,
        fecha_creacion,
        tipo_herramienta_id
	)
    VALUES(
		nuevo_link_titutlo,
		nuevo_link_nombre,
        nuevo_link_url,
        nuevo_link_descripcion,
        NOW(),
        1
    );
    
    SELECT LAST_INSERT_ID () INTO last_insert_link_id;
    
    INSERT INTO herramienta(
		nombre,
        descripcion,
        fecha_creacion,
        recurso_id,
        repositorio_id,
        tipo_herramienta_id,
        recurso_tabla
    )
    VALUES(
		nuevo_link_nombre,
        nuevo_link_descripcion,
        NOW(),
        last_insert_link_id,
        nuevo_repositorio_id,
        1,
        nuevo_recurso_tabla
    );

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_post`(
	nuevo_mensaje TEXT,
	nuevo_ip varchar(50),
	nuevo_host varchar(50),
    nuevo_post_id INT,
	nuevo_foro_id INT,
    nuevo_usuario_id INT,
    nuevo_rol_usuario_id INT,
	OUT llave_id int(11)
)
BEGIN
	INSERT INTO post(
		mensaje,
        ip,
        host,
        fecha_creacion,
        post_id,
        foro_id
    )
    
    VALUES(
		nuevo_mensaje,
		nuevo_ip,
		nuevo_host,
        NOW(),
        nuevo_post_id,
		nuevo_foro_id
		
    );
    
    INSERT INTO usuario_has_post(
		usuario_id,
        rol_usuario_id,
        post_id
    )
    
    VALUES(
		nuevo_usuario_id,
        nuevo_rol_usuario_id,
        nuevo_post_id
    );
    
    SELECT LAST_INSERT_ID () into llave_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_recepcion_trabajo_repositorio_troncal`(

	nuevo_repositorio_id INT,
    nuevo_recepcion_trabajo_nombre VARCHAR (255),
    nuevo_recepcion_trabajo_descripcion TEXT,
    nuevo_recurso_tabla VARCHAR (255),
    nuevo_recepcion_trabajo_entrega_publica BOOL,
    OUT last_insert_recepcion_trabajo_id INT
)
BEGIN
	
    INSERT INTO recepcion_trabajo(
		nombre,
        descripcion,
        fecha_creacion,
        tipo_herramienta_id,
        entrega_publica
	)
    VALUES(
		nuevo_recepcion_trabajo_nombre,
        nuevo_recepcion_trabajo_descripcion,
        NOW(),
        1,
        nuevo_recepcion_trabajo_entrega_publica
    );
    SELECT LAST_INSERT_ID() INTO last_insert_recepcion_trabajo_id;
    
    INSERT INTO herramienta(
		nombre,
        descripcion,
        fecha_creacion,
        recurso_id,
        recurso_tabla,
        repositorio_id,
        tipo_herramienta_id
	)
    VALUES(
		nuevo_recepcion_trabajo_nombre,
        nuevo_recepcion_trabajo_descripcion,
        NOW(),
        last_insert_recepcion_trabajo_id,
        nuevo_recurso_tabla,
        nuevo_repositorio_id,
        1
	);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_asignar_archivo_a_modulo`(
    nuevo_contenedor_id INT,
    nuevo_contenedor_tabla VARCHAR (255),
    nuevo_repositorio_id INT,
    nuevo_repositorio_copia_id INT,
    last_insert_contenedor_id INT,
    nuevo_modulo_id INT
)
BEGIN
-- DECLARE archivos_totales INT DEFAULT NULL; -- no me sirvieron
-- DECLARE archivos_concat TEXT DEFAULT NULL; -- no me sirvieron
DECLARE k INT DEFAULT 0;
    
DECLARE nuevo_archivo_id INT DEFAULT NULL;

DECLARE modulo_nombre VARCHAR(255)  DEFAULT NULL;
DECLARE modulo_codigo VARCHAR(255)  DEFAULT NULL;

SET @archivos_totales = 0;
SET @archivos_concat = NULL;

-- OBTENIENDO LOS VALORES FALTANTES DE MODULO ----------------------------------------------------------------------------------------------
        SELECT M.nombre,M.codigo INTO modulo_nombre,modulo_codigo
        FROM 
                modulo M
        WHERE M.id = nuevo_modulo_id;

-- CONTANDO CANTIDAD DE ARCHIVOS DE EL GLOSARIO ORIGINAL -------------------------------------------------------------------------------
		SET @sql = nuevo_contenedor_tabla;
		SET @sql = CONCAT('SELECT COUNT(A.id) INTO @archivos_totales
							 FROM 
									archivo A,
									',@sql,' H
									
							 WHERE A.contenedor_id = H.id 
							 AND H.id = ',nuevo_contenedor_id,'
							 AND A.contenedor_tabla = "',@sql,'"');

		PREPARE stmt FROM @sql;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
-- CONCATENANDO LOS ID DE LOS ARCHIVOS DEL GLOSARIO ORIGINAL -------------------------------------------------------------------------------        
        SET @sql = nuevo_contenedor_tabla;
        SET @sql = CONCAT('SELECT GROUP_CONCAT(A.id) INTO @archivos_concat
                             FROM 
                             archivo A,
                             ',@sql,'  H
                             WHERE A.contenedor_id = H.id 
							 AND H.id = ',nuevo_contenedor_id,'
							 AND A.contenedor_tabla = "',@sql,'"');

        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
-- -----------------------------------------------------------------------------------------------------------------------------------------        
        WHILE k < @archivos_totales DO
            SET nuevo_archivo_id = getValueFromArray(@archivos_concat, ',', k);              
-- COPIANDO ARCHIVOS -----------------------------------------------------------------------------------------------------------------------
            INSERT INTO archivo_copia_repositorio_modulo_temp(
                    id_old,
                    nombre_old,
                    mime_type_old,
                    tamano_old,
                    ruta_old,
                    usuario_id_old,
                    fecha_creacion_old,
                    fecha_modificacion_old,
                    fecha_acceso_old,
                    fecha_eliminacion_old,
                    lectura_old,
                    escritura_old,
                    descarga_old,
                    eliminacion_old,
                    contenedor_id_old,
                    contenedor_tabla_old,
                    repositorio_id_old,
                    repositorio_id_new,
                    contenedor_id_new,
                    modulo_id,
                    modulo_nombre,
                    modulo_codigo                    
            ) 
            SELECT 
                    A.id,
                    A.nombre, -- 1
                    A.mime_type, -- 2
                    A.tamano, -- 3
                    A.ruta,-- 4
                    A.usuario_id,-- 5
                    NOW(),-- 6
                    NOW(),-- 7
                    null,-- 8
                    null,-- 9
                    A.lectura,-- 10 
                    A.escritura,-- 11
                    A.descarga,-- 12
                    A.eliminacion,-- 13
                    A.contenedor_id,-- 14
                    A.contenedor_tabla,-- 15                    
                    nuevo_repositorio_id,-- 16
                    nuevo_repositorio_copia_id,-- 17 
                    last_insert_contenedor_id,-- 18 
                    nuevo_modulo_id, -- 19
                    modulo_nombre,-- 20
                    modulo_codigo -- 21
                    
            FROM    archivo A
            WHERE A.id = nuevo_archivo_id;            
            
            SET k = k + 1;
        END WHILE;
        SET k = 0;        

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_asignar_glosario_a_modulo`(nuevo_repositorio_id INT,nuevo_repositorio_copia_id INT,nuevo_modulo_id INT)
BEGIN

DECLARE glosarios_totales INT DEFAULT NULL;
DECLARE glosarios_concat TEXT DEFAULT NULL;

DECLARE nuevo_glosario_id INT DEFAULT NULL;
DECLARE i INT DEFAULT 0;

DECLARE last_insert_glosario_id INT DEFAULT NULL;

DECLARE terminos_totales INT DEFAULT NULL;
DECLARE terminos_concat TEXT DEFAULT NULL;

DECLARE j INT DEFAULT 0;

DECLARE nuevo_termino_id INT DEFAULT NULL;

DECLARE nombre_tabla VARCHAR(255) DEFAULT NULL;


-- CONTANDO CANTIDAD DE GLOSARIOS DE EL REPOSITORIO ORIGINAL -------------------------------------------------------------------------------
	SELECT COUNT(G.id) INTO glosarios_totales
	FROM
			glosario G,
			herramienta H,
			repositorio R
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = G.id 
	AND R.id = nuevo_repositorio_id;

-- CONCATENANDO LOS ID DE LOS GLOSARIOS DEL REPOSITORIO ORIGINAL ---------------------------------------------------------------------------        
	SELECT GROUP_CONCAT(G.id) INTO glosarios_concat
    FROM
			glosario G,
			herramienta H,
			repositorio R
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = G.id 
	AND R.id = nuevo_repositorio_id; 

    WHILE i < glosarios_totales DO
		SET nuevo_glosario_id = getValueFromArray(glosarios_concat, ',', i);	
-- COPIANDO UN GLOSARIO --------------------------------------------------------------------------------------------------------------------        
        INSERT INTO glosario(
				nombre,
                descripcion,
                fecha_creacion,
                fecha_modificacion,
                fecha_eliminacion,
                fecha_acceso,
                tipo_herramienta_id,
                glosario_general_id
		) 
		SELECT 
				G.nombre,
                G.descripcion,
                NOW(),
                NOW(),
                null,
                null,
                2,
				nuevo_glosario_id
		FROM	glosario G		
		WHERE 	G.id= nuevo_glosario_id;
        
		SELECT LAST_INSERT_ID() INTO last_insert_glosario_id;
        
-- CREANDO LA ASOCIACION DE LA TABLA HERRAMIENTA CORRESPONDIENTE ---------------------------------------------------------------------------
         INSERT INTO herramienta(
				nombre,
                descripcion,
                fecha_acceso,
                fecha_modificacion,
                fecha_creacion,
                fecha_eliminacion,
                recurso_id,
                recurso_tabla,
                repositorio_id,
                tipo_herramienta_id,
                herramienta_general_id
		) 
		SELECT 
				H.nombre,
                H.descripcion,
                null,
                NOW(),
                NOW(),
                null,
                last_insert_glosario_id,
                H.recurso_tabla,
				nuevo_repositorio_copia_id,
                2,
				H.id
                
		FROM	herramienta H,
				repositorio R,
				glosario G
				
		WHERE R.id = nuevo_repositorio_id
        AND H.repositorio_id = R.id
        AND H.recurso_id = G.id 
        AND G.id = nuevo_glosario_id
        AND H.recurso_tabla = 'glosario';
-- COPIANDO TERMINOS -----------------------------------------------------------------------------------------------------------------------
-- CONTANDO CANTIDAD DE TERMINOS DE EL GLOSARIO ORIGINAL -------------------------------------------------------------------------------
		SELECT COUNT(T.id) INTO terminos_totales
		FROM
				glosario G,
				glosario_termino_definicion T
				
		WHERE G.id = nuevo_glosario_id
		AND G.id = T.glosario_id;		

-- CONCATENANDO LOS ID DE LOS TERMINOS DEL GLOSARIO ORIGINAL -------------------------------------------------------------------------------        
		SELECT GROUP_CONCAT(T.id) INTO terminos_concat
		FROM
				glosario G,
				glosario_termino_definicion T
				
		WHERE G.id = nuevo_glosario_id
		AND G.id = T.glosario_id;
-- -----------------------------------------------------------------------------------------------------------------------------------------        
        WHILE j < terminos_totales DO
			SET nuevo_termino_id = getValueFromArray(terminos_concat, ',', j);	
			
-- COPIANDO TERMINOS -----------------------------------------------------------------------------------------------------------------------
			INSERT INTO glosario_termino_definicion(
					termino,
                    definicion,
                    fecha_creacion,
                    fecha_modificacion,
                    fecha_acceso,
                    fecha_eliminacion,
                    glosario_id
			) 
			SELECT 
					T.termino,
                    T.definicion,
                    NOW(),
					NOW(),
					null,
                    null,
					last_insert_glosario_id
					
			FROM	glosario_termino_definicion T
            WHERE T.id = nuevo_termino_id;            
            
			SET j = j + 1;
		END WHILE;
		SET j = 0; 
-- COPIANDO ARCHIVOS -----------------------------------------------------------------------------------------------------------------------------------------        
		SELECT TABLE_NAME INTO nombre_tabla
        FROM INFORMATION_SCHEMA.TABLES
		WHERE table_schema = 'testreko'
		AND TABLE_NAME = 'glosario';
        
        CALL sp_repositorio_asignar_archivo_a_modulo(
				 nuevo_glosario_id,
				 nombre_tabla,
                 nuevo_repositorio_id,
                 nuevo_repositorio_copia_id,
                 last_insert_glosario_id,
                 nuevo_modulo_id
		);
-- COPIANDO ARCHIVOS -----------------------------------------------------------------------------------------------------------------------------------------        
        
		SET i = i + 1;
	END WHILE;
	SET i = 0;	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_asignar_mod_aprendizaje_rep_troncal_admin`(nuevo_repositorio_id int , nuevo_modelo_id int)
begin
UPDATE repositorio_troncal_admin SET modelo_aprendizaje_id =  nuevo_modelo_id
WHERE id = nuevo_repositorio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_asignar_mod_aprendizaje_rep_troncal_app`(nuevo_repositorio_id int , nuevo_modelo_id int)
begin
UPDATE repositorio_troncal_app SET modelo_aprendizaje_id =  nuevo_modelo_id
WHERE id = nuevo_repositorio_id;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_asignar_repositorio_a_modulo`(lista_repositorio_id text, lista_largo int, nuevo_modulo_id int)
BEGIN
DECLARE x INT DEFAULT 0;
DECLARE nuevo_repositorio_id INT default NULL;
DECLARE repositorio_id_tmp INT default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
DECLARE repositorio_copia INT DEFAULT NULL;

WHILE x < lista_largo DO
	SET nuevo_repositorio_id = getValueFromArray(lista_repositorio_id, ',', x);	
-- 	ASIGNOR REPOSITORIO A MODULO -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    SELECT repositorio_id INTO repositorio_id_tmp FROM modulo_has_repositorio WHERE repositorio_id = nuevo_repositorio_id AND modulo_id = nuevo_modulo_id;
    IF ( repositorio_id_tmp IS NULL) THEN
		INSERT INTO modulo_has_repositorio (`repositorio_id`,`modulo_id`) VALUES (nuevo_repositorio_id,nuevo_modulo_id);
        
--  	COPIAR REPOSITORIO -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --    
		INSERT INTO repositorio(
				nombre,
                descripcion,
                fecha_acceso,
                fecha_modificacion,
                fecha_creacion,
                fecha_eliminacion,
                tipo_repositorio_id,
                modelo_aprendizaje_id,
                guia_instruccional_id,
                repositorio_general_id
		) 
		SELECT 
				R.nombre,
				R.descripcion,
                null,
                now(),
                now(),
                null,
				2,
				R.modelo_aprendizaje_id,
				R.guia_instruccional_id,
				R.id
				
		FROM	repositorio R		
		WHERE 	R.id= nuevo_repositorio_id; 
		
		SELECT LAST_INSERT_ID () into repositorio_copia;
        
-- 		ASIGNAR REPOSITORIO COPIA A MODULO --------------------------------------------------------------------------------------------------------------------------------      
		SELECT repositorio_id INTO repositorio_id_tmp FROM modulo_has_repositorio WHERE repositorio_id = repositorio_copia AND modulo_id = nuevo_modulo_id;
		IF ( repositorio_id_tmp IS NULL) THEN
			INSERT INTO modulo_has_repositorio (`repositorio_id`,`modulo_id`) VALUES (repositorio_copia,nuevo_modulo_id);
		ELSE
			SET repositorio_id_tmp = NULL;
		END IF;
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --  
-- -----COPIANDO HERRAMIENTAS --------------------------------------------------------------------------------------------------------
-- -----COPIANDO GLOSARIO --------------------------------------------------------------------------------------------------------
		CALL sp_repositorio_asignar_glosario_a_modulo(nuevo_repositorio_id, repositorio_copia,nuevo_modulo_id);

-- -----COPIANDO HERRAMIENTAS --------------------------------------------------------------------------------------------------------

        
	ELSE
		SET repositorio_id_tmp = NULL;
    END IF; 
    SET x = x +1;
    SET repositorio_copia = NULL;
        
END WHILE;
SELECT resultado, nuevo_repositorio_id, repositorio_id_tmp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_desasignar_repositorio_a_modulo`(lista_repositorio_id text, lista_largo int, nuevo_modulo_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_repositorio_id int default NULL;
DECLARE repositorio_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;

DECLARE repositorio_copia INT DEFAULT NULL;

WHILE x < lista_largo DO
	SET nuevo_repositorio_id = getValueFromArray(lista_repositorio_id, ',', x);	

-- 	SELECT R.id INTO repositorio_copia
-- 	FROM
-- 			repositorio R,
-- 			modulo_has_repositorio MR

-- 	WHERE R.repositorio_general_id = nuevo_repositorio_id
-- 	AND MR.repositorio_id = R.id
-- 	AND MR.modulo_id = nuevo_modulo_id;
    
-- DESASIGNANDO HERRAMIENTAS ---------------------------------------------------------------------------------------------------------------    

-- DESASIGNANDO HERRAMIENTAS ---------------------------------------------------------------------------------------------------------------
-- 	DELETE MR.*
-- 	FROM modulo_has_repositorio MR
-- 	WHERE MR.repositorio_id = repositorio_copia;

-- 	DELETE R.*
-- 	FROM repositorio R
-- 	WHERE R.id = repositorio_copia;

	SELECT repositorio_id INTO repositorio_id_tmp FROM modulo_has_repositorio WHERE repositorio_id = nuevo_repositorio_id AND modulo_id = nuevo_modulo_id;
    IF ( repositorio_id_tmp IS NOT NULL) THEN
		DELETE FROM modulo_has_repositorio WHERE modulo_id = nuevo_modulo_id AND repositorio_id = nuevo_repositorio_id;
	ELSE
		SET repositorio_id_tmp = NULL;
    END IF;    
    
    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_repositorio_id, repositorio_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_eliminado_fisico_configuracion_foro`(nuevo_id INT)
BEGIN
	DELETE FROM configuracion_foro 
    WHERE id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_eliminado_fisico_foro`(nuevo_id INT)
BEGIN
		DELETE FROM foro WHERE id = nuevo_id;
        DELETE FROM herramienta where recurso_id = nuevo_id;
        DELETE FROM post WHERE foro_id = nuevo_id;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_eliminado_fisico_link_interes`(nuevo_id INT)
BEGIN
		DELETE FROM link_interes
        WHERE id = nuevo_id;
       
		DELETE FROM herramienta
		WHERE recurso_id = nuevo_id;
        
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_eliminado_fisico_post`(nuevo_id INT)
BEGIN
	DELETE FROM post WHERE id = nuevo_id;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_listar_configuracion_por_foro`(nuevo_id INT)
BEGIN
	SELECT A.* FROM configuracion_foro A, foro B
	WHERE B.id = A.foro_id
	AND B.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_listar_post_por_foro`(nuevo_id INT)
BEGIN
		SELECT P.* 
		FROM 
			post P,
            foro F
		
        WHERE F.id = P.foro_id
		and F.id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_listar_post_por_post`(
    nuevo_post_id INT
)
BEGIN
		SELECT P.*
		FROM post P
		WHERE P.post_id = nuevo_post_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_listar_repositorio`(nuevo_institucion_id INT )
BEGIN
SELECT R.*
FROM 
		repositorio R,
        institucion_has_repositorio IR,
        institucion I
        
WHERE R.id = IR.institucion_id
AND I.id = IR.institucion_id
AND I.id = nuevo_institucion_id;
		
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_listar_todos_post`()
BEGIN
		SELECT * FROM post;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_archivo_recurso_repositorio_troncal`(nuevo_repositorio_id INT)
BEGIN

	SELECT AR.*
    FROM
		repositorio R,
        herramienta H,
        archivo_recurso AR
	WHERE R.id = H.repositorio_id
    AND H.recurso_id = AR.id 
    AND R.id = nuevo_repositorio_id
    AND H.recurso_tabla = 'archivo_recurso'
    
    ORDER BY AR.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_foros`(nuevo_repositorio_id INT)
BEGIN
		
        SELECT F.*

	FROM
			repositorio R,
			herramienta H,
			foro F
			
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = F.id
	AND R.id = nuevo_repositorio_id
	AND H.recurso_tabla = 'foro'
    ORDER BY F.id;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_glosario_repositorio`(nuevo_repositorio_id INT)
BEGIN

	SELECT G.*

	FROM
			repositorio R,
			herramienta H,
			glosario G
			
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = G.id
	AND R.id = nuevo_repositorio_id
	AND H.recurso_tabla = 'glosario'
    
    ORDER BY G.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_glosario_repositorio_aula`(nuevo_repositorio_id INT,nuevo_modulo_id INT)
BEGIN

	SELECT G.*

	FROM
			modulo M,
            modulo_has_repositorio MR,
			repositorio R,
			herramienta H,
			glosario G
			
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = G.id
	AND R.id = nuevo_repositorio_id
	AND H.recurso_tabla = 'glosario'
    
    AND M.id = nuevo_modulo_id
    AND M.id = MR.modulo_id
    AND R.id = MR.repositorio_id 
    AND R.tipo_repositorio_id = 2
    
    ORDER BY G.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_glosario_termino_definicion`(nuevo_glosario_id INT)
BEGIN

	SELECT GTD.*

	FROM 
		glosario_termino_definicion GTD,
		glosario G
	WHERE G.id = GTD.glosario_id
	AND G.id = nuevo_glosario_id
    ORDER BY GTD.id;	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_link_interes`(nuevo_repositorio_id INT)
BEGIN

	SELECT L.*

	FROM
			repositorio R,
			herramienta H,
			link_interes L
			
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = L.id
	AND R.id = nuevo_repositorio_id
	AND H.recurso_tabla = 'link_interes'
    ORDER BY L.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_modulos_institucion`(nuevo_institucion_id INT)
BEGIN

	SELECT M.*

	FROM	modulo M,
			institucion I

	WHERE M.institucion_id = I.id
	AND I.id = nuevo_institucion_id

	ORDER BY M.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_modulo_repositorio`(nuevo_modulo_id int(11))
BEGIN
SELECT 
		M.nombre,
		MR.modulo_id,
		MR.repositorio_id 
FROM 
		`modulo` M, 
		`modulo_has_repositorio` MR,
        repositorio R
		
WHERE M.id = MR.modulo_id
AND M.id = nuevo_modulo_id 
AND R.id = MR.repositorio_id
AND R.tipo_repositorio_id = 1

UNION 

SELECT 
		null,
        null,
        R.id 
FROM 
		(`repositorio` R LEFT JOIN `modulo_has_repositorio` MR ON R.id = MR.repositorio_id AND MR.modulo_id = nuevo_modulo_id)
        
WHERE MR.repositorio_id is NULL
AND R.tipo_repositorio_id = 1
order by repositorio_id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_modulo_repositorio_aula`(nuevo_modulo_id int(11))
BEGIN
SELECT R.*

FROM 
		modulo M,
        modulo_has_repositorio MR,
        repositorio R

WHERE M.id = MR.modulo_id
AND MR.repositorio_id = R.id 
AND M.id = nuevo_modulo_id
AND R.tipo_repositorio_id = 2
ORDER BY R.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_recepcion_trabajo_repositorio_troncal`(nuevo_repositorio_id INT)
BEGIN
	
    SELECT RT.*
    FROM 
		repositorio R,
        herramienta H,
        recepcion_trabajo RT
        
	WHERE R.id = H.repositorio_id
    AND H.recurso_id = RT.id
    AND R.id = nuevo_repositorio_id
    AND H.recurso_tabla = 'recepcion_trabajo'
    
    ORDER BY RT.id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_repositorio_institucion`(nuevo_institucion_id int(11))
BEGIN

	SELECT R.*
    FROM 
			repositorio R,
            institucion_has_repositorio IR,
            institucion I
            
WHERE R.id = IR.repositorio_id
AND I.id = IR.institucion_id
AND I.id = nuevo_institucion_id

ORDER BY repositorio_id;         

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_modificar_archivo_recurso_repositorio_troncal`(

	nuevo_archivo_recurso_id INT,
    nuevo_repositorio_id INT,
    nuevo_archivo_recurso_nombre VARCHAR(255),
    nuevo_archivo_recurso_descripcion TEXT,
    OUT last_insert_archivo_recurso_id INT

)
BEGIN
	
	UPDATE archivo_recurso SET
		nombre = nuevo_archivo_recurso_nombre,
        descripcion = nuevo_archivo_recurso_descripcion,
        fecha_modificacion = NOW()
	WHERE archivo_recurso.id = nuevo_archivo_recurso_id;
    
    SET last_insert_archivo_recurso_id = nuevo_archivo_recurso_id;
    
    UPDATE herramienta SET
		nombre = nuevo_archivo_recurso_nombre,
        descripcion = nuevo_archivo_recurso_descripcion,
        fecha_modificacion = NOW()
	WHERE herramienta.recurso_id = nuevo_archivo_recurso_id
    AND herramienta.recurso_tabla = 'archivo_recurso'
    ;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_modificar_glosario_repositorio_troncal`(
	
    nuevo_glosario_id INT,
    nuevo_repositorio_id INT,
    nuevo_glosario_nombre VARCHAR(255),
    nuevo_glosario_descripcion TEXT,
    OUT last_insert_glosario_id INT
)
BEGIN
	UPDATE glosario SET
		nombre = nuevo_glosario_nombre,
        descripcion = nuevo_glosario_descripcion,
        fecha_modificacion = NOW()
	
    WHERE glosario.id = nuevo_glosario_id;
   
    
    SET last_insert_glosario_id = nuevo_glosario_id;
    
    UPDATE herramienta SET
		nombre = nuevo_glosario_nombre,
        descripcion = nuevo_glosario_descripcion,
        fecha_modificacion = NOW()
	WHERE herramienta.recurso_id = nuevo_glosario_id
    AND herramienta.repositorio_id = nuevo_repositorio_id
	AND herramienta.recurso_tabla = 'glosario'
    ;
    
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_modificar_recepcion_trabajo_repositorio_troncal`(
	nuevo_recepcion_trabajo_id INT,
    nuevo_repositorio_id INT,
    nuevo_recepcion_trabajo_nombre VARCHAR(255),
    nuevo_recepcion_trabajo_descripcion TEXT,
    OUT last_insert_recepcion_trabajo_id INT
)
BEGIN
    UPDATE recepcion_trabajo SET
        nombre = nuevo_recepcion_trabajo_nombre,
        descripcion = nuevo_recepcion_trabajo_descripcion,
        fecha_modificacion = NOW()
    
    WHERE recepcion_trabajo.id = nuevo_recepcion_trabajo_id;
   
    
    SET last_insert_recepcion_trabajo_id = nuevo_recepcion_trabajo_id;
    
    UPDATE herramienta SET
        nombre = nuevo_recepcion_trabajo_nombre,
        descripcion = nuevo_recepcion_trabajo_descripcion,
        fecha_modificacion = NOW()
    WHERE herramienta.recurso_id = nuevo_recepcion_trabajo_id
    AND herramienta.repositorio_id = nuevo_repositorio_id
    AND herramienta.recurso_tabla = 'recepcion_trabajo'
    ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_obtener_herramientas_disponibles_repositorio`(nuevo_repositorio_id int(11))
BEGIN
	SELECT MH.*
    FROM
			modelo_aprendizaje M,
            modelo_aprendizaje_has_herramienta MH,
            repositorio R
	WHERE R.modelo_aprendizaje_id = M.id
    AND MH.modelo_aprendizaje_id = M.id
    AND R.id = nuevo_repositorio_id;
    
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
        usuario_administrador U,
        rol_administrador_has_privilegio_administrador RPRIV
        
WHERE PRIV.controlador_administrador_id = C.id
AND C.authitem_permiso_administrador_name = P.name
AND RP.authitem_permiso_administrador_name = P.name
AND RP.rol_administrador_id = R.id
AND UR.rol_administrador_id = R.id
AND UR.usuario_administrador_id = U.id
AND RPRIV.rol_administrador_id = R.id
AND RPRIV.privilegio_administrador_id = PRIV.id

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

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getValueFromArray`(_array TEXT,_del VARCHAR(255),_value INT UNSIGNED) RETURNS varchar(255) CHARSET latin1
    NO SQL
    DETERMINISTIC
BEGIN
IF _array IS NULL || _array = '' || _del IS NULL || _del = '' || _value IS NULL /*|| _value > stringOccurrences(_array, _del)*/ THEN
    RETURN '';
ELSE
    RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(_array, _del, _value + 1), _del, -1);
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aceptacion_contrato`
--

CREATE TABLE IF NOT EXISTS `aceptacion_contrato` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contrato_ficha_tecnica_id` int(11) DEFAULT NULL,
  `modulo_id` int(11) DEFAULT NULL,
  `programa_academico_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `institucion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_aceptacion_contrato_contrato_ficha_tecnica1_idx` (`contrato_ficha_tecnica_id`),
  KEY `fk_aceptacion_contrato_modulo1_idx` (`modulo_id`),
  KEY `fk_aceptacion_contrato_programa_academico1_idx` (`programa_academico_id`),
  KEY `fk_aceptacion_contrato_usuario1_idx` (`usuario_id`),
  KEY `fk_aceptacion_contrato_institucion1_idx` (`institucion_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `aceptacion_contrato`
--

INSERT INTO `aceptacion_contrato` (`id`, `contrato_ficha_tecnica_id`, `modulo_id`, `programa_academico_id`, `usuario_id`, `institucion_id`) VALUES
(1, 1, 9, 0, 248, 1),
(5, 1, 9, 0, 248, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivo`
--

CREATE TABLE IF NOT EXISTS `archivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `mime_type` text,
  `tamano` int(11) DEFAULT NULL,
  `ruta` text,
  `usuario_id` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `lectura` tinyint(1) DEFAULT NULL,
  `escritura` tinyint(1) DEFAULT NULL,
  `descarga` tinyint(1) DEFAULT NULL,
  `eliminacion` tinyint(1) DEFAULT NULL,
  `contenedor_id` int(11) DEFAULT NULL,
  `contenedor_tabla` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contenedor_id` (`contenedor_id`),
  KEY `contenedor_tabla` (`contenedor_tabla`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `archivo`
--

INSERT INTO `archivo` (`id`, `nombre`, `mime_type`, `tamano`, `ruta`, `usuario_id`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `fecha_eliminacion`, `lectura`, `escritura`, `descarga`, `eliminacion`, `contenedor_id`, `contenedor_tabla`) VALUES
(1, '952841-Modelo de probabilidad Normal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 24435, '/reko-archivos/Universidad Tecnológica Metropolitana/repositorio-id-1/glosario/glosario-id-6/', 248, '2015-12-01 11:57:38', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 6, 'glosario'),
(2, '431567-Modelo de probabilidad Normal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 24435, '/reko-archivos/Universidad Tecnológica Metropolitana/repositorio-id-1/archivo_recurso/archivo_recurso-id-1/', 248, '2015-12-01 11:58:37', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'archivo_recurso'),
(3, '772994-8_prueba.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 11318, '/reko-archivos/utem/repositorio-id-1/glosario/glosario-id-7/', 248, '2015-12-03 16:37:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 7, 'glosario'),
(4, '268118-John Cena - 6x8 white.png', 'image/png', 301071, '/reko-archivos/utem/repositorio-id-48/glosario/glosario-id-65/', 248, '2015-12-21 16:32:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 65, 'glosario'),
(11, '952841-Modelo de probabilidad Normal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 24435, '/reko-archivos/utem/modulo-id-15-ola-ola/repositorio-id-65/glosario/glosario-id-81/', 248, '2015-12-28 17:18:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 81, 'glosario'),
(12, '772994-8_prueba.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 11318, '/reko-archivos/utem/modulo-id-15-ola-ola/repositorio-id-65/glosario/glosario-id-82/', 248, '2015-12-28 17:18:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 82, 'glosario'),
(13, '268118-John Cena - 6x8 white.png', 'image/png', 301071, '/reko-archivos/utem/modulo-id-15-ola-ola/repositorio-id-66/glosario/glosario-id-83/', 248, '2015-12-28 17:18:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 83, 'glosario');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivo_copia_repositorio_modulo_temp`
--

CREATE TABLE IF NOT EXISTS `archivo_copia_repositorio_modulo_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_old` int(11) DEFAULT NULL,
  `nombre_old` varchar(255) DEFAULT NULL,
  `mime_type_old` text,
  `tamano_old` int(11) DEFAULT NULL,
  `ruta_old` text,
  `usuario_id_old` int(11) DEFAULT NULL,
  `fecha_creacion_old` datetime DEFAULT NULL,
  `fecha_modificacion_old` datetime DEFAULT NULL,
  `fecha_acceso_old` datetime DEFAULT NULL,
  `fecha_eliminacion_old` datetime DEFAULT NULL,
  `lectura_old` tinyint(1) DEFAULT NULL,
  `escritura_old` tinyint(1) DEFAULT NULL,
  `descarga_old` tinyint(1) DEFAULT NULL,
  `eliminacion_old` tinyint(1) DEFAULT NULL,
  `contenedor_id_old` int(11) DEFAULT NULL,
  `contenedor_tabla_old` varchar(255) DEFAULT NULL,
  `repositorio_id_old` int(11) DEFAULT NULL,
  `repositorio_id_new` int(11) DEFAULT NULL,
  `contenedor_id_new` int(11) DEFAULT NULL,
  `modulo_id` int(11) DEFAULT NULL,
  `modulo_nombre` varchar(255) DEFAULT NULL,
  `modulo_codigo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `repositorio_id_old` (`repositorio_id_old`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `archivo_copia_repositorio_modulo_temp`
--

INSERT INTO `archivo_copia_repositorio_modulo_temp` (`id`, `id_old`, `nombre_old`, `mime_type_old`, `tamano_old`, `ruta_old`, `usuario_id_old`, `fecha_creacion_old`, `fecha_modificacion_old`, `fecha_acceso_old`, `fecha_eliminacion_old`, `lectura_old`, `escritura_old`, `descarga_old`, `eliminacion_old`, `contenedor_id_old`, `contenedor_tabla_old`, `repositorio_id_old`, `repositorio_id_new`, `contenedor_id_new`, `modulo_id`, `modulo_nombre`, `modulo_codigo`) VALUES
(1, 1, '952841-Modelo de probabilidad Normal.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 24435, '/reko-archivos/utem/repositorio-id-1/glosario/glosario-id-6/', 248, '2015-12-28 17:18:15', '2015-12-28 17:18:15', NULL, NULL, NULL, NULL, NULL, NULL, 6, 'glosario', 1, 65, 81, 15, 'ola', 'ola'),
(2, 3, '772994-8_prueba.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 11318, '/reko-archivos/utem/repositorio-id-1/glosario/glosario-id-7/', 248, '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, NULL, NULL, NULL, NULL, NULL, 7, 'glosario', 1, 65, 82, 15, 'ola', 'ola'),
(3, 4, '268118-John Cena - 6x8 white.png', 'image/png', 301071, '/reko-archivos/utem/repositorio-id-48/glosario/glosario-id-65/', 248, '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, NULL, NULL, NULL, NULL, NULL, 65, 'glosario', 48, 66, 83, 15, 'ola', 'ola');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `archivo_recurso`
--

CREATE TABLE IF NOT EXISTS `archivo_recurso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_elminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_archivo_recurso_tipo_herramienta1_idx` (`tipo_herramienta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `archivo_recurso`
--

INSERT INTO `archivo_recurso` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_elminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(1, 'archivo_recurso_1', 'des-archivo_recurso_1', '2015-12-01 11:58:23', NULL, NULL, NULL, 1),
(2, 'archivo_recurso_2', 'des archivo_recurso_2', '2015-12-03 11:48:47', NULL, NULL, NULL, 1);

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
('aula', 2, 'des-aula', NULL, NULL),
('repositorio', 2, 'des-repositorio', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autoevaluacion`
--

CREATE TABLE IF NOT EXISTS `autoevaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `codigo_seguridad`
--

CREATE TABLE IF NOT EXISTS `codigo_seguridad` (
  `id` int(11) NOT NULL,
  `codigo` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracion_foro`
--

CREATE TABLE IF NOT EXISTS `configuracion_foro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad_post` int(11) DEFAULT NULL,
  `foro_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_configuracion_foro_foro1_idx` (`foro_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `configuracion_foro`
--

INSERT INTO `configuracion_foro` (`id`, `cantidad_post`, `foro_id`) VALUES
(2, 8, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contenido_libre`
--

CREATE TABLE IF NOT EXISTS `contenido_libre` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contrato_ficha_tecnica`
--

CREATE TABLE IF NOT EXISTS `contrato_ficha_tecnica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `ficha_tecnica_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contrato_ficha_tecnica_ficha_tecnica1_idx` (`ficha_tecnica_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `contrato_ficha_tecnica`
--

INSERT INTO `contrato_ficha_tecnica` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `ficha_tecnica_id`) VALUES
(1, 'contrato 2', 'descripcion contrato 2', '2016-01-13 15:36:24', '2016-01-13 15:41:00', 5),
(3, 'contrato de prueba', 'descripcion contrato de prueba', '2016-01-14 11:32:38', NULL, 6);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
(1, 'Default', 'aula'),
(2, 'Default', 'repositorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dato_academico`
--

CREATE TABLE IF NOT EXISTS `dato_academico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `universidad` varchar(45) DEFAULT NULL,
  `carrera` varchar(45) DEFAULT NULL,
  `ano_cursado` int(11) DEFAULT NULL,
  `duracion_carrera` int(11) DEFAULT NULL,
  `sede` varchar(45) DEFAULT NULL,
  `direccion_sede` varchar(45) DEFAULT NULL,
  `comuna_sede` varchar(45) DEFAULT NULL,
  `ciudad_sede` varchar(45) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dato_academico_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `dato_academico`
--

INSERT INTO `dato_academico` (`id`, `universidad`, `carrera`, `ano_cursado`, `duracion_carrera`, `sede`, `direccion_sede`, `comuna_sede`, `ciudad_sede`, `usuario_id`) VALUES
(4, 'Duoc', 'Ingenieria en informatica', 3, 4, 'Antonio varas', 'antonio varas 666', 'providencia', 'santiago', 236);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dato_laboral`
--

CREATE TABLE IF NOT EXISTS `dato_laboral` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_empresa` varchar(45) DEFAULT NULL,
  `ano_antiguedad` int(11) DEFAULT NULL,
  `cargo` varchar(45) DEFAULT NULL,
  `actividad` varchar(45) DEFAULT NULL,
  `comuna_empresa` varchar(45) DEFAULT NULL,
  `ciudad_empresa` varchar(45) DEFAULT NULL,
  `telefono_empresa` int(11) DEFAULT NULL,
  `celular_empresa` int(11) DEFAULT NULL,
  `rut_numero` int(11) DEFAULT NULL,
  `digito_verificador` int(11) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dato_laboral_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `dato_laboral`
--

INSERT INTO `dato_laboral` (`id`, `nombre_empresa`, `ano_antiguedad`, `cargo`, `actividad`, `comuna_empresa`, `ciudad_empresa`, `telefono_empresa`, `celular_empresa`, `rut_numero`, `digito_verificador`, `usuario_id`) VALUES
(3, 'Utem Virtual', 3, 'Analista', 'creacion de reko 2', 'santiago', 'santiago', 227578121, 2147483647, 1578951, 1, 236);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dato_login`
--

CREATE TABLE IF NOT EXISTS `dato_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `codigo_seguridad_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dato_login_usuario1_idx` (`usuario_id`),
  KEY `fk_dato_login_codigo_seguridad1_idx` (`codigo_seguridad_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dato_login_has_pregunta_login`
--

CREATE TABLE IF NOT EXISTS `dato_login_has_pregunta_login` (
  `dato_login_id` int(11) NOT NULL,
  `pregunta_login_id` int(11) NOT NULL,
  PRIMARY KEY (`dato_login_id`,`pregunta_login_id`),
  KEY `fk_dato_login_has_pregunta_login_pregunta_login1_idx` (`pregunta_login_id`),
  KEY `fk_dato_login_has_pregunta_login_dato_login1_idx` (`dato_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dato_login_has_respuesta_login`
--

CREATE TABLE IF NOT EXISTS `dato_login_has_respuesta_login` (
  `dato_login_id` int(11) NOT NULL,
  `respuesta_login_id` int(11) NOT NULL,
  PRIMARY KEY (`dato_login_id`,`respuesta_login_id`),
  KEY `fk_dato_login_has_respuesta_login_respuesta_login1_idx` (`respuesta_login_id`),
  KEY `fk_dato_login_has_respuesta_login_dato_login1_idx` (`dato_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dato_personal`
--

CREATE TABLE IF NOT EXISTS `dato_personal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `primer_nombre` varchar(45) DEFAULT NULL,
  `segundo_nombre` varchar(45) DEFAULT NULL,
  `apellido_paterno` varchar(45) DEFAULT NULL,
  `apellido_materno` varchar(45) DEFAULT NULL,
  `fecha_nacimiento` datetime DEFAULT NULL,
  `edad` int(11) DEFAULT NULL,
  `rut` int(11) DEFAULT NULL,
  `digito_verificador` int(11) DEFAULT NULL,
  `direccion_personal` varchar(45) DEFAULT NULL,
  `numero_casa` int(11) DEFAULT NULL,
  `telefono_personal` int(11) DEFAULT NULL,
  `celular_personal` int(11) DEFAULT NULL,
  `comuna_personal` varchar(45) DEFAULT NULL,
  `ciudad_personal` varchar(45) DEFAULT NULL,
  `interes` varchar(45) DEFAULT NULL,
  `estado_civil` varchar(45) DEFAULT NULL,
  `idioma` varchar(45) DEFAULT NULL,
  `nacionalidad` varchar(45) DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_dato_personal_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=507 ;

--
-- Volcado de datos para la tabla `dato_personal`
--

INSERT INTO `dato_personal` (`id`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `edad`, `rut`, `digito_verificador`, `direccion_personal`, `numero_casa`, `telefono_personal`, `celular_personal`, `comuna_personal`, `ciudad_personal`, `interes`, `estado_civil`, `idioma`, `nacionalidad`, `usuario_id`) VALUES
(501, 'Diego ', 'Antonio', 'Morales', 'Hernandez', '2015-11-20 12:33:15', 23, 18087707, 9, 'Avenida el raleo ', 1396, 82460780, 52072575, 'buin', 'santiago', 'nada', 'soltero', 'español', 'chilena', 236),
(503, 'Christian', 'Andres', 'Reyes', 'Arellano', '2015-11-20 13:30:42', 38, 13230098, 4, 'calle 18', 161, 2147483647, 2147483647, 'santiago', 'santiago', 'informatica', 'soltero', 'espanol', 'chilena', 248),
(504, 'John', 'Paul', 'Lopez', 'Suarez', '2015-11-20 13:46:42', 25, 17382459, 9, 'calle 18', 161, 2147483647, 2147483647, 'san bernardo', 'santiago', 'informatica', 'soltero', 'espanol', 'chilena', 237),
(505, 'dfgdfgfgfg', 'fgfg', 'dfgfdg', 'fgfdg', '0000-00-00 00:00:00', 0, 0, 0, '', 0, 0, 0, '', '', '', '', '', '', 238),
(506, 'Francisco', 'Francisco', 'Carvajal', 'Carvajal', '2015-11-20 12:53:05', 30, 11111111, 1, 'calle 18', 161, 2147483647, 52072575, 'santiago', 'santiago', 'diseño', 'soltero', 'espanol', 'chilena', 241);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidad`
--

CREATE TABLE IF NOT EXISTS `entidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `institucion_id` int(11) NOT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `estado_entidad_id` int(11) DEFAULT NULL,
  `pais_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entidad_institucion1_idx` (`institucion_id`),
  KEY `fk_entidad_entidad1_idx` (`entidad_id`),
  KEY `fk_entidad_estado_entidad1_idx` (`estado_entidad_id`),
  KEY `fk_entidad_pais1_idx` (`pais_id`),
  KEY `fk_entidad_region1_idx` (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
-- Estructura de tabla para la tabla `estado_codigo_seguridad`
--

CREATE TABLE IF NOT EXISTS `estado_codigo_seguridad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  `codigo_seguridad_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estado_codigo_seguridad_codigo_seguridad1_idx` (`codigo_seguridad_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_entidad`
--

CREATE TABLE IF NOT EXISTS `estado_entidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_institucion`
--

CREATE TABLE IF NOT EXISTS `estado_institucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `estado_institucion`
--

INSERT INTO `estado_institucion` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_modulo`
--

CREATE TABLE IF NOT EXISTS `estado_modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `estado_modulo`
--

INSERT INTO `estado_modulo` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_programa_academico`
--

CREATE TABLE IF NOT EXISTS `estado_programa_academico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `estado_programa_academico`
--

INSERT INTO `estado_programa_academico` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_seccion`
--

CREATE TABLE IF NOT EXISTS `estado_seccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `estado_seccion`
--

INSERT INTO `estado_seccion` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_usuario`
--

CREATE TABLE IF NOT EXISTS `estado_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `estado_usuario`
--

INSERT INTO `estado_usuario` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'prueba'),
(3, 'eliminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE IF NOT EXISTS `evaluacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modifcacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion_no_objetiva`
--

CREATE TABLE IF NOT EXISTS `evaluacion_no_objetiva` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha_tecnica`
--

CREATE TABLE IF NOT EXISTS `ficha_tecnica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `ficha_tecnica`
--

INSERT INTO `ficha_tecnica` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`) VALUES
(6, 'ficha prueba ', 'descripcion ficha prueba', '2016-01-14 11:31:45', NULL),
(5, 'ficha tecnica 5 ', 'descripcion ficha tecnica 5', '2016-01-13 15:27:35', '2016-01-13 15:28:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha_tecnica_has_modulo`
--

CREATE TABLE IF NOT EXISTS `ficha_tecnica_has_modulo` (
  `ficha_tecnica_id` int(11) NOT NULL,
  `modulo_id` int(11) NOT NULL,
  PRIMARY KEY (`ficha_tecnica_id`,`modulo_id`),
  KEY `fk_ficha_tecnica_has_modulo_modulo1_idx` (`modulo_id`),
  KEY `fk_ficha_tecnica_has_modulo_ficha_tecnica1_idx` (`ficha_tecnica_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ficha_tecnica_has_modulo`
--

INSERT INTO `ficha_tecnica_has_modulo` (`ficha_tecnica_id`, `modulo_id`) VALUES
(5, 9),
(6, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha_tecnica_has_programa_academico`
--

CREATE TABLE IF NOT EXISTS `ficha_tecnica_has_programa_academico` (
  `ficha_tecnica_id` int(11) NOT NULL,
  `programa_academico_id` int(11) NOT NULL,
  PRIMARY KEY (`ficha_tecnica_id`,`programa_academico_id`),
  KEY `fk_ficha_tecnica_has_programa_academico_programa_academico1_idx` (`programa_academico_id`),
  KEY `fk_ficha_tecnica_has_programa_academico_ficha_tecnica1_idx` (`ficha_tecnica_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `foro`
--

CREATE TABLE IF NOT EXISTS `foro` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tema` text,
  `descripcion` text,
  `conclusion` text,
  `leido` tinyint(1) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_foro_tipo_herramienta1_idx` (`tipo_herramienta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `foro`
--

INSERT INTO `foro` (`id`, `tema`, `descripcion`, `conclusion`, `leido`, `fecha_creacion`, `fecha_modificacion`, `fecha_eliminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(8, 'prevencion de las drogas', 'Curso el cual participaran alumnos y profesores y administradores de la universidad', '', NULL, '2016-01-20 10:56:56', '2016-01-21 12:09:59', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `glosario`
--

CREATE TABLE IF NOT EXISTS `glosario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  `glosario_general_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_glosario_tipo_herramienta1_idx` (`tipo_herramienta_id`),
  KEY `fk_glosario_glosario1_idx` (`glosario_general_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

--
-- Volcado de datos para la tabla `glosario`
--

INSERT INTO `glosario` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_eliminacion`, `fecha_acceso`, `tipo_herramienta_id`, `glosario_general_id`) VALUES
(6, 'glosario1', 'glosario1', '2015-12-01 11:55:55', NULL, NULL, NULL, 1, NULL),
(7, 'glosario2', 'glosario2 des', '2015-12-03 11:47:49', NULL, NULL, NULL, 1, NULL),
(65, 'glosario repositorio 2', 'descripcion glosario repositorio 2', '2015-12-21 16:31:58', NULL, NULL, NULL, 1, NULL),
(81, 'glosario1', 'glosario1', '2015-12-28 17:18:15', '2015-12-28 17:18:15', NULL, NULL, 2, 6),
(82, 'glosario 2', 'descripcion glosario 2', '2015-12-28 17:18:15', '2015-12-28 17:18:15', NULL, NULL, 2, 7),
(83, 'glosario repositorio 2', 'descripcion glosario repositorio 2', '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, NULL, 2, 65);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `glosario_termino_definicion`
--

CREATE TABLE IF NOT EXISTS `glosario_termino_definicion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `termino` varchar(45) DEFAULT NULL,
  `definicion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `glosario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_glosario_termino_definicion_glosario1_idx` (`glosario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=76 ;

--
-- Volcado de datos para la tabla `glosario_termino_definicion`
--

INSERT INTO `glosario_termino_definicion` (`id`, `termino`, `definicion`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `fecha_eliminacion`, `glosario_id`) VALUES
(7, 'termino1', 'deficion1', '2015-12-01 11:56:52', NULL, NULL, NULL, 6),
(8, 'cogito ergo sum', 'pienso y luego exito', '2015-12-03 16:35:16', NULL, NULL, NULL, 7),
(74, 'termino1', 'deficion1', '2015-12-28 17:18:15', '2015-12-28 17:18:15', NULL, NULL, 81),
(75, 'cogito ergo sum', 'pienso y luego exito', '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, NULL, 82);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guia_instruccional`
--

CREATE TABLE IF NOT EXISTS `guia_instruccional` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `detalle` varchar(45) DEFAULT NULL,
  `adjunto` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramienta`
--

CREATE TABLE IF NOT EXISTS `herramienta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `recurso_id` int(11) DEFAULT NULL,
  `recurso_tabla` varchar(255) DEFAULT NULL,
  `repositorio_id` int(11) DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  `herramienta_general_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_herramienta_repositorio1_idx` (`repositorio_id`),
  KEY `fk_herramienta_tipo_herramienta1_idx` (`tipo_herramienta_id`),
  KEY `recurso_id` (`recurso_id`),
  KEY `recurso_tabla` (`recurso_tabla`),
  KEY `fk_herramienta_herramienta1_idx` (`herramienta_general_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=102 ;

--
-- Volcado de datos para la tabla `herramienta`
--

INSERT INTO `herramienta` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `recurso_id`, `recurso_tabla`, `repositorio_id`, `tipo_herramienta_id`, `herramienta_general_id`) VALUES
(1, 'glosario1', 'glosario1', NULL, NULL, '2015-12-01 11:55:55', NULL, 6, 'glosario', 1, 1, NULL),
(2, 'skljdsadjkl', 'skljdsadjkl', NULL, '2015-12-01 12:00:27', '2015-12-01 11:58:23', NULL, 1, 'archivo_recurso', 1, 1, NULL),
(3, 'skljdsadjkl', 'skljdsadjkl', NULL, '2015-12-01 12:00:27', '2015-12-01 11:59:55', NULL, 1, NULL, 1, 1, NULL),
(4, 'osodosdo', 'osodosdo', NULL, '2015-12-02 09:51:24', '2015-12-02 09:42:48', NULL, 2, NULL, 1, 1, NULL),
(5, 'sdad', 'sasddsdsdsadsadsadsadsaddsssd', NULL, NULL, '2015-12-02 09:49:24', NULL, 3, NULL, 1, 1, NULL),
(20, 'Recepcion Trabajo JPxxx', 'Descripcion Recepcion Trabajo J', NULL, '2015-12-03 16:21:46', '2015-12-03 12:48:33', NULL, 1, 'recepcion_trabajo', 1, 1, NULL),
(21, 'prevencion de las drogas', 'Curso el cual participaran alumnos y profesores y administradores de la universidad', NULL, '2016-01-21 12:09:59', '2016-01-20 10:56:56', NULL, 8, 'foro', 1, 1, NULL),
(22, 'Recepcion Trabajo J', '123', NULL, NULL, '2015-12-03 17:50:04', NULL, 2, 'recepcion_trabajo', 1, 1, NULL),
(23, 'Recepcion Trabajo J', '123', NULL, NULL, '2015-12-03 17:54:59', NULL, 3, 'recepcion_trabajo', 1, 1, NULL),
(24, 'Recepcion Trabajo J', '123', NULL, NULL, '2015-12-03 18:00:13', NULL, 4, 'recepcion_trabajo', 1, 1, NULL),
(25, 'Recepcion Trabajo J', '123', NULL, NULL, '2015-12-03 18:00:30', NULL, 5, 'recepcion_trabajo', 1, 1, NULL),
(83, 'glosario repositorio 2', 'descripcion glosario repositorio 2', NULL, NULL, '2015-12-21 16:31:58', NULL, 65, 'glosario', 48, 1, NULL),
(99, 'glosario1', 'glosario1', NULL, '2015-12-28 17:18:15', '2015-12-28 17:18:15', NULL, 81, 'glosario', 65, 2, 1),
(100, 'glosario 2', 'descripcion glosario 2', NULL, '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, 82, 'glosario', 65, 2, 21),
(101, 'glosario repositorio 2', 'descripcion glosario repositorio 2', NULL, '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, 83, 'glosario', 66, 2, 83);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucion`
--

CREATE TABLE IF NOT EXISTS `institucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `sigla` varchar(45) DEFAULT NULL,
  `vision` text,
  `mision` text,
  `acreditada` bit(1) DEFAULT NULL,
  `fecha_inicio_acreditacion` datetime DEFAULT NULL,
  `fecha_termino_acreditacion` datetime DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `estado_institucion_id` int(11) DEFAULT NULL,
  `pais_id` int(11) DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_institucion_estado_institucion1_idx` (`estado_institucion_id`),
  KEY `fk_institucion_pais1_idx` (`pais_id`),
  KEY `fk_institucion_region1_idx` (`region_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `institucion`
--

INSERT INTO `institucion` (`id`, `nombre`, `sigla`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_institucion_id`, `pais_id`, `region_id`) VALUES
(1, 'Universidad Tecnológica Metropolitana', 'Utem', 'vision', 'mision', b'1', '2015-11-24 17:15:19', '2015-11-24 17:15:19', 'des-utem', '2015-11-24 17:22:25', '2015-11-25 10:20:17', NULL, NULL, NULL),
(2, 'utem pregrado', 'utem', 'vision utem pregrado', 'mision utem pregrado', b'1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 'descripcion utem pregrado', '2016-01-11 18:05:30', NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucion_has_repositorio`
--

CREATE TABLE IF NOT EXISTS `institucion_has_repositorio` (
  `institucion_id` int(11) NOT NULL,
  `repositorio_id` int(11) NOT NULL,
  PRIMARY KEY (`institucion_id`,`repositorio_id`),
  KEY `fk_institucion_has_repositorio_repositorio1_idx` (`repositorio_id`),
  KEY `fk_institucion_has_repositorio_institucion1_idx` (`institucion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `institucion_has_repositorio`
--

INSERT INTO `institucion_has_repositorio` (`institucion_id`, `repositorio_id`) VALUES
(1, 1),
(1, 48),
(1, 49);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucion_has_rol_usuario`
--

CREATE TABLE IF NOT EXISTS `institucion_has_rol_usuario` (
  `institucion_id` int(11) NOT NULL DEFAULT '0',
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`institucion_id`,`rol_usuario_id`),
  KEY `fk_institucion_has_rol_usuario_rol_usuario1_idx` (`rol_usuario_id`),
  KEY `fk_institucion_has_rol_usuario_institucion1_idx` (`institucion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `institucion_has_rol_usuario`
--

INSERT INTO `institucion_has_rol_usuario` (`institucion_id`, `rol_usuario_id`) VALUES
(1, 1),
(1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `item_ficha_tecnica`
--

CREATE TABLE IF NOT EXISTS `item_ficha_tecnica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `ficha_tecnica_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_item_ficha_tecnica_ficha_tecnica1_idx` (`ficha_tecnica_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `item_ficha_tecnica`
--

INSERT INTO `item_ficha_tecnica` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `ficha_tecnica_id`) VALUES
(1, 'item 2', 'descripcion item 2', '2016-01-13 17:11:08', '2016-01-13 17:16:48', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `link_interes`
--

CREATE TABLE IF NOT EXISTS `link_interes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `url` varchar(250) DEFAULT NULL,
  `descripcion` tinytext,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_link_interes_tipo_herramienta1_idx` (`tipo_herramienta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `link_interes`
--

INSERT INTO `link_interes` (`id`, `titulo`, `nombre`, `url`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(1, 'kljskljadkljsadjkl', 'skljdsadjkl', 'https://', 'mnmmmmnn,m,', '2015-12-01 11:59:54', '2015-12-01 12:00:27', NULL, 1),
(2, 'aoaoaoo', 'osodosdo', 'https://', 'hola mundo', '2015-12-02 09:42:48', '2015-12-02 09:51:24', NULL, 1),
(3, 'sasasasad', 'sdad', 'https://dssas', 'sasddsdsdsadsadsadsadsaddsssd', '2015-12-02 09:49:24', NULL, NULL, 1),
(4, 'asdsadasdasd', 'asdasd', 'https://asdasdsad', 'asdsadsadsad', '2015-12-02 12:01:55', NULL, NULL, 1),
(6, 'jhjkhhkhk', 'kjhkjhk', 'https://kjhj', 'kjhkjhkjhkj', '2015-12-03 09:55:52', '2015-12-09 10:09:54', NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_aprendizaje`
--

CREATE TABLE IF NOT EXISTS `modelo_aprendizaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='			' AUTO_INCREMENT=45 ;

--
-- Volcado de datos para la tabla `modelo_aprendizaje`
--

INSERT INTO `modelo_aprendizaje` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`) VALUES
(44, 'modelo-full', 'des-modelo-full', NULL, NULL, '2015-11-30 16:09:24', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modelo_aprendizaje_has_herramienta`
--

CREATE TABLE IF NOT EXISTS `modelo_aprendizaje_has_herramienta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trabajo_grupal` tinyint(1) DEFAULT NULL,
  `archivo_recurso` tinyint(1) DEFAULT NULL,
  `link_interes` tinyint(1) DEFAULT NULL,
  `glosario` tinyint(1) DEFAULT NULL,
  `contenido_libre` tinyint(1) DEFAULT NULL,
  `foro` tinyint(1) DEFAULT NULL,
  `evaluacion` tinyint(1) DEFAULT NULL,
  `autoevaluacion` tinyint(1) DEFAULT NULL,
  `proyecto` tinyint(1) DEFAULT NULL,
  `recepcion_trabajo` tinyint(1) DEFAULT NULL,
  `evaluacion_no_objetiva` tinyint(1) DEFAULT NULL,
  `modelo_aprendizaje_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_modelo_aprendizaje_has_herramienta_modelo_aprendizaje1_idx` (`modelo_aprendizaje_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='	' AUTO_INCREMENT=41 ;

--
-- Volcado de datos para la tabla `modelo_aprendizaje_has_herramienta`
--

INSERT INTO `modelo_aprendizaje_has_herramienta` (`id`, `trabajo_grupal`, `archivo_recurso`, `link_interes`, `glosario`, `contenido_libre`, `foro`, `evaluacion`, `autoevaluacion`, `proyecto`, `recepcion_trabajo`, `evaluacion_no_objetiva`, `modelo_aprendizaje_id`) VALUES
(40, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 44);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE IF NOT EXISTS `modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `descripcion` tinytext,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `estado_modulo_id` int(11) DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `institucion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_modulo_estado_modulo1_idx` (`estado_modulo_id`),
  KEY `fk_modulo_entidad1_idx` (`entidad_id`),
  KEY `fk_modulo_institucion1_idx` (`institucion_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo_has_repositorio`
--

CREATE TABLE IF NOT EXISTS `modulo_has_repositorio` (
  `modulo_id` int(11) NOT NULL,
  `repositorio_id` int(11) NOT NULL,
  PRIMARY KEY (`modulo_id`,`repositorio_id`),
  KEY `fk_modulo_has_repositorio_repositorio1_idx` (`repositorio_id`),
  KEY `fk_modulo_has_repositorio_modulo1_idx` (`modulo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `modulo_has_repositorio`
--

INSERT INTO `modulo_has_repositorio` (`modulo_id`, `repositorio_id`) VALUES
(15, 1),
(15, 48),
(15, 49),
(15, 65),
(15, 66),
(15, 67);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `nombre`, `codigo`) VALUES
(2, 'argentina', 'arg123');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais_has_dato_academico`
--

CREATE TABLE IF NOT EXISTS `pais_has_dato_academico` (
  `pais_id` int(11) NOT NULL,
  `dato_academico_id` int(11) NOT NULL,
  PRIMARY KEY (`pais_id`,`dato_academico_id`),
  KEY `fk_pais_has_dato_academico_dato_academico1_idx` (`dato_academico_id`),
  KEY `fk_pais_has_dato_academico_pais1_idx` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais_has_dato_laboral`
--

CREATE TABLE IF NOT EXISTS `pais_has_dato_laboral` (
  `pais_id` int(11) NOT NULL,
  `dato_laboral_id` int(11) NOT NULL,
  PRIMARY KEY (`pais_id`,`dato_laboral_id`),
  KEY `fk_pais_has_dato_laboral_dato_laboral1_idx` (`dato_laboral_id`),
  KEY `fk_pais_has_dato_laboral_pais1_idx` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais_has_dato_personal`
--

CREATE TABLE IF NOT EXISTS `pais_has_dato_personal` (
  `pais_id` int(11) NOT NULL,
  `dato_personal_id` int(11) NOT NULL,
  PRIMARY KEY (`pais_id`,`dato_personal_id`),
  KEY `fk_pais_has_dato_personal_dato_personal1_idx` (`dato_personal_id`),
  KEY `fk_pais_has_dato_personal_pais1_idx` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mensaje` text,
  `leido` tinyint(4) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `host` varchar(45) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `foro_id` int(11) NOT NULL,
  `tiene_hijos` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_post_post1_idx` (`post_id`),
  KEY `fk_post_foro1_idx` (`foro_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta_login`
--

CREATE TABLE IF NOT EXISTS `pregunta_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `privilegio_usuario`
--

INSERT INTO `privilegio_usuario` (`id`, `nombre`, `controlador_usuario_id`) VALUES
(1, 'index', 1),
(2, 'index', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programa_academico`
--

CREATE TABLE IF NOT EXISTS `programa_academico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `version` varchar(45) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `entidad_id` int(11) DEFAULT NULL,
  `institucion_id` int(11) DEFAULT NULL,
  `estado_programa_academico_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_programa_academico_entidad1_idx` (`entidad_id`),
  KEY `fk_programa_academico_institucion1_idx` (`institucion_id`),
  KEY `fk_programa_academico_estado_programa_academico1_idx` (`estado_programa_academico_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Volcado de datos para la tabla `programa_academico`
--

INSERT INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`, `entidad_id`, `institucion_id`, `estado_programa_academico_id`) VALUES
(8, 'Ingenieria en subtentabilidad', 'des-Ingenieria-en-subtentabilidad', '1.0', '2015-11-20 16:07:33', '2015-11-26 11:53:26', NULL, 1, 1),
(9, 'Ingenieria en informatica', 'des-Ingenieria-en-informatica', '1.0', '2015-11-26 11:50:15', '2015-11-26 11:53:43', NULL, 1, 1),
(10, 'Diseño', 'des-diseño', '1.0', '2015-11-26 11:50:39', '2015-11-26 11:53:50', NULL, 1, 1),
(11, 'derecho', 'des-derecho', '1.0', '2015-11-26 11:50:56', NULL, NULL, NULL, 1),
(12, 'Ingenieria en redes', 'des-Ingenieria-en-redes', '1.0', '2015-11-26 11:51:31', NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programa_academico_has_modulo`
--

CREATE TABLE IF NOT EXISTS `programa_academico_has_modulo` (
  `programa_academico_id` int(11) NOT NULL,
  `modulo_id` int(11) NOT NULL,
  PRIMARY KEY (`programa_academico_id`,`modulo_id`),
  KEY `fk_programa_academico_has_modulo_modulo1_idx` (`modulo_id`),
  KEY `fk_programa_academico_has_modulo_programa_academico1_idx` (`programa_academico_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `programa_academico_has_modulo`
--

INSERT INTO `programa_academico_has_modulo` (`programa_academico_id`, `modulo_id`) VALUES
(8, 9),
(8, 10),
(8, 11),
(8, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyecto`
--

CREATE TABLE IF NOT EXISTS `proyecto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepcion_trabajo`
--

CREATE TABLE IF NOT EXISTS `recepcion_trabajo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `entrega_publica` tinyint(1) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_recepcion_trabajo_tipo_herramienta1_idx` (`tipo_herramienta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `recepcion_trabajo`
--

INSERT INTO `recepcion_trabajo` (`id`, `nombre`, `entrega_publica`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_eliminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(1, 'Recepcion Trabajo JPxxx', NULL, 'Descripcion Recepcion Trabajo J', '2015-12-03 12:48:33', '2015-12-03 16:21:46', NULL, NULL, 1),
(2, 'Recepcion Trabajo J', NULL, '123', '2015-12-03 17:50:04', NULL, NULL, NULL, 1),
(3, 'Recepcion Trabajo J', NULL, '123', '2015-12-03 17:54:58', NULL, NULL, NULL, 1),
(4, 'Recepcion Trabajo J', 1, '123', '2015-12-03 18:00:12', NULL, NULL, NULL, 1),
(5, 'Recepcion Trabajo J', 0, '123', '2015-12-03 18:00:30', NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `region`
--

CREATE TABLE IF NOT EXISTS `region` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `pais_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_region_pais1_idx` (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reko_session`
--

CREATE TABLE IF NOT EXISTS `reko_session` (
  `id` char(32) NOT NULL,
  `expire` int(11) DEFAULT NULL,
  `data` longblob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `reko_session`
--

INSERT INTO `reko_session` (`id`, `expire`, `data`) VALUES
('2pq178cgupnscaksilfud0aba2', 1454100721, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b6769695f5f72657475726e55726c7c733a31333a222f7465737472656b6f2f676969223b6769695f5f69647c733a353a227969696572223b6769695f5f6e616d657c733a353a227969696572223b6769695f5f7374617465737c613a303a7b7d),
('3gld5659vijbupu409am2si5a3', 1455981025, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a313a2231223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31343a2266656368615f6372656163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31373a2266656368615f656c696d696e6163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a313a2231223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('403ing0khod8i77p05fgmcfg34', 1455204045, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a313a2231223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31343a2266656368615f6372656163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31373a2266656368615f656c696d696e6163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a313a2231223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('4qfac81gd01irtn43llpu3ri03', 1453405765, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a33383a22556e697665727369646164205465636e6f6cc3b367696361204d6574726f706f6c6974616e61223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a323a223438223b733a363a226e6f6d627265223b733a31383a227265706f7369746f72696f2d66756c6c2d32223b733a31313a226465736372697063696f6e223b733a33303a226465736372697063696f6e207265706f7369746f72696f2066756c6c2032223b733a31323a2266656368615f61636365736f223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31343a2266656368615f6372656163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31373a2266656368615f656c696d696e6163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a323a223438223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('6rqh9bfmiovqrt8io8khdluhd7', 1454081725, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b6769695f5f72657475726e55726c7c733a31333a222f7465737472656b6f2f676969223b6769695f5f69647c733a353a227969696572223b6769695f5f6e616d657c733a353a227969696572223b6769695f5f7374617465737c613a303a7b7d),
('6ssurtas6mpka8stod79qgvqv4', 1454854445, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a313a2231223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31343a2266656368615f6372656163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31373a2266656368615f656c696d696e6163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a313a2231223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d7265706f7369746f72696f61756c617c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a323a223635223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31343a2266656368615f6372656163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2232223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b733a313a2231223b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a323a223635223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('8l7pt37be1iibro25ffoopchb3', 1455216630, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d),
('8qggu624rt5djcuahe0sv62go0', 1455200667, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d),
('9736hq9kq8g37ed5bg5nadu2v1', 1455203523, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b),
('9hifeavdpc0tbjshiqs8f3npg0', 1455200719, ''),
('b1rkfe12g3bctbfrrrt8hjkrm3', 1455109216, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d7265706f7369746f72696f61756c617c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a323a223635223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31343a2266656368615f6372656163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2232223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b733a313a2231223b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a323a223635223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('f5nckffitu3m4lilb5psl53qb2', 1454525940, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a323a223635223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31343a2266656368615f6372656163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2232223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b733a313a2231223b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a323a223635223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('lqgrcf34rkefrkfa940f1068b1', 1454593033, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f61756c617c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a323a223635223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31343a2266656368615f6372656163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2232223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b733a313a2231223b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a323a223635223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('mogmjr1914b5ourlob0f5n9ng1', 1455200676, ''),
('ohaaemfpodkq6g3qpmihtpvoe3', 1455140242, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f61756c617c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a323a223635223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31343a2266656368615f6372656163696f6e223b733a31393a22323031352d31322d32382031373a31383a3135223b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2232223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b733a313a2231223b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a323a223635223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('tr2v44j0v34eophkkqc5cmpls3', 1454516321, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31313a7b733a323a226964223b733a313a2231223b733a363a226e6f6d627265223b733a31363a227265706f7369746f72696f2d66756c6c223b733a31313a226465736372697063696f6e223b733a32303a226465732d7265706f7369746f72696f2d66756c6c223b733a31323a2266656368615f61636365736f223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31383a2266656368615f6d6f64696669636163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31343a2266656368615f6372656163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31373a2266656368615f656c696d696e6163696f6e223b733a31393a22303030302d30302d30302030303a30303a3030223b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223434223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b733a32323a227265706f7369746f72696f5f67656e6572616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a313a2231223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d),
('uhn7cnrguct79kbfpitjq4v5p7', 1453910699, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2231223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d31312d32342031373a31353a3139223b),
('uostakob304np6i17v0jiimld0', 1455136813, 0x30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a333a22323438223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `repositorio`
--

CREATE TABLE IF NOT EXISTS `repositorio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `tipo_repositorio_id` int(11) DEFAULT NULL,
  `modelo_aprendizaje_id` int(11) DEFAULT NULL,
  `guia_instruccional_id` int(11) DEFAULT NULL,
  `repositorio_general_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_repositorio_tipo_repositorio1_idx` (`tipo_repositorio_id`),
  KEY `fk_repositorio_modelo_aprendizaje1_idx` (`modelo_aprendizaje_id`),
  KEY `fk_repositorio_guia_instruccional1_idx` (`guia_instruccional_id`),
  KEY `fk_repositorio_repositorio1_idx` (`repositorio_general_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='\n	\n	\n	\n\n\n	\n\n	\n	' AUTO_INCREMENT=68 ;

--
-- Volcado de datos para la tabla `repositorio`
--

INSERT INTO `repositorio` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `tipo_repositorio_id`, `modelo_aprendizaje_id`, `guia_instruccional_id`, `repositorio_general_id`) VALUES
(1, 'repositorio-full', 'des-repositorio-full', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 44, NULL, NULL),
(48, 'repositorio-full-2', 'descripcion repositorio full 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 44, NULL, NULL),
(49, 'repositorio-full-3', 'descripcion repositorio full 3', NULL, '2015-12-21 13:23:15', '2015-12-21 13:23:15', NULL, 1, 44, NULL, NULL),
(65, 'repositorio-full', 'des-repositorio-full', NULL, '2015-12-28 17:18:15', '2015-12-28 17:18:15', NULL, 2, 44, NULL, 1),
(66, 'repositorio-full-2', 'descripcion repositorio full 2', NULL, '2015-12-28 17:18:16', '2015-12-28 17:18:16', NULL, 2, 44, NULL, 48),
(67, 'repositorio-full-3', 'descripcion repositorio full 3', NULL, '2015-12-28 17:18:17', '2015-12-28 17:18:17', NULL, 2, 44, NULL, 49);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuesta_login`
--

CREATE TABLE IF NOT EXISTS `respuesta_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `respuesta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_administrador`
--

CREATE TABLE IF NOT EXISTS `rol_administrador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `rol_administrador`
--

INSERT INTO `rol_administrador` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superadministrador', 'super administrador');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario`
--

CREATE TABLE IF NOT EXISTS `rol_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `tipo` varchar(45) DEFAULT NULL,
  `rol_usuario_general_id` int(11) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rol_usuario_general_id` (`rol_usuario_general_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`id`, `nombre`, `descripcion`, `tipo`, `rol_usuario_general_id`, `fecha_creacion`, `fecha_eliminacion`, `fecha_acceso`, `fecha_modificacion`) VALUES
(1, 'superadministrador', 'descripcion superadministrador', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(2, 'superadministrador', 'descripcion superadministrador', 'rol_usuario_institucion', 1, '2015-12-01 16:11:26', NULL, NULL, '2015-12-01 16:11:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

CREATE TABLE IF NOT EXISTS `rol_usuario_has_authitem_permiso_usuario` (
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  `authitem_permiso_usuario_name` varchar(64) NOT NULL,
  PRIMARY KEY (`rol_usuario_id`,`authitem_permiso_usuario_name`),
  KEY `fk_rol_usuario_has_authitem_permiso_usuario_authitem_permis_idx` (`authitem_permiso_usuario_name`),
  KEY `fk_rol_usuario_has_authitem_permiso_usuario_rol_usuario1_idx` (`rol_usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_usuario_has_authitem_permiso_usuario`
--

INSERT INTO `rol_usuario_has_authitem_permiso_usuario` (`rol_usuario_id`, `authitem_permiso_usuario_name`) VALUES
(1, 'aula'),
(1, 'repositorio'),
(2, 'aula'),
(2, 'repositorio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario_has_privilegio_usuario`
--

CREATE TABLE IF NOT EXISTS `rol_usuario_has_privilegio_usuario` (
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  `privilegio_usuario_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rol_usuario_id`,`privilegio_usuario_id`),
  KEY `fk_rol_usuario_has_privilegio_usuario_privilegio_usuario1_idx` (`privilegio_usuario_id`),
  KEY `fk_rol_usuario_has_privilegio_usuario_rol_usuario1_idx` (`rol_usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `rol_usuario_has_privilegio_usuario`
--

INSERT INTO `rol_usuario_has_privilegio_usuario` (`rol_usuario_id`, `privilegio_usuario_id`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE IF NOT EXISTS `seccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `jornada` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `estado_seccion_id` int(11) DEFAULT NULL,
  `modulo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seccion_estado_seccion1_idx` (`estado_seccion_id`),
  KEY `fk_seccion_modulo1_idx` (`modulo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=22 ;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_image`
--

CREATE TABLE IF NOT EXISTS `tbl_image` (
  `id_image` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `folder` text NOT NULL,
  `image` text NOT NULL,
  PRIMARY KEY (`id_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_herramienta`
--

CREATE TABLE IF NOT EXISTS `tipo_herramienta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `tipo_herramienta`
--

INSERT INTO `tipo_herramienta` (`id`, `nombre`) VALUES
(1, 'herramienta_troncal'),
(2, 'herramienta_troncal_modulo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_repositorio`
--

CREATE TABLE IF NOT EXISTS `tipo_repositorio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='				' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `tipo_repositorio`
--

INSERT INTO `tipo_repositorio` (`id`, `descripcion`) VALUES
(1, 'repositorio_troncal'),
(2, 'repositorio_troncal_modulo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajo_grupal`
--

CREATE TABLE IF NOT EXISTS `trabajo_grupal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `estado_usuario_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_usuario_estado_usuario1_idx` (`estado_usuario_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=253 ;

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
(251, 'sdsdsad', 'sdsadd', NULL, NULL, '2015-11-24 11:55:22', NULL),
(252, 'usuario80', '123', NULL, NULL, '2016-01-13 11:59:10', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `usuario_administrador`
--

INSERT INTO `usuario_administrador` (`id`, `usuario`, `clave`) VALUES
(1, 'creyes', '123'),
(2, 'diego', '123');

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
(1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_institucion`
--

CREATE TABLE IF NOT EXISTS `usuario_has_institucion` (
  `usuario_id` int(11) DEFAULT NULL,
  `institucion_id` int(11) DEFAULT NULL,
  KEY `usuario_id` (`usuario_id`),
  KEY `institucion_id` (`institucion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(248, 1),
(236, 1),
(237, 1),
(238, 1),
(239, 1),
(240, 1),
(241, 1),
(248, 1),
(248, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_modulo`
--

CREATE TABLE IF NOT EXISTS `usuario_has_modulo` (
  `usuario_id` int(11) NOT NULL DEFAULT '0',
  `modulo_id` int(11) NOT NULL DEFAULT '0',
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usuario_id`,`modulo_id`,`rol_usuario_id`),
  KEY `fk_usuario_has_modulo_modulo1_idx` (`modulo_id`),
  KEY `fk_usuario_has_modulo_usuario1_idx` (`usuario_id`),
  KEY `fk_usuario_has_modulo_rol_usuario1_idx` (`rol_usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_has_modulo`
--

INSERT INTO `usuario_has_modulo` (`usuario_id`, `modulo_id`, `rol_usuario_id`) VALUES
(248, 9, 198),
(236, 15, 195),
(236, 15, 196),
(236, 15, 197),
(248, 15, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_post`
--

CREATE TABLE IF NOT EXISTS `usuario_has_post` (
  `usuario_id` int(11) NOT NULL,
  `rol_usuario_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  KEY `fk_usuario_has_post_usuario1_idx` (`usuario_id`),
  KEY `fk_usuario_has_post_rol_usuario1_idx` (`rol_usuario_id`),
  KEY `fk_usuario_has_post_post1_idx` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_programa_academico`
--

CREATE TABLE IF NOT EXISTS `usuario_has_programa_academico` (
  `usuario_id` int(11) NOT NULL DEFAULT '0',
  `programa_academico_id` int(11) NOT NULL DEFAULT '0',
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usuario_id`,`programa_academico_id`,`rol_usuario_id`),
  KEY `fk_usuario_has_programa_academico_programa_academico1_idx` (`programa_academico_id`),
  KEY `fk_usuario_has_programa_academico_usuario1_idx` (`usuario_id`),
  KEY `fk_usuario_has_programa_academico_rol_usuario1_idx` (`rol_usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_has_programa_academico`
--

INSERT INTO `usuario_has_programa_academico` (`usuario_id`, `programa_academico_id`, `rol_usuario_id`) VALUES
(236, 8, 195),
(236, 8, 196),
(236, 8, 197),
(248, 8, 2),
(248, 8, 198),
(248, 9, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_rol_usuario`
--

CREATE TABLE IF NOT EXISTS `usuario_has_rol_usuario` (
  `usuario_id` int(11) NOT NULL DEFAULT '0',
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usuario_id`,`rol_usuario_id`),
  KEY `fk_usuario_has_rol_usuario_rol_usuario1_idx` (`rol_usuario_id`),
  KEY `fk_usuario_has_rol_usuario_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_has_rol_usuario`
--

INSERT INTO `usuario_has_rol_usuario` (`usuario_id`, `rol_usuario_id`) VALUES
(248, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_has_seccion`
--

CREATE TABLE IF NOT EXISTS `usuario_has_seccion` (
  `usuario_id` int(11) NOT NULL DEFAULT '0',
  `rol_usuario_id` int(11) NOT NULL DEFAULT '0',
  `seccion_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rol_usuario_id`,`seccion_id`,`usuario_id`),
  KEY `fk_usuario_has_seccion_usuario1_idx` (`usuario_id`),
  KEY `fk_usuario_has_seccion_rol_usuario1_idx` (`rol_usuario_id`),
  KEY `fk_usuario_has_seccion_seccion1_idx` (`seccion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `usuario_has_seccion`
--

INSERT INTO `usuario_has_seccion` (`usuario_id`, `rol_usuario_id`, `seccion_id`) VALUES
(236, 195, 6);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `archivo_recurso`
--
ALTER TABLE `archivo_recurso`
  ADD CONSTRAINT `fk_archivo_recurso_tipo_herramienta1` FOREIGN KEY (`tipo_herramienta_id`) REFERENCES `tipo_herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Filtros para la tabla `dato_academico`
--
ALTER TABLE `dato_academico`
  ADD CONSTRAINT `fk_dato_academico_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `dato_laboral`
--
ALTER TABLE `dato_laboral`
  ADD CONSTRAINT `fk_dato_laboral_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `dato_login`
--
ALTER TABLE `dato_login`
  ADD CONSTRAINT `fk_dato_login_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_dato_login_codigo_seguridad1` FOREIGN KEY (`codigo_seguridad_id`) REFERENCES `codigo_seguridad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `dato_login_has_pregunta_login`
--
ALTER TABLE `dato_login_has_pregunta_login`
  ADD CONSTRAINT `fk_dato_login_has_pregunta_login_dato_login1` FOREIGN KEY (`dato_login_id`) REFERENCES `dato_login` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dato_login_has_pregunta_login_pregunta_login1` FOREIGN KEY (`pregunta_login_id`) REFERENCES `pregunta_login` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `dato_login_has_respuesta_login`
--
ALTER TABLE `dato_login_has_respuesta_login`
  ADD CONSTRAINT `fk_dato_login_has_respuesta_login_dato_login1` FOREIGN KEY (`dato_login_id`) REFERENCES `dato_login` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dato_login_has_respuesta_login_respuesta_login1` FOREIGN KEY (`respuesta_login_id`) REFERENCES `respuesta_login` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `dato_personal`
--
ALTER TABLE `dato_personal`
  ADD CONSTRAINT `fk_dato_personal_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `entidad`
--
ALTER TABLE `entidad`
  ADD CONSTRAINT `fk_entidad_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entidad_estado_entidad1` FOREIGN KEY (`estado_entidad_id`) REFERENCES `estado_entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entidad_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `escritorio_administrador`
--
ALTER TABLE `escritorio_administrador`
  ADD CONSTRAINT `fk_escritorio_administrador_usuario_administrador1` FOREIGN KEY (`usuario_administrador_id`) REFERENCES `usuario_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `foro`
--
ALTER TABLE `foro`
  ADD CONSTRAINT `fk_foro_tipo_herramienta1` FOREIGN KEY (`tipo_herramienta_id`) REFERENCES `tipo_herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `glosario`
--
ALTER TABLE `glosario`
  ADD CONSTRAINT `fk_glosario_glosario1` FOREIGN KEY (`glosario_general_id`) REFERENCES `glosario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_glosario_tipo_herramienta1` FOREIGN KEY (`tipo_herramienta_id`) REFERENCES `tipo_herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `glosario_termino_definicion`
--
ALTER TABLE `glosario_termino_definicion`
  ADD CONSTRAINT `fk_glosario_termino_definicion_glosario1` FOREIGN KEY (`glosario_id`) REFERENCES `glosario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `herramienta`
--
ALTER TABLE `herramienta`
  ADD CONSTRAINT `fk_herramienta_herramienta1` FOREIGN KEY (`herramienta_general_id`) REFERENCES `herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_herramienta_tipo_herramienta1` FOREIGN KEY (`tipo_herramienta_id`) REFERENCES `tipo_herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `icono_aplicacion_administrador`
--
ALTER TABLE `icono_aplicacion_administrador`
  ADD CONSTRAINT `fk_icono_aplicacion_administrador_authitem_permiso_administra1` FOREIGN KEY (`authitem_permiso_administrador_name`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `institucion`
--
ALTER TABLE `institucion`
  ADD CONSTRAINT `fk_institucion_estado_institucion1` FOREIGN KEY (`estado_institucion_id`) REFERENCES `estado_institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_institucion_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_institucion_region1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `institucion_has_repositorio`
--
ALTER TABLE `institucion_has_repositorio`
  ADD CONSTRAINT `fk_institucion_has_repositorio_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `institucion_has_rol_usuario`
--
ALTER TABLE `institucion_has_rol_usuario`
  ADD CONSTRAINT `fk_institucion_has_rol_usuario_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_institucion_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `link_interes`
--
ALTER TABLE `link_interes`
  ADD CONSTRAINT `fk_link_interes_tipo_herramienta1` FOREIGN KEY (`tipo_herramienta_id`) REFERENCES `tipo_herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modelo_aprendizaje_has_herramienta`
--
ALTER TABLE `modelo_aprendizaje_has_herramienta`
  ADD CONSTRAINT `fk_modelo_aprendizaje_has_herramienta_modelo_aprendizaje1` FOREIGN KEY (`modelo_aprendizaje_id`) REFERENCES `modelo_aprendizaje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD CONSTRAINT `fk_modulo_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_modulo_estado_modulo1` FOREIGN KEY (`estado_modulo_id`) REFERENCES `estado_modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_modulo_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modulo_has_repositorio`
--
ALTER TABLE `modulo_has_repositorio`
  ADD CONSTRAINT `fk_modulo_has_repositorio_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_modulo_has_repositorio_repositorio1` FOREIGN KEY (`repositorio_id`) REFERENCES `repositorio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `pais_has_dato_academico`
--
ALTER TABLE `pais_has_dato_academico`
  ADD CONSTRAINT `fk_pais_has_dato_academico_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pais_has_dato_academico_dato_academico1` FOREIGN KEY (`dato_academico_id`) REFERENCES `dato_academico` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pais_has_dato_laboral`
--
ALTER TABLE `pais_has_dato_laboral`
  ADD CONSTRAINT `fk_pais_has_dato_laboral_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pais_has_dato_laboral_dato_laboral1` FOREIGN KEY (`dato_laboral_id`) REFERENCES `dato_laboral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pais_has_dato_personal`
--
ALTER TABLE `pais_has_dato_personal`
  ADD CONSTRAINT `fk_pais_has_dato_personal_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pais_has_dato_personal_dato_personal1` FOREIGN KEY (`dato_personal_id`) REFERENCES `dato_personal` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Filtros para la tabla `programa_academico`
--
ALTER TABLE `programa_academico`
  ADD CONSTRAINT `fk_programa_academico_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_programa_academico_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_programa_academico_estado_programa_academico1` FOREIGN KEY (`estado_programa_academico_id`) REFERENCES `estado_programa_academico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `programa_academico_has_modulo`
--
ALTER TABLE `programa_academico_has_modulo`
  ADD CONSTRAINT `fk_programa_academico_has_modulo_programa_academico1` FOREIGN KEY (`programa_academico_id`) REFERENCES `programa_academico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_programa_academico_has_modulo_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `recepcion_trabajo`
--
ALTER TABLE `recepcion_trabajo`
  ADD CONSTRAINT `fk_recepcion_trabajo_tipo_herramienta1` FOREIGN KEY (`tipo_herramienta_id`) REFERENCES `tipo_herramienta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `region`
--
ALTER TABLE `region`
  ADD CONSTRAINT `fk_region_pais1` FOREIGN KEY (`pais_id`) REFERENCES `pais` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `repositorio`
--
ALTER TABLE `repositorio`
  ADD CONSTRAINT `fk_repositorio_guia_instruccional1` FOREIGN KEY (`guia_instruccional_id`) REFERENCES `guia_instruccional` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_repositorio_modelo_aprendizaje1` FOREIGN KEY (`modelo_aprendizaje_id`) REFERENCES `modelo_aprendizaje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_repositorio_tipo_repositorio1` FOREIGN KEY (`tipo_repositorio_id`) REFERENCES `tipo_repositorio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_administrador_has_authitem_permiso_administrador`
--
ALTER TABLE `rol_administrador_has_authitem_permiso_administrador`
  ADD CONSTRAINT `fk_rol_administrador_has_authitem_permiso_administrador_rol_a1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_administrador_has_authitem_permiso_administrador_authi1` FOREIGN KEY (`authitem_permiso_administrador_name`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_administrador_has_privilegio_administrador`
--
ALTER TABLE `rol_administrador_has_privilegio_administrador`
  ADD CONSTRAINT `fk_rol_administrador_has_privilegio_administrador_rol_adminis1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_administrador_has_privilegio_administrador_privilegio_1` FOREIGN KEY (`privilegio_administrador_id`) REFERENCES `privilegio_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_usuario_has_authitem_permiso_usuario`
--
ALTER TABLE `rol_usuario_has_authitem_permiso_usuario`
  ADD CONSTRAINT `fk_rol_usuario_has_authitem_permiso_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_usuario_has_authitem_permiso_usuario_authitem_permiso_1` FOREIGN KEY (`authitem_permiso_usuario_name`) REFERENCES `authitem_permiso_usuario` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `rol_usuario_has_privilegio_usuario`
--
ALTER TABLE `rol_usuario_has_privilegio_usuario`
  ADD CONSTRAINT `fk_rol_usuario_has_privilegio_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rol_usuario_has_privilegio_usuario_privilegio_usuario1` FOREIGN KEY (`privilegio_usuario_id`) REFERENCES `privilegio_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `seccion`
--
ALTER TABLE `seccion`
  ADD CONSTRAINT `fk_seccion_estado_seccion1` FOREIGN KEY (`estado_seccion_id`) REFERENCES `estado_seccion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_seccion_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_usuario_estado_usuario1` FOREIGN KEY (`estado_usuario_id`) REFERENCES `estado_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_administrador_has_rol_administrador`
--
ALTER TABLE `usuario_administrador_has_rol_administrador`
  ADD CONSTRAINT `fk_usuario_administrador_has_rol_administrador_usuario_admini1` FOREIGN KEY (`usuario_administrador_id`) REFERENCES `usuario_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_administrador_has_rol_administrador_rol_administra1` FOREIGN KEY (`rol_administrador_id`) REFERENCES `rol_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_has_institucion`
--
ALTER TABLE `usuario_has_institucion`
  ADD CONSTRAINT `usuario_has_institucion_ibfk_2` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`),
  ADD CONSTRAINT `usuario_has_institucion_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `usuario_has_modulo`
--
ALTER TABLE `usuario_has_modulo`
  ADD CONSTRAINT `fk_usuario_has_modulo_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_modulo_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_modulo_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_has_post`
--
ALTER TABLE `usuario_has_post`
  ADD CONSTRAINT `fk_usuario_has_post_post1` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_post_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_post_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_has_programa_academico`
--
ALTER TABLE `usuario_has_programa_academico`
  ADD CONSTRAINT `fk_usuario_has_programa_academico_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_programa_academico_programa_academico1` FOREIGN KEY (`programa_academico_id`) REFERENCES `programa_academico` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_programa_academico_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_has_rol_usuario`
--
ALTER TABLE `usuario_has_rol_usuario`
  ADD CONSTRAINT `fk_usuario_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario_has_seccion`
--
ALTER TABLE `usuario_has_seccion`
  ADD CONSTRAINT `fk_usuario_has_seccion_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_seccion_seccion1` FOREIGN KEY (`seccion_id`) REFERENCES `seccion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_seccion_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
