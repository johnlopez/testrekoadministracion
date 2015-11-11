<?php

class UsuarioHasProgramaAcademicoController extends Controller {
   
    public function actionListaUsuarios(){
        
        $objetoProgramaArray = Array();
        $preSelectedCategories = Array();
        $modelo = new UsuarioHasProgramaAcademico();
        
       
        if(isset($_GET['id'])){
            $idRol = $_GET['id'];
        }        
        
        if(isset($_GET['programa_id'])){
            $idPrograma = $_GET['programa_id'];
        }
        
        $listado = $modelo->listaUsuariosPorRol($idRol, $idPrograma);
       
            
        foreach($listado as $item) { 
            $tmpObj = new UsuarioHasProgramaAcademico('myscenario');
            if((int) $item['programa_academico_id'] != 0 ){
                $preSelectedCategories[] =  (int)$item['usuario_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->usuario_id = (int)$item['usuario_id'];
            $tmpObj->programa_academico_id = (int)$item['programa_academico_id'];  
            $objetoProgramaArray[] = $tmpObj;
        }
            
            
        $this->render('listausuarios',array('model'=>$modelo,
                                            'objeto'=>$objetoProgramaArray,
                                            'seleccionados'=>$preSelectedCategories,
                                            'idRol'=>$idRol, 
                                            'idPrograma'=>$idPrograma));
    }
    
    
    public function actionAsignarUsuariosConRolPrograma() {                     
            
            $programaUsuario = new UsuarioHasProgramaAcademico();
            $listadoAsignarUsuario = Array();
            $listadoDesAsignarUsuario = Array();


            $listadoTotal = unserialize($_POST['datos-id-list']);
            foreach(unserialize($_POST['datos-id-select']) as $usuarios) {   
                $listadoOriginal[] = $usuarios;
            }

            $programaId = $_POST['datos-programa-id'];
            $idRol = $_POST['datos-rol-id'];
            var_dump($programaId);
            //exit;
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
                    //$programaUsuario->asignaProgramaUsuario($listadoAsignarUsuario, $programaId); 
                    $programaUsuario->asignaProgramaUsuario($listadoAsignarUsuario, $programaId, $idRol);

                if( count( $listadoDesAsignarUsuario) )
                    //$programaUsuario->desasignaProgramaUsuario($listadoDesAsignarUsuario, $programaId);
                    $programaUsuario->desasignaProgramaUsuario($listadoDesAsignarUsuario, $programaId, $idRol);
            }
            else{
                //$programaUsuario->desasignaProgramaUsuario($listadoOriginal,$programaId); 
                  $programaUsuario->desasignaProgramaUsuario($listadoOriginal, $programaId, $idRol);
            }


            $this->redirect(array("listausuarios",'id'=>$idRol, 'programa_id'=>$programaId));

        }
}
