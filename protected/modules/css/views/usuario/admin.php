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
	$('#usuario-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>
<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/index" >
            <button class="button primary" type="submit">
                    Listar Usuario
            </button>
        </form>    
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/create" >
            <button class="button primary" type="submit">
                    Crear Usuario
            </button>
        </form>          
</div>

<h1>Usuarios</h1>
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
                    <th>Id</th>
                    <th>Usuario</th>
                    <th>Clave</th>
                    <th>Fecha_Creacion</th>
                    <th>Opciones</th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <th>Id</th>
                    <th>Usuario</th>
                    <th>Clave</th>
                    <th>Fecha_Creacion</th> 
                    <th>Opciones</th>
                </tr>
            </tfoot>
            <tbody>
                <?php foreach ($usuario as $m):?>                                                     
                    <tr>
                        <td><?php echo $m->id; ?></td>
                        <td><?php echo $m->usuario; ?></td>
                        <td><?php echo $m->clave; ?></td>
                        <td><?php echo $m->fecha_creacion; ?></td> 
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m->id?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m->id?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/delete" method="post">
                                    <input type="hidden" name="id" value="<?php echo $m->id?>" />
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