<?php
/* @var $this AuthitemPermisoUsuarioController */
/* @var $model AuthitemPermisoUsuario */

$this->breadcrumbs=array(
	'Authitem Permiso Usuarios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List AuthitemPermisoUsuario', 'url'=>array('index')),
	array('label'=>'Manage AuthitemPermisoUsuario', 'url'=>array('admin')),
);
?>

<h1>Create AuthitemPermisoUsuario</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>