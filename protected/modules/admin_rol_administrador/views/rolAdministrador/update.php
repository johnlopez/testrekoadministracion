<?php
/* @var $this RolAdministradorController */
/* @var $model RolAdministrador */

$this->breadcrumbs=array(
	'Rol Administradors'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RolAdministrador', 'url'=>array('index')),
	array('label'=>'Create RolAdministrador', 'url'=>array('create')),
	array('label'=>'View RolAdministrador', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RolAdministrador', 'url'=>array('admin')),
);
?>

<h1>Update RolAdministrador <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>