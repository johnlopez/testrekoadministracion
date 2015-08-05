<?php
/* @var $this RepositorioLocalAdminController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Repositorio Local Admins',
);

$this->menu=array(
	array('label'=>'Create RepositorioLocalAdmin', 'url'=>array('create')),
	array('label'=>'Manage RepositorioLocalAdmin', 'url'=>array('admin')),
);
?>

<h1>Repositorio Local Admins</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
