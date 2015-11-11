<?php


class UsuarioHasModuloController extends Controller {
   
    
    public function actionIndex()
    {
        $objetoModuloArray = Array();
        $preSelectedCategories = Array();
        $modelo = new UsuarioHasModulo();
        
        if(isset($_GET['id'])){
            $idRol = $_GET['id'];
        }  
        
        if(isset($_GET['modulo_id'])){
            $idModulo = $_GET['modulo_id'];
        }
        
        $listado = $modelo->listaModuloUsuario($idRol, $idModulo);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new UsuarioHasModulo('myscenario');
            if((int) $item['modulo_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['usuario_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->usuario_id = (int)$item['usuario_id'];
            $tmpObj->modulo_id = (int)$item['modulo_id'];  
            $objetoModuloArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,
                                    'objeto'=>$objetoModuloArray,
                                    'seleccionados'=>$preSelectedCategories,
                                    'idRol'=>$idRol, 
                                    'idModulo'=>$idModulo));
    }
    
    public function actionAsignarUsuariosConRolModulo() {                     
            
        $usuarioModulo = new UsuarioHasModulo();
        $listadoAsignarUsuario = Array();
        $listadoDesAsignarUsuario = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-usuario_id-list']);
        foreach(unserialize($_POST['datos-usuario_id-select']) as $usuarios) {   
            $listadoOriginal[] = $usuarios;
        }
        
        $moduloId = $_POST['datos-modulo-id']; 
        $idRol = $_POST['datos-rol-id'];
        var_dump($moduloId);
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
                $usuarioModulo->asignaModuloUsuario($listadoAsignarUsuario, $moduloId,$idRol);           
                
            if( count( $listadoDesAsignarUsuario) )
                $usuarioModulo->desasignaModuloUsuario($listadoDesAsignarUsuario, $moduloId,$idRol);        
        }
        else{
            $usuarioModulo->desasignaModuloUsuario($listadoOriginal,$moduloId,$idRol);                
        }
           
       
        $this->redirect(array("index",'id'=>$idRol, 'modulo_id'=>$moduloId));

    }
}
