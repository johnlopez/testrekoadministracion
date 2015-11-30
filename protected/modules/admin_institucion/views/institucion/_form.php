<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'institucion-form',
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
		<?php echo $form->labelEx($model,'sigla'); ?>
		<?php echo $form->textField($model,'sigla',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'sigla'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'vision'); ?>
		<?php echo $form->textArea($model,'vision',array('size'=>200,'maxlength'=>200)); ?>
		<?php echo $form->error($model,'vision'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'mision'); ?>
		<?php echo $form->textArea($model,'mision',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'mision'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'acreditada'); ?>
		<?php echo $form->textField($model,'acreditada'); ?>
		<?php echo $form->error($model,'acreditada'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_inicio_acreditacion'); ?>
		<?php echo $form->textField($model,'fecha_inicio_acreditacion'); ?>                   
		<?php echo $form->error($model,'fecha_inicio_acreditacion'); ?>
                
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_termino_acreditacion'); ?>
		<?php echo $form->textField($model,'fecha_termino_acreditacion'); ?>              
		<?php echo $form->error($model,'fecha_termino_acreditacion'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'descripcion'); ?>
		<?php echo $form->textField($model,'descripcion',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'descripcion'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'estado_institucion_id'); ?>
		<?php echo $form->dropDownList($model,'estado_institucion_id', CHtml::listData(EstadoInstitucion::model()->findAll(),'id' ,'estado'),array('empty'=>'seleccionar estado')); ?>
		<?php echo $form->error($model,'estado_institucion_id'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'pais_id'); ?>
		<?php echo $form->dropDownList($model,'pais_id', CHtml::listData(Pais::model()->findAll(),'id' ,'nombre'),array('empty'=>'seleccionar pais')); ?>
		<?php echo $form->error($model,'pais_id'); ?>
	</div>
        
        <div class="row">
		<?php echo $form->labelEx($model,'region_id'); ?>
		<?php echo $form->dropDownList($model,'region_id', CHtml::listData(Region::model()->findAll(),'id' ,'nombre'),array('empty'=>'seleccionar region')); ?>
		<?php echo $form->error($model,'region_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Crear institucion'); ?>
	</div>

<?php $this->endWidget(); ?>

</div>

