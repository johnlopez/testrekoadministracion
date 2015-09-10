<?php

class DatoAcademicoController extends Controller
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
				'actions'=>array('index','view','admin','borradoFisicoDatoAcademico'),
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
		$model=new DatoAcademico;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['DatoAcademico']))
		{
			$model->attributes=$_POST['DatoAcademico'];
			if($model->agregarDatoAcademico(
                                $model->universidad,
                                $model->carrera,
                                $model->ano_cursado,
                                $model->duracion_carrera,
                                $model->sede,
                                $model->direccion_sede,
                                $model->comuna_sede,
                                $model->ciudad_sede,
                                $model->usuario_id          
                            ))
				
                        $this->redirect(array('view','id'=>$model->llaveIdAcademico));
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

		if(isset($_POST['DatoAcademico']))
		{
			$model->attributes=$_POST['DatoAcademico'];
			if($model->modificarDatoAcademico(
                                $model->id,
                                $model->universidad,
                                $model->carrera,
                                $model->ano_cursado,
                                $model->duracion_carrera,
                                $model->sede,
                                $model->direccion_sede,
                                $model->comuna_sede,
                                $model->ciudad_sede,
                                $model->usuario_id 
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
		$dataProvider=new CActiveDataProvider('DatoAcademico');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new DatoAcademico('search');
                //$listadoDatoAcademico = DatoAcademico::model()->findAll();
                $listadoDatoAcademico = $model->listarPorEstado();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['DatoAcademico']))
			$model->attributes=$_GET['DatoAcademico'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoDatoAcademico' => $listadoDatoAcademico,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return DatoAcademico the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=DatoAcademico::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param DatoAcademico $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='dato-academico-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionBorradoFisicoDatoAcademico() {
            
                if(isset($_POST['id'])){
                    $idDatoAcademico = $_POST['id'];
                }
                
                $datoAcademico = new DatoAcademico();
                $datoAcademico->eliminadoFisicoDatoAcademico($idDatoAcademico);
                $this->redirect('admin');
        }
}
