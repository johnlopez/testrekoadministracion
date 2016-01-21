<?php
/* @var $this ContratoFichaTecnicaController */
/* @var $model ContratoFichaTecnica */

$this->breadcrumbs=array(
	'Contrato Ficha Tecnicas'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ContratoFichaTecnica', 'url'=>array('index')),
	array('label'=>'Create ContratoFichaTecnica', 'url'=>array('create')),
	array('label'=>'View ContratoFichaTecnica', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ContratoFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Update ContratoFichaTecnica <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>