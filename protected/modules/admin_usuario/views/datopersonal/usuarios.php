<?php
/* @var $this UsuarioController */
/* @var $model Usuario */

$this->breadcrumbs=array(
	'Usuarios'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Usuario', 'url'=>array('index')),
	array('label'=>'Create Usuario', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#usuario-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h2>Administración Usuarios</h2>

<?php echo CHtml::link("Excel",array("admin","excel" =>1),array("class"=>"btn"));?><br>
<?php echo CHtml::link("Csv",array("admin","csv" =>1),array("class"=>"btn"));?><br><br><br>




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
                    <th>USUARIO</th>
                    <th>CLAVE</th>
                    <th>FECHA ACCESO</th>
                    <th>FECHA MODIFICACION</th>
                    <th>FECHA CREACION</th>
                    <th>ESTADO</th>
                    <th>OPCIONES</th> 
                </tr>
            </thead>
            <tbody>
                <?php $vacioEstado = 'Sin estado'; ?>
                <?php $vacioFechaModificacion = 'No se registra'?>
                <?php $vacioFechaAcceso = 'No se registra'?>
                <?php foreach ($listadoUsuarios as $usuario):?>                                                     
                    <tr>
                        <td><?php echo $usuario['id'] ?></td>
                        <td><?php echo $usuario['usuario'] ?></td>
                        <td><?php echo $usuario['clave']?></td>
                        <td><?php echo $usuario['fecha_acceso']? : $usuario['fecha_acceso'] = $vacioFechaAcceso ?></td>
                        <td><?php echo $usuario['fecha_modificacion'] ? : $usuario['fecha_modificacion'] = $vacioFechaModificacion ?></td>
                        <td><?php echo $usuario['fecha_creacion']?></td>
                        <td><?php echo $usuario['estado'] ? : $usuario['estado'] = $vacioEstado ?></td>
       
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/usuario/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/usuario/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/usuario/borrar" method="post">
                                    <input type="hidden" name="id" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-cancel">

                                        </span>
                                    </button>
                                </form> 
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datopersonal/admin" method="post">
                                    <input type="hidden" name="idUsuario" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-visa">

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

