<?php
/* @var $this UsuarioController */
/* @var $model Usuario */

$this->breadcrumbs=array(
	'Usuarios'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

//$this->menu=array(
//	array('label'=>'List Usuario', 'url'=>array('index')),
//	array('label'=>'Create Usuario', 'url'=>array('create')),
//	array('label'=>'View Usuario', 'url'=>array('view', 'id'=>$model->id)),
//	array('label'=>'Manage Usuario', 'url'=>array('admin')),
//);
?>
<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/index" >
            <button class="button primary" type="submit">
                    Listar Usuario
            </button>
        </form>    
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/create" >
            <button class="button primary" type="submit">
                    Crear Usuario
            </button>
        </form> 
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/admin" >
            <button class="button primary" type="submit">
                    Administrar Usuario
            </button>
        </form>
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="get">
            <input type="hidden" name="id" value="<?php echo $model->id?>" />
            <button class="button primary" type="submit">
                    Ver Usuario
            </button>
        </form> 
</div>
<h1>Editar Usuario <?php echo $model->id; ?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>


<?php $this->renderPartial('_form', array('model'=>$model)); ?>