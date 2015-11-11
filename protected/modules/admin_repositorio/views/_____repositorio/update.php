<?php
/* @var $this RepositorioController */
/* @var $model Repositorio */

$this->breadcrumbs=array(
	'Repositorios'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List Repositorio', 'url'=>array('index')),
	array('label'=>'Create Repositorio', 'url'=>array('create')),
	array('label'=>'View Repositorio', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage Repositorio', 'url'=>array('admin')),
);
?>

<h1>Update Repositorio <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>