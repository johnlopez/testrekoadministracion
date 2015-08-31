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
                <div>
                    <script async="" src="http://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
                    <!-- Metro UI - Responsive 1 -->
                    <ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1632668592742327" data-ad-slot="8347181909" data-ad-format="auto"></ins>
                    <script>
                    (adsbygoogle = window.adsbygoogle || []).push({});
                    </script>
                </div>
                <div class="grid fluid">
                    <div class="row">
                        <div class="span4 bg-amber padding20 text-center">
                            <h2 class="fg-white">easy to use</h2>
                        </div>
                        <div class="span4 bg-green padding20 text-center">
                            <h2 class="fg-white">less source</h2>
                        </div>
                        <div class="span4 bg-red padding20 text-center">
                            <h2 class="fg-white">mit license</h2>
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
                        <div class="slide" style="display: none; left: 0px;">
                            <div class="place-right">
                                <img src="./Metro UI CSS   Simple responsive css framework_files/css-logo.png" alt="" class="span3">
                            </div>
                            <h2 class="fg-white ntm">Developed with advice</h2>
                            <p class="fg-white">Metro UI CSS developed with the advice of Microsoft to build the user interface and include: general styles, grid, layouts, typography, 20+ components, 300+ built-in icons.</p>
                            <p class="fg-white">Metro UI CSS build with {LESS}. Metro UI CSS is open source and has MIT licensing model.</p>
                        </div>

                        <div class="slide" style="left: 0px; display: block;">
                            <div class="place-right padding20 ntp nrp nbp">
                                <img src="./Metro UI CSS   Simple responsive css framework_files/bizspark_b_2.png" alt="" class="span3">
                            </div>
                            <h2 class="fg-white ntm">BizSpark Startup</h2>
                            <p class="fg-white">Metro UI CSS is a BizSpark Startup. Microsoft BizSpark is a global program that helps software startups succeed by giving them access to software development tools, connecting them with key industry players, and providing marketing visibility.</p>
                            <p class="fg-white">BizSpark provides free software, support, and visibility to help startups succeed. Join BizSpark and become part of a global community that has over 50,000 members in 100+ countries.</p>
                            <a class="button small1 inverse" href="http://bizspark.com/">Join the BizSpark Program now</a>
                        </div>

                        <div class="slide" style="left: 0px; display: none;">
                            <div class="place-right">
                                <img src="./Metro UI CSS   Simple responsive css framework_files/phpstorm_7_eap.png" alt="" class="span3">
                            </div>
                            <h2 class="fg-white ntm">Thanks to JetBrains</h2>
                            <p class="fg-white">Thanks to the company JetBrains for supporting the project in the form of a license for a great product PhpStorm.</p>
                            <a class="button small1 inverse" href="http://www.jetbrains.com/phpstorm/">Get PhpStorm now!</a>
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