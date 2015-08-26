<?php
/* @var $this EstadoCodigoSeguridadController */
/* @var $model EstadoCodigoSeguridad */

$this->breadcrumbs=array(
	'Estado Codigo Seguridads'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List EstadoCodigoSeguridad', 'url'=>array('index')),
	array('label'=>'Create EstadoCodigoSeguridad', 'url'=>array('create')),
	array('label'=>'Update EstadoCodigoSeguridad', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete EstadoCodigoSeguridad', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage EstadoCodigoSeguridad', 'url'=>array('admin')),
);
?>

<h1>View EstadoCodigoSeguridad #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'estado',
		'codigo_seguridad_id',
	),
)); ?>
