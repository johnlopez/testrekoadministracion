<?php
/* @var $this RepositorioLocalAdminController */
/* @var $model RepositorioLocalAdmin */

$this->breadcrumbs=array(
	'Repositorio Local Admins'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List RepositorioLocalAdmin', 'url'=>array('index')),
	array('label'=>'Create RepositorioLocalAdmin', 'url'=>array('create')),
	array('label'=>'Update RepositorioLocalAdmin', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete RepositorioLocalAdmin', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage RepositorioLocalAdmin', 'url'=>array('admin')),
);
?>

<h1>View RepositorioLocalAdmin #<?php echo $model->id; ?></h1>

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
