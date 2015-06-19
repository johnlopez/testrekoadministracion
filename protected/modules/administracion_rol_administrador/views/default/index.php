<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1><?php echo $this->uniqueId . '/' . $this->action->id; ?></h1>

<p>
This is the view content for action "<?php echo $this->action->id; ?>".
The action belongs to the controller "<?php echo get_class($this); ?>"
in the "<?php echo $this->module->id; ?>" module.
</p>
<p>
You may customize this page by editing <tt><?php echo __FILE__; ?></tt>
</p>

<div id="mainmenu">
		<?php $this->widget('zii.widgets.CMenu',array(
			'items'=>array(
                                array('label'=>'rol_administrador', 'url'=>array('/administracion_rol_administrador/roladministrador/index'),"<br>"),
			),
		)); ?>
</div><!-- mainmenu -->
<div id="mainmenu">
		<?php $this->widget('zii.widgets.CMenu',array(
			'items'=>array(
                                array('label'=>'authitem_permiso_administrador', 'url'=>array('/administracion_rol_administrador/authitempermisoadministrador/index')),
			),
		)); ?>
</div><!-- mainmenu -->
<div id="mainmenu">
		<?php $this->widget('zii.widgets.CMenu',array(
			'items'=>array(
                                array('label'=>'controlador_administrador', 'url'=>array('/administracion_rol_administrador/controladoradministrador/index')),
                                
			),
		)); ?>
</div><!-- mainmenu -->
<div id="mainmenu">
		<?php $this->widget('zii.widgets.CMenu',array(
			'items'=>array(
                                
                                array('label'=>'privilegio_administrador', 'url'=>array('/administracion_rol_administrador/privilegioadministrador/index')),		
			),
		)); ?>
</div><!-- mainmenu -->