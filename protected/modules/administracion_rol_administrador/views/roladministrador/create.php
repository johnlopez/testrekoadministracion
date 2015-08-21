<?php
/* @var $this RolAdministradorController */
/* @var $model RolAdministrador */

$this->breadcrumbs=array(
	'Rol Administradors'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RolAdministrador', 'url'=>array('index')),
	array('label'=>'Manage RolAdministrador', 'url'=>array('admin')),
);
?>

<h1>Create RolAdministrador</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>