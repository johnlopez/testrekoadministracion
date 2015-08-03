<?php
/* @var $this RepositorioTroncalController */
/* @var $model RepositorioTroncal */

$this->breadcrumbs=array(
	'Repositorio Troncals'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RepositorioTroncal', 'url'=>array('index')),
	array('label'=>'Create RepositorioTroncal', 'url'=>array('create')),
	array('label'=>'View RepositorioTroncal', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RepositorioTroncal', 'url'=>array('admin')),
);
?>

<h1>Update RepositorioTroncal <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>