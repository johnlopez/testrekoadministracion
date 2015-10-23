<?php
/* @var $this RepositorioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Repositorios',
);

$this->menu=array(
	array('label'=>'Create Repositorio', 'url'=>array('create')),
	array('label'=>'Manage Repositorio', 'url'=>array('admin')),
);
?>

<h1>Repositorios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
