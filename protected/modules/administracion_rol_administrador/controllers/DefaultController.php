<?php

class DefaultController extends Controller
{
	public function actionIndex()
	{
            echo Yii::app()->controller->module->id;
		$this->render('index');
	}
        
}