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
				'actions'=>array('index','view','admin','admin2','admin3','listaRoles','listaRolesModulo','admin4','listaRolesSeccion'),
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
        
        public function actionView($id)
	{
		$this->render('view',array(
			'model'=>$this->loadModel($id),
		));
	}

	public function actionAdmin()
	{
		$model=new Institucion('search');
                $listadoInstitucion = Institucion::model()->findAll();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Institucion']))
			$model->attributes=$_GET['Institucion'];

		$this->render('admin',array(
			'model'=>$model,
                        'listadoInstitucion' => $listadoInstitucion,
		));
	}
        
        public function actionAdmin2()
	{
		$model=new Institucion('search');
                $listadoInstitucion = Institucion::model()->findAll();
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Institucion']))
			$model->attributes=$_GET['Institucion'];

		$this->render('admin2',array(
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
        
        public function actionAdmin3() {
            
            $programa = new ProgramaAcademico();
            if(isset($_GET['id'])){
                $id = $_GET['id'];
            }
            $listadoPrograma = $programa->listarProgramasPorInstitucion($id);
            $this->render('admin3',array('listadoPrograma' => $listadoPrograma));
        }
        
        public function actionListaRoles() {
            
            $institucion = new Institucion();
            if(isset($_GET['id'])){
                $id = $_GET['id'];
            }
            $listadoRoles = $institucion->listarRolesPorInstitucion($id);
            $this->render('listaRoles', array('listadoRoles' => $listadoRoles, 'programa_id' => $id));
        }
        
        
        public function actionListaRolesModulo() {
            
            $institucion = new Institucion();
             if(isset($_GET['id'])){
                $id = $_GET['id'];
            }
            
            $listadoRolesModulo = $institucion->listarRolesPorInstitucionModulo($id);
            
            $this->render('listaRolesModulo', array('listadoRolesModulo' => $listadoRolesModulo, 'modulo_id' => $id));
        }
        
        
        public function actionAdmin4() {
            
            $model = new Institucion();
            $listadoInstitucion = Institucion::model()->findAll();
            $this->render('admin4',array('listadoInstitucion' => $listadoInstitucion, 'model' => $model));
        }
        
        
        public function actionListaRolesSeccion() {
            
            $institucion = new Institucion();
            
            if(isset($_GET['id'])){
                $idSeccion = $_GET['id'];
            }
            
            $listadoRolesSeccion = $institucion->listarRolesPorInstitucionSeccion($idSeccion);
            $this->render('listaRolesSeccion', array('listadoRolesSeccion' => $listadoRolesSeccion, 'seccion_id' => $idSeccion));
        }
   
}
