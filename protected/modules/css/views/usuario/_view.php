<?php
/* @var $this UsuarioController */
/* @var $data Usuario */
?>


<div class="view">
    <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="get">
        <input type="hidden" name="id" value="<?php echo $data->id?>" />
        <button class="tile-wide bg-darkCyan fg-white" data-role="tile" type="submit">
            <b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
            <?php echo CHtml::encode($data->id); ?>
            <br />

            <b><?php echo CHtml::encode($data->getAttributeLabel('usuario')); ?>:</b>
            <?php echo CHtml::encode($data->usuario); ?>
            <br />

            <b><?php echo CHtml::encode($data->getAttributeLabel('clave')); ?>:</b>
            <?php echo CHtml::encode($data->clave); ?>
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
        </button>
    </form> 
</div>

