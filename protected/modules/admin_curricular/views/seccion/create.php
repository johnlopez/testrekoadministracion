<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/seccion/admin" >
            <button class="button primary" type="submit">
                    Administrar seccion
            </button>
        </form>   
</div>

<h2>Agregar Seccion</h2>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>