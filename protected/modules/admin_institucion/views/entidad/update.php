<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/entidad/admin" >
            <button class="button primary" type="submit">
                    Administrar Entidad
            </button>
        </form>          
</div>

<h2>Actualizar Entidad # <?php echo $model->id; ?></h2>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>