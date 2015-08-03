<?php
/* @var $this RepositorioLocalController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Repositorio Locals',
);

$this->menu=array(
	array('label'=>'Create RepositorioLocal', 'url'=>array('create')),
	array('label'=>'Manage RepositorioLocal', 'url'=>array('admin')),
);
?>

<h1>Repositorio Locals</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
