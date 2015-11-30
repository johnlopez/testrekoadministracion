<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/modulo/admin" >
            <button class="button primary" type="submit">
                    Administrar Modulo
            </button>
        </form>   
</div>


<h2>Agregar Modulo</h2>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>