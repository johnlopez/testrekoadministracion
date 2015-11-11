<?php
/* @var $this RepositoriomasterController */
/* @var $data RepositorioMaster */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('descripcion')); ?>:</b>
	<?php echo CHtml::encode($data->descripcion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_acceso')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_acceso); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_modificacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_modificacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_creacion')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_creacion); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('modelo_aprendizaje_master_id')); ?>:</b>
	<?php echo CHtml::encode($data->modelo_aprendizaje_master_id); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('secuencia_master_id')); ?>:</b>
	<?php echo CHtml::encode($data->secuencia_master_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('repositorio_master_id')); ?>:</b>
	<?php echo CHtml::encode($data->repositorio_master_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('tipo_repositorio_master_id')); ?>:</b>
	<?php echo CHtml::encode($data->tipo_repositorio_master_id); ?>
	<br />

	*/ ?>

</div>