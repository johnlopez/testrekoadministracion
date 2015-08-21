<?php

class RepositoriomasterhasinstitucionController extends Controller
{
        /**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column2';

	/**
	 * @return array action filters
	 */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
			'postOnly + delete', // we only allow deletion via POST request
		);
	}

	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
//        public function accessRules()
//	{
//            return Yii::app()->Validar->validarAcceso();
//	}
        public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view','asignar'),
				'users'=>array('@'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('@'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
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
        public function actionIndex()
        {
            Yii::import('application.modules.admin_institucion.models.Institucion');
            $objetoInstitucionArray = Array();
            $preSelectedCategories = Array();
            $modelo = new RepositorioMasterHasInstitucion();

            if(isset($_GET['id'])){
                $idInstitucion = $_GET['id'];
            }

            $listado = $modelo->listaInstitucionRepositorioMaster($idInstitucion);


            foreach($listado as $item) {                   
                $tmpObj = new RepositorioMasterHasInstitucion('myscenario');
                if((int) $item['institucion_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['repositorio_master_id'];
                }
                else{ 
                    $preSelectedCategories[] =  0;                             
                }

                $tmpObj->repositorio_master_id = (int)$item['usuario_id'];
                $tmpObj->institucion_id = (int)$item['institucion_id'];                              
                $objetoInstitucionArray[] = $tmpObj;
            }


            $this->render('index',array('model'=>$modelo,'objeto'=>$objetoInstitucionArray,'seleccionados'=>$preSelectedCategories,'idInstitucion'=>$idInstitucion));
        }

        public function actionAsignarRepositoriosMaster() {                     

            $repositorio_master_institucion = new RepositorioMasterHasInstitucion();
            $listadoAsignarRepositorioMaster = Array();
            $listadoDesAsignarRepositorioMaster = Array();


            $listadoTotal = unserialize($_POST['datos-repositorio_master_id-list']);
            foreach(unserialize($_POST['datos-repositorio_master_id-select']) as $repositoriosmaster) {   
                $listadoOriginal[] = $repositoriosmaster;
            }

            $institucionId = $_POST['datos-institucion-id'];    
            var_dump($institucionId);
            $repositoriomasterId = Array(); 

            if(isset($_POST['repositorio_master_id'])) {    
                $repositoriomasterId = $_POST['repositorio_master_id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$repositoriomasterId ) ) {
                            $listadoAsignarRepositorioMaster[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarRepositorioMaster[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarRepositorioMaster) )
                    $repositorio_master_institucion->asignaInstitucionRepositorioMaster($listadoAsignarRepositorioMaster, $institucionId);           

                if( count( $listadoDesAsignarRepositorioMaster) )
                    $repositorio_master_institucion->desasignaInstitucionRepositorioMaster($listadoDesAsignarRepositorioMaster, $institucionId);        
            }
            else{
                $repositorio_master_institucion->desasignaInstitucionRepositorioMaster($listadoOriginal,$institucionId);                
            }


            $this->redirect(array("index",'id'=>$institucionId));
        }
}