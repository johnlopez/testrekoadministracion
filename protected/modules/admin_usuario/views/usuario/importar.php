<?php 
   // echo Yii::app()->bootstrap->registerAllCss();
   // echo Yii::app()->bootstrap->registerCoreScripts();
?>


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
        <legend>
            <p class="note">Fields with <span class="required">*</span> are required.</p>
        </legend>
 
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


