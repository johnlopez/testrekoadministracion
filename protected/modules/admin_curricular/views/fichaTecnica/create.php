<?php
/* @var $this FichaTecnicaController */
/* @var $model FichaTecnica */

$this->breadcrumbs=array(
	'Ficha Tecnicas'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List FichaTecnica', 'url'=>array('index')),
	array('label'=>'Manage FichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Create FichaTecnica</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>