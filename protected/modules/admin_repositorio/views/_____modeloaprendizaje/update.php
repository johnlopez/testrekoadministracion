<?php
/* @var $this ModeloAprendizajeController */
/* @var $model ModeloAprendizaje */

$this->breadcrumbs=array(
	'Modelo Aprendizajes'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ModeloAprendizaje', 'url'=>array('index')),
	array('label'=>'Create ModeloAprendizaje', 'url'=>array('create')),
	array('label'=>'View ModeloAprendizaje', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ModeloAprendizaje', 'url'=>array('admin')),
);
?>

<h1>Update ModeloAprendizaje <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>