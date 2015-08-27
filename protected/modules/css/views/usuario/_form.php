<?php
/* @var $this UsuarioController */
/* @var $model Usuario */
/* @var $form CActiveForm */
?>
<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'usuario-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

        <div class="container">
            <section>
                <table id="main_table_demo" class="display striped" cellspacing="0" width="100%">
                    <tbody>
                            <tr>
                                <td><?php echo $form->labelEx($model,'usuario'); ?></td>
                                <td><?php echo $form->textField($model,'usuario',array('size'=>45,'maxlength'=>45)); ?></td>
                                <td><?php echo $form->error($model,'usuario'); ?></td>
                                <td></td> 
                            </tr>
                            <tr>
                                <td><?php echo $form->labelEx($model,'clave'); ?></td>
                                <td><?php echo $form->textField($model,'clave',array('size'=>45,'maxlength'=>45)); ?></td> 
                                <td><?php echo $form->error($model,'clave'); ?></td>
                                <td></td> 
                            </tr>
                            <tr>
                                <td><?php echo $form->labelEx($model,'fecha_acceso'); ?></td>
                                <td><?php echo $form->textField($model,'fecha_acceso'); ?></td> 
                                <td><?php echo $form->error($model,'fecha_acceso'); ?></td> 
                                <td></td> 
                            </tr>
                            <tr>
                                <td><?php echo $form->labelEx($model,'fecha_modificacion'); ?></td>
                                <td><?php echo $form->textField($model,'fecha_modificacion'); ?></td> 
                                <td><?php echo $form->error($model,'fecha_modificacion'); ?></td> 
                                <td></td> 
                            </tr>
                            <tr>
                                <td><?php echo $form->labelEx($model,'fecha_creacion'); ?></td>
                                <td><?php echo $form->textField($model,'fecha_creacion'); ?></td> 
                                <td><?php echo $form->error($model,'fecha_creacion'); ?></td> 
                                <td></td> 
                            </tr>
                            <tr>
                                <td>	
                                    <div class="row buttons">
                                            <?php echo CHtml::submitButton($model->isNewRecord ? 'Crear' : 'Guardar'); ?>
                                    </div>
                                </td>                                
                            </tr>
                    </tbody>
                </table>
           
            </section>
        </div>

<?php $this->endWidget(); ?>

</div><!-- form -->



