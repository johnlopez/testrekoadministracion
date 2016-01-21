<?php
/* @var $this FichaTecnicaController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Ficha Tecnicas',
);

$this->menu=array(
	array('label'=>'Create FichaTecnica', 'url'=>array('create')),
	array('label'=>'Manage FichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Ficha Tecnicas</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
