<?php
/* @var $this FichaTecnicaController */
/* @var $model FichaTecnica */

$this->breadcrumbs=array(
	'Ficha Tecnicas'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List FichaTecnica', 'url'=>array('index')),
	array('label'=>'Create FichaTecnica', 'url'=>array('create')),
	array('label'=>'View FichaTecnica', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage FichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Update FichaTecnica <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>