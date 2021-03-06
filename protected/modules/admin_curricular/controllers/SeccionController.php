<?php

class SeccionController extends Controller
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
				'actions'=>array('index','view','admin','borrar','index2'),
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
		$model=new Seccion;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Seccion']))
		{
			$model->attributes=$_POST['Seccion'];
			if($model->agregarSeccion(
                                $model->nombre,
                                $model->codigo,
                                $model->jornada,
                                $model->descripcion,  
                                $model->fecha_creacion,
                                $model->estado_seccion_id ? : NULL,
                                $model->modulo_id        
                        ))
				
                            
                    $this->redirect(array('view','id'=>$model->llaveIdSeccion));
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

		if(isset($_POST['Seccion']))
		{
			$model->attributes=$_POST['Seccion'];
			if($model->modificarSeccion(
                                $model->id,
                                $model->nombre,
                                $model->codigo,
                                $model->jornada,
                                $model->descripcion,  
                                $model->fecha_modificacion,
                                $model->estado_seccion_id ? : NULL,
                                $model->modulo_id           
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
		$dataProvider=new CActiveDataProvider('Seccion');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new Seccion('search');
                //$listadoSeccion = Seccion::model()->findAll();
                $listadoSeccion = $model->listarSeccionesPorEstado();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Seccion']))
			$model->attributes=$_GET['Seccion'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoSeccion' => $listadoSeccion,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Seccion the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Seccion::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Seccion $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='seccion-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionBorrar() {
            
                if(isset($_POST['id'])){
                    $idSeccion = $_POST['id'];
                }
                
                $seccion = new Seccion();
                $seccion->eliminarLogicoSeccion($idSeccion);
                $this->redirect('admin');
        }
        
        public function actionIndex2() {
            
            $seccion = new Seccion();
            
            if(isset($_GET['id'])){
                $idModulo = $_GET['id'];
            }
            
            $listadoSeccion = $seccion->listarSeccionesPorModulo($idModulo);   
            $this->render('index2', array('listadoSeccion' => $listadoSeccion));
        }
}
