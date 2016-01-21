<?php
/* @var $this ItemFichaTecnicaController */
/* @var $model ItemFichaTecnica */

$this->breadcrumbs=array(
	'Item Ficha Tecnicas'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ItemFichaTecnica', 'url'=>array('index')),
	array('label'=>'Create ItemFichaTecnica', 'url'=>array('create')),
	array('label'=>'View ItemFichaTecnica', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ItemFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Update ItemFichaTecnica <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>