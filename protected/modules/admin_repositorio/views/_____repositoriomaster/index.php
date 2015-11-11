<?php
/* @var $this RepositoriomasterController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Repositorio Masters',
);

$this->menu=array(
	array('label'=>'Create RepositorioMaster', 'url'=>array('create')),
	array('label'=>'Manage RepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>Repositorio Masters</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
