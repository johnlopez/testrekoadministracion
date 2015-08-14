<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */

$this->breadcrumbs=array(
	'Dato Logins'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List DatoLogin', 'url'=>array('index')),
	array('label'=>'Create DatoLogin', 'url'=>array('create')),
	array('label'=>'View DatoLogin', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage DatoLogin', 'url'=>array('admin')),
);
?>

<h1>Update DatoLogin <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>