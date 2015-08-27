<?php
/* @var $this UsuarioController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Usuarios',
);

//$this->menu=array(
//	array('label'=>'Create Usuario', 'url'=>array('create')),
//	array('label'=>'Manage Usuario', 'url'=>array('admin')),
//);
?>
<div class="place-right padding20 no-padding-top no-padding-right">
    <h4>Opciones</h4>        
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/admin" >
            <button class="button primary" type="submit">
                    Administrar Usuario
            </button>
        </form>    
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/create" >
            <button class="button primary" type="submit">
                    Crear Usuario
            </button>
        </form>          
</div>
<div class="place-left padding20 no-padding-bottom no-padding-left">
    <h1>Usuarios</h1>
</div>

<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>


