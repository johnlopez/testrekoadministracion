<?php
/* @var $this ProgramaAcademicoController */
/* @var $model ProgramaAcademico */

$this->breadcrumbs=array(
	'Programa Academicos'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ProgramaAcademico', 'url'=>array('index')),
	array('label'=>'Create ProgramaAcademico', 'url'=>array('create')),
	array('label'=>'View ProgramaAcademico', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ProgramaAcademico', 'url'=>array('admin')),
);
?>

<h1>Update ProgramaAcademico <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>