<?php
/* @var $this ItemFichaTecnicaController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Item Ficha Tecnicas',
);

$this->menu=array(
	array('label'=>'Create ItemFichaTecnica', 'url'=>array('create')),
	array('label'=>'Manage ItemFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Item Ficha Tecnicas</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
