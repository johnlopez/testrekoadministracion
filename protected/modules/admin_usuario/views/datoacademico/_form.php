<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'dato-academico-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'universidad'); ?>
		<?php echo $form->textField($model,'universidad',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'universidad'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'carrera'); ?>
		<?php echo $form->textField($model,'carrera',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'carrera'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'ano_cursado'); ?>
		<?php echo $form->textField($model,'ano_cursado',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'ano_cursado'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'duracion_carrera'); ?>
		<?php echo $form->textField($model,'duracion_carrera',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'duracion_carrera'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'sede'); ?>
		<?php echo $form->textField($model,'sede',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'sede'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'direccion_sede'); ?>
		<?php echo $form->textField($model,'direccion_sede',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'direccion_sede'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'comuna_sede'); ?>
		<?php echo $form->textField($model,'comuna_sede',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'comuna_sede'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'ciudad_sede'); ?>
		<?php echo $form->textField($model,'ciudad_sede',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'ciudad_sede'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'usuario_id'); ?>
		<?php echo $form->dropDownList($model,'usuario_id', CHtml::listData(Usuario::model()->findAll(),'id' ,'usuario'),array('empty'=>'seleccionar usuario')); ?>
		<?php echo $form->error($model,'usuario_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->
