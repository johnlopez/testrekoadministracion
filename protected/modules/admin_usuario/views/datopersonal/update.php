<?php
/* @var $this DatoPersonalController */
/* @var $model DatoPersonal */

$this->breadcrumbs=array(
	'Dato Personals'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List DatoPersonal', 'url'=>array('index')),
	array('label'=>'Create DatoPersonal', 'url'=>array('create')),
	array('label'=>'View DatoPersonal', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage DatoPersonal', 'url'=>array('admin')),
);
?>

<h1>Update DatoPersonal <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>