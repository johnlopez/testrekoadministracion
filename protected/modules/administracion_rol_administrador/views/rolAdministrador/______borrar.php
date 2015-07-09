
                public function actionAssign($id)
        {
            if('preguntar si esta asignado ( $_GET["item"],rol->id)')//BOOLEANO
            {
                'quitar permiso a rol($_GET["item"],rol->id)';
            }
            else
            {
                'asignar permiso a rol($_GET["item"],rol->id)';
            }
            $this->redirect(array("asignar","id"=>$id));
        }

-------------------------------------
<?php 

    $enabled = 0;
    echo CHtml::link($enabled?"Denegar":"Asignar")."<br>";

?>
---------- Vista Asignar-------------
<?php foreach ('listar permisos' as $data) :?>
<?php $enabled= 'preguntar si esta asignado ( permiso->name , rol->id)';//Booleano ?>

    <?php echo $data->name?>
    <?php echo CHtml::link($enabled?"Denegar":"Asignar",array("nombre_controlador/nombre_action","id"=>$variable_del_rol->id,"item"=>$data->name),array('formato del boton CSS'))?>

    
    <?php echo $enabled?"<span class=\"label\">Asigned</span>":"";?>

    
<?php endforeach; ?>
-----------------------------
<?php
public function actionAsignar()
	{            
                $model = new AuthitemPermisoAdministrador();
                $rol = new RolAdministrador();
                if(isset($_GET['id'])) {
                    
                    $vrol = $rol::model()->findByPk($_GET['id']);			
                    $this->render('asignar', array('model' => $model,'vrol'=>$vrol));
                }
                
                if(isset($_POST['AuthitemPermisoAdministrador']))
                {                    
                    foreach ($_POST['AuthitemPermisoAdministrador']['name'] as $permiso)
                    {
                         $rol->asignarPermisoARol($_GET['id'], $permiso);
                         //$rol->desasignarPermisoRol($_GET['id'], $permiso);
                         $listado = $rol->privilegioPermiso($permiso);
                    
                        foreach ($listado as $lista)
                        {
                            $rol->asignarPrivilegioRol($_GET['id'], $lista['id']);
                            //$rol->desasignarPrivilegio($_GET['id'], $lista['id']);
                            echo $lista['id']."<br>"; 
                        }
                    }
                    
                }
	}

?>

------------Asignar-----------
<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$vrol,
	'attributes'=>array(
		'id',
		'nombre',
		
	),
)); ?>

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

	<div>
		<?php echo $form->labelEx($model,'permisos'); ?>
                <?php echo $form->checkBoxList($model,'name', CHtml::listData(AuthitemPermisoAdministrador::model()->findAll(),'name','name'));?>
		<?php echo $form->error($model,'name'); ?>
	</div>	

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Guardar Cambios' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->


------------Asignar-----------





//<?php 
//
// var_dump($vrol);
// print_r($vrol->nombre);
// print_r($vrol->id);
//
//?>       










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


<?php
/* @var $this RolAdministradorController */
/* @var $model RolAdministrador */

$this->breadcrumbs=array(
	'Rol Administradors'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List RolAdministrador', 'url'=>array('index')),
	array('label'=>'Create RolAdministrador', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#rol-administrador-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Rol Administradors</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'rol-administrador-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'nombre',
		'descripcion',
//                array(
//                        'header'=>'Actions',
//                        'type'=>'raw',
//                        'value'=>'CHtml::ajaxLink(CHtml::image("' . Yii::app()->request->baseUrl . '/assets/9e5e8f07/gridview/asignar.png", "Delete", array("title"=>"Delete","class"=>"grid_icon")), Yii::app()->createUrl("controller/ajaxDelete"), array("type"=>"POST", "data"=>array("id"=>$data->id, "action"=>"delete"), "success"=>"jsDelete"), array("onclick"=>"$(\'.grid-view\').addClass(\'grid-view-loading\')", "class"=>"delete", "confirm"=>"Are you sure?\r\nDrafts are permanently deleted and are not recoverable.") )',
//                ),
		array(
			'class'=>'CButtonColumn',
                        'template' => '{view}{update}{delete}{asignar}',
                        'buttons' => array(
                                    'asignar' => array(
                                            'label' => 'asignar',
                                            'imageUrl'=>Yii::app()->request->baseUrl.'/assets/9e5e8f07/gridview/asignar.png', //ruta icono para el botón
                                            'url'=>'Yii::app()->createUrl("administracion_rol_administrador/roladministrador/asignar",array("id"=>$data->id) )', //url de la acción nueva
                                            
                                    
                                    ),
//                                    'solved' => array(
//                                        'label' => 'Жалоба решена',
//                                        'url'=>'Yii::app()->createUrl("administracion_rol_administrador/roladministrador/asignar",array("id"=>$data->id) )', //url de la acción nueva
//                                        'options' => array (
//                                                
//                                                'class' => 'btn',
//                                                'ajax'=>array(
//                                                    'type'=>'POST',
//                                                    'url'=>"js:$(this).attr('href')",
//                                                    'success' => "js:$.fn.yiiGridView.update('rol-administrador-grid')"
//                                         )),
//                                    ),
//                            
//                                    'Update' =>array(
//                                        'imageUrl'=>Yii::app()->request->baseUrl.'/images/up.png',
//                                        'url'=>'Yii::app()->createUrl("roladministrador/asignar", array("id"=>$data->id) )',
//
//                                        'click'=>"function() {
//                                        if(!confirm('Update ?')) return false;
//                                        $.fn.yiiGridView.update('user-grid', {
//                                        type:'POST',
//                                        url:$(this).attr('href'),
//                                        success:function(text,status) {
//                                        $.fn.yiiGridView.update('user-grid');
//
//                                        }
//                                        });
//                                        return false;
//                                        }",
//                                    ),
//                                    'email' => array
//                                    (
//                                        'label'=>'Send an e-mail to this user',
//                                        'imageUrl'=>Yii::app()->request->baseUrl.'/images/email.png',
//                                        'click'=>"function(){
//                                                                $.fn.yiiGridView.update('rol-administrador-grid', {
//                                                                    type:'POST',
//                                                                    url:$(this).attr('href'),
//                                                                    success:function(data) {
//                                                                          $('#AjFlash').html(data).fadeIn().animate({opacity: 1.0}, 3000).fadeOut('slow');
//
//                                                                          $.fn.yiiGridView.update('rol-administrador-grid');
//                                                                    }
//                                                                })
//                                                                return false;
//                                                          }
//                                                 ",
//                                        'url'=>'Yii::app()->createUrl("administracion_rol_administrador/roladministrador/asignar",array("id"=>$data->id) )', //url de la acción nueva
//                                    ),
                        ),
		),
	),
)); ?>

