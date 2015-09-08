<?php
/* @var $this ControladorUsuarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Controlador Usuarios',
);

$this->menu=array(
	array('label'=>'Create ControladorUsuario', 'url'=>array('create')),
	array('label'=>'Manage ControladorUsuario', 'url'=>array('admin')),
);
?>

<h1>Controlador Usuarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
