<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarPermisos'), 'post'); ?>
        <h3>Permisos por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('authitem_permiso_usuario_name', $seleccionados, CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'), array("template" => " <td>{input}</td><td>{label}</td><div id='textDiv'></div>", 'checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-select", serialize (CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'))); ?>
            <?php echo CHtml::hiddenField("datos-rol-id",$idRol)."<br><br>"; ?>
        </div>
        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Permisos')."<br><br>"; ?>
        </div>        
    <?php echo CHtml::endForm(); ?>
    <?php ?>        
</div>


<input type="checkbox" name="check" onclick="marcar(this.checked)"> Seleccionar Todos <br>

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
    <input type="checkbox" name="authitem_permiso_usuario_name[]" value="<?php echo $obje->authitem_permiso_usuario_name;?>" <?php echo $check;?> ><?php echo $obje->authitem_permiso_usuario_name;?><br>
    <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-list", serialize ($seleccionados)); ?>
    <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-select", serialize (CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'))); ?>
    <?php echo CHtml::hiddenField("datos-rol-id",$idRol)."<br><br>"; ?>
    <?php endforeach; ?>
    <input type="submit" value="Submit">
</form>

<script>
function marcar(c)
{ a=document.getElementsByTagName("INPUT");
for(b=0;b<a.length;b++)
if(a[b].type=="checkbox") a[b].checked=c;
}
</script>

borrar
<script>
//$(document).ready(function(){
//    $("input[type=checkbox]").change(function(){
//        if($(this).is(":checked")){
//            var div = document.getElementById("textDiv");
//            div.textContent = "estoy check";
//            var text = div.textContent;
//            //alert("Checked");;
//             //$(this).siblings("input[type=checkbox]").removeAttr("checked");
//        }
//        else{
//            alert("Unchecked")  
//        }
//    });
//});
</script>