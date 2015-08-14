<?php
/* @var $this ControladorUsuarioController */
/* @var $model ControladorUsuario */

$this->breadcrumbs=array(
	'Controlador Usuarios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ControladorUsuario', 'url'=>array('index')),
	array('label'=>'Manage ControladorUsuario', 'url'=>array('admin')),
);
?>

<h1>Create ControladorUsuario</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>