<?php
/* @var $this LogicaEstadoUsuarioController */
/* @var $model LogicaEstadoUsuario */

$this->breadcrumbs=array(
	'Logica Estado Usuarios'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List LogicaEstadoUsuario', 'url'=>array('index')),
	array('label'=>'Create LogicaEstadoUsuario', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#logica-estado-usuario-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Logica Estado Usuarios</h1>

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
	'id'=>'logica-estado-usuario-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'estado',
		array(
			'class'=>'CButtonColumn',
                        'template' => '{asignar}{view}{delete}{update}',
                        'buttons' => array(
                                    'asignar' => array(
                                            'label' => 'asignar usuario',
                                            'imageUrl'=>Yii::app()->request->baseUrl.'/assets/9e5e8f07/gridview/asignar.png', //ruta icono para el botón
                                            'url'=>'Yii::app()->createUrl("admin_usuario/estadousuario/index",array("id" => $data->id) )', //url de la acción nueva
                                    ),

                        ),
		),
	),
)); ?>
