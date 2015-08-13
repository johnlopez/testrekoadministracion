<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="Metro, a sleek, intuitive, and powerful framework for faster and easier web development for Windows Metro Style.">
    <meta name="keywords" content="HTML, CSS, JS, JavaScript, framework, metro, front-end, frontend, web development">
    <meta name="author" content="Sergey Pimenov and Metro UI CSS contributors">

    <link rel='shortcut icon' type='image/x-icon' href='<?php echo Yii::app()->theme->baseUrl; ?>/favicon.ico' />

    <title>News portal :: Metro UI CSS - The front-end framework for developing projects on the web in Windows Metro Style</title>

    <link href="<?php echo Yii::app()->theme->baseUrl; ?>/css/metro.css" rel="stylesheet">
    <link href="<?php echo Yii::app()->theme->baseUrl; ?>/css/metro-icons.css" rel="stylesheet">

    <script src="<?php echo Yii::app()->theme->baseUrl; ?>/js/jquery-2.1.3.min.js"></script>
    <script src="<?php echo Yii::app()->theme->baseUrl; ?>/js/metro.js"></script>
    <script src="<?php echo Yii::app()->theme->baseUrl; ?>/js/ga.js"></script>
    <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>

</head>
<body>
    <div class="container">
        <header class="margin20 no-margin-left no-margin-right">
            <div class="clear-float">
                <div class="place-right">
                    <form>
                        <div class="input-control text margin20" style="width: 300px">
                            <input type="text" name="q" placeholder="Search...">
                            <button class="button"><span class="mif-search"></span></button>
                        </div>
                    </form>
                    <div class="place-right">
                    <div class="tile-area-controls">            
                        <button class="image-button bg-transparent fg-white bg-hover-dark no-border">
                            <span class="sub-header fg-black no-margin text-light">           
                                <?php                     
                                    echo !Yii::app()->user->isGuest
                                    ? ''
                                    : CHtml::link("Login", array('/site/login'), array()); 
                                ?>
                                <?php
                                    echo Yii::app()->user->isGuest
                                    ? ''
                                    : CHtml::link("Logout", array('/site/logout'), array()); 
                                ?>
                           </span> 
                        </button>

                        <button class="image-button icon-right bg-transparent fg-white bg-hover-dark no-border">
                            <span class="sub-header no-margin text-light fg-blue">
                                <?php
                                echo Yii::app()->user->isGuest
                                ? ''
                                : CHtml::link(Yii::app()->user->name);                    
                                ?>
                            </span> 

                            <span class="icon mif-user">                    
                            </span>
                        </button>            
                        <button class="square-button bg-transparent fg-white bg-hover-dark no-border" onclick="showSearch()"><span class="mif-search"></span></button>
                        
                    </div>
                </div>
                </div>
                
                
                <a class="place-left" href="#" title="">
                    <h1 class="tile-area-title">            
                        
                        <a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/escritorio_administrador/escritorioadministrador/index" >
                            <div class="mif-music  mif-ani-shuttle mif-ani-slow" style="color: transparent; width: 80px; height:80px; border-top-left-radius: 50%; border-top-right-radius: 50%; border-bottom-right-radius: 50%; border-bottom-left-radius: 50%; background-image: url(<?php echo Yii::app()->theme->baseUrl; ?>/images/reko.png); background-size: cover; background-repeat: no-repeat;"></div>
                            <a  href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/" title="">
                                <h1>REKO</h1>
                            </a>
                        </a>                        
                    </h1>
                </a>
            </div>

            <div class="main-menu-wrapper">
                <ul class="horizontal-menu" style="margin-left: -20px">
                    <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/escritorio_administrador/escritorioadministrador/index">Inicio</a></li>
                    <li><a href="#">Tutoriales</a></li>
                    <li><a href="#">Soporte Tecnico</a></li>
                    <li><a href="#">Novedades</a></li>
                    <li><a href="#">Contacto</a></li>
                    <li class="place-right">
                        <a href="#" class="dropdown-toggle">Menu</a>
                        <ul class="d-menu place-right" data-role="dropdown">
                            <li><a href="#">Inicio</a></li>
                            <li><a href="#">Reko</a></li>
                            <li><a href="#">Tutoriales</a></li>
                            <li><a href="#">Experiencia de Uso</a></li>
                            <li><a href="#">Soporte Técnico</a></li>
                            <li><a href="#">Novedades</a></li>
                            <li><a href="#">Contacto</a></li>
                        </ul>
                    </li>
                    <?php if(!Yii::app()->user->isGuest):?>
                    <li class="place-right">
                        <a href="#" class="dropdown-toggle">Administracion</a>
                        <ul class="d-menu place-right" data-role="dropdown">
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_usuario_administrador">Admin Usuario Administrador</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_rol_administrador">Admin Rol Administrador</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_usuario">Admin Usuario</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_rol_usuario">Admin Rol Usuario</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_institucion">Admin Istitucion</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_curricular">Admin Curricular</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_aula">Admin Aula</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_repositorio">Admin Repositorio</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_repositorio">Admin Escritorio</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_repositorio">Admin Aplicaciones</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/testrekoadministracion/admin_error_log_mensaje">Admin Error Log Mensaje</a></li>

                        </ul>
                    </li>
                    <?php endif;?>
                    
                </ul>
            </div>
        </header>

        <div class="main-content clear-float">
                    <?php echo $content; ?>
            
        </div> <!-- End of tiles -->

        <footer>
            <div class="bottom-menu-wrapper">
                <ul class="horizontal-menu compact">
                    <li><a>&copy; 2014 Metro UI CSS</a></li>
                    <li class="place-right"><a href="#">Privacy</a></li>
                    <li class="place-right"><a href="#">Legal</a></li>
                    <li class="place-right"><a href="#">Advertise</a></li>
                    <li class="place-right"><a href="#">Help</a></li>
                    <li class="place-right"><a href="#">Feedback</a></li>
                </ul>
            </div>
        </footer>
    </div>

    <!-- hit.ua -->
    <a href='http://hit.ua/?x=136046' target='_blank'>
        <script language="javascript" type="text/javascript"><!--
        Cd=document;Cr="&"+Math.random();Cp="&s=1";
        Cd.cookie="b=b";if(Cd.cookie)Cp+="&c=1";
        Cp+="&t="+(new Date()).getTimezoneOffset();
        if(self!=top)Cp+="&f=1";
        //--></script>
        <script language="javascript1.1" type="text/javascript"><!--
        if(navigator.javaEnabled())Cp+="&j=1";
        //--></script>
        <script language="javascript1.2" type="text/javascript"><!--
        if(typeof(screen)!='undefined')Cp+="&w="+screen.width+"&h="+
        screen.height+"&d="+(screen.colorDepth?screen.colorDepth:screen.pixelDepth);
        //--></script>
        <script language="javascript" type="text/javascript"><!--
        Cd.write("<img src='http://c.hit.ua/hit?i=136046&g=0&x=2"+Cp+Cr+
        "&r="+escape(Cd.referrer)+"&u="+escape(window.location.href)+
        "' border='0' wi"+"dth='1' he"+"ight='1'/>");
        //--></script></a>
    <!-- / hit.ua -->


</body>
</html>