<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarModulos'), 'post'); ?>

        <h3>Modulos por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('modulo_id', $seleccionados, CHtml::listData($objeto,'modulo_id','id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-modulo_id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-modulo_id-select", serialize (CHtml::listData($objeto,'modulo_id','modulo_id'))); ?>
            <?php echo CHtml::hiddenField("datos-programa-id",$idPrograma)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Modulos')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>


