<?php
/* @var $this AuthitemPermisoUsuarioController */
/* @var $model AuthitemPermisoUsuario */

$this->breadcrumbs=array(
	'Authitem Permiso Usuarios'=>array('index'),
	$model->name=>array('view','id'=>$model->name),
	'Update',
);

$this->menu=array(
	array('label'=>'List AuthitemPermisoUsuario', 'url'=>array('index')),
	array('label'=>'Create AuthitemPermisoUsuario', 'url'=>array('create')),
	array('label'=>'View AuthitemPermisoUsuario', 'url'=>array('view', 'id'=>$model->name)),
	array('label'=>'Manage AuthitemPermisoUsuario', 'url'=>array('admin')),
);
?>

<h1>Update AuthitemPermisoUsuario <?php echo $model->name; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>