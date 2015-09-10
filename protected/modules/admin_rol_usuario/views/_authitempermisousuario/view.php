<?php
/* @var $this AuthitemPermisoUsuarioController */
/* @var $model AuthitemPermisoUsuario */

$this->breadcrumbs=array(
	'Authitem Permiso Usuarios'=>array('index'),
	$model->name,
);

$this->menu=array(
	array('label'=>'List AuthitemPermisoUsuario', 'url'=>array('index')),
	array('label'=>'Create AuthitemPermisoUsuario', 'url'=>array('create')),
	array('label'=>'Update AuthitemPermisoUsuario', 'url'=>array('update', 'id'=>$model->name)),
	array('label'=>'Delete AuthitemPermisoUsuario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->name),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage AuthitemPermisoUsuario', 'url'=>array('admin')),
);
?>

<h1>View AuthitemPermisoUsuario #<?php echo $model->name; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'name',
		'type',
		'description',
		'bizrule',
		'data',
	),
)); ?>
