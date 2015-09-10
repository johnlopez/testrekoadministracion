<?php
/* @var $this InstitucionController */
/* @var $data Institucion */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('vision')); ?>:</b>
	<?php echo CHtml::encode($data->vision); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('mision')); ?>:</b>
	<?php echo CHtml::encode($data->mision); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('acreditada')); ?>:</b>
	<?php echo CHtml::encode($data->acreditada); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_inicio_acreditacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_inicio_acreditacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_termino_acreditacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_termino_acreditacion); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('descripcion')); ?>:</b>
	<?php echo CHtml::encode($data->descripcion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_creacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_creacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_modificacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_modificacion); ?>
	<br />

	*/ ?>

</div>