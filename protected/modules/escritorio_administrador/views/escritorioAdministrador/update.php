<?php
/* @var $this EscritorioAdministradorController */
/* @var $model EscritorioAdministrador */

$this->breadcrumbs=array(
	'Escritorio Administradors'=>array('index'),
	$model->name=>array('view','id'=>$model->name),
	'Update',
);

$this->menu=array(
	array('label'=>'List EscritorioAdministrador', 'url'=>array('index')),
	array('label'=>'Create EscritorioAdministrador', 'url'=>array('create')),
	array('label'=>'View EscritorioAdministrador', 'url'=>array('view', 'id'=>$model->name)),
	array('label'=>'Manage EscritorioAdministrador', 'url'=>array('admin')),
);
?>

<h1>Update EscritorioAdministrador <?php echo $model->name; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>