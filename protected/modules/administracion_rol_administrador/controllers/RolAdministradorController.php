<?php

class RolAdministradorController extends Controller
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
		$model=new RolAdministrador;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['RolAdministrador']))
		{
			$model->attributes=$_POST['RolAdministrador'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
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

		if(isset($_POST['RolAdministrador']))
		{
			$model->attributes=$_POST['RolAdministrador'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		$this->loadModel($id)->delete();

		// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
		if(!isset($_GET['ajax']))
			$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
                //Yii::app()->Validar->obtenerPrivilegio(1,'administracion_rol_administrador','roladministrador','index');
		$dataProvider=new CActiveDataProvider('RolAdministrador');
                //Yii::log( Yii::app()->Validar->vista,'','reko2.component');
		/*$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));*/
                $this->render('index',array(
			'dataProvider'=>$dataProvider,
                ));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new RolAdministrador('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['RolAdministrador']))
			$model->attributes=$_GET['RolAdministrador'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}
        public function actionAsignar()
	{            
                $model = new AuthitemPermisoAdministrador();
                $rol = new RolAdministrador();
                if(isset($_GET['id'])) {
                    
                    $vrol = $rol::model()->findByPk($_GET['id']);			
                    $this->render('asignar', array('model' => $model,'vrol'=>$vrol));
                }
                
                if(isset($_POST['AuthitemPermisoAdministrador']))
                {                    
                    foreach ($_POST['AuthitemPermisoAdministrador']['name'] as $permiso)
                    {
                         $rol->asignarPermisoARol($_GET['id'], $permiso);
                         //$rol->desasignarPermisoRol($_GET['id'], $permiso);
                         $listado = $rol->privilegioPermiso($permiso);
                    
                        foreach ($listado as $lista)
                        {
                            $rol->asignarPrivilegioRol($_GET['id'], $lista['id']);
                            //$rol->desasignarPrivilegio($_GET['id'], $lista['id']);
                            echo $lista['id']."<br>"; 
                        }
                    }
                    
                }
	}


	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return RolAdministrador the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=RolAdministrador::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param RolAdministrador $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='rol-administrador-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
}
