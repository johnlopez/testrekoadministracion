<?php
/* @var $this RepositorioLocalAdminController */
/* @var $model RepositorioLocalAdmin */

$this->breadcrumbs=array(
	'Repositorio Local Admins'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RepositorioLocalAdmin', 'url'=>array('index')),
	array('label'=>'Manage RepositorioLocalAdmin', 'url'=>array('admin')),
);
?>

<h1>Create RepositorioLocalAdmin</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>