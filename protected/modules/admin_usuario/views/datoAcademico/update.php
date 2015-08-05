<?php
/* @var $this DatoAcademicoController */
/* @var $model DatoAcademico */

$this->breadcrumbs=array(
	'Dato Academicos'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List DatoAcademico', 'url'=>array('index')),
	array('label'=>'Create DatoAcademico', 'url'=>array('create')),
	array('label'=>'View DatoAcademico', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage DatoAcademico', 'url'=>array('admin')),
);
?>

<h1>Update DatoAcademico <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>