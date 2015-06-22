SELECT PRIV.*
FROM 	
		dato_login_administrador D,
        usuario_administrador U,
	    usuario_administrador_has_rol_administrador UR,
		rol_administrador R,
        rol_administrador_has_permiso_administrador RP,
        permiso_administrador P,
        permiso_administrador_has_privilegio_administrador PP,
        privilegio_administrador PRIV

WHERE U.dato_login_administrador_id = D.id
AND UR.usuario_administrador_id = U.id
AND UR.rol_administrador_id = R.id
AND RP.rol_administrador_id = R.id
AND RP.permiso_administrador_id = P.id
AND PP.permiso_administrador_id = P.id
AND PP.privilegio_administrador_id = PRIV.id

AND D.usuario='diego'
AND P.nombre='administracionusuarioadministrador'
----------------------------------------------------------------------------------------------------------
SELECT PRIV.nombre
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

AND U.id = 1
AND P.name = 'administracion_rol_administrador'
AND C.nombre = 'AuthitemPermisoAdministrador'
AND PRIV.nombre = 'index'



        
        
        
        