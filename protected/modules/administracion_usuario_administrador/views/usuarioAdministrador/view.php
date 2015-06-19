<?php
/* @var $this UsuarioAdministradorController */
/* @var $model UsuarioAdministrador */

$this->breadcrumbs=array(
	'Usuario Administradors'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UsuarioAdministrador', 'url'=>array('index')),
	array('label'=>'Create UsuarioAdministrador', 'url'=>array('create')),
	array('label'=>'Update UsuarioAdministrador', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete UsuarioAdministrador', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UsuarioAdministrador', 'url'=>array('admin')),
);
?>

<h1>View UsuarioAdministrador #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'usuario',
		'clave',
	),
)); ?>
