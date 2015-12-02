<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/create" >
            <button class="button primary" type="submit">
                    Crear Programa
            </button>
        </form>          
</div>

<h2>Administración programas academicos</h2><br><br>


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
                    <th>VERSION</th>
                    <th>FECHA CREACION</th>
                    <th>FECHA MODIFICACION</th>
                    <th>ENTIDAD</th>
                    <th>INSTITUCION</th>
                    <th>ESTADO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php $vacioEstado = 'Sin estado'; ?>
                <?php $vacioEntidad = 'Sin entidad'; ?>
                <?php $vacioInstitucion = 'Sin institucion'; ?>
                <?php foreach ($listadoPrograma as $programa):?>                                                     
                    <tr>
                        <td><?php echo $programa['id'] ?></td>
                        <td><?php echo $programa['nombre'] ?></td>
                        <td><?php echo $programa['descripcion']?></td>
                        <td><?php echo $programa['version']?></td>
                        <td><?php echo $programa['fecha_creacion']?></td>
                        <td><?php echo $programa['fecha_modificacion']?></td>
                        <td><?php echo $programa['entidad_id'] ? : $programa['entidad_id'] = $vacioEntidad ?></td>
                        <td><?php echo $programa['nombre_institucion'] ? : $programa['institucion_id'] = $vacioInstitucion ?></td>
                        <td><?php echo $programa['estado'] ? : $programa['estado'] = $vacioEstado ?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $programa['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $programa['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/borrar" method="post">
                                    <input type="hidden" name="id" value="<?php echo $programa['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-cancel">

                                        </span>
                                    </button>
                                </form> 
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademicohasmodulo/index" method="get">
                                    <input type="hidden" name="id" value="<?php echo $programa['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pin">

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



<a href="<?php echo Yii::app()->getBaseUrl()."/admin_curricular/institucion/admin";?>" >
                <div class="tile-small bg-darkViolet fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-library"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
</a>

<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular" >
            <button class="button primary" type="submit">
                    Volver a administracion
            </button>
        </form>          
</div>

