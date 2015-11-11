<h1>Institucion : <?php echo $nombreInstitucion;?></h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
<h1>Roles (Usuario) por Asignar</h1>
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

<form name="f1" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/institucionhasrolusuario/asignarroles" method="post">
    <div class="container">
        <section>
            <table id="main_table_demo" class="display  striped" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>|</th>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>Tipo</th>
                    </tr>
                </thead>
                <tbody>                
                    <?php foreach($objeto as $obje):?>
                        <?php
                            if(in_array($obje->rol_usuario_id, $seleccionados)){
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
                                        <input type="checkbox" name="rol_usuario_id[]" value="<?php echo $obje->rol_usuario_id;?>" <?php echo $check;?> >      
                                        <span class="check"></span>
                                        <span class="caption"></span>
                                    </label> 
                                </div>
                                    <?php echo CHtml::hiddenField("datos-rol_usuario_id-list", serialize ($seleccionados)); ?>
                                    <?php echo CHtml::hiddenField("datos-rol_usuario_id-select", serialize (CHtml::listData($objeto,'rol_usuario_id','rol_usuario_id'))); ?>
                                    <?php echo CHtml::hiddenField("datos-institucion-id",$idInstitucion)."<br><br>"; ?>
                                    <?php echo CHtml::hiddenField("datos-institucion-nombre",$nombreInstitucion)."<br><br>"; ?>

                            </td>
                            <td>
                                <?php echo $obje->rol_usuario_id;?>
                            </td>
                            <td>
                                <?php echo $obje->rolusuarionombre;?>                                
                            </td>   
                            <td>
                                <?php echo $obje->rolusuariotipo;?>                                
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


<!--codigo de asignacion original-->
<!--<div class="form">
    <?php 
//        echo CHtml::beginForm($this->createUrl('AsignarRoles'), 'post'); 
    ?>

        <h3>Roles (Usuario) por asignar</h3>
        <div class="row rememberMe">
            <?php 
//                echo CHtml::checkBoxList('rol_usuario_id', $seleccionados, CHtml::listData($objeto,'rol_usuario_id','rol_usuario_id'), array('checkAll'=>'Marcar Todos')); 
            ?>
            <?php 
//                echo CHtml::hiddenField("datos-rol_usuario_id-list", serialize ($seleccionados)); 
            ?>
            <?php 
//                echo CHtml::hiddenField("datos-rol_usuario_id-select", serialize (CHtml::listData($objeto,'rol_usuario_id','rol_usuario_id'))); 
            ?>
            <?php 
//                echo CHtml::hiddenField("datos-institucion-id",$idInstitucion)."<br><br>"; 
            ?>
        </div>

        <div class="row submit">
            <?php
//                echo CHtml::submitButton('Asignar Rol Usuario')."<br><br>"; 
            ?>
        </div>
        
    <?php 
//        echo CHtml::endForm(); 
    ?>
</div>-->