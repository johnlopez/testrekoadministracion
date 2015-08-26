<?php
/* @var $this PreguntaLoginController */
/* @var $model PreguntaLogin */

$this->breadcrumbs=array(
	'Pregunta Logins'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List PreguntaLogin', 'url'=>array('index')),
	array('label'=>'Create PreguntaLogin', 'url'=>array('create')),
	array('label'=>'Update PreguntaLogin', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete PreguntaLogin', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PreguntaLogin', 'url'=>array('admin')),
);
?>

<h1>View PreguntaLogin #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'pregunta',
	),
)); ?>
