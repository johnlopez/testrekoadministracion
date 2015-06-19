<?php
/* @var $this RolAdministradorController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Rol Administradors',
);

$this->menu=array(
	array('label'=>'Create RolAdministrador', 'url'=>array('create')),
	array('label'=>'Manage RolAdministrador', 'url'=>array('admin')),
);
?>

<h1>Rol Administradors</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
