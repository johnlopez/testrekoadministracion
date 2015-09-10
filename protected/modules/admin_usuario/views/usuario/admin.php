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

<h2>Administración Usuarios</h2>

<?php echo CHtml::link("Excel",array("admin","excel" =>1),array("class"=>"btn"));?><br>
<?php echo CHtml::link("Csv",array("admin","csv" =>1),array("class"=>"btn"));?><br><br><br>




<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>
<div class="container">
    <section>
        <table id="main_table_demo" class="display cell-hovered hovered striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>USUARIO</th>
                    <th>CLAVE</th>
                    <th>FECHA ACCESO</th>
                    <th>FECHA MODIFICACION</th>
                    <th>FECHA CREACION</th>
                    <th>ESTADO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoUsuarios as $usuario):?>                                                     
                    <tr>
                        <td><?php echo $usuario['id'] ?></td>
                        <td><?php echo $usuario['usuario'] ?></td>
                        <td><?php echo $usuario['clave']?></td>
                        <td><?php echo $usuario['fecha_acceso']?></td>
                        <td><?php echo $usuario['fecha_modificacion']?></td>
                        <td><?php echo $usuario['fecha_creacion']?></td>
                        <td><?php echo $usuario['estado']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/usuario/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/usuario/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/usuario/borrar" method="post">
                                    <input type="hidden" name="id" value="<?php echo $usuario['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-cancel">

                                        </span>
                                    </button>
                                </form> 
                            </div>                                        
                        </td>
                    </tr>
                <?php endforeach;?>                                
            </tbody>
        </table>
        <ul class="tabs">
                <li class="active"></li>                        
        </ul>               
    </section>
</div>

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


<a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/institucion/admin";?>" >
                <div class="tile-small bg-darkViolet fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-library"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
        </div>  
</a>

