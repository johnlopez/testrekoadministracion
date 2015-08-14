<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */

$this->breadcrumbs=array(
	'Dato Laborals'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List DatoLaboral', 'url'=>array('index')),
	array('label'=>'Manage DatoLaboral', 'url'=>array('admin')),
);
?>

<h1>Create DatoLaboral</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>