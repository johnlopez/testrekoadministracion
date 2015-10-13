<!-- codigo de asignacion sin tabla -->
<input type="checkbox" name="check" onclick="marcar(this.checked)"> Seleccionar Todos <br><br>

<form name="f1" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/rolusuariohasauthitempermisousuario/asignarpermisos" method="post">
    <?php foreach($objeto as $obje):?>
        <?php
            if(in_array($obje->authitem_permiso_usuario_name, $seleccionados))
            {
                $check = 'checked="unchecked"';
            }
            else
            {
                $check = '';
            }
        ?>    
        <input type="checkbox" name="authitem_permiso_usuario_name[]" value="<?php  echo $obje->authitem_permiso_usuario_name;?>" <?php  echo $check;?> ><?php  echo $obje->authitem_permiso_usuario_name;?>       
        <?php  echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-list", serialize ($seleccionados)); ?>
        <?php  echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-select", serialize (CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'))); ?>
        <?php  echo CHtml::hiddenField("datos-rol-id",$idRol); ?>
        <form action="<?php  echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="get">
            <input type="hidden" name="id" value="<?php  echo $obje->authitem_permiso_usuario_name;?>" />
            <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                <span class="icon mif-search">
                </span>
            </button>
        </form>
    <?php endforeach;?>
    <input type="submit" value="Submit">
</form>