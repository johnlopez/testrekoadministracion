<?php
/* @var $this SeccionController */
/* @var $model Seccion */

$this->breadcrumbs=array(
	'Seccions'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Seccion', 'url'=>array('index')),
	array('label'=>'Create Seccion', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#seccion-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h2>Administración secciones</h2><br<<br>

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
                    <th>JORNADA</th>
                    <th>DESCRIPCION</th>
                    <th>FECHA CREACION</th>
                    <th>FECHA MODIFICACION</th>
                    <th>MODULO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoSeccion as $seccion):?>                                                     
                    <tr>
                        <td><?php echo $seccion['id'] ?></td>
                        <td><?php echo $seccion['nombre'] ?></td>
                        <td><?php echo $seccion['jornada']?></td>
                        <td><?php echo $seccion['descripcion']?></td>
                        <td><?php echo $seccion['fecha_creacion']?></td>
                        <td><?php echo $seccion['fecha_modificacion']?></td>
                        <td><?php echo $seccion['modulo_id']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/seccion/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $seccion['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/institucion/listaRolesSeccion" method="get">
                                    <input type="hidden" name="id" value="<?php echo $seccion['id']?>" />
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

