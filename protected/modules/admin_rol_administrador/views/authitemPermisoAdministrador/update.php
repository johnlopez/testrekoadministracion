<?php
/* @var $this AuthitemPermisoAdministradorController */
/* @var $model AuthitemPermisoAdministrador */

$this->breadcrumbs=array(
	'Authitem Permiso Administradors'=>array('index'),
	$model->name=>array('view','id'=>$model->name),
	'Update',
);

$this->menu=array(
	array('label'=>'List AuthitemPermisoAdministrador', 'url'=>array('index')),
	array('label'=>'Create AuthitemPermisoAdministrador', 'url'=>array('create')),
	array('label'=>'View AuthitemPermisoAdministrador', 'url'=>array('view', 'id'=>$model->name)),
	array('label'=>'Manage AuthitemPermisoAdministrador', 'url'=>array('admin')),
);
?>

<h1>Update AuthitemPermisoAdministrador <?php echo $model->name; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>