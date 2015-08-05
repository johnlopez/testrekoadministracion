<?php
/* @var $this DatoLoginController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Dato Logins',
);

$this->menu=array(
	array('label'=>'Create DatoLogin', 'url'=>array('create')),
	array('label'=>'Manage DatoLogin', 'url'=>array('admin')),
);
?>

<h1>Dato Logins</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
