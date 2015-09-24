<?php


class InstitucionHasRolUsuarioController extends Controller {
    
    public function actionIndex()
    {
        $objetoRolArray = Array();
        $preSelectedCategories = Array();
        $modelo = new InstitucionHasRolUsuario();
        
        if(isset($_GET['id'])){
            $idRol= $_GET['id'];
        }
        
        $listado = $modelo->listaRolInstitucion($idRol);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new InstitucionHasRolUsuario('myscenario');
            if((int) $item['rol_usuario_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['institucion_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->institucion_id = (int)$item['institucion_id'];
            $tmpObj->rol_usuario_id = (int)$item['rol_usuario_id'];                              
            $objetoRolArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,'objeto'=>$objetoRolArray,'seleccionados'=>$preSelectedCategories,'idRol'=>$idRol));
    }
    
    public function actionAsignarRoles() {                     
            
        $institucionRol = new InstitucionHasRolUsuario();
        $listadoAsignarInstitucion = Array();
        $listadoDesAsignarInstitucion = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-institucion_id-list']);
        foreach(unserialize($_POST['datos-institucion_id-select']) as $instituciones) {   
            $listadoOriginal[] = $instituciones;
        }
        
        $rolId = $_POST['datos-rol-id'];    
        var_dump($rolId);
        $institucionId = Array(); 
                
        if(isset($_POST['institucion_id'])) {    
            $institucionId = $_POST['institucion_id'];                
            for( $i=0; $i < count($listadoOriginal); $i++) {
                if( in_array( $listadoOriginal[$i],$institucionId ) ) {
                        $listadoAsignarInstitucion[] = $listadoOriginal[$i];
                    }
                else {
                        $listadoDesAsignarInstitucion[] = $listadoOriginal[$i];
                    }
            }
                
            if( count($listadoAsignarInstitucion) )
                $institucionRol->asignaRolInstitucion($listadoAsignarInstitucion, $rolId);           
                
            if( count( $listadoDesAsignarInstitucion) )
                $institucionRol->desasignaRolInstitucion($listadoDesAsignarInstitucion, $rolId);        
        }
        else{
            $institucionRol->desasignaRolInstitucion($listadoOriginal,$rolId);                
        }
           
       
        $this->redirect(array("index",'id'=>$rolId));

    }
    
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
    
    public function actionAsignarRolInstitucion()
    {
        $this->render('asignarrolinstitucion');
    }
}
