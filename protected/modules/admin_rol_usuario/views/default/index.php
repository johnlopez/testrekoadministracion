<?php
/* @var $this DefaultController */
$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1>Administración Rol Usuario</h1>

<div class="main-content clear-float">
    <div class="tile-area no-padding">
        <div class="tile-group no-margin no-padding" style="width: 100%">
            
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_usuario/rolusuario/index";?>" >
                <div class="tile-wide bg-darkCyan fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-security"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('rol_usuario');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a> 
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_usuario/authitempermisousuario/index";?>" >
                <div class="tile-wide bg-darkCyan fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-key"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('authitem_permiso_usuario');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a> 
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_usuario/controladorusuario/index";?>" >
                <div class="tile-wide bg-darkCyan fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-cog"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('controlador_usuario');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a> 
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_usuario/privilegiousuario/index";?>" >
                <div class="tile-wide bg-darkCyan fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-cogs"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('privilegio_usuario');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
    </div>
</div> <!-- End of tiles -->
