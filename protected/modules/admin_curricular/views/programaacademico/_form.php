<?php
/* @var $this ProgramaAcademicoController */
/* @var $model ProgramaAcademico */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'programa-academico-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Campos con <span class="required">*</span> son requeridos.</p>

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
		<?php echo $form->labelEx($model,'version'); ?>
		<?php echo $form->textField($model,'version',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'version'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'entidad'); ?>
		<?php echo $form->dropDownList($model,'entidad_id', CHtml::listData(Entidad::model()->findAll(),'id' ,'nombre'),array('empty'=>'seleccionar entidad')); ?>
		<?php echo $form->error($model,'entidad_id'); ?>
	</div>
        
        <div class="row">
                <?php echo $form->labelEx($model,'institucion'); ?>
                <?php echo $form->dropDownList($model,'institucion_id', CHtml::listData(Institucion::model()->findAll(),'id' ,'nombre'),array('empty'=>'seleccionar institucion')); ?>
                <?php echo $form->error($model,'institucion_id'); ?>
        </div>
        
         <div class="row">
                <?php echo $form->labelEx($model,'estado'); ?>
                <?php echo $form->dropDownList($model,'estado_programa_academico_id', CHtml::listData(EstadoProgramaAcademico::model()->findAll(),'id' ,'estado'),array('empty'=>'seleccionar estado')); ?>
                <?php echo $form->error($model,'estado_programa_academico_id'); ?>
        </div>
        
	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->