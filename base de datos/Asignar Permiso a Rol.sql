-------------------------------------------------------------------------------------------------
--ASIGNAR PERMISO A ROL--
INSERT INTO rol_administrador_has_authitem_permiso_administrador (rol_administrador_id,authitem_permiso_administrador_name) 
SELECT RA.id,P.id
FROM 	
		rol_administrador RA,
        authitem_permiso_administrador P
WHERE  RA.id=3
AND P.name=''