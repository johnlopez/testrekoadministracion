<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>
<div class="container">
    <section>
        <table id="main_table_demo" class="display cell-hovered hovered striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>USUARIO</th>
                    <th>CLAVE</th>
                    <th>ESTADO</th>
                    <th>OPCIONES</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($listadoUsuarioEstado as $m):?>                                                     
                    <tr>
                        <td><?php echo $m['id'] ?></td>
                        <td><?php echo $m['usuario'] ?></td>
                        <td><?php echo $m['clave']?></td>
                        <td><?php echo $m['estado']?></td>
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/view" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-search">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/update" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-pencil">

                                        </span>
                                    </button>
                                </form>
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/css/usuario/delete" method="post">
                                    <input type="hidden" name="id" value="<?php echo $m['id']?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        <span class="icon mif-cancel">

                                        </span>
                                    </button>
                                </form> 
                            </div>                                        
                        </td>
                    </tr>
                <?php endforeach;?>                                
            </tbody>
        </table>
        <ul class="tabs">
                <li class="active"></li>                        
        </ul>               
    </section>
</div>


            
<div id="combo">
<?php
    $select = array('' =>'seleccione estado');
    $options = CHtml::listData(LogicaEstadoUsuario::model()->listarEstadosUsuario(), 'estado', 'estado');
    echo CHtml::activeDropDownList($logica,'estado', array_merge($select, $options),
        array(
            'ajax' => array('type'=>'POST',
            'url'=> CController::createUrl('Usuario/admin'),
            'update'=>'#main_table_demo',
            'data'=>array('estado' => 'js:this.value'),
        )));
?>
</div>