<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarPermisos'), 'post'); ?>

        <h3>Permisos por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('authitem_permiso_usuario_name', $seleccionados, CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-select", serialize (CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'))); ?>
            <?php echo CHtml::hiddenField("datos-rol-id",$idRol)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Permisos')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>