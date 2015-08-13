<?php
/* @var $this DatoPersonalController */
/* @var $data DatoPersonal */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('primer_nombre')); ?>:</b>
	<?php echo CHtml::encode($data->primer_nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('segundo_nombre')); ?>:</b>
	<?php echo CHtml::encode($data->segundo_nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('apellido_paterno')); ?>:</b>
	<?php echo CHtml::encode($data->apellido_paterno); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('apellido_materno')); ?>:</b>
	<?php echo CHtml::encode($data->apellido_materno); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('fecha_nacimiento')); ?>:</b>
	<?php echo CHtml::encode($data->fecha_nacimiento); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('edad')); ?>:</b>
	<?php echo CHtml::encode($data->edad); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('rut')); ?>:</b>
	<?php echo CHtml::encode($data->rut); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('digito_verificador')); ?>:</b>
	<?php echo CHtml::encode($data->digito_verificador); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('direccion_personal')); ?>:</b>
	<?php echo CHtml::encode($data->direccion_personal); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('numero_casa')); ?>:</b>
	<?php echo CHtml::encode($data->numero_casa); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('telefono_personal')); ?>:</b>
	<?php echo CHtml::encode($data->telefono_personal); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('celular_personal')); ?>:</b>
	<?php echo CHtml::encode($data->celular_personal); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('comuna_personal')); ?>:</b>
	<?php echo CHtml::encode($data->comuna_personal); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('ciudad_personal')); ?>:</b>
	<?php echo CHtml::encode($data->ciudad_personal); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('interes')); ?>:</b>
	<?php echo CHtml::encode($data->interes); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('estado_civil')); ?>:</b>
	<?php echo CHtml::encode($data->estado_civil); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('idioma')); ?>:</b>
	<?php echo CHtml::encode($data->idioma); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nacionalidad')); ?>:</b>
	<?php echo CHtml::encode($data->nacionalidad); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('usuario_id')); ?>:</b>
	<?php echo CHtml::encode($data->usuario_id); ?>
	<br />

	*/ ?>

</div>