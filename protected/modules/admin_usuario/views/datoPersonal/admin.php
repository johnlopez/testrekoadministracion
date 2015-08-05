<?php
/* @var $this DatoPersonalController */
/* @var $model DatoPersonal */

$this->breadcrumbs=array(
	'Dato Personals'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoPersonal', 'url'=>array('index')),
	array('label'=>'Create DatoPersonal', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-personal-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Dato Personals</h1>

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
	'id'=>'dato-personal-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'primer_nombre',
		'segundo_nombre',
		'apellido_paterno',
		'apellido_materno',
		'fecha_nacimiento',
		/*
		'edad',
		'rut',
		'digito_verificador',
		'direccion_personal',
		'numero_casa',
		'telefono_personal',
		'celular_personal',
		'dato_personalcol',
		'comuna_personal',
		'ciudad_personal',
		'interes',
		'estado_civil',
		'idioma',
		'nacionalidad',
		'usuario_id',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
