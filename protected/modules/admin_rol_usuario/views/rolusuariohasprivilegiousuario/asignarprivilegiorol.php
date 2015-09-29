<h1>Rol : <?php echo $rol_usuario_nombre;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Permiso : <?php echo $authitem_permiso_usuario_name;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Privilegios por Asignar</h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>

<!--codigo de asignacion original-->
<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarPrivilegios'), 'post'); ?>
        <h3>Privilegios por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('privilegio_usuario_id', $seleccionados, CHtml::listData($objeto,'privilegio_usuario_id','privilegio_usuario_id'), array("template" => " <td>{input}</td><td>{label}</td><div id='textDiv'></div>", 'checkAll'=>'Marcar Todos')); ?>
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
