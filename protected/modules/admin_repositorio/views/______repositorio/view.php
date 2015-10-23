<?php
/* @var $this RepositorioController */
/* @var $model Repositorio */

$this->breadcrumbs=array(
	'Repositorios'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List Repositorio', 'url'=>array('index')),
	array('label'=>'Create Repositorio', 'url'=>array('create')),
	array('label'=>'Update Repositorio', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete Repositorio', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Repositorio', 'url'=>array('admin')),
);
?>

<h1>View Repositorio #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		'tipo_repositorio_id',
	),
)); ?>
