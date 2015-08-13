<table>
    <tr>
        <th>ID</th>
        <th>USUARIO</th>
        <th>CLAVE</th>
        <th>FECHA ACCESO</th>
        <th>FECHA CREACION</th>
        <th>FECHA MODIFICACION</th>
        <th>FECHA ELIMINACION</th>
    </tr>
    <?php foreach ($model as $data):?>
    <tr>
        <td><?php echo $data->id ?></td>
        <td><?php echo $data->usuario?></td>
        <td><?php echo $data->clave?></td>
        <td><?php echo $data->fecha_acceso?></td>
        <td><?php echo $data->fecha_creacion?></td>
        <td><?php echo $data->fecha_modificacion?></td>
    </tr>
    <?php endforeach; ?>
</table>