<!DOCTYPE html>
<!-- saved from url=(0025)http://metroui.org.ua/v2/ -->
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
    <body class="metro" style="background-color: rgb(239, 234, 227);">        
        <div class="">
            <div style="background: url(<?php echo Yii::app()->theme->baseUrl; ?>/images/header.png) top left no-repeat; background-size: cover; height: 300px;">
                <div class="container" style="padding: 50px 20px">
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
                            <span class="sub-header no-margin text-light">
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
                
                
                <a class="place-left" title="">
                    <h1 class="tile-area-title">            
                        
                        <a href="<?php echo Yii::app()->getBaseUrl(); ?>/escritorio_administrador/escritorioadministrador/index" >
                            <div class="mif-music  mif-ani-shuttle mif-ani-slow" style="color: transparent; width: 80px; height:80px; border-top-left-radius: 50%; border-top-right-radius: 50%; border-bottom-right-radius: 50%; border-bottom-left-radius: 50%; background-image: url(<?php echo Yii::app()->theme->baseUrl; ?>/images/reko.png); background-size: cover; background-repeat: no-repeat;"></div>
                            <a  href="<?php echo Yii::app()->getBaseUrl(); ?>" title="">
                                <h1 class="fg-white">ReKo</h1>
                            </a>
                        </a>                        
                    </h1>
                </a>
                
            </div>

            <div class="main-menu-wrapper">
                
                <ul class="horizontal-menu" style="margin-left: -20px">
            <ul class="f-menu block-shadow-impact">
                <li><a href="#">Home</a></li>
                <li class="">
                    <a href="#" class="dropdown-toggle">More...</a>
                    <ul class="d-menu" data-role="dropdown" style="display: none;">
                        <li><a href="#">About</a></li>
                        <li><a href="#">Partners</a></li>
                        <li>
                            <a href="#" class="dropdown-toggle">More...</a>
                            <ul class="d-menu" data-role="dropdown">
                                <li><a href="#">About</a></li>
                                <li><a href="#">Partners</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li><a href="#">File</a></li>
                <li><a href="#">Products</a></li>
                <li class="">
                    <a href="#" class="dropdown-toggle">More...</a>
                    <ul class="d-menu" data-role="dropdown" style="display: none;">
                        <li><a href="#">About</a></li>
                        <li><a href="#">Partners</a></li>
                    </ul>
                </li>
            </ul>
                    
                    <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/escritorio_administrador/escritorioadministrador/index">Inicio</a></li>
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
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario_administrador">Admin Usuario Administrador</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_administrador">Admin Rol Administrador</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_usuario">Admin Usuario</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_rol_usuario">Admin Rol Usuario</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_institucion">Admin Istitucion</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_curricular">Admin Curricular</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_aula">Admin Aula</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio">Admin Repositorio</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio">Admin Escritorio</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_repositorio">Admin Aplicaciones</a></li>
                            <li><a href="<?php echo Yii::app()->getBaseUrl(); ?>/admin_error_log_mensaje">Admin Error Log Mensaje</a></li>

                        </ul>
                    </li>
                    <?php endif;?>
                </ul>
            </div>                
                </div>
            </div>

            <div class="container">
                <div class="grid">
                    <div class="row cells3">
                        <div class="tile-big tile-wide-y ol-transparent" data-role="tile">
                            <div class="tile-content">
                                <div class="carousel" data-role="carousel" data-height="100%" data-width="100%" data-controls="false">
                                    <div class="slide">
                                        <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/imagen_destacada.jpg" data-role="fitImage" data-format="fill">
                                    </div>
                                    <div class="slide">
                                        <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/logo-utem.jpg"  data-role="fitImage" data-format="fill">
                                    </div>
                                    <div class="slide">
                                        <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/clouds2.png"  data-role="fitImage" data-format="fill">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="grid no-margin">
                    <div class="row">
                        <div class="span4 no-tablet-portrait no-phone">
                            <div class="notice marker-on-right bg-lighterBlue padding20 text-center" style="height: 200px">
                                <h1 class="fg-white" style="font-size: 120px; line-height: 80px; margin-bottom: 30px">5</h1>
                                <p class="subheader-secondary fg-white">simple steps to you style</p>
                            </div>
                        </div>
                        <div class="span8">
                            <div class="notice marker-on-bottom no-desktop padding10 bg-lighterBlue text-center ">
                                <p class="subheader-secondary fg-white no-margin">5 simple steps to you style</p>
                            </div>
                            <ol class="styled">
                                <li style="width: 90%">Create page with <strong>HTML5 DOCTYPE</strong></li>
                                <li style="width: 90%">Include <strong>metro-bootstrap.css</strong></li>
                                <li style="width: 90%">Include <strong>metro.min.js</strong> (jquery.js required)</li>
                                <li style="width: 90%">Create main container with class <strong>.metro</strong></li>
                                <li style="width: 90%">Use markup, as described in the pages of this site</li>
                            </ol>
                        </div>
                    </div>
                </div>
                <pre class="prettyprint linenums no-phone prettyprinted" style="margin-top: 10px;"><ol class="linenums"><li class="L0"><span class="dec">&lt;!DOCTYPE html&gt;</span></li><li class="L1"><span class="tag">&lt;html&gt;</span></li><li class="L2"><span class="pln">    </span><span class="tag">&lt;head&gt;</span></li><li class="L3"><span class="pln">        </span><span class="tag">&lt;link</span><span class="pln"> </span><span class="atn">rel</span><span class="pun">=</span><span class="atv">"stylesheet"</span><span class="pln"> </span><span class="atn">href</span><span class="pun">=</span><span class="atv">"css/metro-bootstrap.css"</span><span class="tag">&gt;</span></li><li class="L4"><span class="pln">        </span><span class="tag">&lt;script</span><span class="pln"> </span><span class="atn">src</span><span class="pun">=</span><span class="atv">"js/jquery/jquery.min.js"</span><span class="tag">&gt;&lt;/script&gt;</span></li><li class="L5"><span class="pln">        </span><span class="tag">&lt;script</span><span class="pln"> </span><span class="atn">src</span><span class="pun">=</span><span class="atv">"js/jquery/jquery.widget.min.js"</span><span class="tag">&gt;&lt;/script&gt;</span></li><li class="L6"><span class="pln">        </span><span class="tag">&lt;script</span><span class="pln"> </span><span class="atn">src</span><span class="pun">=</span><span class="atv">"js/metro/metro.min.js"</span><span class="tag">&gt;&lt;/script&gt;</span></li><li class="L7"><span class="pln">    </span><span class="tag">&lt;/head&gt;</span></li><li class="L8"><span class="pln">    </span><span class="tag">&lt;body</span><span class="pln"> </span><span class="atn">class</span><span class="pun">=</span><span class="atv">"metro"</span><span class="tag">&gt;</span></li><li class="L9"><span class="pln">        ... markup page ...</span></li><li class="L0"><span class="pln">    </span><span class="tag">&lt;/body&gt;</span></li><li class="L1"><span class="tag">&lt;/html&gt;</span></li></ol></pre>
            </div>
            <div class="bg-steel no-tablet-portrait no-phone">
                <div class="container padding20 fg-white">
                    <div class="carousel bg-transparent no-overflow" id="carousel2" style="width: 100%; height: 210px;">
                       
            <div class="presenter" data-role="presenter" data-height="220" data-easing="swing" style="height: 220px; width: 100%;">
                <div class="scene">
                    <div class="act bg-pink fg-white" style="display: block;">
                        <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/css-logo.png" class="actor" data-position="10,10" style="height: 200px; opacity: 1; position: absolute; display: block; left: 10px; top: 10px;">
                        <h1 class="actor" data-position="10,250" style="opacity: 1; position: absolute; display: block; top: 10px; left: 250px;">Developed with advice</h1>
                        <p class="actor" data-position="70,250" style="opacity: 1; position: absolute; display: block; top: 70px; left: 250px;">Metro UI CSS developed with the advice of Microsoft to build the user interface and include: general styles, grid, layouts, typography, 20+ components, 300+ built-in icons.</p>
                        <p class="actor" data-position="130,250" style="opacity: 1; position: absolute; display: block; left: 250px; top: 130px;">Metro UI CSS build with {LESS}. Metro UI CSS is open source and has MIT licensing model.</p>
                    </div>
                    <div class="act bg-steel fg-white" style="display: none;">
                        <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/bizspark_b_2.png" class="actor" data-position="10,10" style="height: 200px; opacity: 1; position: absolute; display: block; left: 10px; top: 10px;">
                        <h1 class="actor" data-position="10,270" style="opacity: 1; position: absolute; display: block; top: 10px; left: 270px;">BizSpark Startup</h1>
                        <p class="actor" data-position="60,270" style="opacity: 1; position: absolute; display: block; left: 270px; top: 60px;">Metro UI CSS is a BizSpark Startup. Microsoft BizSpark is a global program that helps software startups succeed by giving them access to software development tools, connecting them with key industry players, and providing marketing visibility.</p>
                        <p class="actor" data-position="120,270" style="opacity: 1; position: absolute; display: block; top: 120px; left: 270px;">BizSpark provides free software, support, and visibility to help startups succeed. Join BizSpark and become part of a global community that has over 50,000 members in 100+ countries.</p>
                        <a class="actor button primary" data-position="170,270" href="http://bizspark.com" style="opacity: 1; position: absolute; display: block; left: 270px; top: 170px;">Join the BizSpark Program now</a>
                    </div>
                    <div class="act bg-darkCyan fg-white" style="display: none;">
                        <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/phpstorm_7_eap.png" class="actor" data-position="10,10" style="height: 200px; opacity: 1; position: absolute; display: block; top: 10px; left: 10px;">
                        <h1 class="actor" data-position="10,300" style="opacity: 1; position: absolute; display: block; left: 300px; top: 10px;">Thanks to JetBrains</h1>
                        <p class="actor" data-position="60,300" style="opacity: 1; position: absolute; display: block; top: 60px; left: 300px;">Thanks to the company JetBrains for supporting the project in the form of a license for a great product PhpStorm.</p>
                        <a class="actor button success" data-position="130,300" href="http://www.jetbrains.com/phpstorm/" style="opacity: 1; position: absolute; display: block; top: 130px; left: 300px;">Get PhpStorm now!</a>
                    </div>
                </div>
            </div>
                    </div>
                    <script>
                        $(function(){
                            $("#carousel2").carousel({
                                height: 210,
                                period: 5000,
                                duration: 1000,
                                effect: 'fade',
                                markers: {
                                    show: false
                                }
                            });
                        })
                    </script>
                </div>
            </div>
            <div class="bg-dark">
                <div class="container" style="padding: 10px 0;">

                    <div class="grid no-margin">
                        <div class="row no-margin">
                            <div class="span3 padding10">
                                <img src="./Metro UI CSS   Simple responsive css framework_files/spface.jpg" alt="" class="polaroid">
                            </div>
                            <div class="span6 padding10">
                                <h3 class="fg-white">About author</h3>
                                <p class="fg-white">Hi! My name Sergey Pimenov and i'm author of Metro UI CSS from Kiev, Ukraine.</p>
                            </div>
                            <div class="span3 padding10">
                                <a class="button danger " style="width: 100%; margin-bottom: 5px" href="http://bizspark.com/">Microsoft BizSpark</a>
                                <a class="button success " style="width: 100%; margin-bottom: 5px" href="http://jetbrains.com/">JetBrains</a>
                                <a class="button info " style="width: 100%; margin-bottom: 5px" href="https://github.com/olton/Metro-UI-CSS">Github</a>
                                <a class="button warning " style="width: 100%; margin-bottom: 5px;" href="http://lesscss.org/">{ Less }</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container tertiary-text bg-dark fg-white" style="padding: 10px">
                    2012-2013, Metro UI CSS © by  <a href="mailto:sergey@pimenov.com.ua" class="fg-yellow">Sergey Pimenov</a>
                </div>
            </div>
        </div>
        <script src="./Metro UI CSS   Simple responsive css framework_files/hitua.js"></script><script src="./Metro UI CSS   Simple responsive css framework_files/hit"></script>
    </body>
</html>