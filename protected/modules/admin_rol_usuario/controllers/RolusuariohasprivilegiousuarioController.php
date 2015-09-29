<?php

class RolusuariohasprivilegiousuarioController extends Controller
{
        public function actionAsignarprivilegiorol()
        {
            Yii::import('application.modules.admin_rol_usuario.models.RolUsuario');

            $modelo_rol_usuario = new RolUsuario();

            $objetoRolArray = Array();
            $preSelectedCategories = Array();
            $modelo = new RolUsuarioHasPrivilegioUsuario();

            if(isset($_GET['rol_usuario_id'])){
                $idRol = $_GET['rol_usuario_id'];
                
                $rol_usuario_nombre = $_GET['rol_usuario_nombre'];
                $authitem_permiso_usuario_name = $_GET['authitem_permiso_usuario_name'];                            
            }
            
//            $listado = $modelo->listaRolPrivilegio($idRol);
            $listado = $modelo->listaRolPermisoPrivilegio($idRol,$authitem_permiso_usuario_name);


            foreach($listado as $item) {                   
                $tmpObj = new RolUsuarioHasPrivilegioUsuario('myscenario');
                if((int) $item['rol_usuario_id'] != 0 ){
                    $preSelectedCategories[] =  (string) $item['privilegio_usuario_id'];
                }
                else{ 
                    $preSelectedCategories[] =  NULL;                             
                }

                $tmpObj->privilegio_usuario_id = (string)$item['privilegio_usuario_id'];
                $tmpObj->rol_usuario_id = (int)$item['rol_usuario_id'];                              
                $objetoRolArray[] = $tmpObj;
            }        

            $this->render('asignarprivilegiorol',
                    array(
                            'model'=>$modelo,'objeto'=>$objetoRolArray,
                            'seleccionados'=>$preSelectedCategories,
                            'idRol'=>$idRol,
                        
                            'rol_usuario_nombre'=>$rol_usuario_nombre,
                            'authitem_permiso_usuario_name'=>$authitem_permiso_usuario_name,                       
                    )
            );                                 
      
        }

        public function actionAsignarPrivilegios() {                     

            $privilegio_rol = new RolUsuarioHasPrivilegioUsuario();
            $listadoAsignarPrivilegio = Array();
            $listadoDesAsignarPrivilegio = Array();

            $listadoTotal = unserialize($_POST['datos-privilegio_usuario_id-list']);
            foreach(unserialize($_POST['datos-privilegio_usuario_id-select']) as $privilegios) {   
                $listadoOriginal[] = $privilegios;
            }

            $rolId = $_POST['datos-rol-id'];
            $rol_usuario_nombre = $_POST['rol_usuario_nombre'];
            $authitem_permiso_usuario_name = $_POST['authitem_permiso_usuario_name'];
            var_dump($rolId);
            $privilegioId = Array(); 

            if(isset($_POST['privilegio_usuario_id'])) {    
                $privilegioId = $_POST['privilegio_usuario_id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$privilegioId ) ) {
                            $listadoAsignarPrivilegio[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarPrivilegio[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarPrivilegio) )
                    $privilegio_rol->asignaRolPrivilegio($listadoAsignarPrivilegio, $rolId);           

                if( count( $listadoDesAsignarPrivilegio) )
                    $privilegio_rol->desasignaRolPrivilegio($listadoDesAsignarPrivilegio, $rolId);        
            }
            else{
                $privilegio_rol->desasignaRolPrivilegio($listadoOriginal,$rolId);                
            }       
            $this->redirect(
                    array("asignarprivilegiorol",
                            'rol_usuario_id'=>$rolId,
                            'rol_usuario_nombre'=>$rol_usuario_nombre,
                            'authitem_permiso_usuario_name'=>$authitem_permiso_usuario_name,
                    )
            );
        }

	// Uncomment the following methods and override them if needed
	/*
	public function filters()
	{
		// return the filter configuration for this controller, e.g.:
		return array(
			'inlineFilterName',
			array(
				'class'=>'path.to.FilterClass',
				'propertyName'=>'propertyValue',
			),
		);
	}

	public function actions()
	{
		// return external action classes, e.g.:
		return array(
			'action1'=>'path.to.ActionClass',
			'action2'=>array(
				'class'=>'path.to.AnotherActionClass',
				'propertyName'=>'propertyValue',
			),
		);
	}
	*/
}