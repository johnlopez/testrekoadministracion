<?php
/* @var $this RolUsuarioController */
/* @var $model RolUsuario */

$this->breadcrumbs=array(
	'Rol Usuarios'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RolUsuario', 'url'=>array('index')),
	array('label'=>'Create RolUsuario', 'url'=>array('create')),
	array('label'=>'Update RolUsuario', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RolUsuario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RolUsuario', 'url'=>array('admin')),
);
?>

<h1>View RolUsuario #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
	),
)); ?>
