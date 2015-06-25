<?php
/* @var $this RolAdministradorController */
/* @var $model RolAdministrador */

$this->breadcrumbs=array(
	'Rol Administradors'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List RolAdministrador', 'url'=>array('index')),
	array('label'=>'Create RolAdministrador', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#rol-administrador-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Rol Administradors</h1>

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
	'id'=>'rol-administrador-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre',
		'descripcion',
                array(
                        'header'=>'Actions',
                        'type'=>'raw',
                        'value'=>'CHtml::ajaxLink(CHtml::image("' . Yii::app()->request->baseUrl . '/assets/9e5e8f07/gridview/asignar.png", "Delete", array("title"=>"Delete","class"=>"grid_icon")), Yii::app()->createUrl("controller/ajaxDelete"), array("type"=>"POST", "data"=>array("id"=>$data->id, "action"=>"delete"), "success"=>"jsDelete"), array("onclick"=>"$(\'.grid-view\').addClass(\'grid-view-loading\')", "class"=>"delete", "confirm"=>"Are you sure?\r\nDrafts are permanently deleted and are not recoverable.") )',
                ),
		array(
			'class'=>'CButtonColumn',
                        'template' => '{view}{update}{delete}{asignar}',
                        'buttons' => array(
                                    'asignar' => array(
                                            'label' => 'asignar',
                                            'imageUrl'=>Yii::app()->request->baseUrl.'/assets/9e5e8f07/gridview/asignar.png', //ruta icono para el botón
                                            'url'=>'Yii::app()->createUrl("administracion_rol_administrador/roladministrador/asignar",array("id"=>$data->id,"nombre"=>$data->nombre) )', //url de la acción nueva
                                            
                                    
                                    ),
                        ),
		),
	),
)); ?>
