<?php
/* @var $this DatoPersonalController */
/* @var $model DatoPersonal */

$this->breadcrumbs=array(
	'Dato Personals'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List DatoPersonal', 'url'=>array('index')),
	array('label'=>'Create DatoPersonal', 'url'=>array('create')),
	array('label'=>'Update DatoPersonal', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete DatoPersonal', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage DatoPersonal', 'url'=>array('admin')),
);
?>

<h1>View DatoPersonal #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'primer_nombre',
		'segundo_nombre',
		'apellido_paterno',
		'apellido_materno',
		'fecha_nacimiento',
		'edad',
		'rut',
		'digito_verificador',
		'direccion_personal',
		'numero_casa',
		'telefono_personal',
		'celular_personal',
		'dato_personalcol',
		'comuna_personal',
		'ciudad_personal',
		'interes',
		'estado_civil',
		'idioma',
		'nacionalidad',
		'usuario_id',
	),
)); ?>
