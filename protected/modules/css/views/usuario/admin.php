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

<h1>Usuarios</h1>

<p>

</p>

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
$this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'usuario-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'usuario',
		'clave',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		array(
			'class'=>'CButtonColumn',
		),
	),
)); 
?>
<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#example').DataTable();
} );
</script>

<div class="container">
        <section>
                <table id="example" class="display" cellspacing="0" width="100%">
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
                                        <a>
                                        <?php                                           
                                            echo CHtml::beginForm();
                                            echo CHtml::hiddenField('id',$m->id);
                                            echo CHtml::hiddenField('usuario',$m->usuario);
                                            echo CHtml::linkButton('Ver', array('submit' => $this->createUrl('roladministrador/asignarprivilegio')));
                                            echo CHtml::endForm();         
                                        ?>
                                        </a>
                                        <?php 
                                        // http://www.v09studio.com/websystems/materials/forms.html
                                        // pagina html post url form button
                                        ?>
                                        <form action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="post">
                                            <input type="hidden" name="id" value="<?php $m->id?>" />
                                            <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                                <span class="icon mif-search">
                                                    ....
                                                </span>
                                            </button>
                                        </form>
                                        
                                        <button class="toolbar-button bg-white bg-active-grayLighter fg-black" value="MOTHER FUCKER">
                                            <span class="icon mif-search">                                                
                                            </span>                                            
                                        </button>                                                 
                                        <button class="toolbar-button bg-white bg-active-grayLighter fg-black"><span class="icon mif-pencil"></span></button>
                                        <button class="toolbar-button bg-white bg-active-grayLighter fg-black"><span class="icon mif-cancel"></span></button>
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