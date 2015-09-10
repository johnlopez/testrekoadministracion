<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h2>Administración Institución</h2><br><br>

<div class="main-content clear-float">
    <div class="tile-area no-padding">
        <div class="tile-group no-margin no-padding" style="width: 100%">
            
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_institucion/institucion/admin";?>" >
                <div class="tile-wide bg-darkPink fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-library"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('Institucion');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>  
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_institucion/entidad/admin";?>" >
                <div class="tile-wide bg-darkPink fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-location"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('Entidad');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>  
    </div>
</div> <!-- End of tiles -->

