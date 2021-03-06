<?php
/* @var $this SeccionController */
/* @var $model Seccion */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'seccion-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Campos son <span class="required">*</span> son requeridos.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'nombre'); ?>
		<?php echo $form->textField($model,'nombre',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'nombre'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'codigo'); ?>
		<?php echo $form->textField($model,'codigo',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'codigo'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'jornada'); ?>
		<?php echo $form->textField($model,'jornada',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'jornada'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'descripcion'); ?>
		<?php echo $form->textField($model,'descripcion',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'descripcion'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'estado_seccion_id'); ?>
		<?php echo $form->dropDownList($model,'estado_seccion_id', CHtml::listData(EstadoSeccion::model()->findAll(),'id' ,'estado'),array('empty'=>'seleccionar estado')); ?>
		<?php echo $form->error($model,'estado_seccion_id'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'modulo_id'); ?>
		<?php echo $form->dropDownList($model,'modulo_id', CHtml::listData(Modulo::model()->findAll(),'id' ,'nombre'),array('empty'=>'seleccionar modulo')); ?>
		<?php echo $form->error($model,'modulo_id'); ?>
	</div>
        
	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->