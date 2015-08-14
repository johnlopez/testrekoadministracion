<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */
/* @var $form CActiveForm */
?>

<div class="wide form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

	<div class="row">
		<?php echo $form->label($model,'id'); ?>
		<?php echo $form->textField($model,'id'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'nombre_empresa'); ?>
		<?php echo $form->textField($model,'nombre_empresa',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'ano_antiguedad'); ?>
		<?php echo $form->textField($model,'ano_antiguedad'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'cargo'); ?>
		<?php echo $form->textField($model,'cargo',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'actividad'); ?>
		<?php echo $form->textField($model,'actividad',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'comuna_empresa'); ?>
		<?php echo $form->textField($model,'comuna_empresa',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'ciudad_empresa'); ?>
		<?php echo $form->textField($model,'ciudad_empresa',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'telefono_empresa'); ?>
		<?php echo $form->textField($model,'telefono_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'celular_empresa'); ?>
		<?php echo $form->textField($model,'celular_empresa'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'rut_numero'); ?>
		<?php echo $form->textField($model,'rut_numero'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'digito_verificador'); ?>
		<?php echo $form->textField($model,'digito_verificador'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'usuario_id'); ?>
		<?php echo $form->textField($model,'usuario_id'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton('Search'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- search-form -->