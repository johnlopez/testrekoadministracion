<?php
/* @var $this RepositoriomasterController */
/* @var $model RepositorioMaster */

$this->breadcrumbs=array(
	'Repositorio Masters'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RepositorioMaster', 'url'=>array('index')),
	array('label'=>'Create RepositorioMaster', 'url'=>array('create')),
	array('label'=>'Update RepositorioMaster', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RepositorioMaster', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>View RepositorioMaster #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		'modelo_aprendizaje_master_id',
		'secuencia_master_id',
		'repositorio_master_id',
		'tipo_repositorio_master_id',
	),
)); ?>
