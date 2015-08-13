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
                
                
                <a class="place-left" href="#" title="">
                    <h1 class="tile-area-title">            
                        
                        <a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/escritorio_administrador/escritorioadministrador/index" >
                            <div class="mif-music  mif-ani-shuttle mif-ani-slow" style="color: transparent; width: 80px; height:80px; border-top-left-radius: 50%; border-top-right-radius: 50%; border-bottom-right-radius: 50%; border-bottom-left-radius: 50%; background-image: url(<?php echo Yii::app()->theme->baseUrl; ?>/images/reko.png); background-size: cover; background-repeat: no-repeat;"></div>
                            <a  href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/" title="">
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
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_usuario_administrador">Admin Usuario Administrador</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_rol_administrador">Admin Rol Administrador</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_usuario">Admin Usuario</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_rol_usuario">Admin Rol Usuario</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_institucion">Admin Istitucion</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_curricular">Admin Curricular</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_aula">Admin Aula</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_repositorio">Admin Repositorio</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_repositorio">Admin Escritorio</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_repositorio">Admin Aplicaciones</a></li>
                            <li><a href="<?php echo Yii::app()->theme->baseUrl; ?>/../../../testrekoadministracion/admin_error_log_mensaje">Admin Error Log Mensaje</a></li>

                        </ul>
                    </li>
                    <?php endif;?>
                </ul>
            </div>
        </header>

        <div class="main-content clear-float">
            <div class="tile-area no-padding">
                <div class="tile-group no-margin no-padding" style="width: 100%">
                    <div class="tile-large tile-super-y bg-gray ol-transparent" style="float: right; ">
                        <div class="tile-content">
                            <div class="brand padding10">
                                <h3 class="fg-white">Adverts</h3>
                                <!-- Google adsense block -->
                                <div><ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1632668592742327" data-ad-slot="8347181909" data-ad-format="auto"></ins></div>
                                <script>
                                    (adsbygoogle = window.adsbygoogle || []).push({});
                                </script>
                                <!-- End of gad block -->
                                <!-- Google adsense block -->
                                <br />
                                <br />
                                <div><ins class="adsbygoogle" style="display:block" data-ad-client="ca-pub-1632668592742327" data-ad-slot="8347181909" data-ad-format="auto"></ins></div>
                                <script>
                                    (adsbygoogle = window.adsbygoogle || []).push({});
                                </script>
                                <!-- End of gad block -->
                            </div>
                        </div>
                    </div>

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
                    <div class="tile bg-lightBlue fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-facebook"></span>
                        </div>
                    </div>
                    <div class="tile bg-red fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-youtube"></span>
                        </div>
                    </div>
                    <div class="tile bg-teal fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-twitter"></span>
                        </div>
                    </div>
                    <div class="tile bg-green fg-white" data-role="tile">
                        <div class="tile-content iconic">
                            <span class="icon mif-android"></span>
                        </div>
                    </div>

                    <div class="tile-big tile-wide-y bg-white" data-role="tile">
                        <div class="tile-content">
                            <div class="panel" style="height: 100%">
                                <div class="heading bg-darkRed fg-white"><span class="title text-light">news</span></div>
                                <div class="content fg-dark clear-float" style="height: 100%">
                                    <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg" class="place-left margin10" style="height: 230px">
                                    <h2 class="text-light">Growing Old Before Growing Up</h2>
                                    <p>Jackie Chan’s new book “Growing Old Before Growing Up” 《還沒長大就老了》, written by Zhu Mo, was released on his birthday on April 7, 2015, during a press conference held in Beijing.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tile tile-wide-y bg-white" data-role="tile">
                        <div class="tile-content">
                            <div class="panel">
                                <div class="heading bg-pink fg-white"><span class="title text-light">entertainment</span></div>
                                <div class="content bg-lightPink fg-white clear-float">
                                    <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jek_vorobey.jpg" class="">
                                    <strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry.
                                    Lorem Ipsum has been the industry's standard dummy text ever since.
                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- End first group -->

                <div class="tile-group no-margin no-padding" style="width: 100%">
                    <div class="tile-wide bg-cyan" data-role="tile">
                        <div class="tile-content image-set">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/shvarcenegger.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/vin_d.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jolie.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jek_vorobey.jpg">
                        </div>
                    </div>
                    <div class="tile bg-green" data-role="tile" data-effect="slideUpDown">
                        <div class="tile-content">
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/shvarcenegger.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/vin_d.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jolie.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jek_vorobey.jpg" data-role="fitImage" data-format="fill"></div>
                        </div>
                    </div>
                    <div class="tile bg-green" data-role="tile" data-effect="slideLeftRight">
                        <div class="tile-content">
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/vin_d.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jolie.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jek_vorobey.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg" data-role="fitImage" data-format="fill"></div>
                            <div class="live-slide"><img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/shvarcenegger.jpg" data-role="fitImage" data-format="fill"></div>
                        </div>
                    </div>
                    <div class="tile-wide bg-red" data-role="tile">
                        <div class="tile-content image-set">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jeki_chan.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/shvarcenegger.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/vin_d.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jolie.jpg">
                            <img src="<?php echo Yii::app()->theme->baseUrl; ?>/images/jek_vorobey.jpg">
                        </div>
                    </div>
                </div>


                <h3 class="fg-orange text-light margin5">NEWS <span class="mif-chevron-right mif-2x" style="vertical-align: top !important;"></span></h3>
                <div class="tile-group no-margin no-padding" style="width: 100%;">
                    <div class="tile-large ol-transparent" data-role="tile"></div>
                    <div class="tile-wide ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile-wide ol-transparent" data-role="tile"></div>
                </div>

                <h3 class="fg-blue text-light margin5">SPORT <span class="mif-chevron-right mif-2x" style="vertical-align: top !important;"></span></h3>
                <div class="tile-group no-margin no-padding" style="width: 100%;">
                    <div class="tile-large ol-transparent" data-role="tile"></div>
                    <div class="tile-wide ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile ol-transparent" data-role="tile"></div>
                    <div class="tile-wide ol-transparent" data-role="tile"></div>
                </div>
            </div>
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