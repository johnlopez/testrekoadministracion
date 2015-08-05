<?php
/* @var $this DatoLaboralController */
/* @var $data DatoLaboral */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre_empresa')); ?>:</b>
	<?php echo CHtml::encode($data->nombre_empresa); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ano_antiguedad')); ?>:</b>
	<?php echo CHtml::encode($data->ano_antiguedad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('cargo')); ?>:</b>
	<?php echo CHtml::encode($data->cargo); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('actividad')); ?>:</b>
	<?php echo CHtml::encode($data->actividad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('comuna_empresa')); ?>:</b>
	<?php echo CHtml::encode($data->comuna_empresa); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ciudad_empresa')); ?>:</b>
	<?php echo CHtml::encode($data->ciudad_empresa); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('telefono_empresa')); ?>:</b>
	<?php echo CHtml::encode($data->telefono_empresa); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('celular_empresa')); ?>:</b>
	<?php echo CHtml::encode($data->celular_empresa); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('rut_numero')); ?>:</b>
	<?php echo CHtml::encode($data->rut_numero); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('digito_verificador')); ?>:</b>
	<?php echo CHtml::encode($data->digito_verificador); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('usuario_id')); ?>:</b>
	<?php echo CHtml::encode($data->usuario_id); ?>
	<br />

	*/ ?>

</div>