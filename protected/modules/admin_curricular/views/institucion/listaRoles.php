<h3>Listado de roles</h3><br><br>

<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>
<div class="container">
    <section>
        <table id="main_table_demo" class="display cell-hovered hovered striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>NOMBRE</th>
                    <th>DESCRIPCION</th>
                    <th>TIPO</th>
                    <th>ROL USUARIO GENERAL</th>
                    <th>FECHA CREACION</th>
                    <th>FECHA ELIMINACION</th>
                    <th>FECHA ACCESO</th>
                    <th>FECHA MODIFICACION</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoRoles as $roles):?>                                                     
                    <tr>
                        <td><?php echo $roles['id'] ?></td>
                        <td><?php echo $roles['nombre'] ?></td>
                        <td><?php echo $roles['descripcion'] ?></td>
                        <td><?php echo $roles['tipo'] ?></td>
                        <td><?php echo $roles['rol_usuario_general_id'] ?></td>
                        <td><?php echo $roles['fecha_creacion'] ?></td>
                        <td><?php echo $roles['fecha_eliminacion'] ?></td>
                        <td><?php echo $roles['fecha_acceso'] ?></td>
                        <td><?php echo $roles['fecha_modificacion'] ?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/usuariohasprogramaacademico/listausuarios" method="get">
                                    <input type="hidden" name="id" value="<?php echo $roles['id']?>" />
                                    <input type="hidden" name="programa_id" value="<?php echo $programa_id; ?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-eye">

                                        </span>
                                    </button>
                                </form>
                            </div>                                        
                        </td>
                    </tr>
                <?php endforeach;?>   
            </tbody>
        </table>
        <ul class="tabs">
                <li class="active"></li>                        
        </ul>               
    </section>
</div>