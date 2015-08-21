<?php
/* @var $this RolAdministradorController */
/* @var $model RolAdministrador */

$this->breadcrumbs=array(
	'Rol Administradors'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RolAdministrador', 'url'=>array('index')),
	array('label'=>'Create RolAdministrador', 'url'=>array('create')),
	array('label'=>'Update RolAdministrador', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RolAdministrador', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RolAdministrador', 'url'=>array('admin')),
);
?>

<h1>View RolAdministrador #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
	),
)); ?>
