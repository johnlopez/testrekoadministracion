<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */

$this->breadcrumbs=array(
	'Dato Laborals'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List DatoLaboral', 'url'=>array('index')),
	array('label'=>'Create DatoLaboral', 'url'=>array('create')),
	array('label'=>'Update DatoLaboral', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete DatoLaboral', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage DatoLaboral', 'url'=>array('admin')),
);
?>

<h1>View DatoLaboral #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre_empresa',
		'ano_antiguedad',
		'cargo',
		'actividad',
		'comuna_empresa',
		'ciudad_empresa',
		'telefono_empresa',
		'celular_empresa',
		'rut_numero',
		'digito_verificador',
		'usuario_id',
	),
)); ?>
