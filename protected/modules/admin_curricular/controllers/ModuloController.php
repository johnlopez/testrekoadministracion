<?php

class ModuloController extends Controller
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
				'actions'=>array('index','view','admin','indexInstitucion2','indexEntidad2','AsignarModuloInstitucion','AsignarModuloEntidad','borrar','listaModulos','index2'),
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
		$model=new Modulo;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Modulo']))
		{
			$model->attributes=$_POST['Modulo'];
			if($model->agregarModulo(
                                $model->nombre,
                                $model->codigo,
                                $model->descripcion,
                                $model->fecha_creacion,
                                $model->estado_modulo_id ? : NULL,
                                $model->entidad_id ? : NULL,
                                $model->institucion_id ? : NULL
                        ))
				
                    $this->redirect(array('view','id'=>$model->llaveIdModulo));
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

		if(isset($_POST['Modulo']))
		{
			$model->attributes=$_POST['Modulo'];
			if($model->modificarModulo(
                                $model->id,
                                $model->codigo,
                                $model->nombre,
                                $model->descripcion,
                                $model->fecha_modificacion,
                                $model->estado_modulo_id ? : NULL,
                                $model->entidad_id ? : NULL,
                                $model->institucion_id ? : NULL
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
		$dataProvider=new CActiveDataProvider('Modulo');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Modulo('search');
                //$listadoModulos = Modulo::model()->findAll();
                $listadoModulos = $model->listarModulosPorEstado();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Modulo']))
			$model->attributes=$_GET['Modulo'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoModulos' => $listadoModulos
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Modulo the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Modulo::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Modulo $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='modulo-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionBorrar() {
            
                if(isset($_POST['id'])){
                    $idModulo = $_POST['id'];
                }
                
                $modulo = new Modulo();
                $modulo->eliminarLogicoModulo($idModulo);
                $this->redirect('admin');
        }
        
        
        public function actionIndexEntidad2()
        {   
            $objetoEntidadArray = Array();
            $preSelectedCategories = Array();
            $modelo = new Modulo();

            if(isset($_GET['id'])){
                $idEntidad = $_GET['id'];
            }

            $listado = $modelo->listaEntidadModulo($idEntidad);


            foreach($listado as $item) {                   
                $tmpObj = new Modulo('myscenario');
                if((int) $item['entidad_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['id'];
                }
                else{ 
                    $preSelectedCategories[] =  0; 
                   // echo 'No hay programas disponibles';
                }

                $tmpObj->id = (int)$item['id'];
                $tmpObj->entidad_id = (int)$item['entidad_id']; 
                $objetoEntidadArray[] = $tmpObj;
            }


            $this->render('indexEntidad2',array('model'=>$modelo,'objeto'=>$objetoEntidadArray,'seleccionados'=>$preSelectedCategories,'idEntidad'=>$idEntidad));
        }
    
        public function actionAsignarModuloEntidad() {                     
            
            $modulo = new Modulo();
            $listadoAsignarModulo = Array();
            $listadoDesAsignarModulo = Array();


            $listadoTotal = unserialize($_POST['datos-id-list']);
            foreach(unserialize($_POST['datos-id-select']) as $modulos) {   
                $listadoOriginal[] = $modulos;
            }

            $entidadId = $_POST['datos-entidad-id'];    
            var_dump($entidadId);
            $programaId = Array(); 

            if(isset($_POST['id'])) {    
                $programaId = $_POST['id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$programaId ) ) {
                            $listadoAsignarModulo[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarModulo[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarModulo) )
                    $modulo->asignaModuloEntidad ($listadoAsignarModulo, $entidadId);

                if( count($listadoDesAsignarModulo) )
                    $modulo->desasignaModuloEntidad ($listadoDesAsignarModulo, $entidadId);     
            }
            else{
                $modulo->desasignaModuloEntidad($listadoOriginal, $entidadId);                  
            }


            $this->redirect(array("indexEntidad2",'id'=>$entidadId));

        }
        
        public function actionIndexInstitucion2()
        {
            $objetoInstitucionArray = Array();
            $preSelectedCategories = Array();
            $modelo = new Modulo();

            if(isset($_GET['id'])){
                $idInstitucion = $_GET['id'];
            }

            $listado = $modelo->listaInstitucionModulo($idInstitucion);


            foreach($listado as $item) {                   
                $tmpObj = new Modulo('myscenario');
                if((int) $item['institucion_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['id'];
                    
                }
                else{ 
                    $preSelectedCategories[] =  0; 
                }

                $tmpObj->id = (int)$item['id'];
                $tmpObj->institucion_id = (int)$item['institucion_id']; 
                
                $objetoInstitucionArray[] = $tmpObj;
            }


            $this->render('indexInstitucion2',array('model'=>$modelo,'objeto'=>$objetoInstitucionArray,'seleccionados'=>$preSelectedCategories,'idInstitucion'=>$idInstitucion));
        }
    
        public function actionAsignarModuloInstitucion() {                     
            
            $modulo = new Modulo();
            $listadoAsignarModulo = Array();
            $listadoDesAsignarModulo = Array();


            $listadoTotal = unserialize($_POST['datos-id-list']);
            foreach(unserialize($_POST['datos-id-select']) as $modulos) {   
                $listadoOriginal[] = $modulos;
            }

            $institucionId = $_POST['datos-institucion-id'];    
            var_dump($institucionId);
            $programaId = Array(); 

            if(isset($_POST['id'])) {    
                $programaId = $_POST['id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$programaId ) ) {
                            $listadoAsignarModulo[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarModulo[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarModulo) )
                    $modulo->asignaModuloInstitucion($listadoAsignarModulo, $institucionId);

                if( count($listadoDesAsignarModulo) )
                    $modulo->desasignaModuloInstitucion($listadoDesAsignarModulo, $institucionId);      
            }
            else{
                $modulo->desasignaModuloInstitucion($listadoOriginal, $institucionId);                
            }


            $this->redirect(array("indexInstitucion2",'id'=>$institucionId));

        }
        
        public function actionListaModulos() {
            
            if(isset($_GET['id'])){
                $idInstitucion = $_GET['id'];
            }
            
            $modulo = new Modulo();
            $listadoModulos = $modulo->listarModulosPorInstitucion($idInstitucion);
            
            $this->render('listaModulos',array('listadoModulos' => $listadoModulos));
        }
        
        public function actionIndex2() {
            
            $modulo = new Modulo();
            if(isset($_GET['id'])){
                $idPrograma = $_GET['id'];
            }
            
            $listadoModulos = $modulo->listarModulosPorPrograma($idPrograma);
            $this->render('index2', array('listadoModulos' => $listadoModulos));
        }
}
