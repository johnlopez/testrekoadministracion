<?php
/* @var $this ControladorAdministradorController */
/* @var $model ControladorAdministrador */

$this->breadcrumbs=array(
	'Controlador Administradors'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ControladorAdministrador', 'url'=>array('index')),
	array('label'=>'Create ControladorAdministrador', 'url'=>array('create')),
	array('label'=>'View ControladorAdministrador', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ControladorAdministrador', 'url'=>array('admin')),
);
?>

<h1>Update ControladorAdministrador <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>