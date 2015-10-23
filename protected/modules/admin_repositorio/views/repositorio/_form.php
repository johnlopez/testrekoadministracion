<?php
/* @var $this RepositorioController */
/* @var $model Repositorio */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'repositorio-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'nombre'); ?>
		<?php echo $form->textField($model,'nombre',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'nombre'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'descripcion'); ?>
		<?php echo $form->textField($model,'descripcion',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'descripcion'); ?>
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
		<?php echo $form->textField($model,'fecha_creacion'); ?>
		<?php echo $form->error($model,'fecha_creacion'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_eliminacion'); ?>
		<?php echo $form->textField($model,'fecha_eliminacion'); ?>
		<?php echo $form->error($model,'fecha_eliminacion'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'tipo_repositorio_id'); ?>
		<?php echo $form->textField($model,'tipo_repositorio_id'); ?>
		<?php echo $form->error($model,'tipo_repositorio_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'modelo_aprendizaje_id'); ?>
		<?php echo $form->textField($model,'modelo_aprendizaje_id'); ?>
		<?php echo $form->error($model,'modelo_aprendizaje_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->