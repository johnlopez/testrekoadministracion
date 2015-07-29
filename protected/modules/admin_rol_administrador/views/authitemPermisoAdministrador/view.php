<?php
/* @var $this AuthitemPermisoAdministradorController */
/* @var $model AuthitemPermisoAdministrador */

$this->breadcrumbs=array(
	'Authitem Permiso Administradors'=>array('index'),
	$model->name,
);

$this->menu=array(
	array('label'=>'List AuthitemPermisoAdministrador', 'url'=>array('index')),
	array('label'=>'Create AuthitemPermisoAdministrador', 'url'=>array('create')),
	array('label'=>'Update AuthitemPermisoAdministrador', 'url'=>array('update', 'id'=>$model->name)),
	array('label'=>'Delete AuthitemPermisoAdministrador', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->name),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage AuthitemPermisoAdministrador', 'url'=>array('admin')),
);
?>

<h1>View AuthitemPermisoAdministrador #<?php echo $model->name; ?></h1>

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
