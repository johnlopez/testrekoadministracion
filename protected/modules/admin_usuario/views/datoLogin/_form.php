<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'dato-login-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'pregunta_secreta_1'); ?>
		<?php echo $form->textField($model,'pregunta_secreta_1',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'pregunta_secreta_1'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'pregunta_secreta_2'); ?>
		<?php echo $form->textField($model,'pregunta_secreta_2',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'pregunta_secreta_2'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'respuesta_secreta_1'); ?>
		<?php echo $form->textField($model,'respuesta_secreta_1',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'respuesta_secreta_1'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'respuesta_secreta_2'); ?>
		<?php echo $form->textField($model,'respuesta_secreta_2',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'respuesta_secreta_2'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'usuario_id'); ?>
		<?php echo $form->textField($model,'usuario_id'); ?>
		<?php echo $form->error($model,'usuario_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->