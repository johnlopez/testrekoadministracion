<?php //
/* @var $this ModeloaprendizajeController */
/* @var $model ModeloAprendizaje */

$this->breadcrumbs=array(
	'Modelo Aprendizajes'=>array('index'),
	$model->id,
);
//
//$this->menu=array(
//	array('label'=>'List ModeloAprendizaje', 'url'=>array('index')),
//	array('label'=>'Create ModeloAprendizaje', 'url'=>array('create')),
//	array('label'=>'Update ModeloAprendizaje', 'url'=>array('update', 'id'=>$model->id)),
//	array('label'=>'Delete ModeloAprendizaje', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
//	array('label'=>'Manage ModeloAprendizaje', 'url'=>array('admin')),
//);
?>

<!--<h1>View ModeloAprendizaje #<?php // echo $model->id; ?></h1>-->



                       

<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/modeloaprendizaje/index" >
            <button class="button primary" type="submit">
                    Listar M.Aprendizaje 
            </button>
        </form>    
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/modeloaprendizaje/create" >
            <button class="button primary" type="submit">
                    Crear M.Aprendizaje
            </button>
        </form> 
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/modeloaprendizaje/admin" >
            <button class="button primary" type="submit">
                    Administrar M.Aprendizaje 
            </button>
        </form>
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/modeloaprendizaje/update" method="get">
            <input type="hidden" name="id" value="<?php echo $model->id?>" />
            <button class="button primary" type="submit">
                    Editar M.Aprendizaje
            </button>
        </form> 
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/modeloaprendizaje/delete" method="post">
            <input type="hidden" name="id" value="<?php echo $model->id?>" />
            <button class="button danger" type="submit">
                    Eliminar M.Aprendizaje
            </button>
        </form> 
</div>
<h1>Modelo de Aprendizaje</h1>
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
            <td><?php echo $model->id."<br>";?></td>      
        </tr>
        <tr>
            <td>Nombre</td>
            <td><?php echo $model->nombre;?></td>
        </tr>
        <tr>
            <td>Descripcion</td>
            <td><?php echo $model->descripcion; ?></td>  
        </tr>
        <tr>
            <td>Fecha Acceso</td>
            <td><?php echo $model->fecha_acceso; ?></td>    
        </tr>
        <tr>
            <td>Fecha Modificacion</td>
            <td><?php echo $model->fecha_modificacion; ?></td>    
        </tr>
        <tr>
            <td>Fecha Creacion</td>
            <td><?php echo $model->fecha_creacion; ?></td>    
        </tr>
        <tr>
            <td>Fecha Eliminacion</td>
            <td><?php echo $model->fecha_eliminacion; ?></td>    
        </tr>

<!--        //////////////////////////////////////////////////////////////////////////////-->
        <tr>
            <td>Herramientas Id</td>
            <td><?php    echo $herramienta->id;?></td>    
        </tr>
        <tr>
            <td>Trabajo Grupal</td>
            <td><?php    echo $herramienta->trabajo_grupal;?></td>    
        </tr>
        <tr>
            <td>Archivo Recurso</td>
            <td><?php    echo $herramienta->archivo_recurso;?></td>    
        </tr>
        <tr>
            <td>Link Interes</td>
            <td><?php    echo $herramienta->link_interes;?></td>    
        </tr>
        <tr>
            <td>Glosario</td>
            <td><?php    echo $herramienta->glosario;?></td>    
        </tr>
        <tr>
            <td>Contenido Libre</td>
            <td><?php    echo $herramienta->contenido_libre;?> </td>    
        </tr>
        <tr>
            <td>Foro</td>
            <td><?php    echo $herramienta->foro;?></td>    
        </tr>
        <tr>
            <td>Evaluacion</td>
            <td><?php    echo $herramienta->evaluacion;?></td>    
        </tr>
        <tr>
            <td>Autoevaluacion</td>
            <td><?php    echo $herramienta->autoevaluacion;?></td>    
        </tr>
        <tr>
            <td>Proyecto</td>
            <td><?php    echo $herramienta->proyecto;?></td>    
        </tr>
        <tr>
            <td>Recepcion de Trabajo</td>
            <td><?php    echo $herramienta->recepcion_trabajo;?></td>    
        </tr>
        <tr>
            <td>Evaluacion No Objetiva</td>
            <td><?php    echo $herramienta->evaluacion_no_objetiva;?></td>    
        </tr>
        <tr>
            <td>Modelo Aprendizaje Id</td>
            <td><?php    echo $herramienta->modelo_aprendizaje_id;?></td>    
        </tr>       
<!--        //////////////////////////////////////////////////////////////////////////////-->

    </tbody>
</table>


<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_acceso',
		'fecha_modificacion',
		'fecha_creacion',
		'fecha_eliminacion',
	),
)); ?>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$herramienta,
	'attributes'=>array(
		'id',
                'trabajo_grupal',
                'archivo_recurso',
                'link_interes',
                'glosario',
                'contenido_libre',
                'foro',
                'evaluacion',
                'autoevaluacion',
                'proyecto',
                'recepcion_trabajo',
                'evaluacion_no_objetiva',
                'modelo_aprendizaje_id',
	),
)); ?>

