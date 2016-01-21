<?php
/* @var $this ContratoFichaTecnicaController */
/* @var $model ContratoFichaTecnica */

$this->breadcrumbs=array(
	'Contrato Ficha Tecnicas'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ContratoFichaTecnica', 'url'=>array('index')),
	array('label'=>'Manage ContratoFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Create ContratoFichaTecnica</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>