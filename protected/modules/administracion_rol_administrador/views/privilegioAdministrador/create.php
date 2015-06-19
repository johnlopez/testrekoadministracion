<?php
/* @var $this PrivilegioAdministradorController */
/* @var $model PrivilegioAdministrador */

$this->breadcrumbs=array(
	'Privilegio Administradors'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List PrivilegioAdministrador', 'url'=>array('index')),
	array('label'=>'Manage PrivilegioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Create PrivilegioAdministrador</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>