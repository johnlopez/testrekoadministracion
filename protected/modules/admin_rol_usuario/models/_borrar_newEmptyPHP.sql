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
    INSERT INTO rol_usuario(nombre,descripcion,tipo,fecha_creacion,fecha_eliminacion,fecha_acceso,fecha_modificacion) 
	SELECT 
			R.nombre,
			R.descripcion,
			'rol_usuario',
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
END WHILE;

SELECT resultado, nuevo_rol_id, rol_id_tmp;

END