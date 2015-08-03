<?php
/* @var $this RepositorioTroncalController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Repositorio Troncals',
);

$this->menu=array(
	array('label'=>'Create RepositorioTroncal', 'url'=>array('create')),
	array('label'=>'Manage RepositorioTroncal', 'url'=>array('admin')),
);
?>

<h1>Repositorio Troncals</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
