<?php
/* @var $this InstitucionController */
/* @var $model Institucion */

$this->breadcrumbs=array(
	'Institucions'=>array('index'),
	$model->id,
);

?>

<h1>View Institucion #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'vision',
		'mision',
		'acreditada',
		'fecha_inicio_acreditacion',
		'fecha_termino_acreditacion',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
	),
)); ?>
