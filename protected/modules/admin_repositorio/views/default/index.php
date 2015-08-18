<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1>Administración Repositorio</h1>

<div class="main-content clear-float">
    <div class="tile-area no-padding">
        <div class="tile-group no-margin no-padding" style="width: 100%">
            
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_repositorio/repositoriomaster/index";?>" >
                <div class="tile-wide bg-brown fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-cabinet"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('repositorio_troncal_master');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porción
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_repositorio/modeloaprendizajemaster";?>" >
                <div class="tile-wide bg-brown fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-spell-check"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('modelo_aprendizaje_master');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porción
                        ?>                
                    </span>
                </div>  
            </a>            
    </div>
</div> <!-- End of tiles -->