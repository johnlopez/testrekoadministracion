<?php
/* @var $this ControladorAdministradorController */
/* @var $data ControladorAdministrador */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('nombre')); ?>:</b>
	<?php echo CHtml::encode($data->nombre); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('authitem_permiso_administrador_name')); ?>:</b>
	<?php echo CHtml::encode($data->authitem_permiso_administrador_name); ?>
	<br />


</div>