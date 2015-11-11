<?php
/* @var $this ModeloAprendizajeController */
/* @var $model ModeloAprendizaje */

$this->breadcrumbs=array(
	'Modelo Aprendizajes'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ModeloAprendizaje', 'url'=>array('index')),
	array('label'=>'Create ModeloAprendizaje', 'url'=>array('create')),
	array('label'=>'Update ModeloAprendizaje', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete ModeloAprendizaje', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ModeloAprendizaje', 'url'=>array('admin')),
);
?>

<h1>View ModeloAprendizaje #<?php echo $model->id; ?></h1>

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
