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
<h3>Permisos por asignar</h3>

<?php foreach(AuthitemPermisoAdministrador::model()->findAll() as $data):?>
<?php $enabled = RolAdministrador::model()->checkRolPermiso($vrol->id,$data->name); ?>

    <?php echo CHtml::link($enabled?"Denegar":"Asignar",array("roladministrador/assign","id"=>$vrol->id,"nombre_permiso"=>$data->name)); ?>
    <?php echo $data->name."<br>"; ?>


<?php endforeach; ?>


