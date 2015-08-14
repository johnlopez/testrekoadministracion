<?php
/* @var $this DatoAcademicoController */
/* @var $model DatoAcademico */

$this->breadcrumbs=array(
	'Dato Academicos'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List DatoAcademico', 'url'=>array('index')),
	array('label'=>'Create DatoAcademico', 'url'=>array('create')),
	array('label'=>'Update DatoAcademico', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete DatoAcademico', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage DatoAcademico', 'url'=>array('admin')),
);
?>

<h1>View DatoAcademico #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'universidad',
		'carrera',
		'ano_cursado',
		'duracion_carrera',
		'sede',
		'direccion_sede',
		'comuna_sede',
		'ciudad_sede',
		'usuario_id',
	),
)); ?>
