<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarRepositorios'), 'post'); ?>

        <h3>Repositorios por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('repositorio_id', $seleccionados, CHtml::listData($objeto,'repositorio_id','repositorio_id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-repositorio_id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-repositorio_id-select", serialize (CHtml::listData($objeto,'repositorio_id','repositorio_id'))); ?>
            <?php echo CHtml::hiddenField("datos-institucion-id",$idInstitucion)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Repositorios')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>
