<?php
/* @var $this PrivilegioUsuarioController */
/* @var $model PrivilegioUsuario */

$this->breadcrumbs=array(
	'Privilegio Usuarios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PrivilegioUsuario', 'url'=>array('index')),
	array('label'=>'Manage PrivilegioUsuario', 'url'=>array('admin')),
);
?>

<h1>Create PrivilegioUsuario</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>