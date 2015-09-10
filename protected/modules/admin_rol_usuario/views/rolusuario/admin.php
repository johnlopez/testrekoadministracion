<?php
/* @var $this RolusuarioController */
/* @var $model RolUsuario */

$this->breadcrumbs=array(
	'Rol Usuarios'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List RolUsuario', 'url'=>array('index')),
	array('label'=>'Create RolUsuario', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#rol-usuario-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Rol Usuarios</h1>

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
	'id'=>'rol-usuario-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_creacion',
		'fecha_eliminacion',
		'fecha_acceso',
		/*
		'fecha_modificacion',
		*/
		array(
			'class'=>'CButtonColumn',
		),
                array(
			'class'=>'CButtonColumn',
                        'template' => '{asignarpermiso}',
                        'buttons' => array(                                   
                                    'asignarpermiso' => array(
                                            'label' => 'asignar permiso',
                                            'url'=>'Yii::app()->createUrl("admin_rol_usuario/Rolusuariohasauthitempermisousuario/index",array("id" => $data->id) )', //url de la acción nueva
                                    ),
                        ),                       
		),
	),
)); ?>
