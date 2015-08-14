<?php
/* @var $this DatoLaboralController */
/* @var $model DatoLaboral */

$this->breadcrumbs=array(
	'Dato Laborals'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoLaboral', 'url'=>array('index')),
	array('label'=>'Create DatoLaboral', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-laboral-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Dato Laborals</h1>

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
	'id'=>'dato-laboral-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre_empresa',
		'ano_antiguedad',
		'cargo',
		'actividad',
		'comuna_empresa',
		/*
		'ciudad_empresa',
		'telefono_empresa',
		'celular_empresa',
		'rut_numero',
		'digito_verificador',
		'usuario_id',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
