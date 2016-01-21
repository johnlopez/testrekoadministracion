<?php
/* @var $this ItemFichaTecnicaController */
/* @var $model ItemFichaTecnica */

$this->breadcrumbs=array(
	'Item Ficha Tecnicas'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List ItemFichaTecnica', 'url'=>array('index')),
	array('label'=>'Create ItemFichaTecnica', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#item-ficha-tecnica-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Item Ficha Tecnicas</h1>

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
	'id'=>'item-ficha-tecnica-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
		'ficha_tecnica_id',
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
