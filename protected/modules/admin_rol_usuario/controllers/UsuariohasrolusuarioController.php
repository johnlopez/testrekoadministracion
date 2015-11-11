<?php

class UsuariohasrolusuarioController extends Controller
{
	public function actionIndex()
	{
		$this->render('index');
	}
        
        public function actionAdminrolusuarioinstitucion()
        {   
            if(isset($_GET['institucion_id'])){
                $institucionId = $_GET['institucion_id'];
                $institucionNombre = $_GET['institucion_nombre'];

                $model = new InstitucionHasRolUsuario();

                $rolUsuarioInstitucion = $model->listarRolUsuarioInstitucion($institucionId);

                $this->render('adminrolusuarioinstitucion',array(            
                    'institucionId'=>$institucionId,
                    'institucionNombre'=>$institucionNombre,
                    'rolUsuarioInstitucion'=>$rolUsuarioInstitucion,
                ));
            }            
        }   
        
        public function actionAsignarusuariorolusuario()
        { 
            $objetoRolUsuarioArray = Array();
            $preSelectedCategories = Array();
            $modelo = new UsuarioHasRolUsuario();

            if(isset($_GET['id'])){
                $idRolUsuario = $_GET['id'];
                $rolUsuarioNombre = $_GET['rolUsuarioNombre'];
                $institucionId = $_GET['institucionId'];  
                $institucionNombre = $_GET['institucionNombre'];
            }

            $listado = $modelo->listaUsuarioInstitucionRolUsuario($idRolUsuario,$institucionId);

            foreach($listado as $item) {                   
                $tmpObj = new UsuarioHasRolUsuario('myscenario');
                if((int) $item['rol_usuario_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['usuario_id'];
                }
                else{ 
                    $preSelectedCategories[] =  0;                             
                }

                $tmpObj->usuario_id = (int)$item['usuario_id'];
                $tmpObj->rol_usuario_id = (int)$item['rol_usuario_id']; 
                $tmpObj->setAttributes(Array('usuario'=>((string)$item['usuario'])),false);      
                $tmpObj->setAttributes(Array('rut'=>((string)$item['rut'])),false);     
                $tmpObj->setAttributes(Array('primerNombre'=>((string)$item['primer_nombre'])),false);                
                $tmpObj->setAttributes(Array('apellidoPaterno'=>((string)$item['apellido_paterno'])),false);     
                $tmpObj->setAttributes(Array('apellidoMaterno'=>((string)$item['apellido_materno'])),false);                

                $objetoRolUsuarioArray[] = $tmpObj;
            }

            $this->render('asignarusuariorolusuario',
                    array(  'model'=>$modelo,
                            'objeto'=>$objetoRolUsuarioArray,
                            'seleccionados'=>$preSelectedCategories,
                            'idRolUsuario'=>$idRolUsuario,
                            'rolUsuarioNombre'=>$rolUsuarioNombre,
                            'institucionId'=>$institucionId,
                            'institucionNombre'=>$institucionNombre,
            ));
        }
        
        public function actionAsignarUsuarios() {                     

            $usuario_rol_usuario = new UsuarioHasRolUsuario();
            $listadoAsignarUsuario = Array();
            $listadoDesAsignarUsuario = Array();


            $listadoTotal = unserialize($_POST['datos-usuario_id-list']);
            foreach(unserialize($_POST['datos-usuario_id-select']) as $usuarios) {   
                $listadoOriginal[] = $usuarios;
            }

            $rolUsuarioId = $_POST['datos-rolUsuario-id']; 
            $rolUsuarioNombre = $_POST['rolUsuarioNombre'];
            $institucionId = $_POST['institucionId'];
            $institucionNombre = $_POST['institucionNombre'];
            var_dump($rolUsuarioId);
            $usuarioId = Array(); 

            if(isset($_POST['usuario_id'])) {    
                $usuarioId = $_POST['usuario_id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$usuarioId ) ) {
                            $listadoAsignarUsuario[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarUsuario[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarUsuario) )
                    $usuario_rol_usuario->asignaRolUsuarioUsuario($listadoAsignarUsuario, $rolUsuarioId);           

                if( count( $listadoDesAsignarUsuario) )
                    $usuario_rol_usuario->desasignaRolUsuarioUsuario($listadoDesAsignarUsuario, $rolUsuarioId);        
            }
            else{
                $usuario_rol_usuario->desasignaRolUsuarioUsuario($listadoOriginal,$rolUsuarioId);                
            }

            $this->redirect(array("asignarusuariorolusuario",
                                    'id'=>$rolUsuarioId,
                                    'rolUsuarioNombre'=>$rolUsuarioNombre,
                                    'institucionId'=>$institucionId,
                                    'institucionNombre'=>$institucionNombre,
            ));

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