<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/region/create" >
            <button class="button primary" type="submit">
                    Crear region
            </button>
        </form>          
</div>

<h2>Administración regiones</h2><br><br>

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
                    <th>CODIGO</th>
                    <th>PAIS</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoRegion as $region):?>                                                     
                    <tr>
                        <td><?php echo $region['id'] ?></td>
                        <td><?php echo $region['nombre'] ?></td>
                        <td><?php echo $region['codigo']?></td>
                        <td><?php echo $region['pais_id']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/region/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $region['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/region/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $region['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/region/borradoFisicoRegion" method="post">
                                    <input type="hidden" name="id" value="<?php echo $region['id']?>" />
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
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario" >
            <button class="button primary" type="submit">
                    Volver a administracion
            </button>
        </form>          
</div>