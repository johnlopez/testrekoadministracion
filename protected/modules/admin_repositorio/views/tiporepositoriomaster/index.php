<?php
/* @var $this TiporepositoriomasterController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Tipo Repositorio Masters',
);

$this->menu=array(
	array('label'=>'Create TipoRepositorioMaster', 'url'=>array('create')),
	array('label'=>'Manage TipoRepositorioMaster', 'url'=>array('admin')),
);
?>

<h1>Tipo Repositorio Masters</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
