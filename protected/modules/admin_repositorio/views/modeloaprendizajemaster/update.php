<?php
/* @var $this ModeloaprendizajemasterController */
/* @var $model ModeloAprendizajeMaster */

$this->breadcrumbs=array(
	'Modelo Aprendizaje Masters'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ModeloAprendizajeMaster', 'url'=>array('index')),
	array('label'=>'Create ModeloAprendizajeMaster', 'url'=>array('create')),
	array('label'=>'View ModeloAprendizajeMaster', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ModeloAprendizajeMaster', 'url'=>array('admin')),
);
?>

<h1>Update ModeloAprendizajeMaster <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>