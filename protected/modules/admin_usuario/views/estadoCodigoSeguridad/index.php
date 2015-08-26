<?php
/* @var $this EstadoCodigoSeguridadController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Estado Codigo Seguridads',
);

$this->menu=array(
	array('label'=>'Create EstadoCodigoSeguridad', 'url'=>array('create')),
	array('label'=>'Manage EstadoCodigoSeguridad', 'url'=>array('admin')),
);
?>

<h1>Estado Codigo Seguridads</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
