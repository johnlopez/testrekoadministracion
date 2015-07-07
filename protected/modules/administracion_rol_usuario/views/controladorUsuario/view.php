<?php
/* @var $this ControladorUsuarioController */
/* @var $model ControladorUsuario */

$this->breadcrumbs=array(
	'Controlador Usuarios'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ControladorUsuario', 'url'=>array('index')),
	array('label'=>'Create ControladorUsuario', 'url'=>array('create')),
	array('label'=>'Update ControladorUsuario', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete ControladorUsuario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ControladorUsuario', 'url'=>array('admin')),
);
?>

<h1>View ControladorUsuario #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'authitem_permiso_usuario_name',
	),
)); ?>
