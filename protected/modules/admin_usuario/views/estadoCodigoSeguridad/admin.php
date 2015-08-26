<?php
/* @var $this EstadoCodigoSeguridadController */
/* @var $model EstadoCodigoSeguridad */

$this->breadcrumbs=array(
	'Estado Codigo Seguridads'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List EstadoCodigoSeguridad', 'url'=>array('index')),
	array('label'=>'Create EstadoCodigoSeguridad', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#estado-codigo-seguridad-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Estado Codigo Seguridads</h1>

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
	'id'=>'estado-codigo-seguridad-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'estado',
		'codigo_seguridad_id',
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
