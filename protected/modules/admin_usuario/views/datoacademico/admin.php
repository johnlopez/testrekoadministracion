<?php
/* @var $this DatoAcademicoController */
/* @var $model DatoAcademico */

$this->breadcrumbs=array(
	'Dato Academicos'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoAcademico', 'url'=>array('index')),
	array('label'=>'Create DatoAcademico', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-academico-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Dato Academicos</h1>

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
	'id'=>'dato-academico-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'universidad',
		'carrera',
		'ano_cursado',
		'duracion_carrera',
		'sede',
		/*
		'direccion_sede',
		'comuna_sede',
		'ciudad_sede',
		'usuario_id',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
