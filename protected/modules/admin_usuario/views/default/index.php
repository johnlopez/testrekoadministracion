<?php
/* @var $this DefaultController */

$this->breadcrumbs=array(
	$this->module->id,
);
?>
<h1>Administración Usuario</h1>

<div class="main-content clear-float">
    <div class="tile-area no-padding">
        <div class="tile-group no-margin no-padding" style="width: 100%">
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/usuario/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-user"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('usuario');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/datoAcademico/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-profile"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('dato_academico');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/datoLaboral/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-profile"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('dato_laboral');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/datoLogin/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-profile"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('dato_login');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/datoPersonal/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-profile"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('dato_personal');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/pais/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-map2"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('pais');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario/region/admin";?>" >
                <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                    <div class="tile-content iconic">
                        <span class="icon mif-location-city"></span>
                    </div>
                    <span class="tile-label">            
                        <?php 
                            $pizza  = CHtml::encode('region');
                            $porciones = explode("_", $pizza);
                            foreach ($porciones as $p)
                            echo $p." "; // porciÃ³n
                        ?>                
                    </span>
                </div>  
            </a>
            
    </div>
</div> <!-- End of tiles -->

<<<<<<< HEAD
<?php echo CHtml::link('Dato Academico','admin_usuario/datoacademico/admin')."<br>";?>
<?php echo CHtml::link('Dato Laboral','admin_usuario/datolaboral/admin')."<br>";?>
<?php echo CHtml::link('Dato Login','admin_usuario/datologin/admin')."<br>";?>
<?php echo CHtml::link('Dato Personal','admin_usuario/datopersonal/admin')."<br>";?>
<?php echo CHtml::link('Pais','admin_usuario/pais/admin')."<br>";?>
<?php echo CHtml::link('Region','admin_usuario/region/admin')."<br>";?>
<?php echo CHtml::link('Usuario','admin_usuario/usuario/admin')."<br>";?>
<?php echo CHtml::link('Logica estado usuario','admin_usuario/logicaestadousuario/admin');?>
=======
>>>>>>> 3860e8c3ba7825acf3a21b5317dc0ebb1ad6318f
