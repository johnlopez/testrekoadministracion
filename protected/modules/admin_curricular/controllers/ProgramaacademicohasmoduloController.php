<?php


class ProgramaAcademicoHasModuloController extends Controller {
    
    public function actionIndex() {
        
        $objetoProgramaArray = Array();
        $preSelectedCategories = Array();
        $modelo = new ProgramaAcademicoHasModulo();
        
        if(isset($_GET['id'])){
            $idPrograma = $_GET['id'];
        }
        
        $listado = $modelo->listaProgramaModulo($idPrograma);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new ProgramaAcademicoHasModulo('myscenario');
            if((int) $item['programa_academico_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['modulo_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->modulo_id = (int)$item['modulo_id'];
            $tmpObj->programa_academico_id = (int)$item['programa_academico_id']; 
           
            
            $objetoProgramaArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,'objeto'=>$objetoProgramaArray,'seleccionados'=>$preSelectedCategories,'idPrograma'=>$idPrograma));
    }
    
    
    public function actionAsignarModulos() {                     
            
        $moduloPrograma = new ProgramaAcademicoHasModulo();
        $listadoAsignarModulo = Array();
        $listadoDesAsignarModulo = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-modulo_id-list']);
        foreach(unserialize($_POST['datos-modulo_id-select']) as $modulos) {   
            $listadoOriginal[] = $modulos;
        }
        
        $programaId = $_POST['datos-programa-id'];    
        var_dump($programaId);
        $moduloId = Array(); 
                
        if(isset($_POST['modulo_id'])) {    
            $moduloId = $_POST['modulo_id'];                
            for( $i=0; $i < count($listadoOriginal); $i++) {
                if( in_array( $listadoOriginal[$i],$moduloId ) ) {
                        $listadoAsignarModulo[] = $listadoOriginal[$i];
                    }
                else {
                        $listadoDesAsignarModulo[] = $listadoOriginal[$i];
                    }
            }
                
            if( count($listadoAsignarModulo) )
                $moduloPrograma->asignaProgramaModulo($listadoAsignarModulo, $programaId);           
                
            if( count( $listadoDesAsignarModulo) )
                $moduloPrograma->desasignaProgramaModulo($listadoDesAsignarModulo, $programaId);        
        }
        else{
            $moduloPrograma->desasignaProgramaModulo($listadoOriginal,$programaId);                
        }
           
       
        $this->redirect(array("index",'id'=>$programaId));

    }
}
