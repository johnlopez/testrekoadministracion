<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
?>


<h1>Asignar Privilegio Administrador a Rol Administrador</h1>
<br>

<h3>Rol</h3>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vrol,
	'attributes'=>array(
		'id',
		'nombre',
		
	),
)); ?>
<br>

<h3>Permiso</h3>
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vpermiso,
	'attributes'=>array(
		'name',	
	),
)); ?>
<br>

<h3>Listado De Privilegios</h3>
<?php foreach ($controlador as $c):?>                         
        <?php echo "<h4>".$c['nombre']."</h4>"."<br>";?>
        <?php $privilegio  = $vrol->listarPrivilegioControlador($c['id']);?>                         
        <?php foreach ($privilegio as $p):?> 
                <?php $enabled = $vrol->checkRolPrivilegio($vrol->id,$p['id']); ?>
                <?php
                echo CHtml::beginForm();
                echo CHtml::hiddenField('id',$vrol->id);
                echo CHtml::hiddenField('id_privilegio',$p['id']);
                echo CHtml::hiddenField('nombre_permiso',$vpermiso->name);
                echo CHtml::linkButton($enabled?"Denegar":"Asignar", array('submit' => $this->createUrl('roladministrador/assignprivilegio')));
                echo CHtml::endForm();   
                ?>

                <?php echo $p['id']." ";?>
                <?php echo $p['nombre']."<br>";?>
        <?php endforeach; ?>
        <br>
<?php endforeach; ?>
             