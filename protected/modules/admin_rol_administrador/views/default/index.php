<?php

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1>Administración Rol Administrador</h1>

<div class="main-content clear-float">
    <div class="tile-area no-padding">
        <div class="tile-group no-margin no-padding" style="width: 100%">
            
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador/usuarioadministrador/index";?>" >
                <div class="tile-wide bg-darkBlue fg-white" data-role="tile">
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
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador/roladministrador/index";?>" >
                <div class="tile-wide bg-darkBlue fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-security"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('rol_administrador');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a> 
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador/authitempermisoadministrador/index";?>" >
                <div class="tile-wide bg-darkBlue fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-key"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('authitem_permiso_administrador');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador/controladoradministrador/index";?>" >
                <div class="tile-wide bg-darkBlue fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-cog"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('controlador_administrador');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a> 
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador/privilegioadministrador/index";?>" >
                <div class="tile-wide bg-darkBlue fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-cogs"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('privilegio_administrador');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a> 
    </div>
</div> <!-- End of tiles -->
