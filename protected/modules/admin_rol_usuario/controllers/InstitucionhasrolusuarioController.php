<?php


class InstitucionHasRolUsuarioController extends Controller {
           
    public function actionListaInstitucion()
    {
        Yii::import('application.modules.admin_institucion.models.Institucion');
        
        $model = New Institucion();
        //var_dump($institucion->findByPk(1)) ;
        
        $institucion = $model->findAll();
        
        $this->render('listainstitucion',array(            
            'institucion'=>$institucion,            
        ));
    }
//    
//    public function actionAsignarRolInstitucion()
//    {
//        if(isset($_POST['institucion_id']))
//        {
//            echo $_POST['institucion_id'];
//        }
//        $this->render('asignarrolinstitucion');
//    }
    
    public function actionAsignarrolinstitucion()
    {
        Yii::import('application.modules.admin_institucion.models.Institucion');
        $objetoInstitucionArray = Array();
        $preSelectedCategories = Array();
        $modelo = new InstitucionHasRolUsuario();
        
        if(isset($_GET['institucion_id'])){
            $idInstitucion = $_GET['institucion_id'];
            $nombreInstitucion = $_GET['institucion_nombre'];
        }
        
        $listado = $modelo->listaInstitucionRolUsuario($idInstitucion);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new InstitucionHasRolUsuario('myscenario');
            if((int) $item['institucion_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['rol_usuario_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->rol_usuario_id = (int)$item['rol_usuario_id'];
            $tmpObj->institucion_id = (int)$item['institucion_id'];    
            $tmpObj->setAttributes(Array('rolusuarionombre'=>((string)$item['rol_usuario_nombre'])),false); 
            $tmpObj->setAttributes(Array('rolusuariotipo'=>((string)$item['rol_usuario_tipo'])),false);           

            $objetoInstitucionArray[] = $tmpObj;
        }
            
            
        $this->render('asignarrolinstitucion',
                array(
                        'model'=>$modelo,
                        'objeto'=>$objetoInstitucionArray,
                        'seleccionados'=>$preSelectedCategories,
                        'idInstitucion'=>$idInstitucion,
                        'nombreInstitucion'=>$nombreInstitucion,
                ));
    }
    public function actionAsignarRoles() {                     
            
        $rol_usuario_institucion = new InstitucionHasRolUsuario();
        $listadoAsignarRolUsuario = Array();
        $listadoDesAsignarRolUsuario = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-rol_usuario_id-list']);
        foreach(unserialize($_POST['datos-rol_usuario_id-select']) as $roles) {   
            $listadoOriginal[] = $roles;
        }
        
        $institucionId = $_POST['datos-institucion-id'];    
        var_dump($institucionId);
        $rol_usuario_id = Array(); 
                
        if(isset($_POST['rol_usuario_id'])) {    
            $rol_usuario_id = $_POST['rol_usuario_id'];                
            for( $i=0; $i < count($listadoOriginal); $i++) {
                if( in_array( $listadoOriginal[$i],$rol_usuario_id ) ) {
                        $listadoAsignarRolUsuario[] = $listadoOriginal[$i];
                    }
                else {
                        $listadoDesAsignarRolUsuario[] = $listadoOriginal[$i];
                    }
            }
                
            if( count($listadoAsignarRolUsuario) )
                $rol_usuario_institucion->asignaInstitucionRolUsuario($listadoAsignarRolUsuario, $institucionId);           
                
            if( count( $listadoDesAsignarRolUsuario) )
                $rol_usuario_institucion->desasignaInstitucionRolUsuario($listadoDesAsignarRolUsuario, $institucionId);        
        }
        else{
            $rol_usuario_institucion->desasignaInstitucionRolUsuario($listadoOriginal,$institucionId);                
        }
           
       
        $this->redirect(array("asignarrolinstitucion",'institucion_id'=>$institucionId));

    }
   
}
