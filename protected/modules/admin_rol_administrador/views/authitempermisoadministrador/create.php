<?php
/* @var $this AuthitemPermisoAdministradorController */
/* @var $model AuthitemPermisoAdministrador */

$this->breadcrumbs=array(
	'Authitem Permiso Administradors'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List AuthitemPermisoAdministrador', 'url'=>array('index')),
	array('label'=>'Manage AuthitemPermisoAdministrador', 'url'=>array('admin')),
);
?>

<h1>Create AuthitemPermisoAdministrador</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>