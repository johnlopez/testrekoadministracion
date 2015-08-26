<?php
/* @var $this UsuarioController */
/* @var $model Usuario */

$this->breadcrumbs=array(
	'Usuarios'=>array('index'),
	'Create',
);

//$this->menu=array(
//	array('label'=>'List Usuario', 'url'=>array('index')),
//	array('label'=>'Manage Usuario', 'url'=>array('admin')),
//);
?>
<div class="place-right padding20 no-padding-top no-padding-right">
    <h4>Opciones</h4>        
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/index" >
            <button class="button primary" type="submit">
                    Listar Usuario
            </button>
        </form>    
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/admin" >
            <button class="button primary" type="submit">
                    Administrar Usuario
            </button>
        </form>          
</div>
<h1>Create Usuario</h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>


<?php $this->renderPartial('_form', array('model'=>$model)); ?>