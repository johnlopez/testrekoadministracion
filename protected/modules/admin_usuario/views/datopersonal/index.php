<?php
/* @var $this DatoPersonalController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Dato Personals',
);

$this->menu=array(
	array('label'=>'Create DatoPersonal', 'url'=>array('create')),
	array('label'=>'Manage DatoPersonal', 'url'=>array('admin')),
);
?>

<h1>Dato Personals</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
