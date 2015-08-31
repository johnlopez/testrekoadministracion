-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 31-08-2015 a las 20:21:07
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionaplicacion_actualizar_aplicacion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionaplicacion_agregar_aplicacion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioncurricular_actualizar_modulo`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioncurricular_actualizar_programa_academico`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioncurricular_actualizar_seccion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioncurricular_agregar_modulo`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioncurricular_agregar_programa_academico`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioncurricular_agregar_seccion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioninstitucion_actualizar_entidad`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioninstitucion_actualizar_institucion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioninstitucion_agregar_entidad`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracioninstitucion_agregar_institucion`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_dato_academico`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_dato_laboral`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_dato_login`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_dato_personal`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_logica_estado_usuario`(
nuevo_id int,
nuevo_estado varchar(50)
)
begin
update logica_estado_usuario set
id = nuevo_id,
estado = nuevo_estado
where id = nuevo_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_pais`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_region`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_actualizar_usuario`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_dato_academico`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_dato_laboral`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_dato_login`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_dato_personal`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_logica_estado_usuario`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_pais`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_region`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_agregar_usuario`(
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_administracionusuario_listar_usuario`()
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_asigna_rol_institucion`(lista_institucion_id varchar(255), lista_largo int, nuevo_rol_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_institucion_id int default NULL;
DECLARE institucion_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_institucion_id = getValueFromArray(lista_institucion_id, ',', x);	
    SELECT institucion_id INTO institucion_id_tmp FROM institucion_has_rol_usuario WHERE institucion_id = nuevo_institucion_id AND rol_usuario_id = nuevo_rol_id;
    IF (institucion_id_tmp IS NULL) THEN
		INSERT INTO institucion_has_rol_usuario (`institucion_id`,`rol_usuario_id`) VALUES (nuevo_institucion_id,nuevo_rol_id);
	ELSE
		SET institucion_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_institucion_id, institucion_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_desasigna_rol_institucion`(lista_institucion_id varchar(255), lista_largo int, nuevo_rol_id int)
BEGIN
DECLARE x int DEFAULT 0;
DECLARE nuevo_institucion_id int default NULL;
DECLARE institucion_id_tmp int default NULL;
DECLARE resultado BOOLEAN DEFAULT TRUE;
WHILE x < lista_largo DO
	SET nuevo_institucion_id = getValueFromArray(lista_institucion_id, ',', x);	
    SELECT institucion_id INTO institucion_id_tmp FROM institucion_has_rol_usuario WHERE institucion_id = nuevo_institucion_id AND rol_usuario_id = nuevo_rol_id;
    IF (institucion_id_tmp IS NOT NULL) THEN
		DELETE FROM institucion_has_rol_usuario WHERE rol_usuario_id = nuevo_rol_id AND institucion_id = nuevo_institucion_id;
	ELSE
		SET institucion_id_tmp = NULL;
    END IF;    
    SET x = x +1;
END WHILE;

SELECT resultado, nuevo_institucion_id, institucion_id_tmp;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_admin_rol_usuario_lista_rol_institucion`(nuevo_rol_id int(11))
BEGIN
SELECT A.nombre,B.rol_usuario_id,B.institucion_id FROM `rol_usuario` A, `institucion_has_rol_usuario` B 
WHERE A.id = B.rol_usuario_id
AND A.id = nuevo_rol_id UNION SELECT null,null,A.id FROM (`institucion` A LEFT JOIN `institucion_has_rol_usuario` B ON A.id = B.institucion_id AND B.rol_usuario_id = nuevo_rol_id)
WHERE B.institucion_id is NULL
order by institucion_id;
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
('repositorio', 2, NULL, NULL, NULL);

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
(1, 'ola ', 'lola', 12, 12, 'saldksj', 'jdklj', 'saljdklj', 'sajd', 1),
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `dato_personal`
--

INSERT INTO `dato_personal` (`id`, `primer_nombre`, `segundo_nombre`, `apellido_paterno`, `apellido_materno`, `fecha_nacimiento`, `edad`, `rut`, `digito_verificador`, `direccion_personal`, `numero_casa`, `telefono_personal`, `celular_personal`, `comuna_personal`, `ciudad_personal`, `interes`, `estado_civil`, `idioma`, `nacionalidad`, `usuario_id`) VALUES
(1, 'juan', 'diego', 'kjhdkjskjd', 'sakjdsakj', '2015-08-10 16:55:05', 5454, 54545, 4545, 'asdkj', 454, 545, 545, 'akjsh', 'kjshakjsh', 'askljasklj', 'alsjj', 'alskjasklj', 'asjsajklsaj', 1),
(2, 'kjhxjhzkj<xhKHZ<KJXH', 'askjhaskh', 'skjdhskjsdh', 'askjha', '2015-08-10 17:04:11', 2121, 2121, 2121, 'askjaks', 454, 5454, 545, 'ajhsajsajhsk', 'akjshajksh', 'akjshakjsh', 'kjahsakjhs', 'kajshkjasjh', 'kjhakjshaks', 1),
(3, 'kjhxjhzkj<xhKHZ<KJXH', 'askjhaskh', 'skjdhskjsdh', 'askjha', '2015-08-10 17:04:11', 2121, 2121, 2121, 'askjaks', 454, 5454, 545, 'ajhsajsajhsk', 'akjshajksh', 'akjshakjsh', 'kjahsakjhs', 'kajshkjasjh', 'kjhakjshaks', 1),
(4, 'kljsldkjsadjkl', 'slkjdksjd', 'skljdkljd', 'skldjsakd', '2015-08-11 15:25:14', 45445, 455454, 5454, 'asljajskl', 44, 5454, 5454, 'lksjakjs', 'lasjsj', 'alsjasklj', 'askljajsk', 'akjaskjl', 'asjasljl', 5),
(5, 'klsklsjklsd', 'iowuerwuo', 'iowuoiwueqoi', 'wiqowioe', '2015-08-12 10:28:29', 55454, 54545, 54545, 'skjdwkjkjl', 54545, 545454, 545454, 'sklajdkjsdkl', 'slkjdklsjdkljs', 'sjdskljd', 'wsjdklsjdkl', 'wsajdkljwskld', 'wljewjqeklj', 4);

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
  PRIMARY KEY (`id`),
  KEY `fk_entidad_institucion1_idx` (`institucion_id`),
  KEY `fk_entidad_entidad1_idx` (`entidad_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `entidad`
--

INSERT INTO `entidad` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `institucion_id`, `entidad_id`) VALUES
(3, 'gfgfgfg', 'fgfgfdg', '2015-08-12 11:29:33', '2015-08-12 14:49:20', 2, 3),
(5, 'nmxbzxnmbnmbzxcnmb', 'znmxcbznmxcbznmx', '2015-08-12 12:16:42', NULL, 1, 3);

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
-- Estructura de tabla para la tabla `estado_usuario`
--

CREATE TABLE IF NOT EXISTS `estado_usuario` (
  `logica_estado_usuario_id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  KEY `fk_estado_usuario_logica_estado_usuario1_idx` (`logica_estado_usuario_id`),
  KEY `fk_estado_usuario_usuario1_idx` (`usuario_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `estado_usuario`
--

INSERT INTO `estado_usuario` (`logica_estado_usuario_id`, `usuario_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(1, 186),
(1, 187),
(1, 1),
(2, 2),
(3, 3),
(1, 186),
(1, 187),
(1, 1),
(2, 2),
(3, 3),
(1, 186),
(1, 187),
(1, 1),
(2, 2),
(3, 3),
(1, 186),
(1, 187);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `institucion`
--

INSERT INTO `institucion` (`id`, `nombre`, `vision`, `mision`, `acreditada`, `fecha_inicio_acreditacion`, `fecha_termino_acreditacion`, `descripcion`, `fecha_creacion`, `fecha_modificacion`) VALUES
(1, 'utem', 'vision', 'mision', b'0', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 'ajhsjah', '2015-08-06 15:40:32', '2015-08-06 15:40:32'),
(2, 'duoc', 'vision', 'mision', b'1', '2015-08-06 15:40:32', '2015-08-06 15:40:32', 'kjahsa', '2015-08-06 15:40:32', '2015-08-06 15:40:32'),
(3, 'usash', 'vision', 'mision', b'1', '2015-08-10 11:48:35', '2015-08-10 11:48:35', 'descripcion', NULL, NULL),
(4, 'catolica', 'vision', 'sakjhdksj', b'1', '2015-08-10 12:11:56', '2015-08-10 12:11:56', 'sdsdsdasd', '2015-08-10 12:16:53', '2015-08-10 12:22:20'),
(5, 'udp', 'kljsakdljsadl', 'olaolaolaolaola', b'1', '2015-08-12 10:28:29', '2015-08-12 10:28:29', 'kjsdjkjsahdkjsd', '2015-08-12 10:33:26', '2015-08-12 10:33:47');

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
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logica_estado_usuario`
--

CREATE TABLE IF NOT EXISTS `logica_estado_usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `logica_estado_usuario`
--

INSERT INTO `logica_estado_usuario` (`id`, `estado`) VALUES
(1, 'disponible'),
(2, 'en espera'),
(3, 'eliminado');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`id`, `nombre`, `descripcion`, `fecha_creacion`, `fecha_modificacion`) VALUES
(1, 'matematicas', 'des-matematicas', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(2, 'lenguaje', 'des-lenguaje', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(3, 'calculo', 'des-calculo', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(4, 'historia', 'des-historia', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(5, 'algebra', 'des-algebra', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(6, 'dibujo', 'des-dibujo', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(7, 'estadistica', 'des-estadistica', '2015-08-11 15:59:49', '2015-08-11 15:59:49');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `pregunta_login`
--

INSERT INTO `pregunta_login` (`id`, `pregunta`) VALUES
(1, 'donde naciste'),
(2, 'nombre de tu mama'),
(3, 'nombre de tu perro'),
(4, 'mejor amigo '),
(5, 'interes'),
(6, 'ola que haces');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `programa_academico`
--

INSERT INTO `programa_academico` (`id`, `nombre`, `descripcion`, `version`, `fecha_creacion`, `fecha_modificacion`) VALUES
(1, 'ingenieria en informatica', 'des-info', '1.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(2, 'diseño', 'des-diseño', '1.5', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(3, 'derecho', 'des-derecho', '2.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49'),
(4, 'juegos', 'des-juegos', '3.0', '2015-08-11 15:59:49', '2015-08-11 15:59:49');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='			' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyecto_master`
--

CREATE TABLE IF NOT EXISTS `proyecto_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepcion_trabajo`
--

CREATE TABLE IF NOT EXISTS `recepcion_trabajo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='\n	\n	\n	\n	\n\n		\n	' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recepcion_trabajo_master`
--

CREATE TABLE IF NOT EXISTS `recepcion_trabajo_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `region`
--

INSERT INTO `region` (`id`, `nombre`, `codigo`, `pais_id`) VALUES
(2, 'santiago', 'san54', 1),
(3, 'la plata', 'laplata23', 2),
(4, 'kjjdkskdhsakj', 'kjsahdkjsahdak', 1),
(5, 'sadsadad', 'sdsadsad', 2),
(6, 'iowueuweqo', 'owiueiowuqe', 3),
(7, 'akjssajh', 'kjahskjhsk', 2),
(8, 'metropolitana', 'suecia', 1),
(9, 'jhghjsgdsjd', 'jhsdjhhsdhsd', 1);

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
(5, 'admin_rol_usuario'),
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
(6, 43),
(1, 44),
(6, 44),
(1, 45),
(6, 45),
(1, 46),
(6, 46),
(1, 47),
(6, 47),
(1, 48),
(6, 48),
(1, 49),
(6, 49),
(1, 50),
(6, 50),
(1, 51),
(6, 51),
(1, 52),
(6, 52),
(1, 53),
(6, 53),
(1, 54),
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `rol_usuario`
--

INSERT INTO `rol_usuario` (`id`, `nombre`, `descripcion`) VALUES
(1, 'superusuario', 'rol superusuario'),
(2, 'profesor', 'rol profesor'),
(3, 'alumno', 'rol alumno');

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
(1, 'repositorio'),
(2, 'aula'),
(2, 'repositorio'),
(3, 'aula');

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
  PRIMARY KEY (`id`),
  KEY `fk_seccion_modulo1_idx` (`modulo_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `seccion`
--

INSERT INTO `seccion` (`id`, `nombre`, `jornada`, `descripcion`, `fecha_creacion`, `fecha_modificacion`, `modulo_id`) VALUES
(6, 'mnbvbnmvc', 'nmcvbbnmvxc', 'cmnvbnmcbvx', '2015-08-12 11:38:53', '2015-08-12 11:39:57', 1);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=204 ;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `usuario`, `clave`, `fecha_acceso`, `fecha_modificacion`, `fecha_creacion`) VALUES
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
(3, 3);

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
  ADD CONSTRAINT `fk_entidad_entidad1` FOREIGN KEY (`entidad_id`) REFERENCES `entidad` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Filtros para la tabla `estado_usuario`
--
ALTER TABLE `estado_usuario`
  ADD CONSTRAINT `fk_estado_usuario_logica_estado_usuario1` FOREIGN KEY (`logica_estado_usuario_id`) REFERENCES `logica_estado_usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_estado_usuario_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `icono_aplicacion_administrador`
--
ALTER TABLE `icono_aplicacion_administrador`
  ADD CONSTRAINT `fk_icono_aplicacion_administrador_authitem_permiso_administra1` FOREIGN KEY (`authitem_permiso_administrador_name`) REFERENCES `authitem_permiso_administrador` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `institucion_has_rol_usuario`
--
ALTER TABLE `institucion_has_rol_usuario`
  ADD CONSTRAINT `fk_institucion_has_rol_usuario_institucion1` FOREIGN KEY (`institucion_id`) REFERENCES `institucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_institucion_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_seccion_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `fk_usuario_has_rol_usuario_usuario1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_has_rol_usuario_rol_usuario1` FOREIGN KEY (`rol_usuario_id`) REFERENCES `rol_usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
