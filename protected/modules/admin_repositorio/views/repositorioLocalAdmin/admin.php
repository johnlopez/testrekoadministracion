<?php
/* @var $this RepositorioLocalAdminController */
/* @var $model RepositorioLocalAdmin */

$this->breadcrumbs=array(
	'Repositorio Local Admins'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List RepositorioLocalAdmin', 'url'=>array('index')),
	array('label'=>'Create RepositorioLocalAdmin', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#repositorio-local-admin-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Repositorio Local Admins</h1>

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
	'id'=>'repositorio-local-admin-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		
		'modelo_aprendizaje_id',
		
		array(
			'class'=>'CButtonColumn',
                        'template' => '{view}{update}{delete}{asignar}',
                        'buttons' => array(
                                    'asignar' => array(
                                            'label' => 'asignar modelo de aprendizaje',
                                            'imageUrl'=>Yii::app()->request->baseUrl.'/assets/9e5e8f07/gridview/asignar.png', //ruta icono para el botón
                                            'url'=>'Yii::app()->createUrl("admin_repositorio/repositoriolocaladmin/asignarmodeloaprendizaje",array("id"=>$data->id) )', //url de la acción nueva
                                    ),
                        ),
		),
	),
)); ?>
