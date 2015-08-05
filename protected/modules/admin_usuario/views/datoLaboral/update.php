<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */

$this->breadcrumbs=array(
	'Dato Laborals'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List DatoLaboral', 'url'=>array('index')),
	array('label'=>'Create DatoLaboral', 'url'=>array('create')),
	array('label'=>'View DatoLaboral', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage DatoLaboral', 'url'=>array('admin')),
);
?>

<h1>Update DatoLaboral <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>