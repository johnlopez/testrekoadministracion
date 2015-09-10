<?php

class DatoPersonalController extends Controller
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
				'actions'=>array('index','view','admin','borradoFisicoDatoPersonal'),
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
		$model=new DatoPersonal;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['DatoPersonal']))
		{
			$model->attributes=$_POST['DatoPersonal'];
			if($model->agregarDatoPersonal(
                                $model->primer_nombre,
                                $model->segundo_nombre,
                                $model->apellido_paterno,
                                $model->apellido_materno,
                                $model->fecha_nacimiento,
                                $model->edad,
                                $model->rut,
                                $model->digito_verificador,
                                $model->direccion_personal,
                                $model->numero_casa,
                                $model->telefono_personal,
                                $model->celular_personal,
                                $model->comuna_personal,
                                $model->ciudad_personal,
                                $model->interes,
                                $model->estado_civil,
                                $model->idioma,
                                $model->nacionalidad,
                                $model->usuario_id
                            ))
				
                        $this->redirect(array('view','id'=>$model->llaveIdPersonal));
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

		if(isset($_POST['DatoPersonal']))
		{
			$model->attributes=$_POST['DatoPersonal'];
			if($model->modificarDatoPersonal(
                                $model->id,
                                $model->primer_nombre,
                                $model->segundo_nombre,
                                $model->apellido_paterno,
                                $model->apellido_materno,
                                $model->fecha_nacimiento,
                                $model->edad,
                                $model->rut,
                                $model->digito_verificador,
                                $model->direccion_personal,
                                $model->numero_casa,
                                $model->telefono_personal,
                                $model->celular_personal,
                                $model->comuna_personal,
                                $model->ciudad_personal,
                                $model->interes,
                                $model->estado_civil,
                                $model->idioma,
                                $model->nacionalidad,
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
		$dataProvider=new CActiveDataProvider('DatoPersonal');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new DatoPersonal('search');
                //$listadoDatoPersonal = DatoPersonal::model()->findAll();
                $listadoDatoPersonal = $model->listarPorEstado();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['DatoPersonal']))
			$model->attributes=$_GET['DatoPersonal'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoDatoPersonal' => $listadoDatoPersonal,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return DatoPersonal the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=DatoPersonal::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param DatoPersonal $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='dato-personal-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionBorradoFisicoDatoPersonal() {
            
                if(isset($_POST['id'])){
                    $idDatoPersonal = $_POST['id'];
                }
                
                $datoPersonal = new DatoPersonal();
                $datoPersonal->eliminadoFisicoDatoPersonal($idDatoPersonal);
                $this->redirect('admin');
        }
}
