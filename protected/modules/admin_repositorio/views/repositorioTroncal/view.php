<?php
/* @var $this RepositorioTroncalController */
/* @var $model RepositorioTroncal */

$this->breadcrumbs=array(
	'Repositorio Troncals'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RepositorioTroncal', 'url'=>array('index')),
	array('label'=>'Create RepositorioTroncal', 'url'=>array('create')),
	array('label'=>'Update RepositorioTroncal', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RepositorioTroncal', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RepositorioTroncal', 'url'=>array('admin')),
);
?>

<h1>View RepositorioTroncal #<?php echo $model->id; ?></h1>

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
