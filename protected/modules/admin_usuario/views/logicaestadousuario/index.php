<?php
/* @var $this LogicaEstadoUsuarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Logica Estado Usuarios',
);

$this->menu=array(
	array('label'=>'Create LogicaEstadoUsuario', 'url'=>array('create')),
	array('label'=>'Manage LogicaEstadoUsuario', 'url'=>array('admin')),
);
?>

<h1>Logica Estado Usuarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
