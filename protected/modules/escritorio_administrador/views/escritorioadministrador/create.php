<?php
/* @var $this EscritorioAdministradorController */
/* @var $model EscritorioAdministrador */

$this->breadcrumbs=array(
	'Escritorio Administradors'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List EscritorioAdministrador', 'url'=>array('index')),
	array('label'=>'Manage EscritorioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Create EscritorioAdministrador</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>