<?php
/* @var $this ItemFichaTecnicaController */
/* @var $model ItemFichaTecnica */

$this->breadcrumbs=array(
	'Item Ficha Tecnicas'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ItemFichaTecnica', 'url'=>array('index')),
	array('label'=>'Create ItemFichaTecnica', 'url'=>array('create')),
	array('label'=>'Update ItemFichaTecnica', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete ItemFichaTecnica', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ItemFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>View ItemFichaTecnica #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
		'ficha_tecnica_id',
	),
)); ?>
