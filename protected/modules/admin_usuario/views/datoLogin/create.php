<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */

$this->breadcrumbs=array(
	'Dato Logins'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List DatoLogin', 'url'=>array('index')),
	array('label'=>'Manage DatoLogin', 'url'=>array('admin')),
);
?>

<h1>Create DatoLogin</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>