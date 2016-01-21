<?php
/* @var $this ItemFichaTecnicaController */
/* @var $model ItemFichaTecnica */

$this->breadcrumbs=array(
	'Item Ficha Tecnicas'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ItemFichaTecnica', 'url'=>array('index')),
	array('label'=>'Manage ItemFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Create ItemFichaTecnica</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>