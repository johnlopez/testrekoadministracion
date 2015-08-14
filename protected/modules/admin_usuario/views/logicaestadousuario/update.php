<?php
/* @var $this LogicaEstadoUsuarioController */
/* @var $model LogicaEstadoUsuario */

$this->breadcrumbs=array(
	'Logica Estado Usuarios'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List LogicaEstadoUsuario', 'url'=>array('index')),
	array('label'=>'Create LogicaEstadoUsuario', 'url'=>array('create')),
	array('label'=>'View LogicaEstadoUsuario', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage LogicaEstadoUsuario', 'url'=>array('admin')),
);
?>

<h1>Update LogicaEstadoUsuario <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>