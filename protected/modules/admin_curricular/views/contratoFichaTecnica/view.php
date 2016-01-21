<?php
/* @var $this ContratoFichaTecnicaController */
/* @var $model ContratoFichaTecnica */

$this->breadcrumbs=array(
	'Contrato Ficha Tecnicas'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ContratoFichaTecnica', 'url'=>array('index')),
	array('label'=>'Create ContratoFichaTecnica', 'url'=>array('create')),
	array('label'=>'Update ContratoFichaTecnica', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete ContratoFichaTecnica', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ContratoFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>View ContratoFichaTecnica #<?php echo $model->id; ?></h1>

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
