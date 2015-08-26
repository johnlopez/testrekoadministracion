<?php
/* @var $this PreguntaLoginController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Pregunta Logins',
);

$this->menu=array(
	array('label'=>'Create PreguntaLogin', 'url'=>array('create')),
	array('label'=>'Manage PreguntaLogin', 'url'=>array('admin')),
);
?>

<h1>Pregunta Logins</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
