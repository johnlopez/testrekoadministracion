CREATE DEFINER=`root`@`localhost` TRIGGER `testreko`.`rol_usuario_has_authitem_permiso_usuario_AFTER_INSERT` AFTER INSERT ON `rol_usuario_has_authitem_permiso_usuario` FOR EACH ROW
BEGIN
	CALL sp_admin_rol_usuario_asignar_privilegio_rol_automatico (new.rol_usuario_id,new.authitem_permiso_usuario_name);
END