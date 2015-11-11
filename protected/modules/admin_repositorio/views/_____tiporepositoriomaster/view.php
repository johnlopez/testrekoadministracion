<?php
/* @var $this TiporepositoriomasterController */
/* @var $model TipoRepositorioMaster */

$this->breadcrumbs=array(
	'Tipo Repositorio Masters'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List TipoRepositorioMaster', 'url'=>array('index')),
	array('label'=>'Create TipoRepositorioMaster', 'url'=>array('create')),
	array('label'=>'Update TipoRepositorioMaster', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete TipoRepositorioMaster', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage TipoRepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>View TipoRepositorioMaster #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'descripcion',
	),
)); ?>
