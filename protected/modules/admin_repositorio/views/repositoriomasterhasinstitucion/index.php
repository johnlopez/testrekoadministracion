<?php
/* @var $this RepositoriomasterhasinstitucionController */

$this->breadcrumbs=array(
	'Repositoriomasterhasinstitucion',
);
?>
<h1><?php echo $this->id . '/' . $this->action->id; ?></h1>

<p>
	You may change the content of this page by modifying
	the file <tt><?php echo __FILE__; ?></tt>.
</p>
<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarUsuarios'), 'post'); ?>

        <h3>Usuarios por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('usuario_id', $seleccionados, CHtml::listData($objeto,'usuario_id','usuario_id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-usuario_id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-usuario_id-select", serialize (CHtml::listData($objeto,'usuario_id','usuario_id'))); ?>
            <?php echo CHtml::hiddenField("datos-institucion-id",$idInstitucion)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Usuarios')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>

