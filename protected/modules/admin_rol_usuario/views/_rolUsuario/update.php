<?php
/* @var $this RolUsuarioController */
/* @var $model RolUsuario */

$this->breadcrumbs=array(
	'Rol Usuarios'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RolUsuario', 'url'=>array('index')),
	array('label'=>'Create RolUsuario', 'url'=>array('create')),
	array('label'=>'View RolUsuario', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RolUsuario', 'url'=>array('admin')),
);
?>

<h1>Update RolUsuario <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>