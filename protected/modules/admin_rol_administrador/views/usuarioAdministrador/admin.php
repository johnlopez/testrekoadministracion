<?php
/* @var $this UsuarioAdministradorController */
/* @var $model UsuarioAdministrador */

$this->breadcrumbs=array(
	'Usuario Administradors'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List UsuarioAdministrador', 'url'=>array('index')),
	array('label'=>'Create UsuarioAdministrador', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#usuario-administrador-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Usuario Administradors</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'usuario-administrador-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'usuario',
		'clave',
		array(
			'class'=>'CButtonColumn',
                        'template' => '{asignar}',
                        'buttons' => array(
                                    'asignar' => array(
                                            'label' => 'asignar',
                                            'imageUrl'=>Yii::app()->request->baseUrl.'/assets/9e5e8f07/gridview/asignar.png', //ruta icono para el botón
                                            'url'=>'Yii::app()->createUrl("administracion_rol_administrador/usuarioadministrador/asignar",array("id"=>$data->id) )', //url de la acción nueva
                                    ),

                        ),
		),
	),
)); ?>
