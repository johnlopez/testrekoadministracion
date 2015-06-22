--ASIGNAR PERMISO A USUARIO SEGUN EL ROL ASIGNADO
INSERT INTO authassignment_administrador (itemname,userid) 
SELECT P.name, U.id
FROM 
		usuario_administrador U,
        usuario_administrador_has_rol_administrador UR,
        rol_administrador R,
        rol_administrador_has_authitem_permiso_administrador RP,
        authitem_permiso_administrador P

WHERE U.id = UR.usuario_administrador_id
AND R.id = UR.rol_administrador_id
AND RP.rol_administrador_id= R.id
AND RP.authitem_name = P.name

AND R.id=2
