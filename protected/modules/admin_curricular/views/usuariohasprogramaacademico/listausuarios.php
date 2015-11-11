<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarUsuariosConRolPrograma'), 'post'); ?>

        <h3>Usuarios por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('usuario_id', $seleccionados, CHtml::listData($objeto,'usuario_id','usuario_id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-id-select", serialize (CHtml::listData($objeto,'usuario_id','usuario_id'))); ?>
            <?php echo CHtml::hiddenField("datos-programa-id",$idPrograma)."<br><br>"; ?>
            <?php echo CHtml::hiddenField("datos-rol-id",$idRol)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Usuario')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>
