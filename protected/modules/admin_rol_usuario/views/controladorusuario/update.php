<?php
/* @var $this ControladorUsuarioController */
/* @var $model ControladorUsuario */

$this->breadcrumbs=array(
	'Controlador Usuarios'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ControladorUsuario', 'url'=>array('index')),
	array('label'=>'Create ControladorUsuario', 'url'=>array('create')),
	array('label'=>'View ControladorUsuario', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ControladorUsuario', 'url'=>array('admin')),
);
?>

<h1>Update ControladorUsuario <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>