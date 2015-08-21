<?php


class EstadoUsuarioController extends Controller {
    
    public function actionIndex()
    {
        $objetoEstadoArray = Array();
        $preSelectedCategories = Array();
        $modelo = new EstadoUsuario();
        
        
        if(isset($_GET['id'])){
            $idEstado = $_GET['id'];
        }
        
        $listado = $modelo->listaEstadoUsuario($idEstado);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new EstadoUsuario('myscenario');
            if((int) $item['logica_estado_usuario_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['usuario_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->usuario_id = (int)$item['usuario_id'];
            $tmpObj->logica_estado_usuario_id = (int)$item['logica_estado_usuario_id'];                              
            $objetoEstadoArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,'objeto'=>$objetoEstadoArray,'seleccionados'=>$preSelectedCategories,'idEstado'=>$idEstado));
    }
    
    public function actionAsignarEstado() {                     
            
        $usuarioEstado = new EstadoUsuario();
        $listadoAsignarUsuario = Array();
        $listadoDesAsignarUsuario = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-usuario_id-list']);
        foreach(unserialize($_POST['datos-usuario_id-select']) as $usuarios) {   
            $listadoOriginal[] = $usuarios;
        }
        
        $estadoId = $_POST['datos-estado-id'];    
        var_dump($estadoId);
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
                $usuarioEstado->asignaEstadoUsuario($listadoAsignarUsuario, $estadoId);           
                
            if( count( $listadoDesAsignarUsuario) )
                $usuarioEstado->desasignaEstadoUsuario($listadoDesAsignarUsuario, $estadoId);        
        }
        else{
            $usuarioEstado->desasignaEstadoUsuario($listadoOriginal,$estadoId);                
        }
           
       
        $this->redirect(array("index",'id'=>$estadoId));

    }
    
    
    public function actionIndex2(){        
        
        $modelo = new EstadoUsuario();
        $usuario = new Usuario();
        
        if(isset($_GET['id'])){
            $idUsuario = $_GET['id'];
        }
        
        $listado = $modelo->listarEstadoUsuario($idUsuario);
        
        $this->render('index2',array('model'=>$modelo,'listado'=>$listado,'usuario'=>$usuario));
    }
    
}
