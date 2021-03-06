<?php

class ModeloaprendizajeController extends Controller
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
				'actions'=>array('index','view'),
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
                $modelHerramienta = new ModeloAprendizajeHasHerramienta();

                if(isset($_GET['herramienta_id']))
                {
                    $herramienta = $modelHerramienta->findByPk($_GET['herramienta_id']);
                }
                else {
                    $herramientaProcedure = $modelHerramienta->listaModeloAprendizajeHasHerramienta($id);
                    $herramienta = new ModeloAprendizajeHasHerramienta();
                    foreach ($herramientaProcedure as $herramientaP){
                        $herramienta->id = $herramientaP['id'];
                        $herramienta->trabajo_grupal =  $herramientaP['trabajo_grupal'];
                        $herramienta->archivo_recurso =  $herramientaP['archivo_recurso'];
                        $herramienta->link_interes =  $herramientaP['link_interes'];
                        $herramienta->glosario =  $herramientaP['glosario'];
                        $herramienta->contenido_libre =  $herramientaP['contenido_libre'];
                        $herramienta->foro =  $herramientaP['foro'];
                        $herramienta->evaluacion =  $herramientaP['evaluacion'];
                        $herramienta->autoevaluacion =  $herramientaP['autoevaluacion'];
                        $herramienta->proyecto =  $herramientaP['proyecto'];
                        $herramienta->recepcion_trabajo =  $herramientaP['recepcion_trabajo'];
                        $herramienta->evaluacion_no_objetiva =  $herramientaP['evaluacion_no_objetiva'];
                        $herramienta->modelo_aprendizaje_id =  $herramientaP['modelo_aprendizaje_id'];
                    }                    
                }
		$this->render('view',array(
			'model'=>$this->loadModel($id),
                        'herramienta'=>$herramienta,
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionCreate()
	{
		$model=new ModeloAprendizaje();
                $herramienta = new ModeloAprendizajeHasHerramienta();

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['ModeloAprendizaje'],$_POST['ModeloAprendizajeHasHerramienta']))
		{
			$model->attributes=$_POST['ModeloAprendizaje'];
                        $herramienta->attributes= $_POST['ModeloAprendizajeHasHerramienta'];
                        
                        var_dump($model);
                        
                        
			if  ($model->agregarModeloAprendizaje(
                                $model->nombre, 
                                $model->descripcion, 
                                $herramienta->trabajo_grupal,
                                $herramienta->archivo_recurso,
                                $herramienta->link_interes, 
                                $herramienta->glosario, 
                                $herramienta->contenido_libre, 
                                $herramienta->foro, 
                                $herramienta->evaluacion, 
                                $herramienta->autoevaluacion, 
                                $herramienta->proyecto, 
                                $herramienta->recepcion_trabajo, 
                                $herramienta->evaluacion_no_objetiva)
                            )
				$this->redirect(array('view','id'=>$model->lastInsertModeloAprendizajeId,'herramienta_id'=>$model->lastInsertModeloAprendizajeHerramientaId));
		}

		$this->render('create',array(
			'model'=>$model,
                        'herramienta'=>$herramienta,
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
                $modelHerramienta = new ModeloAprendizajeHasHerramienta();
                $herramientaProcedure = $modelHerramienta->listaModeloAprendizajeHasHerramienta($id);
                $herramienta = new ModeloAprendizajeHasHerramienta();
                foreach ($herramientaProcedure as $herramientaP){
                    $herramienta->id = $herramientaP['id'];
                    $herramienta->trabajo_grupal =  $herramientaP['trabajo_grupal'];
                    $herramienta->archivo_recurso =  $herramientaP['archivo_recurso'];
                    $herramienta->link_interes =  $herramientaP['link_interes'];
                    $herramienta->glosario =  $herramientaP['glosario'];
                    $herramienta->contenido_libre =  $herramientaP['contenido_libre'];
                    $herramienta->foro =  $herramientaP['foro'];
                    $herramienta->evaluacion =  $herramientaP['evaluacion'];
                    $herramienta->autoevaluacion =  $herramientaP['autoevaluacion'];
                    $herramienta->proyecto =  $herramientaP['proyecto'];
                    $herramienta->recepcion_trabajo =  $herramientaP['recepcion_trabajo'];
                    $herramienta->evaluacion_no_objetiva =  $herramientaP['evaluacion_no_objetiva'];
                    $herramienta->modelo_aprendizaje_id =  $herramientaP['modelo_aprendizaje_id'];
                }
                

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['ModeloAprendizaje']) && isset($_POST['ModeloAprendizajeHasHerramienta']))
		{
                    $model->attributes = $_POST['ModeloAprendizaje'];
                    $herramienta->attributes = $_POST['ModeloAprendizajeHasHerramienta'];
                                                                       
                    if($model->modificarModeloAprendizaje(
                            $id,
                            $model->nombre, 
                            $model->descripcion, 
                            $herramienta->trabajo_grupal,
                            $herramienta->archivo_recurso,
                            $herramienta->link_interes, 
                            $herramienta->glosario, 
                            $herramienta->contenido_libre, 
                            $herramienta->foro, 
                            $herramienta->evaluacion, 
                            $herramienta->autoevaluacion, 
                            $herramienta->proyecto, 
                            $herramienta->recepcion_trabajo, 
                            $herramienta->evaluacion_no_objetiva)
                        )
                    {
                        
                        $this->redirect(array('view','id'=>$model->lastInsertModeloAprendizajeId,'herramienta_id'=>$model->lastInsertModeloAprendizajeHerramientaId));
                    }
			
		}

		$this->render('update',array(
			'model'=>$model,
                        'herramienta'=>$herramienta,

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
		$dataProvider=new CActiveDataProvider('ModeloAprendizaje');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new ModeloAprendizaje('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['ModeloAprendizaje']))
			$model->attributes=$_GET['ModeloAprendizaje'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return ModeloAprendizaje the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=ModeloAprendizaje::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param ModeloAprendizaje $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='modelo-aprendizaje-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
}
