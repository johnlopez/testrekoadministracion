<?php
/* @var $this UsuarioController */
/* @var $model Usuario */

$this->breadcrumbs=array(
	'Usuarios'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Usuario', 'url'=>array('index')),
	array('label'=>'Create Usuario', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#usuario-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Administracion de  Usuarios</h1>

<h4>Exportar usuarios</h4>
<?php echo CHtml::link("Excel",array("admin","excel" =>1),array("class"=>"btn"));?><br>
<?php echo CHtml::link("Csv",array("admin","csv" =>1),array("class"=>"btn"));?><br><br><br>

<div class='form'>
    <?php
        $form = $this->beginWidget('CActiveForm', 
          array(
            'method' => 'POST',
            'htmlOptions' => array(  
                'enctype' => 'multipart/form-data',
              ),
            'enableClientValidation' => true,
            'clientOptions' => array(
                'validateOnSubmit' => true,
            ),
        ));
    ?>
 
    <fieldset>
        <?php echo $form->errorSummary($model, 'Opps!!!', null, array('class'=>'alert alert-error span12')); ?>
 
        <div class="control-group">     
            <div class="span4">
                <div class="control-group <?php if ($model->hasErrors('postcode')) echo "error"; ?>">
                    <?php echo $form->labelEx($model,'file'); ?>
                    <?php echo $form->fileField($model,'file'); ?>
                    <?php echo $form->error($model,'file'); ?>
                </div>
            </div>
        </div>
        <div class="form-actions">
            <?php echo CHtml::submitButton("Importar", array('class' => 'btn btn-primary')); ?>
        </div>
    </fieldset>
    <?php $this->endWidget(); ?>
</div>
<br><br><br>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'usuario-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'usuario',
		'clave',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
