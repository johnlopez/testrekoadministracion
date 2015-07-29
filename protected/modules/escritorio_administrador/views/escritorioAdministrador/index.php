
<?php $var = 0 ?>  
<?php foreach ($vpermiso as $p): ?>
<?php if( $p['name'] == 'admin_usuario_administrador' && $var == 0
        || $p['name'] == 'admin_rol_administrador' && $var == 0
        || $p['name'] == 'admin_rol_usuario' && $var == 0
        || $p['name'] == 'admin_usuario' && $var == 0            
) :?>
<?php $var = 1;?>
<div class="tile-group double">
    <span class="tile-group-title">Usuarios y Roles</span>
    <div class="tile-container">
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_usuario_administrador') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario_administrador";?>" >
                    <div class="tile-wide bg-teal fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-user"></span>
                        </div>
                        <span class="tile-label">
                            <?php 
                                $pizza  = CHtml::encode('administracion_usuario_administrador');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_rol_administrador') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_administrador";?>" >
                    <div class="tile bg-darkBlue fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-security"></span>
                        </div>
                        <span class="tile-label">            
                            <?php 
                                $pizza  = CHtml::encode('administracion_rol_administrador');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>                
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_rol_usuario') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_rol_usuario";?>" >
                    <div class="tile bg-darkCyan fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-security"></span>
                        </div>
                        <span class="tile-label">            
                            <?php 
                                $pizza  = CHtml::encode('administracion_rol_usuario');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>                
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_usuario') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_usuario";?>" >
                    <div class="tile-wide bg-darkGreen fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-users"></span>
                        </div>
                        <span class="tile-label">
                            <?php 
                                $pizza  = CHtml::encode('administracion_usuario');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
    </div>
</div>
<?php endif;?>
<?php endforeach; ?>
<?php $var = 0 ?>  
<?php foreach ($vpermiso as $p): ?>
<?php if( $p['name'] == 'admin_institucion' && $var == 0
        || $p['name'] == 'admin_curricular' && $var == 0    
) :?>
<?php $var = 1 ?>  
<div class="tile-group double">
    <span class="tile-group-title">Institucion y Gestion Curricular</span>
    <div class="tile-container">
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_institucion') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_institucion";?>" >
                    <div class="tile-large bg-darkPink fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-library"></span>
                        </div>
                        <span class="tile-label">
                            <?php 
                                $pizza  = CHtml::encode('administracion_institucion');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_curricular') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_curricular";?>" >
                    <div class="tile-wide bg-darkViolet fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-school"></span>
                        </div>
                        <span class="tile-label">            
                            <?php 
                                $pizza  = CHtml::encode('administracion_curricular');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>                
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
    </div>
</div>
<?php endif;?>
<?php endforeach; ?>
<?php $var = 0 ?>  
<?php foreach ($vpermiso as $p): ?>
<?php if( $p['name'] == 'admin_escritorio' && $var == 0
        || $p['name'] == 'admin_aplicacion' && $var == 0
) :?>
<?php $var = 1 ?>  
<div class="tile-group double">
    <span class="tile-group-title">Escritorio y Aplicaciones</span>
    <div class="tile-container">
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_escritorio') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_escritorio";?>" >
                    <div class="tile-wide bg-green fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-display"></span>
                        </div>
                        <span class="tile-label">
                            <?php 
                                $pizza  = CHtml::encode('administracion_escritorio');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_aplicacion') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_aplicacion";?>" >
                    <div class="tile bg-amber fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-widgets"></span>
                        </div>
                        <span class="tile-label">            
                            <?php 
                                $pizza  = CHtml::encode('administracion_aplicacion');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>                
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>

    </div>
</div>
<?php endif;?>
<?php endforeach; ?>

<?php $var = 0 ?>  
<?php foreach ($vpermiso as $p): ?>
<?php if( $p['name'] == 'admin_aula' && $var == 0
        || $p['name'] == 'admin_repositorio' && $var == 0     
) :?>
<?php $var = 1 ?>
<div class="tile-group double">
    <span class="tile-group-title">Aula y Repositorio</span>
    <div class="tile-container">
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_aula') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_aula";?>" >
                    <div class="tile-wide bg-lime fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-books"></span>
                        </div>
                        <span class="tile-label">
                            <?php 
                                $pizza  = CHtml::encode('administracion_aula');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>
                        </span>
                    </div>
                </a>
            <?php endif;?>
        <?php endforeach; ?>
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_repositorio') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_repositorio";?>" >
                    <div class="tile-large bg-brown fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-cabinet"></span>
                        </div>
                        <span class="tile-label">            
                            <?php 
                                $pizza  = CHtml::encode('administracion_repositorio');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>                
                        </span>
                    </div>  
                </a>
            <?php endif;?>
        <?php endforeach; ?>

    </div>
</div>
<?php endif;?>
<?php endforeach; ?>
<?php $var = 0 ?>
<?php foreach ($vpermiso as $p): ?>
<?php if( $p['name'] == 'admin_error_log_mensaje' && $var == 0 
) :?>
<?php $var = 1 ?>
<div class="tile-group double">
    <span class="tile-group-title">Error Log Mensaje</span>
    <div class="tile-container">
        <?php foreach ($vpermiso as $p): ?>
            <?php if( $p['name'] == 'admin_error_log_mensaje') :?>
                <a href="<?php echo Yii::app()->getBaseUrl()."/admin_error_log_mensaje";?>" >
                    <div class="tile-large bg-red fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-history"></span>
                        </div>
                        <span class="tile-label">
                            <?php 
                                $pizza  = CHtml::encode('administracion_error_log_mensaje');
                                $porciones = explode("_", $pizza);
                                foreach ($porciones as $p)
                                echo $p." "; // porción
                            ?>
                        </span>
                    </div>  
                </a>
            <?php endif;?>
        <?php endforeach; ?>

    </div>
</div>
<?php endif;?>
<?php endforeach; ?>
<div class="tile-group double">
    <span class="tile-group-title">General</span>

    <div class="tile-container">

        <div class="tile bg-indigo fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-calendar"></span>
            </div>
            <span class="tile-label">Calendar</span>
        </div>

        <div class="tile bg-darkBlue fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-envelop"></span>
            </div>
            <span class="tile-label">Inbox</span>
        </div>

        <div class="tile-large bg-steel fg-white" data-role="tile">
            <div class="tile-content" style="background: url(<?php echo Yii::app()->theme->baseUrl; ?>/images/clouds2.png) top left no-repeat; background-size: cover">
                <div class="padding10">
                    <h1>57°</h1>
                    <h2>San Francisco</h2>
                    <h5>Party Cloudy</h5>
                    <p class="tertiary-text fg-white no-margin">Today</p>
                    <p class="tertiary-text fg-white no-margin">63°/55° Mostly Clear</p>
                    <p class="tertiary-text fg-white no-margin">Tomorrow</p>
                    <p class="tertiary-text fg-white no-margin">64°/54° Mostly Clear</p>
                </div>
            </div>
            <span class="tile-label">Weather</span>
        </div>
    </div>
</div>

<div class="tile-group double">
    <span class="tile-group-title">Images</span>
    <div class="tile-container">
        <div class="tile-wide" data-role="tile" data-effect="slideLeft">
            <div class="tile-content">
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/1.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/2.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/3.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/4.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/5.jpg" data-role="fitImage" data-format="fill"></div>
            </div>
            <div class="tile-label">Gallery</div>
        </div>
        <div class="tile" data-role="tile" data-role="tile" data-effect="slideUpDown">
            <div class="tile-content">
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/me.jpg" data-role="fitImage" data-format="fill"></div>
                <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/spface.jpg" data-role="fitImage" data-format="fill"></div>
            </div>
            <div class="tile-label">Photos</div>
        </div>
        <div class="tile-small bg-amber fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-video-camera"></span>
            </div>
        </div>
        <div class="tile-small bg-green fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-gamepad"></span>
            </div>
        </div>
        <div class="tile-small bg-pink fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-headphones"></span>
            </div>
        </div>
        <div class="tile-small bg-yellow fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-lock"></span>
            </div>
        </div>

        <div class="tile-wide bg-orange fg-white" data-role="tile">
            <div class="tile-content image-set">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/shvarcenegger.jpg">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/vin_d.jpg">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jolie.jpg">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jek_vorobey.jpg">
            </div>
        </div>

    </div>
</div>

<div class="tile-group one">
    <span class="tile-group-title">Office</span>

    <div class="tile-small bg-blue" data-role="tile">
        <div class="tile-content iconic">
            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/outlook.png" class="icon">
        </div>
    </div>
    <div class="tile-small bg-darkBlue" data-role="tile">
        <div class="tile-content iconic">
            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/word.png" class="icon">
        </div>
    </div>
    <div class="tile-small bg-green" data-role="tile">
        <div class="tile-content iconic">
            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/excel.png" class="icon">
        </div>
    </div>
    <div class="tile-small bg-red" data-role="tile">
        <div class="tile-content iconic">
            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/access.png" class="icon">
        </div>
    </div>
    <div class="tile-small bg-orange" data-role="tile">
        <div class="tile-content iconic">
            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/powerpoint.png" class="icon">
        </div>
    </div>
</div>

<div class="tile-group double">
    <span class="tile-group-title">Games</span>
    <div class="tile-container">
        <div class="tile" data-role="tile">
            <div class="tile-content">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/grid2.jpg" data-role="fitImage" data-format="square">
            </div>
        </div>
        <div class="tile-small" data-role="tile">
            <div class="tile-content">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/Battlefield_4_Icon.png" data-role="fitImage" data-format="square">
            </div>
        </div>
        <div class="tile-small" data-role="tile">
            <div class="tile-content">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/Crysis-2-icon.png" data-role="fitImage" data-format="square" data-frame-color="bg-steel">
            </div>
        </div>
        <div class="tile-small" data-role="tile">
            <div class="tile-content">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/WorldofTanks.png" data-role="fitImage" data-format="square" data-frame-color="bg-dark">
            </div>
        </div>
        <div class="tile-small" data-role="tile">
            <div class="tile-content">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/halo.jpg" data-role="fitImage" data-format="square">
            </div>
        </div>
        <div class="tile-wide bg-green fg-white" data-role="tile">
            <div class="tile-content iconic">
                <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/x-box.png" class="icon">
            </div>
            <div class="tile-label">X-Box Live</div>
        </div>
    </div>
</div>

<div class="tile-group double">
    <span class="tile-group-title">Other</span>
    <div class="tile-container">
        <div class="tile bg-teal fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-pencil"></span>
            </div>
            <span class="tile-label">Editor</span>
        </div>
        <div class="tile bg-darkGreen fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-shopping-basket"></span>
            </div>
            <span class="tile-label">Store</span>
        </div>
        <div class="tile bg-cyan fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-skype"></span>
            </div>
            <div class="tile-label">Skype</div>
        </div>
        <div class="tile bg-darkBlue fg-white" data-role="tile">
            <div class="tile-content iconic">
                <span class="icon mif-cloud"></span>
            </div>
            <span class="tile-label">OneDrive</span>
        </div>
    </div>
</div>