<?php
/* @var $this PrivilegioUsuarioController */
/* @var $model PrivilegioUsuario */

$this->breadcrumbs=array(
	'Privilegio Usuarios'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List PrivilegioUsuario', 'url'=>array('index')),
	array('label'=>'Create PrivilegioUsuario', 'url'=>array('create')),
	array('label'=>'Update PrivilegioUsuario', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete PrivilegioUsuario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage PrivilegioUsuario', 'url'=>array('admin')),
);
?>

<h1>View PrivilegioUsuario #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'controlador_usuario_id',
	),
)); ?>
