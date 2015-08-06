<?php
/* @var $this DatoLoginController */
/* @var $model DatoLogin */

$this->breadcrumbs=array(
	'Dato Logins'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List DatoLogin', 'url'=>array('index')),
	array('label'=>'Create DatoLogin', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#dato-login-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Dato Logins</h1>

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
	'id'=>'dato-login-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'pregunta_secreta_1',
		'pregunta_secreta_2',
		'respuesta_secreta_1',
		'respuesta_secreta_2',
		'usuario_id',
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>