<?php
/* @var $this PrivilegioAdministradorController */
/* @var $data PrivilegioAdministrador */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('controlador_administrador_id')); ?>:</b>
	<?php echo CHtml::encode($data->controlador_administrador_id); ?>
	<br />


</div>