<?php
$this->breadcrumbs=array(
	'Repositorio Master'=>array('index'),
	'Manage'=>array('admin'),
        'Asignar'=>array('asignarmodeloaprendizajemaster'),
);
?>
<h1>Asignar Modelo Aprendizaje Master a Repositorio Master</h1>
<br>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vrepositorio,
	'attributes'=>array(
		'id',
		'nombre',
		
	),
)); ?>
<br>
<div class="form">
<?php $form=$this->beginWidget('CActiveForm'); ?>
      
    <div class="row">
        <?php echo $form->label($modeloaprendizaje,'Listado Modelo de Aprendizaje Master'); ?>
        <?php echo $form->dropDownList($modeloaprendizaje,'id',
                
                CHtml::listData($modeloaprendizaje::model()->findAll(),'id','nombre'),
                array("empty"=>"Seleccione Modelo de Aprendizaje")
                
                ) ?>
    </div>
    <br>
    <div class="row submit">
        <?php echo CHtml::submitButton('Guardar'); ?>
    </div>
 
<?php $this->endWidget(); ?>
</div><!-- form -->


