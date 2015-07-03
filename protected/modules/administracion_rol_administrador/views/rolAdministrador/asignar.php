<?php
$this->breadcrumbs=array(
	'Rol Administrador'=>array('index'),
	'Manage'=>array('admin'),
        'Asignar'=>array('asignar'),
);
?>
<h1>Asignar Authitem Permiso Administrador a Rol Administrador</h1>

<div class="form">
<?php $form=$this->beginWidget('CActiveForm'); ?>
 
    <?php echo $form->errorSummary($model); ?>
 
    <div class="row rememberMe">
        <?php echo $form->checkBoxList($model,'name', CHtml::listData(AuthitemPermisoAdministrador::model()->findAll(),'name','name')); ?>
        <?php echo $form->label($model,'name'); ?>
    </div>
 
    <div class="row submit">
        <?php echo CHtml::submitButton('Guardar'); ?>
    </div>
 
<?php $this->endWidget(); ?>
</div><!-- form -->