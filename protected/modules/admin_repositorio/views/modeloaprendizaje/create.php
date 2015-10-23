<?php
/* @var $this ModeloaprendizajeController */
/* @var $model ModeloAprendizaje */

$this->breadcrumbs=array(
	'Modelo Aprendizajes'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ModeloAprendizaje', 'url'=>array('index')),
	array('label'=>'Manage ModeloAprendizaje', 'url'=>array('admin')),
);
?>

<h1>Create ModeloAprendizaje</h1>

<?php $this->renderPartial('_form', array('model'=>$model,'herramienta'=>$herramienta)); ?>