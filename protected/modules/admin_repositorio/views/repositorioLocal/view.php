<?php
/* @var $this RepositorioLocalController */
/* @var $model RepositorioLocal */

$this->breadcrumbs=array(
	'Repositorio Locals'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RepositorioLocal', 'url'=>array('index')),
	array('label'=>'Create RepositorioLocal', 'url'=>array('create')),
	array('label'=>'Update RepositorioLocal', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RepositorioLocal', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RepositorioLocal', 'url'=>array('admin')),
);
?>

<h1>View RepositorioLocal #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
	),
)); ?>
