<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular/programaacademico/admin" >
            <button class="button primary" type="submit">
                    Administrar Programas
            </button>
        </form>          
</div>

<h2>Crear ProgramaAcademico</h2>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>