<?php
/* @var $this UsuarioController */
/* @var $model Usuario */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'usuario-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'usuario'); ?>
		<?php echo $form->textField($model,'usuario',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'usuario'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'clave'); ?>
		<?php echo $form->textField($model,'clave',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'clave'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_acceso'); ?>
		<?php echo $form->textField($model,'fecha_acceso'); ?>
		<?php echo $form->error($model,'fecha_acceso'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_modificacion'); ?>
		<?php echo $form->textField($model,'fecha_modificacion'); ?>
		<?php echo $form->error($model,'fecha_modificacion'); ?>
	</div>

	<div class="row">
		
                <?php echo $form->labelEx($model,'fecha_creacion'); ?>
		
            <div class="input-control text" data-role="input">
                <?php echo $form->textField($model,'fecha_creacion'); ?>
            </div>
                
                <?php echo $form->error($model,'fecha_creacion'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->


<div class="input-control text" data-role="input">
    <input type="text" data-validate-func="required" placeholder="not empty" data-validate-hint="This field can not be empty" style="padding-right: 5px;">
    <span class="input-state-error mif-warning" style="right: 8px;"></span>
    <span class="input-state-success mif-checkmark" style="right: 8px;"></span>
</div>

<div class="input-control modern text iconic">
    <input type="text">
    <span class="informer">Please enter you login or email</span>
    <span class="placeholder">Input login</span>
    <span class="icon mif-user"></span>
</div>