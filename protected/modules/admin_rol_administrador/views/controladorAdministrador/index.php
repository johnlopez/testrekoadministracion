<?php
/* @var $this ControladorAdministradorController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Controlador Administradors',
);

$this->menu=array(
	array('label'=>'Create ControladorAdministrador', 'url'=>array('create')),
	array('label'=>'Manage ControladorAdministrador', 'url'=>array('admin')),
);
?>

<h1>Controlador Administradors</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
