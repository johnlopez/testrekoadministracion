<?php 
    $x = ',';
    foreach ($model as $data):
       echo $data->id.$x.$data->usuario.$x.$data->clave.$x.$data->fecha_acceso.$x.$data->fecha_creacion.$x.$data->fecha_modificacion."\r\n";
    endforeach;
?>
