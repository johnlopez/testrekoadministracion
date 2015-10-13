<?php

class InstitucionController extends Controller
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
				'actions'=>array('index','view','admin','borrar'),
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
		$model=new Institucion;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Institucion']))
		{
			$model->attributes=$_POST['Institucion'];
			if($model->agregarInstitucion(
                                $model->nombre,
                                $model->vision,
                                $model->mision,
                                $model->acreditada,
                                $model->fecha_inicio_acreditacion,
                                $model->fecha_termino_acreditacion,
                                $model->descripcion,
                                $model->fecha_creacion
                        ))
				
                    $this->redirect(array('view','id'=>$model->llaveIdInstitucion));
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

		if(isset($_POST['Institucion']))
		{
			$model->attributes=$_POST['Institucion'];
			if($model->modificarInstitucion(
                                $model->id,
                                $model->nombre,
                                $model->vision,
                                $model->mision,
                                $model->acreditada,
                                $model->fecha_inicio_acreditacion,
                                $model->fecha_termino_acreditacion,
                                $model->descripcion,
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
		$dataProvider=new CActiveDataProvider('Institucion');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model = new Institucion('search');
                //$listadoInstitucion = Institucion::model()->findAll();
                $listadoInstitucion = $model->listarInstitucionPorEstado();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Institucion']))
			$model->attributes=$_GET['Institucion'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoInstitucion' => $listadoInstitucion,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Institucion the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Institucion::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Institucion $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='institucion-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionBorrar() {
            
                if(isset($_POST['id'])){
                    $idInstitucion = $_POST['id'];
                }
                
                $institucion = new Institucion();
                $institucion->eliminarLogicoInstitucion($idInstitucion);
                $this->redirect('admin');
        }
        
}
