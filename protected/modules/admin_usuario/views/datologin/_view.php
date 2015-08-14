<?php
/* @var $this DatoLoginController */
/* @var $data DatoLogin */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('pregunta_secreta_1')); ?>:</b>
	<?php echo CHtml::encode($data->pregunta_secreta_1); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('pregunta_secreta_2')); ?>:</b>
	<?php echo CHtml::encode($data->pregunta_secreta_2); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('respuesta_secreta_1')); ?>:</b>
	<?php echo CHtml::encode($data->respuesta_secreta_1); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('respuesta_secreta_2')); ?>:</b>
	<?php echo CHtml::encode($data->respuesta_secreta_2); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('usuario_id')); ?>:</b>
	<?php echo CHtml::encode($data->usuario_id); ?>
	<br />


</div>