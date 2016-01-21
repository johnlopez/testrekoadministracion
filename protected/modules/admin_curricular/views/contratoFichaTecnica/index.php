<?php
/* @var $this ContratoFichaTecnicaController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Contrato Ficha Tecnicas',
);

$this->menu=array(
	array('label'=>'Create ContratoFichaTecnica', 'url'=>array('create')),
	array('label'=>'Manage ContratoFichaTecnica', 'url'=>array('admin')),
);
?>

<h1>Contrato Ficha Tecnicas</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
