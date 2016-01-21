<?php


class FichatecnicahasprogramaacademicoController extends Controller {
    
    public function actionIndex()
    {
        $fichaArray = Array();
        $preSelectedCategories = Array();
        $modelo = new FichaTecnicaHasProgramaAcademico();
        
        if(isset($_GET['id'])){
            $idFicha = $_GET['id'];
        }
        
        
        
        $listado = $modelo->listaProgramas($idFicha);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new FichaTecnicaHasProgramaAcademico('myscenario');
            if((int) $item['ficha_tecnica_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['programa_academico_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->programa_academico_id = (int)$item['programa_academico_id'];
            $tmpObj->ficha_tecnica_id = (int)$item['ficha_tecnica_id'];  

 
            $fichaArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,'objeto'=>$fichaArray,'seleccionados'=>$preSelectedCategories,'idFicha'=>$idFicha));
    }
    
    public function actionAsignarProgramas() {                     
            
        $fichaTecnicaPrograma = new FichaTecnicaHasProgramaAcademico();
        $listadoAsignarPrograma = Array();
        $listadoDesAsignarPrograma = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-programa_id-list']);
        foreach(unserialize($_POST['datos-programa_id-select']) as $programa) {   
            $listadoOriginal[] = $programa;
        }
        
        $fichaId = $_POST['datos-ficha-id'];    
        var_dump($fichaId);
        $programaId = Array(); 
                
        if(isset($_POST['programa_academico_id'])) {    
            $programaId = $_POST['programa_academico_id'];                
            for( $i=0; $i < count($listadoOriginal); $i++) {
                if( in_array( $listadoOriginal[$i],$programaId ) ) {
                        $listadoAsignarPrograma[] = $listadoOriginal[$i];
                    }
                else {
                        $listadoDesAsignarPrograma[] = $listadoOriginal[$i];
                    }
            }
                
            if( count($listadoAsignarPrograma) )
                $fichaTecnicaPrograma->asignaFichaPrograma ($listadoAsignarPrograma, $fichaId);     
                
            if( count( $listadoDesAsignarPrograma) )
                $fichaTecnicaPrograma->desasignaFichaPrograma ($listadoDesAsignarPrograma, $fichaId);
        }
        else{
            $fichaTecnicaPrograma->desasignaFichaPrograma($listadoOriginal, $fichaId);         
        }
           
        $this->redirect(array("index",'id'=>$fichaId));

    }
    
}
