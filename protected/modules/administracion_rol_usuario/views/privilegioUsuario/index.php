<?php
/* @var $this PrivilegioUsuarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Privilegio Usuarios',
);

$this->menu=array(
	array('label'=>'Create PrivilegioUsuario', 'url'=>array('create')),
	array('label'=>'Manage PrivilegioUsuario', 'url'=>array('admin')),
);
?>

<h1>Privilegio Usuarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
