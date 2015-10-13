<?php

class ProgramaAcademicoController extends Controller
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
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('index','view','admin','indexInstitucion','indexEntidad','AsignarProgramaInstitucion','AsignarProgramaEntidad','borrar'),
				'users'=>array('*'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id)
	{
		$this->render('view',array(
			'model'=>$this->loadModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new ProgramaAcademico;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['ProgramaAcademico']))
		{
			$model->attributes=$_POST['ProgramaAcademico'];
			if($model->agregarProgramaAcademico(
                                $model->nombre,
                                $model->descripcion,
                                $model->version,
                                $model->fecha_creacion
                        ))
				
                    $this->redirect(array('view','id'=>$model->llaveIdPrograma));
		}

		$this->render('create',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['ProgramaAcademico']))
		{
			$model->attributes=$_POST['ProgramaAcademico'];
			if($model->modificarProgramaAcademico(
                                $model->id,
                                $model->nombre,
                                $model->descripcion,
                                $model->version,
                                $model->fecha_modificacion    
                        ))
				
                    $this->redirect(array('view','id'=>$model->id));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('ProgramaAcademico');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new ProgramaAcademico('search');
                $listadoPrograma = ProgramaAcademico::model()->findAll();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['ProgramaAcademico']))
			$model->attributes=$_GET['ProgramaAcademico'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoPrograma' => $listadoPrograma
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return ProgramaAcademico the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=ProgramaAcademico::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param ProgramaAcademico $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='programa-academico-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionIndexEntidad()
        {   
            $objetoEntidadArray = Array();
            $preSelectedCategories = Array();
            $modelo = new ProgramaAcademico();

            if(isset($_GET['id'])){
                $idEntidad = $_GET['id'];
            }

            $listado = $modelo->listaEntidadProgrma($idEntidad);


            foreach($listado as $item) {                   
                $tmpObj = new ProgramaAcademico('myscenario');
                if((int) $item['entidad_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['id'];
                }
                else{ 
                    $preSelectedCategories[] =  0; 
                    echo 'No hay programas disponibles';
                }

                $tmpObj->id = (int)$item['id'];
                $tmpObj->entidad_id = (int)$item['entidad_id']; 
                $tmpObj->nombre = $item['nombre'];
                $objetoEntidadArray[] = $tmpObj;
            }


            $this->render('indexEntidad',array('model'=>$modelo,'objeto'=>$objetoEntidadArray,'seleccionados'=>$preSelectedCategories,'idEntidad'=>$idEntidad));
        }
    
        public function actionAsignarProgramaEntidad() {                     
            
            $programaEntidad = new ProgramaAcademico();
            $listadoAsignarPrograma = Array();
            $listadoDesAsignarPrograma = Array();


            $listadoTotal = unserialize($_POST['datos-id-list']);
            foreach(unserialize($_POST['datos-id-select']) as $programa) {   
                $listadoOriginal[] = $programa;
            }

            $entidadId = $_POST['datos-entidad-id'];    
            var_dump($entidadId);
            $programaId = Array(); 

            if(isset($_POST['id'])) {    
                $programaId = $_POST['id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$programaId ) ) {
                            $listadoAsignarPrograma[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarPrograma[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarPrograma) )
                    $programaEntidad->asignaProgramaEntidad($listadoAsignarPrograma, $entidadId);

                if( count($listadoDesAsignarPrograma) )
                    $programaEntidad->desasignaProgramaEntidad($listadoDesAsignarPrograma, $entidadId);       
            }
            else{
                $programaEntidad->desasignaProgramaEntidad($listadoOriginal, $entidadId);                   
            }


            $this->redirect(array("indexEntidad",'id'=>$entidadId));

        }
        
        public function actionIndexInstitucion()
        {
            $objetoInstitucionArray = Array();
            $preSelectedCategories = Array();
            $modelo = new ProgramaAcademico();

            if(isset($_GET['id'])){
                $idInstitucion = $_GET['id'];
            }

            $listado = $modelo->listaInstitucionProgrma($idInstitucion);


            foreach($listado as $item) {                   
                $tmpObj = new ProgramaAcademico('myscenario');
                if((int) $item['institucion_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['id'];
                    
                }
                else{ 
                    $preSelectedCategories[] =  0; 
                }

                $tmpObj->id = (int)$item['id'];
                $tmpObj->institucion_id = (int)$item['institucion_id']; 
                $tmpObj->nombre = $item['nombre'];
                
                $objetoInstitucionArray[] = $tmpObj;
            }


            $this->render('indexInstitucion',array('model'=>$modelo,'objeto'=>$objetoInstitucionArray,'seleccionados'=>$preSelectedCategories,'idInstitucion'=>$idInstitucion));
        }
    
        public function actionAsignarProgramaInstitucion() {                     
            
            $programaInstitucion = new ProgramaAcademico();
            $listadoAsignarPrograma = Array();
            $listadoDesAsignarPrograma = Array();


            $listadoTotal = unserialize($_POST['datos-id-list']);
            foreach(unserialize($_POST['datos-id-select']) as $programa) {   
                $listadoOriginal[] = $programa;
            }

            $institucionId = $_POST['datos-institucion-id'];    
            var_dump($institucionId);
            $programaId = Array(); 

            if(isset($_POST['id'])) {    
                $programaId = $_POST['id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$programaId ) ) {
                            $listadoAsignarPrograma[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarPrograma[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarPrograma) )
                    $programaInstitucion->asignaProgramaInstitucion($listadoAsignarPrograma, $institucionId);

                if( count($listadoDesAsignarPrograma) )
                    $programaInstitucion->desasignaProgramaInstitucion ($listadoDesAsignarPrograma, $institucionId);       
            }
            else{
                $programaInstitucion->desasignaProgramaInstitucion ($listadoOriginal, $institucionId);                 
            }


            $this->redirect(array("indexInstitucion",'id'=>$institucionId));

        }
        
        public function actionBorrar() {
            
                if(isset($_POST['id'])){
                    $idPrograma = $_POST['id'];
                }
                
                $programa = new ProgramaAcademico();
                $programa->eliminarLogicoProgramaAcademico($idPrograma);
                $this->redirect('admin');
        }
}
