<h1>Permisos por asignar</h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>

<div class="padding20 bg-grayLighter">
    <div class="inline-block" id="main_table_demo_keys">
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" name="check" onclick="marcar(this.checked)">            
            <span class="check"></span>
            <span class="caption">Seleccionar Todos</span>
        </label>        
    </div>
</div>

<form name="f1" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/rolusuariohasauthitempermisousuario/asignarpermisos" method="post">
    <div class="container">
        <section>
            <table id="main_table_demo" class="display  striped" cellspacing="0" width="100%">
                <tbody>                
                    <?php foreach($objeto as $obje):?>
                        <?php
                            if(in_array($obje->authitem_permiso_usuario_name, $seleccionados)){
                                $check = 'checked="unchecked"';
                            }
                            else{
                                $check = '';
                            }
                        ?>                                                           
                        <tr>
                            <td>&nbsp
                                <div class="inline-block" id="main_table_demo_keys">
                                    <label class="input-control checkbox small-check no-margin">
                                        <input type="checkbox" name="authitem_permiso_usuario_name[]" value="<?php echo $obje->authitem_permiso_usuario_name;?>" <?php echo $check;?> >      
                                        <span class="check"></span>
                                        <span class="caption"></span>
                                    </label> 
                                </div>
                                <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-list", serialize ($seleccionados)); ?>
                                <?php echo CHtml::hiddenField("datos-authitem_permiso_usuario_name-select", serialize (CHtml::listData($objeto,'authitem_permiso_usuario_name','authitem_permiso_usuario_name'))); ?>
                                <?php echo CHtml::hiddenField("datos-rol-id",$idRol); ?>
                            </td>
                            <td>
                                <?php echo $obje->authitem_permiso_usuario_name;?>
                            </td>
                            <td>
                                <form action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/rolusuariohasprivilegiousuario/index" method="post">
                                    <input type="hidden" name="authitem_permiso_usuario_name" value="<?php echo $obje->authitem_permiso_usuario_name;?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">
                                        </span>
                                    </button>
                                </form>
                            </td>                        
                        </tr>
                    <?php endforeach;?>                    
                </tbody>
            </table>
        </section>
    </div>
    <input type="submit" value="Submit">
</form>
<!-- Scritp de efectos de tabla -->
<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>

<!-- script para marcar todos -->
<script>
function marcar(c)
{ a=document.getElementsByTagName("INPUT");
for(b=0;b<a.length;b++)
if(a[b].type=="checkbox") a[b].checked=c;
}
</script>