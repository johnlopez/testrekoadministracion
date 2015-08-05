<?php
/* @var $this EntidadController */
/* @var $model Entidad */

$this->breadcrumbs=array(
	'Entidads'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List Entidad', 'url'=>array('index')),
	array('label'=>'Create Entidad', 'url'=>array('create')),
	array('label'=>'View Entidad', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage Entidad', 'url'=>array('admin')),
);
?>

<h1>Update Entidad <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>