<?php
/* @var $this RepositorioTroncalController */
/* @var $model RepositorioTroncal */

$this->breadcrumbs=array(
	'Repositorio Troncals'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RepositorioTroncal', 'url'=>array('index')),
	array('label'=>'Manage RepositorioTroncal', 'url'=>array('admin')),
);
?>

<h1>Create RepositorioTroncal</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>