<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarEntidadEntidad'), 'post'); ?>

        <h3>Entidades por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('id', $seleccionados, CHtml::listData($objeto,'id','nombre'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-id-select", serialize (CHtml::listData($objeto,'id','id'))); ?>
            <?php echo CHtml::hiddenField("datos-entidad-id",$idEntidad)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Entidad')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>
