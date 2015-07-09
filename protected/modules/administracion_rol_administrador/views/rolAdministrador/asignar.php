<?php
$this->breadcrumbs=array(
	'Rol Administrador'=>array('index'),
	'Manage'=>array('admin'),
        'Asignar'=>array('asignar'),
);
?>
<h1>Asignar Authitem Permiso Administrador a Rol Administrador</h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vrol,
	'attributes'=>array(
		'id',
		'nombre',
		
	),
)); ?>
<h1>.</h1>

<div class="form">
<?php $form=$this->beginWidget('CActiveForm'); ?>
 
    <?php echo $form->errorSummary($permiso); ?>
 
    <h3>Permisos por asignar</h3>
    <div class="row rememberMe">
        <?php echo $form->checkBoxList($permiso,'name', CHtml::listData(AuthitemPermisoAdministrador::model()->findAll(),'name','name')); ?>
    </div>
    <div class="row submit">
        <?php echo CHtml::submitButton('Guardar')."<br><br>"; ?>
    </div>
   
<?php $this->endWidget(); ?>
</div><!-- form -->





<?php foreach(AuthitemPermisoAdministrador::model()->findAll() as $data):?>
<?php $enabled = RolAdministrador::model()->checkRolPermiso($vrol->id,$data->name); ?>

    <?php echo CHtml::link($enabled?"Denegar":"Asignar",array("roladministrador/assign","id_rol"=>$vrol->id,"nombre_permiso"=>$data->name)); ?>
    <?php echo $data->name."<br>"; ?>


<?php endforeach; ?>


