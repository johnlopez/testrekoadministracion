<?php
/* @var $this RepositorioController */
/* @var $model Repositorio */

$this->breadcrumbs=array(
	'Repositorios'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Repositorio', 'url'=>array('index')),
	array('label'=>'Manage Repositorio', 'url'=>array('admin')),
);
?>

<h1>Create Repositorio</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>