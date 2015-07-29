<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1><?php echo $this->uniqueId . '/' . $this->action->id; ?></h1>

<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'usuario_administrador', 'url'=>array('/administracion_usuario_administrador/usuarioadministrador/index')),		
        ),
)); ?>
