<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */

$this->breadcrumbs=array(
	'Dato Laborals'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoLaboral', 'url'=>array('index')),
	array('label'=>'Create DatoLaboral', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-laboral-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h2>Administración datos laborales</h2><br><br>


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
                    <th>NOMBRE EMPRESA</th>
                    <th>AÑOS ANTIGUEDAD</th>
                    <th>CARGO</th>
                    <th>ACTIVIDAD</th>
                    <th>COMUNA</th>
                    <th>CIUDAD</th>
                    <th>TELEFONO</th>
                    <th>CELULAR</th>
                    <th>RUT</th>
                    <th>DIGITO VERIFICADOR</th>
                    <th>USUARIO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoDatoLaboral as $datoLaboral):?>                                                     
                    <tr>
                        <td><?php echo $datoLaboral['id'] ?></td>
                        <td><?php echo $datoLaboral['nombre_empresa'] ?></td>
                        <td><?php echo $datoLaboral['ano_antiguedad']?></td>
                        <td><?php echo $datoLaboral['cargo']?></td>
                        <td><?php echo $datoLaboral['actividad']?></td>
                        <td><?php echo $datoLaboral['comuna_empresa']?></td>
                        <td><?php echo $datoLaboral['ciudad_empresa']?></td>
                        <td><?php echo $datoLaboral['telefono_empresa']?></td>
                        <td><?php echo $datoLaboral['celular_empresa']?></td>
                        <td><?php echo $datoLaboral['rut_numero']?></td>
                        <td><?php echo $datoLaboral['digito_verificador']?></td>
                        <td><?php echo $datoLaboral['usuario_id']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoLaboral/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoLaboral['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoLaboral/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoLaboral['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datoLaboral/borradoFisicoDatoLaboral" method="post">
                                    <input type="hidden" name="id" value="<?php echo $datoLaboral['id']?>" />
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