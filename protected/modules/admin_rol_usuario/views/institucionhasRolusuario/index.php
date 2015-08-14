<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarRoles'), 'post'); ?>

        <h3>Usuarios por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('institucion_id', $seleccionados, CHtml::listData($objeto,'institucion_id','institucion_id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-institucion_id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-institucion_id-select", serialize (CHtml::listData($objeto,'institucion_id','institucion_id'))); ?>
            <?php echo CHtml::hiddenField("datos-rol-id",$idRol)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Institucion')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>
