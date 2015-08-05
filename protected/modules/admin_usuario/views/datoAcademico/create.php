<?php
/* @var $this DatoAcademicoController */
/* @var $model DatoAcademico */

$this->breadcrumbs=array(
	'Dato Academicos'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List DatoAcademico', 'url'=>array('index')),
	array('label'=>'Manage DatoAcademico', 'url'=>array('admin')),
);
?>

<h1>Create DatoAcademico</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>