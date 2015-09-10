<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of UsuarioHasInstitucionController
 *
 * @author Utem
 */
class UsuarioHasInstitucionController extends Controller {
    
    public function actionAsignar()
    {
        Yii::import('application.modules.admin_institucion.models.Institucion');
        $objetoInstitucionArray = Array();
        $preSelectedCategories = Array();
        $modelo = new UsuarioHasInstitucion();
        
        if(isset($_GET['id'])){
            $idInstitucion = $_GET['id'];
        }
        
        $listado = $modelo->listaInstitucionUsuario($idInstitucion);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new UsuarioHasInstitucion('myscenario');
            if((int) $item['institucion_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['usuario_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->usuario_id = (int)$item['usuario_id'];
            $tmpObj->institucion_id = (int)$item['institucion_id'];                              
            $objetoInstitucionArray[] = $tmpObj;
        }
            
            
        $this->render('asignar',array('model'=>$modelo,'objeto'=>$objetoInstitucionArray,'seleccionados'=>$preSelectedCategories,'idInstitucion'=>$idInstitucion));
    }
    
    public function actionAsignarUsuarios() {                     
            
        $usuario_institucion = new UsuarioHasInstitucion();
        $listadoAsignarUsuario = Array();
        $listadoDesAsignarUsuario = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-usuario_id-list']);
        foreach(unserialize($_POST['datos-usuario_id-select']) as $usuarios) {   
            $listadoOriginal[] = $usuarios;
        }
        
        $institucionId = $_POST['datos-institucion-id'];    
        var_dump($institucionId);
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
                $usuario_institucion->asignaInstitucionUsuario($listadoAsignarUsuario, $institucionId);           
                
            if( count( $listadoDesAsignarUsuario) )
                $usuario_institucion->desasignaInstitucionUsuario($listadoDesAsignarUsuario, $institucionId);        
        }
        else{
            $usuario_institucion->desasignaInstitucionUsuario($listadoOriginal,$institucionId);                
        }
           
       
        $this->redirect(array("index",'id'=>$institucionId));

    }
    
}
