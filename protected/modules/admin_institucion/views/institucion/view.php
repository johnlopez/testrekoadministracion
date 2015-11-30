<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/create" >
            <button class="button primary" type="submit">
                    Crear Institucion
            </button>
        </form>
    <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/update" method="GET" >
        <input type="hidden" name="id" value="<?php echo $model->id?>" />
            <button class="button primary" type="submit">
                    Actualizar Institucion
            </button>
        </form> 
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/institucion/admin" >
            <button class="button primary" type="submit">
                    Administrar Institucion
            </button>
        </form>   
</div>


<h2>Institucion #<?php echo $model->id; ?></h2>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'vision',
		'mision',
		'acreditada',
		'fecha_inicio_acreditacion',
		'fecha_termino_acreditacion',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
                'estado_institucion_id',
                'pais_id',
                'region_id'
	),
)); ?>
