<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(

                array('label'=>'rol', 'url'=>array('/administracion_rol/rol/index')),		
        ),
)); ?>
