<?php
/* @var $this ControladorAdministradorController */
/* @var $model ControladorAdministrador */

$this->breadcrumbs=array(
	'Controlador Administradors'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ControladorAdministrador', 'url'=>array('index')),
	array('label'=>'Create ControladorAdministrador', 'url'=>array('create')),
	array('label'=>'Update ControladorAdministrador', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete ControladorAdministrador', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ControladorAdministrador', 'url'=>array('admin')),
);
?>

<h1>View ControladorAdministrador #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'authitem_permiso_administrador_name',
	),
)); ?>
