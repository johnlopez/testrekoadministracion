<?php
/* @var $this TiporepositoriomasterController */
/* @var $model TipoRepositorioMaster */

$this->breadcrumbs=array(
	'Tipo Repositorio Masters'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List TipoRepositorioMaster', 'url'=>array('index')),
	array('label'=>'Manage TipoRepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>Create TipoRepositorioMaster</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>