<?php
/* @var $this UsuarioAdministradorController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Usuario Administradors',
);

$this->menu=array(
	array('label'=>'Create UsuarioAdministrador', 'url'=>array('create')),
	array('label'=>'Manage UsuarioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Usuario Administradors</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
