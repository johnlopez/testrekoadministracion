<?php

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#institucion-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h3>Listado de instituciones</h3><br><br>

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
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/institucion/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/indexInstitucion" method="get">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pin">

                                        </span>
                                    </button>
                                </form>
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/entidad/admin" method="get">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-eye">

                                        </span>
                                    </button>
                                </form>
                                
                                 <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/institucion/admin3" method="get">
                                    <input type="hidden" name="id" value="<?php echo $institucion['id']?>" />
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

