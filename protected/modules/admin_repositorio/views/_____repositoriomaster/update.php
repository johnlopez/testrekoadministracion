<?php
/* @var $this RepositoriomasterController */
/* @var $model RepositorioMaster */

$this->breadcrumbs=array(
	'Repositorio Masters'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RepositorioMaster', 'url'=>array('index')),
	array('label'=>'Create RepositorioMaster', 'url'=>array('create')),
	array('label'=>'View RepositorioMaster', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>Update RepositorioMaster <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>