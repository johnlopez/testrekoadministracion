<?php
/* @var $this ControladorAdministradorController */
/* @var $model ControladorAdministrador */

$this->breadcrumbs=array(
	'Controlador Administradors'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ControladorAdministrador', 'url'=>array('index')),
	array('label'=>'Manage ControladorAdministrador', 'url'=>array('admin')),
);
?>

<h1>Create ControladorAdministrador</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>