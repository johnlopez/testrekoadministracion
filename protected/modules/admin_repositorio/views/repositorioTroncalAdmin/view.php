<?php
/* @var $this RepositorioTroncalAdminController */
/* @var $model RepositorioTroncalAdmin */

$this->breadcrumbs=array(
	'Repositorio Troncal Admins'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RepositorioTroncalAdmin', 'url'=>array('index')),
	array('label'=>'Create RepositorioTroncalAdmin', 'url'=>array('create')),
	array('label'=>'Update RepositorioTroncalAdmin', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RepositorioTroncalAdmin', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RepositorioTroncalAdmin', 'url'=>array('admin')),
);
?>

<h1>View RepositorioTroncalAdmin #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		'modelo_aprendizaje_id',
	),
)); ?>
