<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario/pais/admin" >
            <button class="button primary" type="submit">
                    Administracion Pais
            </button>
        </form>          
</div>

<h2>Actualizar Pais # <?php echo $model->id; ?></h2>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>