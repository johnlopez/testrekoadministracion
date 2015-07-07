<?php
/* @var $this AuthitemPermisoUsuarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Authitem Permiso Usuarios',
);

$this->menu=array(
	array('label'=>'Create AuthitemPermisoUsuario', 'url'=>array('create')),
	array('label'=>'Manage AuthitemPermisoUsuario', 'url'=>array('admin')),
);
?>

<h1>Authitem Permiso Usuarios</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
