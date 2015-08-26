<?php
/* @var $this PreguntaLoginController */
/* @var $model PreguntaLogin */

$this->breadcrumbs=array(
	'Pregunta Logins'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List PreguntaLogin', 'url'=>array('index')),
	array('label'=>'Create PreguntaLogin', 'url'=>array('create')),
	array('label'=>'View PreguntaLogin', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage PreguntaLogin', 'url'=>array('admin')),
);
?>

<h1>Update PreguntaLogin <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>