<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarPrivilegios'), 'post'); ?>
        <h3>Privilegios por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('privilegio_usuario_id', $seleccionados, CHtml::listData($objeto,'privilegio_usuario_id','controladorusuarionombre'), array("template" => " <td>{input}</td><td>{label}</td><div id='textDiv'></div>", 'checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-privilegio_usuario_id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-privilegio_usuario_id-select", serialize (CHtml::listData($objeto,'privilegio_usuario_id','privilegio_usuario_id'))); ?>
            <?php echo CHtml::hiddenField("datos-rol-id",$idRol); ?>
            <?php echo CHtml::hiddenField("rol_usuario_nombre",$rol_usuario_nombre); ?>            
            <?php echo CHtml::hiddenField("authitem_permiso_usuario_name",$authitem_permiso_usuario_name)."<br><br>"; ?>

        </div>
        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Privilegios')."<br><br>"; ?>
        </div>        
    <?php echo CHtml::endForm(); ?>
</div>
