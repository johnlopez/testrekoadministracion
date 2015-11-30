<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/create" >
            <button class="button primary" type="submit">
                    Crear Institucion
            </button>
        </form>          
</div>


<h2>Administración Institucion</h2><br><br>


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
                    <th>SIGLA</th>
                    <th>VISION</th>
                    <th>MISION</th>
                    <th>ACREDITADA</th>
                    <th>FECHA INICIO ACRED</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoInstitucion as $institucion):?>                                                     
                    <tr>
                        <td><?php echo $institucion['id'] ?></td>
                        <td><?php echo $institucion['nombre'] ?></td>
                        <td><?php echo $institucion['sigla'] ?></td>
                        <td><?php echo $institucion['vision']?></td>
                        <td><?php echo $institucion['mision']?></td>
                        <td><?php echo $institucion['acreditada']?></td>
                        <td><?php echo $institucion['fecha_inicio_acreditacion']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/borrar" method="post">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
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

<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion" >
            <button class="button primary" type="submit">
                    Volver a administracion
            </button>
        </form>          
</div>
