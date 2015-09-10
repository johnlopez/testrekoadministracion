<?php
/* @var $this EntidadController */
/* @var $model Entidad */

$this->breadcrumbs=array(
	'Entidads'=>array('index'),
	'Manage',
);


Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#entidad-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>


<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

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
                    <th>FECHA CREACION</th>
                    <th>FECHA MODIFICACION</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoEntidad as $entidad):?>                                                     
                    <tr>
                        <td><?php echo $entidad['id'] ?></td>
                        <td><?php echo $entidad['nombre'] ?></td>
                        <td><?php echo $entidad['descripcion']?></td>
                        <td><?php echo $entidad['fecha_creacion']?></td>
                        <td><?php echo $entidad['fecha_modificacion']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/entidad/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $entidad['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/indexEntidad" method="get">
                                    <input type="hidden" name="id" value="<?php echo $entidad['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pin">

                                        </span>
                                    </button>
                                </form>
                                
                                 <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/entidad/xi" method="get">
                                    <input type="hidden" name="id" value="<?php echo $entidad['id']?>" />
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
