<?php
/* @var $this DatoAcademicoController */
/* @var $model DatoAcademico */

$this->breadcrumbs=array(
	'Dato Academicos'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoAcademico', 'url'=>array('index')),
	array('label'=>'Create DatoAcademico', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-academico-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h2>Administración datos academicos</h2><br><br>



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
                    <th>UNIVERSIDAD</th>
                    <th>CARRERA</th>
                    <th>AÑO CURSADO</th>
                    <th>DURACION CARRERA</th>
                    <th>SEDE</th>
                    <th>DIRECCION SEDE</th>
                    <th>COMUNA SEDE</th>
                    <th>CIUDAD SEDE</th>
                    <th>USUARIO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoDatoAcademico as $datoAcademico):?>                                                     
                    <tr>
                        <td><?php echo $datoAcademico['id'] ?></td>
                        <td><?php echo $datoAcademico['universidad'] ?></td>
                        <td><?php echo $datoAcademico['carrera']?></td>
                        <td><?php echo $datoAcademico['ano_cursado']?></td>
                        <td><?php echo $datoAcademico['duracion_carrera']?></td>
                        <td><?php echo $datoAcademico['sede']?></td>
                        <td><?php echo $datoAcademico['direccion_sede']?></td>
                        <td><?php echo $datoAcademico['comuna_sede']?></td>
                        <td><?php echo $datoAcademico['ciudad_sede']?></td>
                        <td><?php echo $datoAcademico['usuario_id']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoacademico/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoAcademico['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoacademico/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoAcademico['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoacademico/borradoFisicoDatoAcademico" method="post">
                                    <input type="hidden" name="id" value="<?php echo $datoAcademico['id']?>" />
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