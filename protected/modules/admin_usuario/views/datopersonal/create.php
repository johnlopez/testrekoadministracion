<?php
/* @var $this DatoPersonalController */
/* @var $model DatoPersonal */

$this->breadcrumbs=array(
	'Dato Personals'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List DatoPersonal', 'url'=>array('index')),
	array('label'=>'Manage DatoPersonal', 'url'=>array('admin')),
);
?>

<h1>Create DatoPersonal</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>