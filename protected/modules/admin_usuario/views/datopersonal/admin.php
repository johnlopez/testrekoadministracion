<?php
/* @var $this DatoPersonalController */
/* @var $model DatoPersonal */

$this->breadcrumbs=array(
	'Dato Personals'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoPersonal', 'url'=>array('index')),
	array('label'=>'Create DatoPersonal', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-personal-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h2>Administración datos personales</h2><br><br>

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
                    <th>PRIMER NOMBRE</th>
                    <th>SEGUNDO NOMBRE</th>
                    <th>APELLIDO PATERNO</th>
                    <th>APELLIDO MATERNO</th>
                    <th>FECHA NACIMIENTO</th>
                    <th>EDAD</th>
                    <th>RUT</th>
                    <th>DIGITO VERIFICADOR</th>
                    <th>DIRECCION PERSONAL</th>
                    <th>OPCIONES</th>
<!--                    <th>NUMERO DE CASA</th>
                    <th>TELEFONO</th>
                    <th>CELULAR</th>
                    <th>COMUNA</th>
                    <th>CIUDAD</th>
                    <th>INTERES</th>
                    <th>ESTADO CIVIL</th>
                    <th>IDIOMAS</th>
                    <th>NACIONALIDAD</th>
                    <th>USUARIO</th>-->
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoDatoPersonal as $datoPersonal):?>                                                     
                    <tr>
                        <td><?php echo $datoPersonal['id'] ?></td>
                        <td><?php echo $datoPersonal['primer_nombre'] ?></td>
                        <td><?php echo $datoPersonal['segundo_nombre']?></td>
                        <td><?php echo $datoPersonal['apellido_paterno']?></td>
                        <td><?php echo $datoPersonal['apellido_materno']?></td>
                        <td><?php echo $datoPersonal['fecha_nacimiento']?></td>
                        <td><?php echo $datoPersonal['edad']?></td>
                        <td><?php echo $datoPersonal['rut']?></td>
                        <td><?php echo $datoPersonal['digito_verificador']?></td>
                        <td><?php echo $datoPersonal['direccion_personal']?></td>
<!--                        <td><?php echo $datoPersonal['numero_casa']?></td>
                        <td><?php echo $datoPersonal['telefono_personal']?></td>
                        <td><?php echo $datoPersonal['celular_personal']?></td>
                        <td><?php echo $datoPersonal['comuna_personal']?></td>
                        <td><?php echo $datoPersonal['ciudad_personal']?></td>
                        <td><?php echo $datoPersonal['interes']?></td>
                        <td><?php echo $datoPersonal['estado_civil']?></td>
                        <td><?php echo $datoPersonal['idioma']?></td>
                        <td><?php echo $datoPersonal['nacionalidad']?></td>
                        <td><?php echo $datoPersonal['usuario']?></td>-->
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoPersonal/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoPersonal['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoPersonal/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoPersonal['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoPersonal/borradoFisicoDatoPersonal" method="post">
                                    <input type="hidden" name="id" value="<?php echo $datoPersonal['id']?>" />
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