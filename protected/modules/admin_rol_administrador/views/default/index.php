<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1><?php echo $this->uniqueId . '/' . $this->action->id; ?></h1>

<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'usuario_administrador', 'url'=>array('/admin_rol_administrador/usuarioadministrador/index'),"<br>"),
        ),
)); ?>

<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'rol_administrador', 'url'=>array('/admin_rol_administrador/roladministrador/index'),"<br>"),
        ),
)); ?>


<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'authitem_permiso_administrador', 'url'=>array('/admin_rol_administrador/authitempermisoadministrador/index')),
        ),
)); ?>


<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'controlador_administrador', 'url'=>array('/admin_rol_administrador/controladoradministrador/index')),

        ),
)); ?>

<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(

                array('label'=>'privilegio_administrador', 'url'=>array('/admin_rol_administrador/privilegioadministrador/index')),		
        ),
)); ?>
