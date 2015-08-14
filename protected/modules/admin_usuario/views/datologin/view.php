<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */

$this->breadcrumbs=array(
	'Dato Logins'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List DatoLogin', 'url'=>array('index')),
	array('label'=>'Create DatoLogin', 'url'=>array('create')),
	array('label'=>'Update DatoLogin', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete DatoLogin', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage DatoLogin', 'url'=>array('admin')),
);
?>

<h1>View DatoLogin #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'pregunta_secreta_1',
		'pregunta_secreta_2',
		'respuesta_secreta_1',
		'respuesta_secreta_2',
		'usuario_id',
	),
)); ?>
