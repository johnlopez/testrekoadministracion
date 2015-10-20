<h1>Institucion: <?php echo $institucionNombre;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Rol Usuario: <?php echo $rolUsuarioNombre;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Listado de usuarios de la Institucion</h1>
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

<form name="f1" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/usuariohasrolusuario/asignarusuarios" method="post">
    <div class="container">
        <section>
            <table id="main_table_demo" class="display  striped" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>|</th>
                        <th>Id</th>   
                        <th>Usuario</th> 
                        <th>Rut</th>  
                        <th>Primer Nombre</th>   
                        <th>Apellido Paterno</th>   
                        <th>Apellido Materno</th>                        
                    </tr>
                </thead>
                <tbody>                
                    <?php foreach($objeto as $obje):?>
                        <?php
                            if(in_array($obje->usuario_id, $seleccionados)){
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
                                        <input type="checkbox" name="usuario_id[]" value="<?php echo $obje->usuario_id;?>" <?php echo $check;?> >      
                                        <span class="check"></span>
                                        <span class="caption"></span>
                                    </label> 
                                </div>
                                <?php echo CHtml::hiddenField("datos-usuario_id-list", serialize ($seleccionados)); ?>
                                <?php echo CHtml::hiddenField("datos-usuario_id-select", serialize (CHtml::listData($objeto,'usuario_id','usuario_id'))); ?>
                                <?php echo CHtml::hiddenField("datos-rolUsuario-id",$idRolUsuario)."<br><br>"; ?>
                                <?php echo CHtml::hiddenField("rolUsuarioNombre",$rolUsuarioNombre)."<br><br>"; ?>
                                <?php echo CHtml::hiddenField("institucionId",$institucionId)."<br><br>"; ?>
                                <?php echo CHtml::hiddenField("institucionNombre",$institucionNombre)."<br><br>"; ?>

                            </td>
                            <td>
                                <?php echo $obje->usuario_id;?>
                            </td>
                            <td>
                                <?php echo $obje->usuario;?>
                            </td>
                            <td>
                                <?php echo $obje->rut;?>
                            </td>
                            <td>
                                <?php echo $obje->primerNombre;?>
                            </td>
                            <td>
                                <?php echo $obje->apellidoPaterno;?>
                            </td>
                            <td>
                                <?php echo $obje->apellidoMaterno;?>
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

<!--
<div class="form">
    <?php // echo CHtml::beginForm($this->createUrl('AsignarUsuarios'), 'post'); ?>

        <h3>Usuarios por asignar</h3>
        <div class="row rememberMe">
            <?php // echo CHtml::checkBoxList('usuario_id', $seleccionados, CHtml::listData($objeto,'usuario_id','usuario_id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php // echo CHtml::hiddenField("datos-usuario_id-list", serialize ($seleccionados)); ?>
            <?php // echo CHtml::hiddenField("datos-usuario_id-select", serialize (CHtml::listData($objeto,'usuario_id','usuario_id'))); ?>
            <?php // echo CHtml::hiddenField("datos-rolUsuario-id",$idRolUsuario)."<br><br>"; ?>
            <?php // echo CHtml::hiddenField("institucionId",$institucionId)."<br><br>"; ?>
            <?php // echo CHtml::hiddenField("institucionNombre",$institucionNombre)."<br><br>"; ?>

        </div>

        <div class="row submit">
            <?php // echo CHtml::submitButton('Asignar Usuarios')."<br><br>"; ?>
        </div>
        
    <?php // echo CHtml::endForm(); ?>
</div>-->
