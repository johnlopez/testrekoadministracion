<?php
/* @var $this ModeloaprendizajeController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Modelo Aprendizajes',
);

$this->menu=array(
	array('label'=>'Create ModeloAprendizaje', 'url'=>array('create')),
	array('label'=>'Manage ModeloAprendizaje', 'url'=>array('admin')),
);
?>

<h1>Modelo Aprendizajes</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
