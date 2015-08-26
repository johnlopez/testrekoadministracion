<?php
/* @var $this DatoLoginController */
/* @var $data DatoLogin */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('usuario_id')); ?>:</b>
	<?php echo CHtml::encode($data->usuario_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('codigo_seguridad_id')); ?>:</b>
	<?php echo CHtml::encode($data->codigo_seguridad_id); ?>
	<br />


</div>