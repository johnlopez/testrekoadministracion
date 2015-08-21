<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1>Administración Usuario Administrador</h1>

<div class="main-content clear-float">
    <div class="tile-area no-padding">
        <div class="tile-group no-margin no-padding" style="width: 100%">
            
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario_administrador/usuarioadministrador/index";?>" >
                <div class="tile-wide bg-teal fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-user"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('usuario_administrador');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>            
    </div>
</div> <!-- End of tiles -->