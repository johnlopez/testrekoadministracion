<?php
/* @var $this ProgramaAcademicoController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Programa Academicos',
);

$this->menu=array(
	array('label'=>'Create ProgramaAcademico', 'url'=>array('create')),
	array('label'=>'Manage ProgramaAcademico', 'url'=>array('admin')),
);
?>

<h1>Programa Academicos</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
