-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 06-11-2015 a las 20:35:38
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_modulo`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_fecha_modificacion datetime
)
begin
update modulo set 
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
fecha_modificacion = nuevo_fecha_modificacion
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_programa_academico`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_version varchar(50),
nuevo_fecha_modificacion datetime
)
begin
update programa_academico set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
version = nuevo_version,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_actualizar_seccion`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_jornada varchar(50),
nuevo_descripcion varchar(50),
nuevo_fecha_modificacion datetime
)
begin
update seccion set
id = nuevo_id,
nombre = nuevo_nombre,
jornada = nuevo_jornada,
descripcion = nuevo_descripcion,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_modulo`(
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into modulo(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_programa_academico`(
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_version varchar(50),
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into programa_academico(
nombre,
descripcion,
version,
fecha_creacion
)
values(
nuevo_nombre ,
nuevo_descripcion ,
nuevo_version ,
now()
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_agregar_seccion`(
nuevo_nombre varchar(50),
nuevo_jornada varchar(50),
nuevo_descripcion varchar(50),
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into seccion(
nombre,
jornada,
descripcion,
fecha_creacion
)
values(
nuevo_nombre,
nuevo_jornada,
nuevo_descripcion,
now()
);
SELECT LAST_INSERT_ID () into llave_id;
end$$

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
    SELECT programa_academico_id INTO programa_id_tmp FROM programa_academico_has_entidad WHERE programa_academico_id = nuevo_programa_id AND entidad_id = nuevo_entidad_id;
    IF ( programa_id_tmp IS NULL) THEN
		INSERT INTO programa_academico_has_entidad (`programa_academico_id`,`entidad_id`) VALUES (nuevo_programa_id,nuevo_entidad_id);
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
    SELECT programa_academico_id INTO programa_id_tmp FROM programa_academico_has_institucion WHERE programa_academico_id = nuevo_programa_id AND institucion_id = nuevo_institucion_id;
    IF ( programa_id_tmp IS NULL) THEN
		INSERT INTO programa_academico_has_institucion (`programa_academico_id`,`institucion_id`) VALUES (nuevo_programa_id,nuevo_institucion_id);
	ELSE
		SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

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
    SELECT programa_academico_id INTO programa_id_tmp FROM programa_academico_has_entidad WHERE programa_academico_id = nuevo_programa_id AND entidad_id = nuevo_entidad_id;
    IF ( programa_id_tmp IS NOT NULL) THEN
		DELETE FROM programa_academico_has_entidad WHERE entidad_id = nuevo_entidad_id AND programa_academico_id = nuevo_programa_id;
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
    SELECT programa_academico_id INTO programa_id_tmp FROM programa_academico_has_institucion WHERE programa_academico_id = nuevo_programa_id AND institucion_id = nuevo_institucion_id;
    IF ( programa_id_tmp IS NOT NULL) THEN
		DELETE FROM programa_academico_has_institucion WHERE institucion_id = nuevo_institucion_id AND programa_academico_id = nuevo_programa_id;
	ELSE
		SET programa_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_programa_id, programa_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_eliminado_logico_modulo`(nuevo_id int)
BEGIN
	update modulo m,estado_modulo em
	set m.estado_modulo_id = em.id 
	where m.id = nuevo_id
	and em.id = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_eliminado_logico_programa_academico`(nuevo_id int)
BEGIN
	update programa_academico pa,estado_programa_academico epa
	set pa.estado_programa_academico_id = epa.id 
	where pa.id = nuevo_id
	and epa.id = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_eliminado_logico_seccion`(nuevo_id int)
BEGIN
	update seccion s,estado_seccion es
	set s.estado_seccion_id = es.id 
	where s.id = nuevo_id
	and es.id = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_listar2_entidad_entidad`(nuevo_entidad_id int(11))
BEGIN
SELECT A.nombre,A.entidad_id,A.id FROM `entidad` A
WHERE A.id = A.entidad_id
AND A.id = nuevo_entidad_id UNION SELECT null,null,A.id FROM (`entidad` A LEFT JOIN `entidad` B ON A.entidad_id = B.id)
WHERE A.entidad_id is NULL;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_entidad_programa`(nuevo_entidad_id int(11))
BEGIN
SELECT A.nombre,B.entidad_id, B.programa_academico_id FROM `entidad` A, `programa_academico_has_entidad` B 
WHERE A.id = B.entidad_id
AND A.id = nuevo_entidad_id UNION SELECT null,null,A.id FROM (`programa_academico` A LEFT JOIN `programa_academico_has_entidad` B ON A.id = B.programa_academico_id)
WHERE B.programa_academico_id is NULL
order by programa_academico_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_institucion_programa`(nuevo_institucion_id int(11))
BEGIN
SELECT A.nombre,B.institucion_id, B.programa_academico_id FROM `institucion` A, `programa_academico_has_institucion` B 
WHERE A.id = B.institucion_id
AND A.id = nuevo_institucion_id UNION SELECT null,null,A.id FROM (`programa_academico` A LEFT JOIN `programa_academico_has_institucion` B ON A.id = B.programa_academico_id)
WHERE B.programa_academico_id is NULL
order by programa_academico_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_curricular_lista_programa_modulo`(nuevo_programa_id int(11))
BEGIN
SELECT A.nombre,B.programa_academico_id,B.modulo_id FROM `programa_academico` A, `programa_academico_has_modulo` B 
WHERE A.id = B.programa_academico_id
AND A.id = nuevo_programa_id UNION SELECT null,null,A.id FROM (`modulo` A LEFT JOIN `programa_academico_has_modulo` B ON A.id = B.modulo_id AND B.programa_academico_id = nuevo_programa_id)
WHERE B.modulo_id is NULL
order by modulo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_actualizar_entidad`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_fecha_modificacion datetime
)
begin
update entidad set
id = nuevo_id,
nombre = nuevo_nombre,
descripcion = nuevo_descripcion,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_actualizar_institucion`(
nuevo_id int,
nuevo_nombre varchar(50),
nuevo_vision varchar(50),
nuevo_mision varchar(50),
nuevo_acreditada bit(1),
nuevo_fecha_inicio_acreditacion datetime,
nuevo_fecha_termino_acreditacion datetime,
nuevo_descripcion varchar(50),
nuevo_fecha_modificacion datetime
)
begin
update institucion set
id = nuevo_id,
nombre = nuevo_nombre,
vision = nuevo_vision,
mision = nuevo_mision,
acreditada = nuevo_acreditada,
fecha_inicio_acreditacion = nuevo_fecha_inicio_acreditacion,
fecha_termino_acreditacion = nuevo_fecha_termino_acreditacion,
descripcion = nuevo_descripcion,
fecha_modificacion = now()
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_agregar_entidad`(
nuevo_nombre varchar(50),
nuevo_descripcion varchar(50),
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into entidad(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_agregar_institucion`(
nuevo_nombre varchar(50),
nuevo_vision varchar(50),
nuevo_mision varchar(50),
nuevo_acreditada bit(1),
nuevo_fecha_inicio_acreditacion datetime,
nuevo_fecha_termino_acreditacion datetime,
nuevo_descripcion varchar(50),
nuevo_fecha_creacion datetime,
OUT llave_id int(11)
)
begin
insert into institucion(
nombre,
vision,
mision,
acreditada,
fecha_inicio_acreditacion,
fecha_termino_acreditacion,
descripcion,
fecha_creacion
)
values(
nuevo_nombre,
nuevo_vision, 
nuevo_mision, 
nuevo_acreditada, 
nuevo_fecha_inicio_acreditacion, 
nuevo_fecha_termino_acreditacion, 
nuevo_descripcion, 
now()
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
	and ee.id = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_eliminado_logico_institucion`(nuevo_id int)
BEGIN
	update institucion ins,estado_institucion ei
	set ins.estado_institucion_id = ei.id 
	where ins.id = nuevo_id
	and ei.id = 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_entidad_entidad`(nuevo_id int)
BEGIN
SELECT en.id,en.nombre,en.descripcion,en.fecha_creacion,en.fecha_modificacion,en.entidad_id
FROM entidad en
where en.entidad_id = nuevo_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_institucion_listar_entidad_por_estado`()
BEGIN
select 
	en.*,
    ee.estado 
from entidad en,estado_entidad ee
where ee.id = en.estado_entidad_id
and en.estado_entidad_id !=1;
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
select 
	ins.*,
    ei.estado 
from institucion ins,estado_institucion ei
where ei.id = ins.estado_institucion_id
and ins.estado_institucion_id !=1;
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
nuevo_fecha_modificacion datetime
)
BEGIN
UPDATE usuario SET
id = nuevo_id,
usuario = nuevo_usuario,
clave = nuevo_clave,
fecha_modificacion = now()
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
OUT llave_id int(11)
)
begin
INSERT INTO usuario(
usuario,
clave,
fecha_creacion
)
VALUES(
nuevo_usuario,
nuevo_clave,
now()
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_eliminado_logico_usuario`(nuevo_id int)
BEGIN
	update usuario usu,estado_usuario ea
	set usu.estado_usuario_id = ea.id 
	where usu.id = nuevo_id
	and ea.id = 3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_academicos_por_estado`()
BEGIN
SELECT 
		da.id,
		da.universidad,
		da.carrera,
		da.ano_cursado,
		da.duracion_carrera,
		da.sede,
		da.direccion_sede,
		da.comuna_sede,
		da.ciudad_sede,
		da.usuario_id
FROM dato_academico da,usuario usu,estado_usuario ea
WHERE da.usuario_id = usu.id
AND usu.estado_usuario_id = ea.id
AND usu.estado_usuario_id !=3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_laborales_por_estado`()
BEGIN
SELECT 
		dl.id,
		dl.nombre_empresa,
		dl.ano_antiguedad,
		dl.cargo,
		dl.actividad,
		dl.comuna_empresa,
		dl.ciudad_empresa,
		dl.telefono_empresa,
		dl.celular_empresa,
		dl.rut_numero,
        dl.digito_verificador,
        dl.usuario_id
FROM dato_laboral dl,usuario usu,estado_usuario ea
WHERE dl.usuario_id = usu.id
AND usu.estado_usuario_id = ea.id
AND usu.estado_usuario_id !=3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_login_por_estado`()
BEGIN
SELECT 
		dl.id,
		dl.usuario_id,
		dl.codigo_seguridad_id

FROM dato_login dl,usuario usu,estado_usuario ea
WHERE dl.usuario_id = usu.id
AND usu.estado_usuario_id = ea.id
AND usu.estado_usuario_id !=3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_listar_datos_personales_por_estado`()
BEGIN
SELECT 
		dp.id, 
        dp.primer_nombre, 
        dp.segundo_nombre, 
        dp.apellido_paterno, 
        dp.apellido_materno, 
        dp.fecha_nacimiento, 
        dp.edad, 
        dp.rut, 
        dp.digito_verificador, 
        dp.direccion_personal, 
        dp.numero_casa, 
        dp.telefono_personal, 
        dp.celular_personal, 
        dp.comuna_personal, 
        dp.ciudad_personal, 
        dp.interes, 
        dp.estado_civil, 
        dp.idioma, 
        dp.nacionalidad, 
        dp.usuario_id
        
FROM dato_personal dp,usuario usu,estado_usuario ea
WHERE dp.usuario_id = usu.id
AND usu.estado_usuario_id = ea.id
AND usu.estado_usuario_id !=3;
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
select usu.id,usu.usuario,usu.clave,usu.fecha_acceso,usu.fecha_modificacion,usu.fecha_creacion,eu.estado from usuario usu,estado_usuario eu
where eu.id = usu.estado_usuario_id
and usu.estado_usuario_id !=3;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_lista_institucion_usuario`(nuevo_institucion_id int(11))
BEGIN
SELECT A.nombre,B.institucion_id, B.usuario_id FROM `institucion` A, `usuario_has_institucion` B 
WHERE A.id = B.institucion_id
AND A.id = nuevo_institucion_id UNION SELECT null,null,A.id FROM (`usuario` A LEFT JOIN `usuario_has_institucion` B ON A.id = B.usuario_id AND B.institucion_id = nuevo_institucion_id)
WHERE B.usuario_id is NULL
order by usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_usuario_lista_usuario_estado`(nuevo_usuario_id int(11))
BEGIN
SELECT A.usuario,B.usuario_id, B.logica_estado_usuario_id FROM `usuario` A, `estado_usuario` B 
WHERE A.id = B.usuario_id
AND A.id = nuevo_usuario_id UNION SELECT null,null,A.id FROM (`logica_estado_usuario` A LEFT JOIN `estado_usuario` B ON A.id = B.logica_estado_usuario_id)
WHERE B.logica_estado_usuario_id is NULL
order by logica_estado_usuario_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_components_obtener_institucion_usuario`(nuevo_usuario_id int)
SELECT I.*
FROM
		institucion I,
        usuario_has_institucion UI,
        usuario U
        
WHERE UI.institucion_id = I.id
AND UI.usuario_id = U.id
AND U.id = nuevo_usuario_id
ORDER BY institucion_id$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_agregar_glosario_repositorio_troncal`(
	
    nuevo_repositorio_id INT,
    nuevo_glosario_nombre VARCHAR(255),
    nuevo_glosario_descripcion TEXT,
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
        repositorio_id,
        tipo_herramienta_id
    )
    VALUES(
		nuevo_glosario_nombre,
        nuevo_glosario_descripcion,
        NOW(),
        last_insert_glosario_id,
        nuevo_repositorio_id,
        1
    );

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_repositorio_lista_glosario_repositorio`(nuevo_repositorio_id INT)
BEGIN

	SELECT G.*

	FROM
			repositorio R,
			herramienta H,
			glosario G
			
	WHERE R.id = H.repositorio_id
	AND H.recurso_id = G.id
	AND R.id = nuevo_repositorio_id;

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
    AND herramienta.repositorio_id = nuevo_repositorio_id;
    
    
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
('administracion_usuario_administrador', '1', NULL, NULL),
('admin_rol_usuario', '2', NULL, 'N;'),
('admin_usuario', '2', NULL, 'N;');

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
('aula', '1', NULL, NULL),
('aula', '2', NULL, NULL),
('aula', '3', NULL, NULL),
('aula', '4', NULL, NULL),
('aula', '5', NULL, NULL),
('repositorio', '1', NULL, NULL),
('repositorio', '4', NULL, NULL),
('repositorio', '5', NULL, NULL);

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
('aula', 2, NULL, NULL, NULL),
('mesa_de_ayuda', 2, NULL, NULL, NULL),
('repositorio', 2, NULL, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `controlador_usuario`
--

INSERT INTO `controlador_usuario` (`id`, `nombre`, `authitem_permiso_usuario_name`) VALUES
(1, 'Aula', 'aula'),
(2, 'Default', 'aula'),
(3, 'Repositorio', 'repositorio'),
(4, 'Default', 'repositorio');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `dato_academico`
--

INSERT INTO `dato_academico` (`id`, `universidad`, `carrera`, `ano_cursado`, `duracion_carrera`, `sede`, `direccion_sede`, `comuna_sede`, `ciudad_sede`, `usuario_id`) VALUES
(1, 'akjassa', 'askjak', 5, 5, 'skldj', 'sakjhd', 'sakjdhd', 'sakjdh', 9),
(2, 'wuyeywueuiy', 'nmbcnxmnmcz', 45454, 0, 'sadsad', 'sadsad', 'sadsad', 'sdsdsda', 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `dato_laboral`
--

INSERT INTO `dato_laboral` (`id`, `nombre_empresa`, `ano_antiguedad`, `cargo`, `actividad`, `comuna_empresa`, `ciudad_empresa`, `telefono_empresa`, `celular_empresa`, `rut_numero`, `digito_verificador`, `usuario_id`) VALUES
(1, 'empresa', 7, 'skldjsakd', 'sakldjkl', 'saljdsakld', 'sajdkljsd', 45454, 5454, 545454, 5454, 1),
(2, 'dvcvcvcxvcv', 12121, 'efefefef', 'saxsadsads', 'sakjhdsakjsk', 'sakhdskjhdsak', 212121, 212121, 21212, 21212, 2);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `dato_login`
--

INSERT INTO `dato_login` (`id`, `usuario_id`, `codigo_seguridad_id`) VALUES
(1, 1, 0),
(2, 1, 0),
(3, 5, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=501 ;

--
-- Volcado de datos para la tabla `dato_personal`
--

INSERT INTO `dato_personal` (`id`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `edad`, `rut`, `digito_verificador`, `direccion_personal`, `numero_casa`, `telefono_personal`, `celular_personal`, `comuna_personal`, `ciudad_personal`, `interes`, `estado_civil`, `idioma`, `nacionalidad`, `usuario_id`) VALUES
(100, 'christian', NULL, 'reyes', 'arellano', NULL, 11, 11111111, 1, NULL, NULL, NULL, NULL, 'maipu', 'santiago', NULL, NULL, 'espanol', 'chileno', 1),
(200, 'francisco', NULL, 'carvajal', NULL, NULL, 22, 22222222, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2),
(300, 'victor', NULL, 'guzman', NULL, NULL, 33, 33333333, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 3),
(400, 'marcelo', NULL, NULL, NULL, NULL, 44, 44444444, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 4),
(500, 'patricio', NULL, 'iriarte', NULL, NULL, 55, 55555555, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 5);

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
  PRIMARY KEY (`id`),
  KEY `fk_entidad_institucion1_idx` (`institucion_id`),
  KEY `fk_entidad_entidad1_idx` (`entidad_id`),
  KEY `fk_entidad_estado_entidad1_idx` (`estado_entidad_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `entidad`
--

INSERT INTO `entidad` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `institucion_id`, `entidad_id`, `estado_entidad_id`) VALUES
(1, 'centro de alumnos', 'centro-descripcion', '2015-09-04 16:40:13', '2015-09-04 16:40:13', 1, 9, 1),
(2, 'sede', 'sede-descr', '2015-09-04 16:40:13', '2015-09-04 16:40:13', 1, 1, 1),
(3, 'campus', 'campus-des', '2015-09-04 16:40:13', '2015-09-04 16:40:13', 1, 1, NULL),
(4, 'facultad', 'facul-des', '2015-09-04 16:40:13', '2015-09-04 16:40:13', 2, 1, 1),
(5, 'prueba1', 'des1', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 4, 2),
(6, 'prueba2', 'des2', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 4, 2),
(7, 'prueba3', 'des3', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 4, 2),
(8, 'prueba4', 'des4', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 1, 2),
(9, 'prueba5', 'des5', '2015-09-23 15:05:57', '2015-09-23 15:05:57', 1, 1, 2);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `estado_codigo_seguridad`
--

INSERT INTO `estado_codigo_seguridad` (`id`, `estado`, `codigo_seguridad_id`) VALUES
(1, 'bloqueadostodos', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_entidad`
--

CREATE TABLE IF NOT EXISTS `estado_entidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `estado_entidad`
--

INSERT INTO `estado_entidad` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_institucion`
--

CREATE TABLE IF NOT EXISTS `estado_institucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `estado_institucion`
--

INSERT INTO `estado_institucion` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_modulo`
--

CREATE TABLE IF NOT EXISTS `estado_modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `estado_modulo`
--

INSERT INTO `estado_modulo` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_programa_academico`
--

CREATE TABLE IF NOT EXISTS `estado_programa_academico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `estado_programa_academico`
--

INSERT INTO `estado_programa_academico` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_seccion`
--

CREATE TABLE IF NOT EXISTS `estado_seccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `estado_seccion`
--

INSERT INTO `estado_seccion` (`id`, `estado`) VALUES
(1, 'eliminado'),
(2, 'prueba');

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
(2, 'en espera'),
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
-- Estructura de tabla para la tabla `foro`
--

CREATE TABLE IF NOT EXISTS `foro` (
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
  PRIMARY KEY (`id`),
  KEY `fk_glosario_tipo_herramienta1_idx` (`tipo_herramienta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Volcado de datos para la tabla `glosario`
--

INSERT INTO `glosario` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `fecha_eliminacion`, `fecha_acceso`, `tipo_herramienta_id`) VALUES
(1, 'Diccionario de la lengua española', 'Versión electrónica del Diccionario de la lengua española, obra lexicográfica académica por excelencia.', NULL, NULL, NULL, NULL, 1),
(2, 'UCT Diccionario Abreviado Mapudungun - Españo', 'Contiene un listado de entradas léxicas del mapudungun, ordenado alfabéticamente, con una versión abreviada de sus significados en español e inglés.', NULL, NULL, NULL, NULL, 1),
(3, 'Glosario de términos geográficos', 'A. Acantilado: Costa alta y escarpada, de altura variable. Accesibilidad: Capacidad potencial de establecer contactos físicos y/o sociales', NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `glosario_termino_definicion`
--

CREATE TABLE IF NOT EXISTS `glosario_termino_definicion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `termino` varchar(45) DEFAULT NULL,
  `definicion` text,
  `glosario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_glosario_termino_definicion_glosario1_idx` (`glosario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `repositorio_id` int(11) DEFAULT NULL,
  `tipo_herramienta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_herramienta_repositorio1_idx` (`repositorio_id`),
  KEY `fk_herramienta_tipo_herramienta1_idx` (`tipo_herramienta_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Volcado de datos para la tabla `herramienta`
--

INSERT INTO `herramienta` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `recurso_id`, `repositorio_id`, `tipo_herramienta_id`) VALUES
(1, 'Diccionario de la lengua española', 'Versión electrónica del Diccionario de la lengua española, obra lexicográfica académica por excelencia.', NULL, NULL, NULL, NULL, 1, 1, 1),
(2, 'UCT Diccionario Abreviado Mapudungun - Españo', 'Contiene un listado de entradas léxicas del mapudungun, ordenado alfabéticamente, con una versión abreviada de sus significados en español e inglés.', NULL, NULL, NULL, NULL, 2, 1, 1),
(3, 'Glosario de términos geográficos', 'A. Acantilado: Costa alta y escarpada, de altura variable. Accesibilidad: Capacidad potencial de establecer contactos físicos y/o sociales', NULL, NULL, NULL, NULL, 3, 2, 1),
(28, 'gggggggggg', 'gggggggggggggggggg', NULL, '2015-11-06 15:57:25', '2015-11-06 15:56:06', NULL, 28, 1, 1);

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
-- Estructura de tabla para la tabla `institucion`
--

CREATE TABLE IF NOT EXISTS `institucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `vision` varchar(45) DEFAULT NULL,
  `mision` varchar(45) DEFAULT NULL,
  `acreditada` bit(1) DEFAULT NULL,
  `fecha_inicio_acreditacion` datetime DEFAULT NULL,
  `fecha_termino_acreditacion` datetime DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `estado_institucion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_institucion_estado_institucion1_idx` (`estado_institucion_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Volcado de datos para la tabla `institucion`
--

INSERT INTO `institucion` (`id`, `nombre`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_institucion_id`) VALUES
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
(13, 'etc tv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
(2, 1),
(1, 2),
(2, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `institucion_has_rol_usuario`
--

CREATE TABLE IF NOT EXISTS `institucion_has_rol_usuario` (
  `institucion_id` int(11) NOT NULL,
  `rol_usuario_id` int(11) NOT NULL,
  PRIMARY KEY (`institucion_id`,`rol_usuario_id`),
  KEY `fk_institucion_has_rol_usuario_rol_usuario1_idx` (`rol_usuario_id`),
  KEY `fk_institucion_has_rol_usuario_institucion1_idx` (`institucion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `institucion_has_rol_usuario`
--

INSERT INTO `institucion_has_rol_usuario` (`institucion_id`, `rol_usuario_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 186),
(1, 187),
(1, 188);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `link_interes`
--

CREATE TABLE IF NOT EXISTS `link_interes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `fecha_elminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='			' AUTO_INCREMENT=44 ;

--
-- Volcado de datos para la tabla `modelo_aprendizaje`
--

INSERT INTO `modelo_aprendizaje` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`) VALUES
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='	' AUTO_INCREMENT=40 ;

--
-- Volcado de datos para la tabla `modelo_aprendizaje_has_herramienta`
--

INSERT INTO `modelo_aprendizaje_has_herramienta` (`id`, `trabajo_grupal`, `archivo_recurso`, `link_interes`, `glosario`, `contenido_libre`, `foro`, `evaluacion`, `autoevaluacion`, `proyecto`, `recepcion_trabajo`, `evaluacion_no_objetiva`, `modelo_aprendizaje_id`) VALUES
(32, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 36),
(33, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 37),
(34, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 38),
(35, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 39),
(36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 40),
(37, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 41),
(38, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 42),
(39, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 43);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE IF NOT EXISTS `modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `estado_modulo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_modulo_estado_modulo1_idx` (`estado_modulo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `estado_modulo_id`) VALUES
(1, 'matematicas', 'des-matematicas', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL),
(2, 'lenguaje', 'des-lenguaje', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL),
(3, 'calculo', 'des-calculo', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL),
(4, 'historia', 'des-historia', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL),
(5, 'algebra', 'des-algebra', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL),
(6, 'dibujo', 'des-dibujo', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL),
(7, 'estadistica', 'des-estadistica', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pais`
--

CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `pais`
--

INSERT INTO `pais` (`id`, `nombre`, `codigo`) VALUES
(1, 'chile', 'chile02'),
(2, 'brasil', 'ar34'),
(3, 'dasdsadsad', 'sadsadsad'),
(4, 'uiituiooru', 'oriuiorutre');

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
-- Estructura de tabla para la tabla `pregunta_login`
--

CREATE TABLE IF NOT EXISTS `pregunta_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `pregunta_login`
--

INSERT INTO `pregunta_login` (`id`, `pregunta`) VALUES
(1, 'donde naciste'),
(2, 'nombre de tu mama'),
(3, 'nombre de tu perro'),
(4, 'mejor amigo '),
(5, 'interes'),
(6, 'ola que haces'),
(7, 'fgdsfgdfgdfgdfd');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `programa_academico`
--

INSERT INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`, `entidad_id`, `institucion_id`, `estado_programa_academico_id`) VALUES
(1, 'ingenieria en informatica', 'des-info', '1.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', 1, NULL, NULL),
(2, 'diseño', 'des-diseño', '1.5', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, 2, NULL),
(3, 'derecho', 'des-derecho', '2.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', 2, NULL, NULL),
(4, 'juegos', 'des-juegos', '3.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, 5, NULL),
(5, 'redes', 'des-redes', '4.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49', NULL, 2, NULL);

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
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7);

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
  `descripcion` text,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modifcacion` datetime DEFAULT NULL,
  `fecha_eliminacion` datetime DEFAULT NULL,
  `fecha_acceso` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Volcado de datos para la tabla `region`
--

INSERT INTO `region` (`id`, `nombre`, `codigo`, `pais_id`) VALUES
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
('o9k32vus9jak0skbf22ntl34k3', 1446839872, 0x30373333353130383865316330316231363262316162353236386465653766615f5f72657475726e55726c7c733a34333a222f7465737472656b6f2f7265706f7369746f72696f2f676c6f736172696f2f7570646174653f69643d3237223b30373333353130383865316330316231363262316162353236386465653766615f5f69647c733a313a2231223b30373333353130383865316330316231363262316162353236386465653766615f5f6e616d657c733a363a22637265796573223b30373333353130383865316330316231363262316162353236386465653766615f5f7374617465737c613a303a7b7d696e737469747563696f6e49647c733a313a2231223b696e737469747563696f6e4e6f6d6272657c733a343a227574656d223b696e737469747563696f6e566973696f6e7c733a363a22766973696f6e223b696e737469747563696f6e4d6973696f6e7c733a363a226d6973696f6e223b696e737469747563696f6e416372656469746164617c733a313a2230223b696e737469747563696f6e4665636861496e6963696f416372656469746163696f6e7c733a31393a22323031352d30382d30362031353a34303a3332223b696e737469747563696f6e46656368615465726d696e6f416372656469746163696f6e7c733a31393a22323031352d30382d30362031353a34303a3332223b7265706f7369746f72696f7c4f3a31313a225265706f7369746f72696f223a31313a7b733a31393a2200434163746976655265636f7264005f6e6577223b623a303b733a32363a2200434163746976655265636f7264005f61747472696275746573223b613a31303a7b733a323a226964223b733a313a2231223b733a363a226e6f6d627265223b733a31343a223141207265706f7369746f72696f223b733a31313a226465736372697063696f6e223b733a31343a223141207265706f7369746f72696f223b733a31323a2266656368615f61636365736f223b4e3b733a31383a2266656368615f6d6f64696669636163696f6e223b4e3b733a31343a2266656368615f6372656163696f6e223b4e3b733a31373a2266656368615f656c696d696e6163696f6e223b4e3b733a31393a227469706f5f7265706f7369746f72696f5f6964223b733a313a2231223b733a32313a226d6f64656c6f5f617072656e64697a616a655f6964223b733a323a223433223b733a32313a22677569615f696e737472756363696f6e616c5f6964223b4e3b7d733a32333a2200434163746976655265636f7264005f72656c61746564223b613a303a7b7d733a31373a2200434163746976655265636f7264005f63223b4e3b733a31383a2200434163746976655265636f7264005f706b223b733a313a2231223b733a32313a2200434163746976655265636f7264005f616c696173223b733a313a2274223b733a31353a2200434d6f64656c005f6572726f7273223b613a303a7b7d733a31393a2200434d6f64656c005f76616c696461746f7273223b4e3b733a31373a2200434d6f64656c005f7363656e6172696f223b733a363a22757064617465223b733a31343a220043436f6d706f6e656e74005f65223b4e3b733a31343a220043436f6d706f6e656e74005f6d223b4e3b7d);

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
  PRIMARY KEY (`id`),
  KEY `fk_repositorio_tipo_repositorio1_idx` (`tipo_repositorio_id`),
  KEY `fk_repositorio_modelo_aprendizaje1_idx` (`modelo_aprendizaje_id`),
  KEY `fk_repositorio_guia_instruccional1_idx` (`guia_instruccional_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='\n	\n	\n	\n\n\n	\n\n	\n	' AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `repositorio`
--

INSERT INTO `repositorio` (`id`, `nombre`, `descripcion`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `fecha_eliminacion`, `tipo_repositorio_id`, `modelo_aprendizaje_id`, `guia_instruccional_id`) VALUES
(1, '1A repositorio', '1A repositorio', NULL, NULL, NULL, NULL, 1, 43, NULL),
(2, '2B repositorio', '2B repositorio', NULL, NULL, NULL, NULL, 1, 42, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `rol_administrador`
--

INSERT INTO `rol_administrador` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superadministrador', NULL),
(5, 'root', ''),
(6, 'supervisor usuario', 'usuario y rol usuario'),
(7, 'mantenedor', 'descripcion mantenedor'),
(8, '', '');

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
(1, 'admin_usuario_administrador'),
(5, 'admin_aplicacion'),
(5, 'admin_rol_usuario'),
(5, 'admin_usuario'),
(5, 'admin_usuario_administrador'),
(6, 'admin_rol_usuario'),
(6, 'admin_usuario');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=190 ;

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`id`, `nombre`, `descripcion`, `tipo`, `rol_usuario_general_id`, `fecha_creacion`, `fecha_eliminacion`, `fecha_acceso`, `fecha_modificacion`) VALUES
(1, 'superusuario', 'rol superusuario', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'profesor', 'rol profesor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(3, 'alumno', 'rol alumno', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(4, 'ayudante', 'rol ayudante', 'rol_usuario_general', NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'inspector', 'rol inspector', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(6, 'percutor', 'rol percutor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(7, 'constructor', 'rol constructor', 'rol_usuario_general', NULL, NULL, NULL, NULL, NULL),
(186, 'profesor', 'rol profesor', 'rol_usuario_institucion', 2, '2015-10-15 11:31:41', NULL, NULL, '2015-10-15 11:31:41'),
(187, 'alumno', 'rol alumno', 'rol_usuario_institucion', 3, '2015-10-15 11:31:42', NULL, NULL, '2015-10-15 11:31:42'),
(188, 'ayudante', 'rol ayudante', 'rol_usuario_institucion', 4, '2015-10-15 11:31:44', NULL, NULL, '2015-10-15 11:31:44'),
(189, 'destructor', 'rol destructor', 'rol_usuario_general', NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

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
(186, 1),
(1, 2),
(2, 2),
(186, 2),
(1, 3),
(2, 3),
(186, 3),
(1, 4),
(2, 4),
(186, 4),
(1, 5),
(2, 5),
(186, 5),
(1, 6),
(2, 6),
(186, 6),
(1, 7),
(2, 7),
(186, 7),
(1, 8),
(2, 8),
(186, 8),
(1, 9),
(2, 9),
(186, 9),
(1, 10),
(2, 10),
(186, 10),
(1, 11),
(2, 11),
(186, 11),
(1, 12),
(2, 12),
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seccion`
--

CREATE TABLE IF NOT EXISTS `seccion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `jornada` varchar(45) DEFAULT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  `modulo_id` int(11) NOT NULL,
  `estado_seccion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seccion_modulo1_idx` (`modulo_id`),
  KEY `fk_seccion_estado_seccion1_idx` (`estado_seccion_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`id`, `nombre`, `jornada`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `modulo_id`, `estado_seccion_id`) VALUES
(6, 'mnbvbnmvc', 'nmcvbbnmvxc', 'cmnvbnmcbvx', '2015-08-12 11:38:53', '2015-08-12 11:39:57', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) DEFAULT NULL,
  `institucion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_herramienta`
--

CREATE TABLE IF NOT EXISTS `tipo_herramienta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `tipo_herramienta`
--

INSERT INTO `tipo_herramienta` (`id`, `nombre`) VALUES
(1, 'herramienta_troncal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_repositorio`
--

CREATE TABLE IF NOT EXISTS `tipo_repositorio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='				' AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `tipo_repositorio`
--

INSERT INTO `tipo_repositorio` (`id`, `descripcion`) VALUES
(1, 'repositorio_troncal');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=204 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, `clave`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`, `estado_usuario_id`) VALUES
(1, 'creyes', '123', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 1),
(2, 'francisco', '123', '2015-09-09 12:23:17', '2015-09-09 12:23:17', '2015-09-09 12:23:17', 1),
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
(203, '3', 'usuario', '0000-00-00 00:00:00', '2015-08-07 11:05:41', '2015-08-07 11:05:41', NULL);

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
(2, 6);

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
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 2),
(6, 1);

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
(1, 1),
(4, 2),
(5, 2),
(2, 3),
(3, 3),
(3, 186),
(4, 186);

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
  ADD CONSTRAINT `fk_entidad_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entidad_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_entidad_estado_entidad1` FOREIGN KEY (`estado_entidad_id`) REFERENCES `estado_entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `escritorio_administrador`
--
ALTER TABLE `escritorio_administrador`
  ADD CONSTRAINT `fk_escritorio_administrador_usuario_administrador1` FOREIGN KEY (`usuario_administrador_id`) REFERENCES `usuario_administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `glosario`
--
ALTER TABLE `glosario`
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
  ADD CONSTRAINT `fk_herramienta_repositorio1` FOREIGN KEY (`repositorio_id`) REFERENCES `repositorio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
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
  ADD CONSTRAINT `fk_institucion_estado_institucion1` FOREIGN KEY (`estado_institucion_id`) REFERENCES `estado_institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `institucion_has_repositorio`
--
ALTER TABLE `institucion_has_repositorio`
  ADD CONSTRAINT `fk_institucion_has_repositorio_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_institucion_has_repositorio_repositorio1` FOREIGN KEY (`repositorio_id`) REFERENCES `repositorio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `institucion_has_rol_usuario`
--
ALTER TABLE `institucion_has_rol_usuario`
  ADD CONSTRAINT `fk_institucion_has_rol_usuario_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_institucion_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modelo_aprendizaje_has_herramienta`
--
ALTER TABLE `modelo_aprendizaje_has_herramienta`
  ADD CONSTRAINT `fk_modelo_aprendizaje_has_herramienta_modelo_aprendizaje1` FOREIGN KEY (`modelo_aprendizaje_id`) REFERENCES `modelo_aprendizaje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD CONSTRAINT `fk_modulo_estado_modulo1` FOREIGN KEY (`estado_modulo_id`) REFERENCES `estado_modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_seccion_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_seccion_estado_seccion1` FOREIGN KEY (`estado_seccion_id`) REFERENCES `estado_seccion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Filtros para la tabla `usuario_has_rol_usuario`
--
ALTER TABLE `usuario_has_rol_usuario`
  ADD CONSTRAINT `fk_usuario_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
