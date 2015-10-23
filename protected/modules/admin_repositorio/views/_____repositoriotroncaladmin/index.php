<?php
/* @var $this RepositorioTroncalAdminController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Repositorio Troncal Admins',
);

$this->menu=array(
	array('label'=>'Create RepositorioTroncalAdmin', 'url'=>array('create')),
	array('label'=>'Manage RepositorioTroncalAdmin', 'url'=>array('admin')),
);
?>

<h1>Repositorio Troncal Admins</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
