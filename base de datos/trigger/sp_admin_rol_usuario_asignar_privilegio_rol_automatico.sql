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
END