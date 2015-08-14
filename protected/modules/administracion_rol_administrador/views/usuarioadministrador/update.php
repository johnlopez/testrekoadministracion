<?php
/* @var $this UsuarioAdministradorController */
/* @var $model UsuarioAdministrador */

$this->breadcrumbs=array(
	'Usuario Administradors'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UsuarioAdministrador', 'url'=>array('index')),
	array('label'=>'Create UsuarioAdministrador', 'url'=>array('create')),
	array('label'=>'View UsuarioAdministrador', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage UsuarioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Update UsuarioAdministrador <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>