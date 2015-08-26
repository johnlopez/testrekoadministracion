<?php
/* @var $this UsuarioController */
/* @var $model Usuario */

$this->breadcrumbs=array(
	'Usuarios'=>array('index'),
	$model->id,
);
//
//$this->menu=array(
//	array('label'=>'List Usuario', 'url'=>array('index')),
//	array('label'=>'Create Usuario', 'url'=>array('create')),
//	array('label'=>'Update Usuario', 'url'=>array('update', 'id'=>$model->id)),
//	array('label'=>'Delete Usuario', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
//	array('label'=>'Manage Usuario', 'url'=>array('admin')),
//);
//?>



<?php 
//$this->widget('zii.widgets.CDetailView', array(
//	'data'=>$model,
//	'attributes'=>array(
//		'id',
//		'usuario',
//		'clave',
//		'fecha_acceso',
//		'fecha_modificacion',
//		'fecha_creacion',
//	),
//)); 
?>
<div class="place-right padding20 no-padding-top no-padding-right">
    <h4 class=" padding1 ">Opciones</h4>        
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/index" >
            <button class="button primary" type="submit">
                    Listar Usuario
            </button>
        </form>    
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/create" >
            <button class="button primary" type="submit">
                    Crear Usuario
            </button>
        </form> 
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/admin" >
            <button class="button primary" type="submit">
                    Administrar Usuario
            </button>
        </form>
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/update" method="get">
            <input type="hidden" name="id" value="<?php echo $model->id?>" />
            <button class="button primary" type="submit">
                    Editar Usuario
            </button>
        </form> 
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/delete" method="post">
            <input type="hidden" name="id" value="<?php echo $model->id?>" />
            <button class="button danger" type="submit">
                    Eliminar Usuario
            </button>
        </form> 
</div>
<h1>Detalle Usuario</h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>


<table class="table striped" id="main_table_demo">
    <thead>
    <tr>
        <th>Atributo</th>
        <th>Valor</th>            
    </tr>
    </thead>
    <tbody>
        <tr>
            <td>Id</td>
            <td><?php echo $model->id; ?></td>      
        </tr>
        <tr>
            <td>Usuario</td>
            <td><?php echo $model->usuario; ?></td>
        </tr>
        <tr>
            <td>Clave</td>
            <td><?php echo $model->clave; ?></td>  
        </tr>
        <tr>
            <td>Fecha Creacion</td>
            <td><?php echo $model->fecha_creacion; ?></td>    
        </tr>        
    </tbody>
</table>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>
