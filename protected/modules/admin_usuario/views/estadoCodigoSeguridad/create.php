<?php
/* @var $this EstadoCodigoSeguridadController */
/* @var $model EstadoCodigoSeguridad */

$this->breadcrumbs=array(
	'Estado Codigo Seguridads'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List EstadoCodigoSeguridad', 'url'=>array('index')),
	array('label'=>'Manage EstadoCodigoSeguridad', 'url'=>array('admin')),
);
?>

<h1>Create EstadoCodigoSeguridad</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>