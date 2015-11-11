<?php
/* @var $this ModeloaprendizajemasterController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Modelo Aprendizaje Masters',
);

$this->menu=array(
	array('label'=>'Create ModeloAprendizajeMaster', 'url'=>array('create')),
	array('label'=>'Manage ModeloAprendizajeMaster', 'url'=>array('admin')),
);
?>

<h1>Modelo Aprendizaje Masters</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
