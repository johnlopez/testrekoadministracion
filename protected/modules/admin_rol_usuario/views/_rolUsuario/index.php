<?php
/* @var $this RolUsuarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Rol Usuarios',
);

$this->menu=array(
	array('label'=>'Create RolUsuario', 'url'=>array('create')),
	array('label'=>'Manage RolUsuario', 'url'=>array('admin')),
);
?>

<h1>Rol Usuarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
