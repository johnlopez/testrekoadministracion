<?php
/* @var $this LogicaEstadoUsuarioController */
/* @var $model LogicaEstadoUsuario */

$this->breadcrumbs=array(
	'Logica Estado Usuarios'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List LogicaEstadoUsuario', 'url'=>array('index')),
	array('label'=>'Create LogicaEstadoUsuario', 'url'=>array('create')),
	array('label'=>'Update LogicaEstadoUsuario', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete LogicaEstadoUsuario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage LogicaEstadoUsuario', 'url'=>array('admin')),
);
?>

<h1>View LogicaEstadoUsuario #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'estado',
	),
)); ?>
