<?php
/* @var $this InstitucionController */
/* @var $model Institucion */

$this->breadcrumbs=array(
	'Institucions'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Institucion', 'url'=>array('index')),
	array('label'=>'Create Institucion', 'url'=>array('create')),
);

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

<h1>Administración Institucion</h1>



<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->


<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'institucion-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre',
		'vision',
		'mision',
		'acreditada',
		'fecha_inicio_acreditacion',
		/*
		'fecha_termino_acreditacion',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
		*/
		array(
			'class'=>'CButtonColumn',
                        'template' => '{asignar}{view}{delete}{update}',
                        'buttons' => array(
                                    'asignar' => array(
                                            'label' => 'asignar usuario',
                                            'imageUrl'=>Yii::app()->request->baseUrl.'/assets/9e5e8f07/gridview/asignar.png', //ruta icono para el botón
                                            'url'=>'Yii::app()->createUrl("admin_usuario/usuarioHasInstitucion/index",array("id" => $data->id) )', //url de la acción nueva
                                    ),

                        ),
		),
	),
)); ?>
