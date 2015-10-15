<?php
/* @var $this UsuarioController */
/* @var $model Usuario */

$this->breadcrumbs=array(
	'Usuarios'=>array('index'),
	'Manage',
);

//$this->menu=array(
//	array('label'=>'List Usuario', 'url'=>array('index')),
//	array('label'=>'Create Usuario', 'url'=>array('create')),
//);

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


<h1>Listado Instituciones</h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>

<?php 
//echo CHtml::link('Advanced Search','#',array('class'=>'search-button'));
?>
<div class="search-form" style="display:none">
<?php 
//$this->renderPartial('_search',array(
//	'model'=>$model,
//)); 
?>
</div><!-- search-form -->

<?php 
//$this->widget('zii.widgets.grid.CGridView', array(
//	'id'=>'usuario-grid',
//	'dataProvider'=>$model->search(),
//	'filter'=>$model,
//	'columns'=>array(
//		'id',
//		'usuario',
//		'clave',
//		'fecha_acceso',
//		'fecha_modificacion',
//		'fecha_creacion',
//		array(
//			'class'=>'CButtonColumn',
//		),
//	),
//)); 
?>
<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>
<div class="padding20 bg-grayLighter">
    <div class="inline-block" id="main_table_demo_keys">
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('striped')">
            <span class="check"></span>
            <span class="caption">striped</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('hovered')">
            <span class="check"></span>
            <span class="caption">hovered</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('cell-hovered')">
            <span class="check"></span>
            <span class="caption">cell-hovered</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('border')">
            <span class="check"></span>
            <span class="caption">border</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('bordered')">
            <span class="check"></span>
            <span class="caption">bordered</span>
        </label>
    </div>
</div>

<div class="container">
    <section>
        <table id="main_table_demo" class="display cell-hovered hovered striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <tr>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Vision</th>
                    <th>Mision</th>
                    <th>Acreditada</th>
                    <th>Operaciones</th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Vision</th>
                    <th>Mision</th>
                    <th>Acreditada</th>
                    <th>Operaciones</th>
                </tr>
            </tfoot>
            <tbody>
                <?php foreach ($institucion as $inst):?>                                                     
                    <tr>
                        <td><?php echo $inst->id; ?></td>
                        <td><?php echo $inst->nombre; ?></td>
                        <td><?php echo $inst->vision; ?></td>
                        <td><?php echo $inst->mision; ?></td> 
                        <td><?php echo $inst->acreditada; ?></td> 
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/institucionhasrolusuario/asignarrolinstitucion" method="get">
                                    <input type="hidden" name="institucion_id" value="<?php echo $inst->id?>" />
                                    <input type="hidden" name="institucion_nombre" value="<?php echo $inst->nombre?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                               Asignar Roles
                                    </button>
                                    &nbsp;
                                    &nbsp;
                                </form>                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario/institucionhasrolusuario/editarrolinstitucion" method="get">
                                    <input type="hidden" name="institucion_id" value="<?php echo $inst->id?>" />
                                    <input type="hidden" name="institucion_nombre" value="<?php echo $inst->nombre?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                               Editar Roles
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