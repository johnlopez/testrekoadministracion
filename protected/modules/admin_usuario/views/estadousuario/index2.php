 <div class="form">
<?php echo CHtml::beginForm(); ?>     
    <?php 
        $type_list = CHtml::listData(EstadoUsuario::model()->listarEstadoUsuario($_GET['id']),'id','estado');
        echo CHtml::activeRadioButtonList($model,'usuario_id',$type_list,array('checked'=>'checked'));
    ?>
     <br><br>
    <div class="row submit">
        <?php echo CHtml::submitButton('Asignar Estado')."<br><br>"; ?>
    </div>
<?php echo CHtml::endForm(); ?>
</div>

<?php var_dump($listado);?>

<div id="combo">
<?php
    $select = array('' =>'seleccione estado');
    $options = CHtml::listData($listado, 'id', 'estado');
    echo CHtml::activeDropDownList($model,'logica_estado_usuario_id', array_merge($select, $options),
        array(
            'ajax' => array('type'=>'POST',
            'url'=> CController::createUrl('Auto/index'),
            'update'=>'#table', 
            'data'=>array('estado' => 'js:this.value'),
        )));
?>
</div>




