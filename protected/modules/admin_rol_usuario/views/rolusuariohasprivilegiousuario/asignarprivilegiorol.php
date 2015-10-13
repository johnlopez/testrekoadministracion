<h1>Rol : <?php echo $rol_usuario_nombre;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Permiso : <?php echo $authitem_permiso_usuario_name;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Privilegios por Asignar</h1>
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

<form name="f1" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/rolusuariohasprivilegiousuario/asignarprivilegios" method="post">
    <div class="container">
        <section>
            <table id="main_table_demo" class="display  striped" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>|</th>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>Controlador</th>
                    </tr>
                </thead>
                <tbody>                
                    <?php foreach($objeto as $obje):?>
                        <?php
                            if(in_array($obje->privilegio_usuario_id, $seleccionados)){
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
                                        <input type="checkbox" name="privilegio_usuario_id[]" value="<?php echo $obje->privilegio_usuario_id;?>" <?php echo $check;?> >      
                                        <span class="check"></span>
                                        <span class="caption"></span>
                                    </label> 
                                </div>
                                <?php echo CHtml::hiddenField("datos-privilegio_usuario_id-list", serialize ($seleccionados)); ?>
                                <?php echo CHtml::hiddenField("datos-privilegio_usuario_id-select", serialize (CHtml::listData($objeto,'privilegio_usuario_id','privilegio_usuario_id'))); ?>
                                <?php echo CHtml::hiddenField("datos-rol-id",$idRol); ?>
                                <?php echo CHtml::hiddenField("rol_usuario_nombre",$rol_usuario_nombre); ?>            
                                <?php echo CHtml::hiddenField("authitem_permiso_usuario_name",$authitem_permiso_usuario_name)."<br><br>"; ?>

                            </td>
                            <td>
                                <?php echo $obje->privilegio_usuario_id;?>
                            </td>
                            <td>
                                <?php echo $obje->privilegiousuarionombre;?>
                            </td>
                            <td>
                                <?php echo $obje->controladorusuarionombre;?>
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

