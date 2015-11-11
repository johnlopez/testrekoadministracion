<?php
/* @var $this InstitucionController */
/* @var $model Institucion */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'institucion-form',
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
		<?php echo $form->labelEx($model,'vision'); ?>
		<?php echo $form->textField($model,'vision',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'vision'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'mision'); ?>
		<?php echo $form->textField($model,'mision',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'mision'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'acreditada'); ?>
		<?php echo $form->textField($model,'acreditada'); ?>
		<?php echo $form->error($model,'acreditada'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_inicio_acreditacion'); ?>
		<?php
                    $this->widget('zii.widgets.jui.CJuiDatePicker',array(
                        'model' => $model,
                        'value'=>date('Y-m-d H:i:s'), 
                        'language' => 'es',
                        'attribute' => 'fecha_inicio_acreditacion',
                        'options'=>array(
                            'showAnim'=>'fold',
                        ),
                    ));
                ?>
		<?php echo $form->error($model,'fecha_inicio_acreditacion'); ?>
                
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'fecha_termino_acreditacion'); ?>
		<?php
                     $this->widget('zii.widgets.jui.CJuiDatePicker', array(
                    'model' => $model,
                    'value'=>date('Y-m-d H:i:s'),  
                    'language' => 'es',
                    'attribute' => 'fecha_termino_acreditacion',
                    'options' => array(
                        'showAnim' => 'fold',
                    ),
                    ));
                ?>
		<?php echo $form->error($model,'fecha_termino_acreditacion'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'descripcion'); ?>
		<?php echo $form->textField($model,'descripcion',array('size'=>45,'maxlength'=>45)); ?>
		<?php echo $form->error($model,'descripcion'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->