<?php
/* @var $this ProgramaAcademicoController */
/* @var $model ProgramaAcademico */

$this->breadcrumbs=array(
	'Programa Academicos'=>array('index'),
	'Manage',
);



Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#programa-academico-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h3>Listado de programas academicos</h3><br><br>


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
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoPrograma as $programa):?>                                                     
                    <tr>
                        <td><?php echo $programa['id'] ?></td>
                        <td><?php echo $programa['nombre'] ?></td>
                        <td><?php echo $programa['descripcion']?></td>
                        <td><?php echo $programa['version']?></td>
                        <td><?php echo $programa['fecha_creacion']?></td>
                        <td><?php echo $programa['fecha_modificacion']?></td>
                        <td><?php echo $programa['entidad_id']?></td>
                        <td><?php echo $programa['institucion_id']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/usuariohasprogramaacademico/listausuarios" method="get">
                                    <input type="hidden" name="id" value="<?php echo $programa['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-eye">

                                        </span>
                                    </button>
                                </form>
                                
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/institucion/listaRoles" method="get">
                                    <input type="hidden" name="id" value="<?php echo $programa['id']?>" />
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

