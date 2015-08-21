<?php
/* @var $this PrivilegioAdministradorController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Privilegio Administradors',
);

$this->menu=array(
	array('label'=>'Create PrivilegioAdministrador', 'url'=>array('create')),
	array('label'=>'Manage PrivilegioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Privilegio Administradors</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
