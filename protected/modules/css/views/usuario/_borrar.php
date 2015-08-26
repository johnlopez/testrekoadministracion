<?php

public function actionView($id)
{
        $this->render('view',array(
                'model'=>$this->loadModel($id),
        ));
}

public function actionUpdate($id)
{
        $model=$this->loadModel($id);

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if(isset($_POST['Usuario']))
        {
                $model->attributes=$_POST['Usuario'];
                if($model->save())
                        $this->redirect(array('view','id'=>$model->id));
        }

        $this->render('update',array(
                'model'=>$model,
        ));
}