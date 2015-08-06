<?php
/* @var $this RepositorioTroncalAdminController */
/* @var $model RepositorioTroncalAdmin */

$this->breadcrumbs=array(
	'Repositorio Troncal Admins'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List RepositorioTroncalAdmin', 'url'=>array('index')),
	array('label'=>'Manage RepositorioTroncalAdmin', 'url'=>array('admin')),
);
?>

<h1>Create RepositorioTroncalAdmin</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>