<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'dato-laboral-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'nombre_empresa'); ?>
		<?php echo $form->textField($model,'nombre_empresa',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'nombre_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'ano_antiguedad'); ?>
		<?php echo $form->textField($model,'ano_antiguedad'); ?>
		<?php echo $form->error($model,'ano_antiguedad'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'cargo'); ?>
		<?php echo $form->textField($model,'cargo',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'cargo'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'actividad'); ?>
		<?php echo $form->textField($model,'actividad',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'actividad'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'comuna_empresa'); ?>
		<?php echo $form->textField($model,'comuna_empresa',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'comuna_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'ciudad_empresa'); ?>
		<?php echo $form->textField($model,'ciudad_empresa',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'ciudad_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'telefono_empresa'); ?>
		<?php echo $form->textField($model,'telefono_empresa'); ?>
		<?php echo $form->error($model,'telefono_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'celular_empresa'); ?>
		<?php echo $form->textField($model,'celular_empresa'); ?>
		<?php echo $form->error($model,'celular_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'rut_numero'); ?>
		<?php echo $form->textField($model,'rut_numero'); ?>
		<?php echo $form->error($model,'rut_numero'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'digito_verificador'); ?>
		<?php echo $form->textField($model,'digito_verificador'); ?>
		<?php echo $form->error($model,'digito_verificador'); ?>
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