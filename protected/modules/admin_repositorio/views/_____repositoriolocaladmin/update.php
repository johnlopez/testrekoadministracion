<?php
/* @var $this RepositorioLocalAdminController */
/* @var $model RepositorioLocalAdmin */

$this->breadcrumbs=array(
	'Repositorio Local Admins'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List RepositorioLocalAdmin', 'url'=>array('index')),
	array('label'=>'Create RepositorioLocalAdmin', 'url'=>array('create')),
	array('label'=>'View RepositorioLocalAdmin', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage RepositorioLocalAdmin', 'url'=>array('admin')),
);
?>

<h1>Update RepositorioLocalAdmin <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>