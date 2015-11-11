<?php

class EntidadController extends Controller
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
				'actions'=>array('index','view','admin','AsignarEntidadEntidad','IndexEntidad','borrar'),
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
		$model=new Entidad;
                $valorEntidad;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Entidad']))
		{
			$model->attributes=$_POST['Entidad'];
			if($model->agregarEntidad(
                                $model->nombre,
                                $model->descripcion,
                                $model->institucion_id,
                                $model->entidad_id ? : NULL,
                                $model->estado_entidad_id ? : NULL,
                                $model->fecha_creacion
                        ))
                           
				
                    $this->redirect(array('view','id'=>$model->llaveIdEntidad));
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

		if(isset($_POST['Entidad']))
		{
			$model->attributes=$_POST['Entidad'];
			if($model->modificarEntidad(
                                $model->id,
                                $model->nombre,
                                $model->descripcion,
                                $model->institucion_id,
                                $model->entidad_id ? : NULL,
                                $model->estado_entidad_id ? : NULL,
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
		$dataProvider=new CActiveDataProvider('Entidad');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Entidad('search');
                $listadoEntidades = $model->listarEntidadPorEstado();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Entidad']))
			$model->attributes=$_GET['Entidad'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoEntidades' => $listadoEntidades,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Entidad the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Entidad::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Entidad $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='entidad-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionIndexEntidad()
        {   
            $objetoEntidadArray = Array();
            $preSelectedCategories = Array();
            $modelo = new Entidad();

            if(isset($_GET['id'])){
                $idEntidad = $_GET['id'];
            }

            $listado = $modelo->listaEntidadEntidad($idEntidad);


            foreach($listado as $item) {                   
                $tmpObj = new Entidad('myscenario');
                if((int) $item['entidad_id'] != 0 ){
                    $preSelectedCategories[] =  (int) $item['id'];
                }
                else{ 
                    $preSelectedCategories[] =  0;                             
                }

                $tmpObj->id = (int)$item['id'];
                $tmpObj->entidad_id = (int)$item['entidad_id']; 
                $tmpObj->nombre = $item['nombre'];
                $objetoEntidadArray[] = $tmpObj;
            }


            $this->render('indexEntidad',array('model'=>$modelo,'objeto'=>$objetoEntidadArray,'seleccionados'=>$preSelectedCategories,'idEntidad'=>$idEntidad));
        }
    
        public function actionAsignarEntidadEntidad() {                     
            
            $entidad = new Entidad();
            $listadoAsignarEntidad = Array();
            $listadoDesAsignarEntidad = Array();


            $listadoTotal = unserialize($_POST['datos-id-list']);
            foreach(unserialize($_POST['datos-id-select']) as $programa) {   
                $listadoOriginal[] = $programa;
            }

            $entidadId = $_POST['datos-entidad-id'];    
            var_dump($entidadId);
            $id = Array(); 

            if(isset($_POST['id'])) {    
                $id = $_POST['id'];                
                for( $i=0; $i < count($listadoOriginal); $i++) {
                    if( in_array( $listadoOriginal[$i],$id) ) {
                            $listadoAsignarEntidad[] = $listadoOriginal[$i];
                        }
                    else {
                            $listadoDesAsignarEntidad[] = $listadoOriginal[$i];
                        }
                }

                if( count($listadoAsignarEntidad) )
                    $entidad->asignaEntidadEntidad($listadoAsignarEntidad, $entidadId);

                if( count($listadoDesAsignarEntidad) )
                    $entidad->desasignaProgramaEntidad($listadoDesAsignarEntidad, $entidadId);       
            }
            else{
                $entidad->desasignaProgramaEntidad($listadoOriginal, $entidadId);                   
            }


            $this->redirect(array("indexEntidad",'id'=>$entidadId));

        }
        
        public function actionBorrar() {
            
                if(isset($_POST['id'])){
                    $idEntidad = $_POST['id'];
                }
                
                $entidad = new Entidad();
                $entidad->eliminarLogicoEntidad($idEntidad);
                $this->redirect('admin');
        }
        
}
