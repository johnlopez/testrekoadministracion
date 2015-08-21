<?php
/* @var $this AuthitemPermisoAdministradorController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Authitem Permiso Administradors',
);

$this->menu=array(
	array('label'=>'Create AuthitemPermisoAdministrador', 'url'=>array('create')),
	array('label'=>'Manage AuthitemPermisoAdministrador', 'url'=>array('admin')),
);
?>

<h1>Authitem Permiso Administradors</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
