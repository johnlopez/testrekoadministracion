<?php
/* @var $this EntidadController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Entidads',
);

$this->menu=array(
	array('label'=>'Create Entidad', 'url'=>array('create')),
	array('label'=>'Manage Entidad', 'url'=>array('admin')),
);
?>

<h1>Entidads</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
