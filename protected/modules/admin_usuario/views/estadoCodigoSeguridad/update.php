<?php
/* @var $this EstadoCodigoSeguridadController */
/* @var $model EstadoCodigoSeguridad */

$this->breadcrumbs=array(
	'Estado Codigo Seguridads'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List EstadoCodigoSeguridad', 'url'=>array('index')),
	array('label'=>'Create EstadoCodigoSeguridad', 'url'=>array('create')),
	array('label'=>'View EstadoCodigoSeguridad', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage EstadoCodigoSeguridad', 'url'=>array('admin')),
);
?>

<h1>Update EstadoCodigoSeguridad <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>