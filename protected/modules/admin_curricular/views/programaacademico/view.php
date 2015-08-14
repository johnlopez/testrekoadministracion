<?php
/* @var $this ProgramaAcademicoController */
/* @var $model ProgramaAcademico */

$this->breadcrumbs=array(
	'Programa Academicos'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List ProgramaAcademico', 'url'=>array('index')),
	array('label'=>'Create ProgramaAcademico', 'url'=>array('create')),
	array('label'=>'Update ProgramaAcademico', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete ProgramaAcademico', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage ProgramaAcademico', 'url'=>array('admin')),
);
?>

<h1>View ProgramaAcademico #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'version',
		'fecha_creacion',
		'fecha_modificacion',
	),
)); ?>
