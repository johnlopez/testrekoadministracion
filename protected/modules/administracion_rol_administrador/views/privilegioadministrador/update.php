<?php
/* @var $this PrivilegioAdministradorController */
/* @var $model PrivilegioAdministrador */

$this->breadcrumbs=array(
	'Privilegio Administradors'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PrivilegioAdministrador', 'url'=>array('index')),
	array('label'=>'Create PrivilegioAdministrador', 'url'=>array('create')),
	array('label'=>'View PrivilegioAdministrador', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage PrivilegioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Update PrivilegioAdministrador <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>