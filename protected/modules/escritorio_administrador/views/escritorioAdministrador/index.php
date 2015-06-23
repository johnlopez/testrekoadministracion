<?php
/* @var $this EscritorioAdministradorController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Escritorio Administradors',
);

//$this->menu=array(
//	array('label'=>'Create EscritorioAdministrador', 'url'=>array('create')),
//	array('label'=>'Manage EscritorioAdministrador', 'url'=>array('admin')),
//);
//?>

<h1>Escritorio Administradors</h1>



<?php
$dataArray = $dataProvider->getData();
foreach ($dataArray as $data)
{
    $this->widget   (   
                        'zii.widgets.CMenu',array
                        (
                            'items'=>array
                            (
                                array
                                (
                                    'label'=>CHtml::encode($data->name), 
                                    'url'=> array
                                            ('/'.CHtml::encode($data->name).'/default/index')
                                ),                                
                            ),
                        )               
                    );
}

?>




