<?php
/* @var $this DatoAcademicoController */
/* @var $data DatoAcademico */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('universidad')); ?>:</b>
	<?php echo CHtml::encode($data->universidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('carrera')); ?>:</b>
	<?php echo CHtml::encode($data->carrera); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ano_cursado')); ?>:</b>
	<?php echo CHtml::encode($data->ano_cursado); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('duracion_carrera')); ?>:</b>
	<?php echo CHtml::encode($data->duracion_carrera); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('sede')); ?>:</b>
	<?php echo CHtml::encode($data->sede); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('direccion_sede')); ?>:</b>
	<?php echo CHtml::encode($data->direccion_sede); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('comuna_sede')); ?>:</b>
	<?php echo CHtml::encode($data->comuna_sede); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ciudad_sede')); ?>:</b>
	<?php echo CHtml::encode($data->ciudad_sede); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('usuario_id')); ?>:</b>
	<?php echo CHtml::encode($data->usuario_id); ?>
	<br />

	*/ ?>

</div>