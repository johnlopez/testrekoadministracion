<?php
/* @var $this DatoAcademicoController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Dato Academicos',
);

$this->menu=array(
	array('label'=>'Create DatoAcademico', 'url'=>array('create')),
	array('label'=>'Manage DatoAcademico', 'url'=>array('admin')),
);
?>

<h1>Dato Academicos</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
