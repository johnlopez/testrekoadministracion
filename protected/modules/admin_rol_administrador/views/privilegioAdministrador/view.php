<?php
/* @var $this PrivilegioAdministradorController */
/* @var $model PrivilegioAdministrador */

$this->breadcrumbs=array(
	'Privilegio Administradors'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List PrivilegioAdministrador', 'url'=>array('index')),
	array('label'=>'Create PrivilegioAdministrador', 'url'=>array('create')),
	array('label'=>'Update PrivilegioAdministrador', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete PrivilegioAdministrador', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PrivilegioAdministrador', 'url'=>array('admin')),
);
?>

<h1>View PrivilegioAdministrador #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'controlador_administrador_id',
	),
)); ?>
