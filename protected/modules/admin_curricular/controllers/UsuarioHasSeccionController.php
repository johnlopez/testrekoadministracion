<?php


class UsuarioHasSeccionController extends Controller{
    
    
    public function actionIndex()
    {
        $objetoInstitucionArray = Array();
        $preSelectedCategories = Array();
        $modelo = new UsuarioHasSeccion();
        
        if(isset($_GET['id'])){
            $idRol = $_GET['id'];
        }  
        
        if(isset($_GET['seccion_id'])){
            $idSeccion = $_GET['seccion_id'];
        }
        
        $listado = $modelo->listaSeccionUsuario($idRol, $idSeccion);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new UsuarioHasSeccion('myscenario');
            if((int) $item['seccion_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['usuario_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->usuario_id = (int)$item['usuario_id'];
            $tmpObj->seccion_id = (int)$item['seccion_id'];
    
            $objetoInstitucionArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,
                                    'objeto'=>$objetoInstitucionArray,
                                    'seleccionados'=>$preSelectedCategories,
                                    'idRol'=>$idRol,
                                    'idSeccion'=>$idSeccion));
    }
    
    public function actionAsignarUsuarios() {                     
            
        $usuarioSeccion = new UsuarioHasSeccion();
        $listadoAsignarUsuario = Array();
        $listadoDesAsignarUsuario = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-usuario_id-list']);
        foreach(unserialize($_POST['datos-usuario_id-select']) as $usuarios) {   
            $listadoOriginal[] = $usuarios;
        }
        
        $seccionId = $_POST['datos-seccion-id'];    
        $idRol = $_POST['datos-rol-id'];
        var_dump($seccionId);
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
                $usuarioSeccion->asignaSeccionUsuario ($listadoAsignarUsuario, $seccionId, $idRol);        
                
            if( count( $listadoDesAsignarUsuario) )
                $usuarioSeccion->desasignaSeccionUsuario ($listadoDesAsignarUsuario, $seccionId, $idRol);    
        }
        else{
            $usuarioSeccion->desasignaSeccionUsuario($listadoOriginal, $seccionId, $idRol);              
        }
           
       
        $this->redirect(array("index",'id'=>$idRol, 'seccion_id'=>$seccionId));

    }
    
}
