<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'rol_usuario', 'url'=>array('/administracion_rol_usuario/rolusuario/index'),"<br>"),
        ),
)); ?>


<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'authitem_permiso_usuario', 'url'=>array('/administracion_rol_usuario/authitempermisousuario/index'),"<br>"),
        ),
)); ?>

<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'controlador_usuario', 'url'=>array('/administracion_rol_usuario/controladorusuario/index'),"<br>"),
        ),
)); ?>

<?php $this->widget('zii.widgets.CMenu',array(
        'items'=>array(
                array('label'=>'privilegio_usuario', 'url'=>array('/administracion_rol_usuario/privilegiousuario/index'),"<br>"),
        ),
)); ?>