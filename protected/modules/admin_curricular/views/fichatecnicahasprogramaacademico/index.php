<div class="form">
    <?php echo CHtml::beginForm($this->createUrl('AsignarProgramas'), 'post'); ?>

        <h3>Programas por asignar</h3>
        <div class="row rememberMe">
            <?php echo CHtml::checkBoxList('programa_academico_id', $seleccionados, CHtml::listData($objeto,'programa_academico_id','programa_academico_id'), array('checkAll'=>'Marcar Todos')); ?>
            <?php echo CHtml::hiddenField("datos-programa_id-list", serialize ($seleccionados)); ?>
            <?php echo CHtml::hiddenField("datos-programa_id-select", serialize (CHtml::listData($objeto,'programa_academico_id','programa_academico_id'))); ?>
            <?php echo CHtml::hiddenField("datos-ficha-id",$idFicha)."<br><br>"; ?>
        </div>

        <div class="row submit">
            <?php echo CHtml::submitButton('Asignar Programas')."<br><br>"; ?>
        </div>
        
    <?php echo CHtml::endForm(); ?>
</div>
