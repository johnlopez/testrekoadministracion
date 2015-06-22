<?php 
class Validar extends CApplicationComponent
{
   //public $idioma; // configurable en config/main.php 
   public function init(){
    // init es llamado por Yii, debido a que es un componente.
   }
   public function validarAcceso()
   {
        return(       
                array(
                        array('allow',
				'actions'=>array(
                                                    'index',
                                                    'view',
                                                    'admin',
                                                    'create',
                                                    'update',
                                                    'delete'
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