<div class="place-right padding20 no-padding-top no-padding-right">  
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/entidad/create" >
            <button class="button primary" type="submit">
                    Crear Entidad
            </button>
        </form>
    
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion/entidad/admin" >
            <button class="button primary" type="submit">
                    Administracion entidad
            </button>
        </form> 
</div>

<h2>Entidad #<?php echo $model->id; ?></h2>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'nombre',
		'descripcion',
		'fecha_creacion',
		'fecha_modificacion',
		'institucion_id',
		'entidad_id',
	),
)); ?>
