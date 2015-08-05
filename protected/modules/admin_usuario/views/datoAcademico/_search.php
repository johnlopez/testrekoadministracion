<?php
/* @var $this DatoAcademicoController */
/* @var $model DatoAcademico */
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
		<?php echo $form->label($model,'universidad'); ?>
		<?php echo $form->textField($model,'universidad',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'carrera'); ?>
		<?php echo $form->textField($model,'carrera',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'ano_cursado'); ?>
		<?php echo $form->textField($model,'ano_cursado'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'duracion_carrera'); ?>
		<?php echo $form->textField($model,'duracion_carrera'); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'sede'); ?>
		<?php echo $form->textField($model,'sede',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'direccion_sede'); ?>
		<?php echo $form->textField($model,'direccion_sede',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'comuna_sede'); ?>
		<?php echo $form->textField($model,'comuna_sede',array('size'=>45,'maxlength'=>45)); ?>
	</div>

	<div class="row">
		<?php echo $form->label($model,'ciudad_sede'); ?>
		<?php echo $form->textField($model,'ciudad_sede',array('size'=>45,'maxlength'=>45)); ?>
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