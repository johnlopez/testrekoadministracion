<?php

class InstitucionhasrepositorioController extends Controller
{
	public function actionIndex()
    {
        Yii::import('application.modules.admin_institucion.models.Institucion');
        $objetoInstitucionArray = Array();
        $preSelectedCategories = Array();
        $modelo = new InstitucionHasRepositorio();
        
        if(isset($_GET['id'])){
            $idInstitucion = $_GET['id'];
        }
        
        $listado = $modelo->listaInstitucionRepositorio($idInstitucion);
       
            
        foreach($listado as $item) {                   
            $tmpObj = new InstitucionHasRepositorio('myscenario');
            if((int) $item['institucion_id'] != 0 ){
                $preSelectedCategories[] =  (int) $item['repositorio_id'];
            }
            else{ 
                $preSelectedCategories[] =  0;                             
            }
                    
            $tmpObj->repositorio_id = (int)$item['repositorio_id'];
            $tmpObj->institucion_id = (int)$item['institucion_id'];                              
            $objetoInstitucionArray[] = $tmpObj;
        }
            
            
        $this->render('index',array('model'=>$modelo,'objeto'=>$objetoInstitucionArray,'seleccionados'=>$preSelectedCategories,'idInstitucion'=>$idInstitucion));
    }
    
    public function actionAsignarRepositorios() {                     
            
        $repositorio_institucion = new InstitucionHasRepositorio();
        $listadoAsignarRepositorio = Array();
        $listadoDesAsignarRepositorio = Array();
            
            
        $listadoTotal = unserialize($_POST['datos-repositorio_id-list']);
        foreach(unserialize($_POST['datos-repositorio_id-select']) as $repositorios) {   
            $listadoOriginal[] = $repositorios;
        }
        
        $institucionId = $_POST['datos-institucion-id'];    
        var_dump($institucionId);
        $repositorioId = Array(); 
                
        if(isset($_POST['repositorio_id'])) {    
            $repositorioId = $_POST['repositorio_id'];                
            for( $i=0; $i < count($listadoOriginal); $i++) {
                if( in_array( $listadoOriginal[$i],$repositorioId ) ) {
                        $listadoAsignarRepositorio[] = $listadoOriginal[$i];
                    }
                else {
                        $listadoDesAsignarRepositorio[] = $listadoOriginal[$i];
                    }
            }
                
            if( count($listadoAsignarRepositorio) )
                $repositorio_institucion->asignaInstitucionRepositorio($listadoAsignarRepositorio, $institucionId);           
                
            if( count( $listadoDesAsignarRepositorio) )
                $repositorio_institucion->desasignaInstitucionRepositorio($listadoDesAsignarRepositorio, $institucionId);        
        }
        else{
            $repositorio_institucion->desasignaInstitucionRepositorio($listadoOriginal,$institucionId);                
        }
           
       
        $this->redirect(array("index",'id'=>$institucionId));

    }

	// Uncomment the following methods and override them if needed
	/*
	public function filters()
	{
		// return the filter configuration for this controller, e.g.:
		return array(
			'inlineFilterName',
			array(
				'class'=>'path.to.FilterClass',
				'propertyName'=>'propertyValue',
			),
		);
	}

	public function actions()
	{
		// return external action classes, e.g.:
		return array(
			'action1'=>'path.to.ActionClass',
			'action2'=>array(
				'class'=>'path.to.AnotherActionClass',
				'propertyName'=>'propertyValue',
			),
		);
	}
	*/
}