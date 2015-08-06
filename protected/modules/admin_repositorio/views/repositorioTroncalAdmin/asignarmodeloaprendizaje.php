<?php
$this->breadcrumbs=array(
	'Repositorio Troncal Admin'=>array('index'),
	'Manage'=>array('admin'),
        'Asignar'=>array('asignarmodeloaprendizaje'),
);
?>
<h1>Asignar Authitem Permiso Administrador a Rol Administrador</h1>
<br>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vrepositorio,
	'attributes'=>array(
		'id',
		'nombre',
		
	),
)); ?>
<br>
<?php foreach($modeloaprendizaje->findAll() as $data):?>
<?php echo $data->id." "?>
<?php echo $data->nombre."<br>"?>
<?php  
            echo CHtml::beginForm();
            echo CHtml::hiddenField('id',$vrepositorio->id);
            echo CHtml::hiddenField('nombre_permiso',$data->id);
            //echo CHtml::radioButton('Asignar Modelo', array('submit' => $this->createUrl('repositoriotroncaladmin/asignarmodeloaprendizaje')));

            echo CHtml::endForm(); 
            
?>
<?php endforeach; ?>


   <?php echo CHtml::radioButtonList('asset', 'asset', $modeloaprendizaje, array('uncheckValue'=>null));?>


