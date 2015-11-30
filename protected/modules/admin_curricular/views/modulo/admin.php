<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/modulo/create" >
            <button class="button primary" type="submit">
                    Agregar Modulo
            </button>
        </form>   
</div>

<h2>Administración modulos</h2><br><br>

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
                    <th>FECHA CREACION</th>
                    <th>FECHA MODIFICACION</th>
                    <th>ESTADO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php $vacio = 'Sin estado'; ?>
                <?php foreach ($listadoModulos as $modulo):?>                                                     
                    <tr>
                        <td><?php echo $modulo['id'] ?></td>
                        <td><?php echo $modulo['nombre'] ?></td>
                        <td><?php echo $modulo['descripcion']?></td>
                        <td><?php echo $modulo['fecha_creacion']?></td>
                        <td><?php echo $modulo['fecha_modificacion']?></td>
                        <td><?php echo $modulo['estado'] ? : $modulo['estado'] = $vacio ?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/modulo/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $modulo['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/modulo/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $modulo['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/modulo/borrar" method="post">
                                    <input type="hidden" name="id" value="<?php echo $modulo['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-cancel">

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



<a href="<?php echo Yii::app()->getBaseUrl()."/admin_curricular/institucion/admin2";?>" >
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