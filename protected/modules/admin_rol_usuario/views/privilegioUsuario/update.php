<?php
/* @var $this PrivilegioUsuarioController */
/* @var $model PrivilegioUsuario */

$this->breadcrumbs=array(
	'Privilegio Usuarios'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PrivilegioUsuario', 'url'=>array('index')),
	array('label'=>'Create PrivilegioUsuario', 'url'=>array('create')),
	array('label'=>'View PrivilegioUsuario', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage PrivilegioUsuario', 'url'=>array('admin')),
);
?>

<h1>Update PrivilegioUsuario <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>