        public function actionAsignar()
	{            
                $model = new AuthitemPermisoAdministrador();
                //$listarPermiso = $model->listarPermisos();
		$this->render('asignar', array('model' => $model));
	}























<div>
    <?php 
//        foreach ($listarPermiso as $permiso){
//            echo $permiso['name']."<br>";
//        }
    ?>
</div>
<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'rol-administrador-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'permisos'); ?>
                <?php echo $form->checkBoxList($model,'name', CHtml::listData(AuthitemPermisoAdministrador::model()->findAll(),'name','name'));?>
		<?php echo $form->error($model,'name'); ?>
	</div>

	

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Guardar Cambios' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->