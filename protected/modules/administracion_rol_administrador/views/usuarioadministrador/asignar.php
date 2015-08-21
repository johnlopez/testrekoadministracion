<?php
$this->breadcrumbs=array(
	'Usuario Administrador'=>array('index'),
	'Manage'=>array('admin'),
        'Asignar'=>array('asignar'),
);
?>
<h1>Asignar Rol Administrador a Usuario Administrador</h1>
<br>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vusuario,
	'attributes'=>array(
		'id',
		'usuario',
		
	),
)); ?>
<br>
<br>
<h3>Listado De Roles</h3>

<?php foreach($rol->findAll() as $data):?>
    <?php $enabled = $vusuario->checkUsuarioRol($vusuario->id,$data->id); ?>
    <?php echo CHtml::link($enabled?"Denegar":"Asignar",array("usuarioadministrador/assign","id"=>$vusuario->id,"id_rol"=>$data->id)); ?>
    <?php echo $data->nombre."<br>"; ?>
<?php endforeach; ?>
