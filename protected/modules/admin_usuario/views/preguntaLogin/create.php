<?php
/* @var $this PreguntaLoginController */
/* @var $model PreguntaLogin */

$this->breadcrumbs=array(
	'Pregunta Logins'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PreguntaLogin', 'url'=>array('index')),
	array('label'=>'Manage PreguntaLogin', 'url'=>array('admin')),
);
?>

<h1>Create PreguntaLogin</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>