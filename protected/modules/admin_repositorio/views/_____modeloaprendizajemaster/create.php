<?php
/* @var $this ModeloaprendizajemasterController */
/* @var $model ModeloAprendizajeMaster */

$this->breadcrumbs=array(
	'Modelo Aprendizaje Masters'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ModeloAprendizajeMaster', 'url'=>array('index')),
	array('label'=>'Manage ModeloAprendizajeMaster', 'url'=>array('admin')),
);
?>

<h1>Create ModeloAprendizajeMaster</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>