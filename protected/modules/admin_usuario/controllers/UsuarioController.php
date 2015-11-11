<?php
Yii::app()->getModule('admin_curricular');

class UsuarioController extends Controller
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
				'actions'=>array('index','view','admin','importar','borrar'),
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
		$model = new Usuario;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Usuario']))
		{
			$model->attributes=$_POST['Usuario'];
			if($model->agregarUsuario(
                                $model->usuario,
                                $model->clave,
                                $model->fecha_creacion,
                                $model->estado_usuario_id ? : NULL
                                
                            ))
                                
                        $this->redirect(array('view','id' => $model->llaveIdUsuario));
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

		if(isset($_POST['Usuario']))
		{
			$model->attributes=$_POST['Usuario'];
			if($model->modificarUsuario(
                                $model->id,
                                $model->usuario,
                                $model->clave,
                                $model->fecha_modificacion,
                                $model->estado_usuario_id ? : NULL
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
		$dataProvider=new CActiveDataProvider('Usuario');
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
        
        public function exportarExcel() {
                
            if(isset($_GET["excel"]))
                {
                    $model = Usuario::model()->findAll();
                    $content = $this->renderPartial("excel",array("model"=>$model),true);
                    Yii::app()->request->sendFile("test.xls",$content);
                }
        }
        
        public function exportarCsv() {
             
            if (isset($_GET["csv"])) 
                {
                    $model = Usuario::model()->findAll();
                    $content = $this->renderPartial("csv",array("model"=>$model),true);
                    Yii::app()->request->sendFile("test.csv",$content);
                }
        }
        
        public function importarUsuarios() {
            
            $model = new Usuario();
            if(isset($_POST['Usuario'])){
                    $model->attributes = $_POST['Usuario']; 
                
                    if($model->validate()){
                        $csvFile = CUploadedFile::getInstance($model,'file');  
                        $tempLoc = $csvFile->getTempName(); 
                        $model->cargarUsuarios(addslashes($tempLoc));
                        $this->redirect(array("admin"));
                    }
                }
        }
        
//        public function listPorEstado() {
//            
//            $model = new Usuario();
//            if(Yii::app()->request->isAjaxRequest){       
//                    $estado = Yii::app()->request->getParam('estado');
//                    $myHtml = CHtml::encode('Estado seleccionado...'. $estado);
//                    echo $myHtml;
//                    $logica = new LogicaEstadoUsuario();  
//                    $listadoUsuarioEstado = $logica->listarUsuarioPorEstado($estado);
//                    $this->renderPartial('_admin', array('listadoUsuarioEstado' => $listadoUsuarioEstado));       
//                }
//        
//                else{
//                    $logica = new LogicaEstadoUsuario();  
//                    $listadoUsuarioEstado = $logica->listarUsuarioPorEstado('');
//                    $listarEstados = $logica->listarEstadosUsuario();
//                    $this->render('admin', array('listadoUsuarioEstado' => $listadoUsuarioEstado,'logica' => $logica,'model'=>$model));        
//                }
//        }
        
	public function actionAdmin()
	{
                 
                $model = new Usuario('search');
		$model->unsetAttributes();
		if(isset($_GET['Usuario']))
			$model->attributes=$_GET['Usuario'];
                
                //$listadoUsuarios = Usuario::model()->findAll();
                $listadoUsuarios = $model->listarPorEstado();
                //$this->listPorEstado();
                $this->exportarExcel();
                $this->exportarCsv();
                $this->importarUsuarios();   
                $this->render('admin',array('listadoUsuarios' => $listadoUsuarios,'model'=>$model));
        }
        
                

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer $id the ID of the model to be loaded
	 * @return Usuario the loaded model
	 * @throws CHttpException
	 */
	public function loadModel($id)
	{
		$model=Usuario::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param Usuario $model the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='usuario-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
        
        public function actionBorrar() {
            
            if(isset($_POST['id'])){
                    $idUsuario = $_POST['id'];
                }
                
                $usuario = new Usuario();
                $usuario->eliminarLogico($idUsuario);
                $this->redirect('admin');
        }
       
       
}

