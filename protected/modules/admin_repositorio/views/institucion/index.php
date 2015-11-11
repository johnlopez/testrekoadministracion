<div class="place-right padding20 no-padding-top no-padding-right">
        <form class="place-left padding20 no-padding-left no-padding-bottom no-padding-top" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/institucion/index" >
            <button class="button primary" type="submit">
                    Listar Institucion
            </button>
        </form>    
        <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/institucion/create" >
            <button class="button primary" type="submit">
                    Crear Institucion
            </button>
        </form>          
</div>

<h1>Instituciones</h1>
<div class="progress small" data-value="100" data-color="bg-grayLight" data-role="progressBar"><div class="bar bg-red" style="width: 85%;"></div></div>

<div class="search-form" style="display:none"></div><!-- search-form -->

<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#main_table_demo').DataTable();
} );
</script>
<div class="padding20 bg-grayLighter">
    <div class="inline-block" id="main_table_demo_keys">
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('striped')">
            <span class="check"></span>
            <span class="caption">striped</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('hovered')">
            <span class="check"></span>
            <span class="caption">hovered</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('cell-hovered')">
            <span class="check"></span>
            <span class="caption">cell-hovered</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('border')">
            <span class="check"></span>
            <span class="caption">border</span>
        </label>
        <label class="input-control checkbox small-check no-margin">
            <input type="checkbox" onchange="$('#main_table_demo').toggleClass('bordered')">
            <span class="check"></span>
            <span class="caption">bordered</span>
        </label>
    </div>
</div>

<div class="container">
    <section>
        <table id="main_table_demo" class="display cell-hovered hovered striped" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Operaciones</th>                    
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Operaciones</th>                                        
                </tr>
            </tfoot>
            <tbody>
                <?php foreach ($institucion as $m):?>                                                     
                    <tr>
                        <td><?php echo $m->id; ?></td>
                        <td><?php echo $m->nombre; ?></td>
                        
                        <td>                                        
                            <?php 
                            // http://www.v09studio.com/websystems/materials/forms.html
                            // pagina html post url form button
                            ?>                                        
                            <div id="button-group-1">
                                <form class="place-left" action="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio/institucionhasrepositorio/index" method="get">
                                    <input type="hidden" name="id" value="<?php echo $m->id?>" />
                                    <button class="toolbar-button bg-white bg-active-grayLighter fg-black" type="submit">
                                        Asignar Repositorio
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