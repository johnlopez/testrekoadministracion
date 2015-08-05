<?php
/* @var $this DatoPersonalController */
/* @var $model DatoPersonal */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'dato-personal-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'primer_nombre'); ?>
		<?php echo $form->textField($model,'primer_nombre',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'primer_nombre'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'segundo_nombre'); ?>
		<?php echo $form->textField($model,'segundo_nombre',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'segundo_nombre'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'apellido_paterno'); ?>
		<?php echo $form->textField($model,'apellido_paterno',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'apellido_paterno'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'apellido_materno'); ?>
		<?php echo $form->textField($model,'apellido_materno',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'apellido_materno'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_nacimiento'); ?>
		<?php echo $form->textField($model,'fecha_nacimiento'); ?>
		<?php echo $form->error($model,'fecha_nacimiento'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'edad'); ?>
		<?php echo $form->textField($model,'edad'); ?>
		<?php echo $form->error($model,'edad'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'rut'); ?>
		<?php echo $form->textField($model,'rut'); ?>
		<?php echo $form->error($model,'rut'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'digito_verificador'); ?>
		<?php echo $form->textField($model,'digito_verificador'); ?>
		<?php echo $form->error($model,'digito_verificador'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'direccion_personal'); ?>
		<?php echo $form->textField($model,'direccion_personal',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'direccion_personal'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'numero_casa'); ?>
		<?php echo $form->textField($model,'numero_casa'); ?>
		<?php echo $form->error($model,'numero_casa'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'telefono_personal'); ?>
		<?php echo $form->textField($model,'telefono_personal'); ?>
		<?php echo $form->error($model,'telefono_personal'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'celular_personal'); ?>
		<?php echo $form->textField($model,'celular_personal'); ?>
		<?php echo $form->error($model,'celular_personal'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'dato_personalcol'); ?>
		<?php echo $form->textField($model,'dato_personalcol',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'dato_personalcol'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'comuna_personal'); ?>
		<?php echo $form->textField($model,'comuna_personal',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'comuna_personal'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'ciudad_personal'); ?>
		<?php echo $form->textField($model,'ciudad_personal',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'ciudad_personal'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'interes'); ?>
		<?php echo $form->textField($model,'interes',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'interes'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'estado_civil'); ?>
		<?php echo $form->textField($model,'estado_civil',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'estado_civil'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'idioma'); ?>
		<?php echo $form->textField($model,'idioma',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'idioma'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'nacionalidad'); ?>
		<?php echo $form->textField($model,'nacionalidad',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'nacionalidad'); ?>
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