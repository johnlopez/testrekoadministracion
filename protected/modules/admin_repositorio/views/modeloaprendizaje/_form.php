<?php $form=$this->beginWidget('CActiveForm');?>
    <?php echo $form->errorSummary(array($model));?>
    <?php echo $form->errorSummary(array($herramienta));?>

    <div class="row">
        <?php echo $form->labelEx($model,'nombre');?>
        <?php echo $form->textField($model,'nombre');?>
        <?php echo $form->error($model,'nombre');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($model,'descripcion');?>
        <?php echo $form->textField($model,'descripcion');?>
        <?php echo $form->error($model,'descripcion');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'trabajo_grupal');?>
        <?php echo $form->checkBox($herramienta,'trabajo_grupal');?>
        <?php echo $form->error($herramienta,'trabajo_grupal');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'archivo_recurso');?>
        <?php echo $form->checkBox($herramienta,'archivo_recurso');?>
        <?php echo $form->error($herramienta,'archivo_recurso');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'link_interes');?>
        <?php echo $form->checkBox($herramienta,'link_interes');?>
        <?php echo $form->error($herramienta,'link_interes');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'glosario');?>
        <?php echo $form->checkBox($herramienta,'glosario');?>
        <?php echo $form->error($herramienta,'glosario');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'contenido_libre');?>
        <?php echo $form->checkBox($herramienta,'contenido_libre');?>
        <?php echo $form->error($herramienta,'contenido_libre');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'foro');?>
        <?php echo $form->checkBox($herramienta,'foro');?>
        <?php echo $form->error($herramienta,'foro');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'evaluacion');?>
        <?php echo $form->checkBox($herramienta,'evaluacion');?>
        <?php echo $form->error($herramienta,'evaluacion');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'autoevaluacion');?>
        <?php echo $form->checkBox($herramienta,'autoevaluacion');?>
        <?php echo $form->error($herramienta,'autoevaluacion');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'proyecto');?>
        <?php echo $form->checkBox($herramienta,'proyecto');?>
        <?php echo $form->error($herramienta,'proyecto');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'recepcion_trabajo');?>
        <?php echo $form->checkBox($herramienta,'recepcion_trabajo');?>
        <?php echo $form->error($herramienta,'recepcion_trabajo');?>
    </div>
    <div class="row">
        <?php echo $form->labelEx($herramienta,'evaluacion_no_objetiva');?>
        <?php echo $form->checkBox($herramienta,'evaluacion_no_objetiva');?>
        <?php echo $form->error($herramienta,'evaluacion_no_objetiva');?>
    </div>
    
    <div class="row buttons">
        <?php echo CHtml::submitButton('create'); ?>
    </div>

<?php $this->endWidget();?>