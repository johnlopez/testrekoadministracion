<?php
$this->breadcrumbs=array(
	'Rol Administrador'=>array('index'),
	'Manage'=>array('admin'),
        'Asignar'=>array('asignar'),
);
?>
<h1>Asignar Authitem Permiso Administrador a Rol Administrador</h1>
<br>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vrol,
	'attributes'=>array(
		'id',
		'nombre',
		
	),
)); ?>
<br>
<br>
<h3>Listado De Permisos</h3>

<?php foreach($permiso->findAll() as $data):?>
    <?php $enabled = $vrol->checkRolPermiso($vrol->id,$data->name); ?>
    <?php echo CHtml::link($enabled?"Denegar":"Asignar",array("roladministrador/assign","id"=>$vrol->id,"nombre_permiso"=>$data->name)); ?>
    <?php echo $data->name."<br>"; ?>
<?php endforeach; ?>


