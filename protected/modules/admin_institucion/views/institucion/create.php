<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/admin" >
            <button class="button primary" type="submit">
                    Administrar Institucion
            </button>
        </form>          
</div>

<h2>Crear Institucion</h2>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>