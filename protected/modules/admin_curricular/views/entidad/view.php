<?php
/* @var $this EntidadController */
/* @var $model Entidad */

$this->breadcrumbs=array(
	'Entidads'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List Entidad', 'url'=>array('index')),
	array('label'=>'Create Entidad', 'url'=>array('create')),
	array('label'=>'Update Entidad', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete Entidad', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Entidad', 'url'=>array('admin')),
);
?>

<h1>View Entidad #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
		'institucion_id',
		'entidad_id',
	),
)); ?>
