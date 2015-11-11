<?php
/* @var $this RepositoriomasterController */
/* @var $model RepositorioMaster */

$this->breadcrumbs=array(
	'Repositorio Masters'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RepositorioMaster', 'url'=>array('index')),
	array('label'=>'Manage RepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>Create RepositorioMaster</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>