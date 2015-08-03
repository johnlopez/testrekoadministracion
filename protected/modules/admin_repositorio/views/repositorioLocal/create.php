<?php
/* @var $this RepositorioLocalController */
/* @var $model RepositorioLocal */

$this->breadcrumbs=array(
	'Repositorio Locals'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RepositorioLocal', 'url'=>array('index')),
	array('label'=>'Manage RepositorioLocal', 'url'=>array('admin')),
);
?>

<h1>Create RepositorioLocal</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>