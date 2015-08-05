<?php
/* @var $this LogicaEstadoUsuarioController */
/* @var $model LogicaEstadoUsuario */

$this->breadcrumbs=array(
	'Logica Estado Usuarios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List LogicaEstadoUsuario', 'url'=>array('index')),
	array('label'=>'Manage LogicaEstadoUsuario', 'url'=>array('admin')),
);
?>

<h1>Create LogicaEstadoUsuario</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>