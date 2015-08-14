<?php
/* @var $this ProgramaAcademicoController */
/* @var $model ProgramaAcademico */

$this->breadcrumbs=array(
	'Programa Academicos'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List ProgramaAcademico', 'url'=>array('index')),
	array('label'=>'Manage ProgramaAcademico', 'url'=>array('admin')),
);
?>

<h1>Create ProgramaAcademico</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>