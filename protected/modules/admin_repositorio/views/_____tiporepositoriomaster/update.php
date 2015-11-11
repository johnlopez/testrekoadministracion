<?php
/* @var $this TiporepositoriomasterController */
/* @var $model TipoRepositorioMaster */

$this->breadcrumbs=array(
	'Tipo Repositorio Masters'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List TipoRepositorioMaster', 'url'=>array('index')),
	array('label'=>'Create TipoRepositorioMaster', 'url'=>array('create')),
	array('label'=>'View TipoRepositorioMaster', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage TipoRepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>Update TipoRepositorioMaster <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>