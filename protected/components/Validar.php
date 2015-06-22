<?php 
class Validar extends CApplicationComponent
{
    
    public $vista;
   //public $idioma; // configurable en config/main.php 
   public function init(){
    // init es llamado por Yii, debido a que es un componente.
   }
   public function obtenerPrivilegio($id,$nombreModulo,$nombreControlador,$nombreAction) {
       $comando = Yii::app()->db->createCommand("CALL validar_privilegio(:id,:nombreModulo,:nombreControlador,:nombreAction,@vista)");
       $comando->bindParam(':id',$id);
       $comando->bindParam(':nombreModulo',$nombreModulo );
       $comando->bindParam(':nombreControlador',$nombreControlador);
       $comando->bindParam(':nombreAction',$nombreAction);
       $comando->execute();
       $this->vista =  Yii::app()->db->createCommand("select @vista as result;")->queryScalar();
       return $comando;
   }
   public function validarAcceso()
   {
       $id = Yii::app()->user->getId();
       $nombreModulo = Yii::app()->controller->module->id;
       $nombreControlador = Yii::app()->controller->id;
       $nombreAction = Yii::app()->controller->action->id;
       
       $this->obtenerPrivilegio($id, $nombreModulo, $nombreControlador, $nombreAction);
       $vistas = $this->vista;
        return(       
                array(
                        array('allow',
				'actions'=>array(
                                                    $vistas,
                                                    /*'view',
                                                    'admin',
                                                    'create',
                                                    'update',
                                                    'delete'*/
                                    ),
				'roles'=>array(Yii::app()->controller->module->id),
			),
			array('deny',
				'users'=>array('*'),
			),
		)
        );
   }
   public function comprobarRuta()
   {
        echo Yii::app()->user->getId(); 
        echo "<br>";
        echo Yii::app()->controller->module->id;
        echo "<br>";
        echo Yii::app()->controller->id;
        echo "<br>";
        echo Yii::app()->controller->action->id;
        echo "<br>";  
   }
} 
//
//<?php 
//class Validar extends CApplicationComponent
//{
//   //public $idioma; // configurable en config/main.php 
//   public function init(){
//    // init es llamado por Yii, debido a que es un componente.
//   }
//   
//   public function obtenerPrivilegio($id,$nombreModulo,$nombreControlador,$nombreAction) {
//       
//       $id = Yii::app()->user->getId(); 
//       $nombreModulo = Yii::app()->controller->module->id;
//       $nombreControlador = Yii::app()->controller->id;
//       $nombreAction = Yii::app()->controller->action->id;
//       
//       $comando = Yii::app()->db->createCommand("CALL validar_privilegio($id,$nombreModulo,$nombreControlador,$nombreAction)");
//       return $comando;
//   }
//   public function validarAcceso()
//   {
//        return(       
//                array(
//                        array('allow',
//				'actions'=>array(
//                                        $this->obtenerPrivilegio($id, $nombreModulo, $nombreControlador, $nombreAction)
//                                    ),
//				'roles'=>array(Yii::app()->controller->module->id),
//			),
//			array('deny',
//				'users'=>array('*'),
//			),
//		)
//        );
//   }
//   
//} 