<?php
/* @var $this FichaTecnicaController */
/* @var $model FichaTecnica */

$this->breadcrumbs=array(
	'Ficha Tecnicas'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List FichaTecnica', 'url'=>array('index')),
	array('label'=>'Create FichaTecnica', 'url'=>array('create')),
	array('label'=>'Update FichaTecnica', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete FichaTecnica', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage FichaTecnica', 'url'=>array('admin')),
);
?>

<h1>View FichaTecnica #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
                'nombre',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
	),
)); ?>
