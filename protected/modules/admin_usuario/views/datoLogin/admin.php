<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */

$this->breadcrumbs=array(
	'Dato Logins'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoLogin', 'url'=>array('index')),
	array('label'=>'Create DatoLogin', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-login-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h2>Administración datos login</h2><br><br>

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
                    <th>CODIGO SEGURIDAD</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoDatoLogin as $datoLogin):?>                                                     
                    <tr>
                        <td><?php echo $datoLogin['id'] ?></td>
                        <td><?php echo $datoLogin['usuario_id'] ?></td>
                        <td><?php echo $datoLogin['codigo_seguridad_id']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datologin/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoLogin['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datologin/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $datoLogin['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/datologin/delete" method="post">
                                    <input type="hidden" name="id" value="<?php echo $datoLogin['id']?>" />
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
