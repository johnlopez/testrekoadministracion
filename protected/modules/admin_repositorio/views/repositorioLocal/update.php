<?php
/* @var $this RepositorioLocalController */
/* @var $model RepositorioLocal */

$this->breadcrumbs=array(
	'Repositorio Locals'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RepositorioLocal', 'url'=>array('index')),
	array('label'=>'Create RepositorioLocal', 'url'=>array('create')),
	array('label'=>'View RepositorioLocal', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RepositorioLocal', 'url'=>array('admin')),
);
?>

<h1>Update RepositorioLocal <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>