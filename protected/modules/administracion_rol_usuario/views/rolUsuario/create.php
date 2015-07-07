<?php
/* @var $this RolUsuarioController */
/* @var $model RolUsuario */

$this->breadcrumbs=array(
	'Rol Usuarios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RolUsuario', 'url'=>array('index')),
	array('label'=>'Manage RolUsuario', 'url'=>array('admin')),
);
?>

<h1>Create RolUsuario</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>