<?php
/* @var $this UsuarioAdministradorController */
/* @var $model UsuarioAdministrador */

$this->breadcrumbs=array(
	'Usuario Administradors'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UsuarioAdministrador', 'url'=>array('index')),
	array('label'=>'Manage UsuarioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Create UsuarioAdministrador</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>