<?php

class RolusuariohasauthitempermisousuarioController extends Controller
{
    public function actionAsignarpermisorol()
    {
        Yii::import('application.modules.admin_rol_usuario.models.RolUsuario');
        
        $modelo_rol_usuario = new RolUsuario();

        $objetoRolArray = Array();
        $preSelectedCategories = Array();
        $modelo = new RolUsuarioHasAuthitemPermisoUsuario();
        
        if(isset($_GET['id'])){
            $idRol = $_GET['id'];
            $rol_usuario = $modelo_rol_usuario->findByPk((int)$idRol);                     
        }
        
        $listado = $modelo->listaRolPermiso($idRol);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new RolUsuarioHasAuthitemPermisoUsuario('myscenario');
            if((int) $item['rol_usuario_id'] != 0 ){
                $preSelectedCategories[] =  (string) $item['authitem_permiso_usuario_name'];
            }
            else{ 
                $preSelectedCategories[] =  NULL;                             
            }
                    
            $tmpObj->authitem_permiso_usuario_name = (string)$item['authitem_permiso_usuario_name'];
            $tmpObj->rol_usuario_id = (int)$item['rol_usuario_id'];                              
            $objetoRolArray[] = $tmpObj;
        }        
            
        $this->render('asignarpermisorol',array('model'=>$modelo,'objeto'=>$objetoRolArray,'seleccionados'=>$preSelectedCategories,'idRol'=>$idRol,'rol_usuario'=>$rol_usuario));
    }
    
    public function actionAsignarPermisos() {                     
            
        $permiso_rol = new RolUsuarioHasAuthitemPermisoUsuario();
        $listadoAsignarPermiso = Array();
        $listadoDesAsignarPermiso = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-authitem_permiso_usuario_name-list']);
        foreach(unserialize($_POST['datos-authitem_permiso_usuario_name-select']) as $permisos) {   
            $listadoOriginal[] = $permisos;
        }
        
        $rolId = $_POST['datos-rol-id'];    
        var_dump($rolId);
        $permisoName = Array(); 
                
        if(isset($_POST['authitem_permiso_usuario_name'])) {    
            $permisoName = $_POST['authitem_permiso_usuario_name'];                
            for( $i=0; $i < count($listadoOriginal); $i++) {
                if( in_array( $listadoOriginal[$i],$permisoName ) ) {
                        $listadoAsignarPermiso[] = $listadoOriginal[$i];
                    }
                else {
                        $listadoDesAsignarPermiso[] = $listadoOriginal[$i];
                    }
            }
                
            if( count($listadoAsignarPermiso) )
                $permiso_rol->asignaRolPermiso($listadoAsignarPermiso, $rolId);           
                
            if( count( $listadoDesAsignarPermiso) )
                $permiso_rol->desasignaRolPermiso($listadoDesAsignarPermiso, $rolId);        
        }
        else{
            $permiso_rol->desasignaRolPermiso($listadoOriginal,$rolId);                
        }       
        $this->redirect(array("asignarpermisorol",'id'=>$rolId));
    }
}