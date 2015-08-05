<?php
/* @var $this EntidadController */
/* @var $model Entidad */

$this->breadcrumbs=array(
	'Entidads'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Entidad', 'url'=>array('index')),
	array('label'=>'Manage Entidad', 'url'=>array('admin')),
);
?>

<h1>Create Entidad</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>