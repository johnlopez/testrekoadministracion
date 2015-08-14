<?php
/* @var $this DatoLaboralController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Dato Laborals',
);

$this->menu=array(
	array('label'=>'Create DatoLaboral', 'url'=>array('create')),
	array('label'=>'Manage DatoLaboral', 'url'=>array('admin')),
);
?>

<h1>Dato Laborals</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
