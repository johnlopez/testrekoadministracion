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

<h1>Administracion de  Usuarios</h1>

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
                    <th>ESTADO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoUsuarioEstado as $m):?>                                                     
                    <tr>
                        <td><?php echo $m['id'] ?></td>
                        <td><?php echo $m['usuario'] ?></td>
                        <td><?php echo $m['clave']?></td>
                        <td><?php echo $m['estado']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/delete" method="post">
                                    <input type="hidden" name="id" value="<?php echo $m['id']?>" />
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



<div id="combo">
<?php
    $select = array('' =>'seleccione estado');
    $options = CHtml::listData(LogicaEstadoUsuario::model()->listarEstadosUsuario(), 'estado', 'estado');
    echo CHtml::activeDropDownList($logica,'estado', array_merge($select, $options),
        array(
            'ajax' => array('type'=>'POST',
            'url'=> CController::createUrl('Usuario/admin'),
            'update'=>'#main_table_demo',
            'data'=>array('estado' => 'js:this.value'),
        )));
?>
</div>
<br><br><br>

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