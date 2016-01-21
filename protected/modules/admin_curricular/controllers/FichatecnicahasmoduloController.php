<?php


class FichatecnicahasmoduloController extends Controller{
    
    public function actionIndex()
    {
        $fichaArray = Array();
        $preSelectedCategories = Array();
        $modelo = new FichaTecnicaHasModulo();
        
        if(isset($_GET['id'])){
            $idFicha = $_GET['id'];
        }
        
        
        
        $listado = $modelo->listaModulos($idFicha);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new FichaTecnicaHasModulo('myscenario');
            if((int) $item['ficha_tecnica_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['modulo_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->modulo_id = (int)$item['modulo_id'];
            $tmpObj->ficha_tecnica_id = (int)$item['ficha_tecnica_id'];  

 
            $fichaArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,'objeto'=>$fichaArray,'seleccionados'=>$preSelectedCategories,'idFicha'=>$idFicha));
    }
    
    public function actionAsignarModulos() {                     
            
        $fichaTecnicaModulo = new FichaTecnicaHasModulo();
        $listadoAsignarModulo = Array();
        $listadoDesAsignarModulo = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-modulo_id-list']);
        foreach(unserialize($_POST['datos-modulo_id-select']) as $modulo) {   
            $listadoOriginal[] = $modulo;
        }
        
        $fichaId = $_POST['datos-ficha-id'];    
        var_dump($fichaId);
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
                $fichaTecnicaModulo->asignaFichaModulo ($listadoAsignarModulo, $fichaId);       
                
            if( count( $listadoDesAsignarModulo) )
                $fichaTecnicaModulo->desasignaFichaModulo ($listadoDesAsignarModulo, $fichaId); 
        }
        else{
            $fichaTecnicaModulo->desasignaFichaModulo($listadoOriginal, $fichaId);           
        }
           
       
        $this->redirect(array("index",'id'=>$fichaId));

    }
    
}
