<?php
/* @var $this RepositorioTroncalAdminController */
/* @var $model RepositorioTroncalAdmin */

$this->breadcrumbs=array(
	'Repositorio Troncal Admins'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RepositorioTroncalAdmin', 'url'=>array('index')),
	array('label'=>'Create RepositorioTroncalAdmin', 'url'=>array('create')),
	array('label'=>'View RepositorioTroncalAdmin', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RepositorioTroncalAdmin', 'url'=>array('admin')),
);
?>

<h1>Update RepositorioTroncalAdmin <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>