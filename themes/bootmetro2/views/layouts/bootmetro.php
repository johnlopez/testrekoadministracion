<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
<head>
   <meta charset="utf-8" />
   <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
   <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
   <!-- Mobile viewport optimized: h5bp.com/viewport -->
   <meta name="viewport" content="width=device-width">

   <title><?php echo $this->pageTitle;?></title>

   <meta name="robots" content="noindex, nofollow">
   <meta name="description" content="BootMetro : Simple and complete web UI framework to create web apps with Windows 8 Metro user interface." />
   <meta name="keywords" content="bootmetro, modern ui, modern-ui, metro, metroui, metro-ui, metro ui, windows 8, metro style, bootstrap, framework, web framework, css, html" />
   <meta name="author" content="AozoraLabs by Marcello Palmitessa"/>
   <link rel="publisher" href="https://plus.google.com/117689250782136016574">

   <!-- remove or comment this line if you want to use the local fonts -->
   <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700' rel='stylesheet' type='text/css'>

   <link rel="stylesheet" type="text/css" href="<?php echo yii::app()->theme->baseUrl;?>/assets/css/bootmetro.css">
   <link rel="stylesheet" type="text/css" href="<?php echo yii::app()->theme->baseUrl;?>/assets/css/bootmetro-responsive.css">
   <link rel="stylesheet" type="text/css" href="<?php echo yii::app()->theme->baseUrl;?>/assets/css/bootmetro-icons.css">
   <link rel="stylesheet" type="text/css" href="<?php echo yii::app()->theme->baseUrl;?>/assets/css/bootmetro-ui-light.css">
   <link rel="stylesheet" type="text/css" href="<?php echo yii::app()->theme->baseUrl;?>/assets/css/datepicker.css">

   <!--  these two css are to use only for documentation -->
   <link rel="stylesheet" type="text/css" href="<?php echo yii::app()->theme->baseUrl;?>/assets/css/demo.css">

   <!-- Le fav and touch icons -->
   <link rel="shortcut icon" href="<?php echo yii::app()->theme->baseUrl;?>/assets/ico/favicon.ico">
   <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<?php echo yii::app()->theme->baseUrl;?>/assets/ico/apple-touch-icon-144-precomposed.png">
   <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<?php echo yii::app()->theme->baseUrl;?>/assets/ico/apple-touch-icon-114-precomposed.png">
   <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<?php echo yii::app()->theme->baseUrl;?>/assets/ico/apple-touch-icon-72-precomposed.png">
   <link rel="apple-touch-icon-precomposed" href="<?php echo yii::app()->theme->baseUrl;?>/assets/ico/apple-touch-icon-57-precomposed.png">
  
   <!-- All JavaScript at the bottom, except for Modernizr and Respond.
      Modernizr enables HTML5 elements & feature detects; Respond is a polyfill for min/max-width CSS3 Media Queries
      For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->
   <script src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/modernizr-2.6.2.min.js"></script>

   <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3182578-6']);
      _gaq.push(['_trackPageview']);
      (function() {
         var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
         ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
         var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
   </script>
</head>


<body>
   <!--[if lt IE 7]>
   <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> or <a href="http://www.google.com/chromeframe/?redirect=true">activate Google Chrome Frame</a> to improve your experience.</p>
   <![endif]-->

   <div id="wrap">
   
      <!-- Header
      ================================================== -->
      <div id="nav-bar" class="">
         <div class="pull-left">
            <div id="header-container">
               <h5>BootMetro Demo</h5>
               <div class="dropdown">
                  <a class="header-dropdown dropdown-toggle accent-color" data-toggle="dropdown" href="#">
                     Wikipedia Featured
                     <b class="caret"></b>
                  </a>
                  <ul class="dropdown-menu">
                  <li>
                        <?php $this->widget('zii.widgets.CMenu',array(
                            'items'=>array(
//                                array('label'=>'administracion_usuario_administrador', 'url'=>array('/administracion_usuario_administrador/default/index')),
//                                array('label'=>'administracion_rol_administrador', 'url'=>array('/administracion_rol_administrador/default/index')),
//                                array('label'=>'administracion_usuario', 'url'=>array('administracion_usuario/default/index')),
                            
				array('label'=>'Home', 'url'=>array('escritorio_administrador/escritorioadministrador/index')),
				array('label'=>'About', 'url'=>array('/site/page', 'view'=>'about')),
				array('label'=>'Contact', 'url'=>array('/site/contact')),
				array('label'=>'Login', 'url'=>array('/site/login'), 'visible'=>Yii::app()->user->isGuest),
				array('label'=>'Logout ('.Yii::app()->user->name.')', 'url'=>array('/site/logout'), 'visible'=>!Yii::app()->user->isGuest)
                            ),
                        )); ?>
                  </li>
                  <li><a href="../hub.html">Hub</a></li>
               </ul>
            </div>
            </div>
         </div>
         <div class="pull-right">
            <div id="top-info" class="pull-right">
            <a id="settings" href="#" class="win-command pull-right">
               <span class="win-commandicon win-commandring icon-cog-3"></span>
            </a>
            <a id="logged-user" href="#" class="win-command pull-right">
               <span class="win-commandicon win-commandring icon-user"></span>
            </a>
            <div class="pull-left">
               <h3>FirstName</h3>
               <h4>LastName</h4>
            </div>
         </div>
      </div>
      </div>
   
      <div id="alerts-container">
         <div id="toast-example1" class="toast toasttext02 fade in">
            <button type="button" class="close" data-dismiss="alert"></button>
            <div class="pull-left">
               <div class="toast-object icon-info-4"></div>
            </div>
            <div class="toast-body">
               <h4 class="toast-heading">Alpha version!</h4>
               <p>Please be patience, this demo is still a work in progress! Thanks.</p>
            </div>
         </div>
      </div>
      <!--<div id="metro-container" class="-container">-->
         <!--<div class="row">-->
            <!--<div id="hub" class="metro">-->
               <div class="metro panorama">
                  <div class="panorama-sections">
                      <!-- panorama sections -->
                        <div class="panorama-section tile-span-4">  
                            <?php echo $content;?>
                        </div>
                  </div>
               </div>
               <a id="panorama-scroll-prev" href="#"></a>
               <a id="panorama-scroll-next" href="#"></a>
               <div id="panorama-scroll-prev-bkg"></div>
               <div id="panorama-scroll-next-bkg"></div>
            <!--</div>-->
         <!--</div>-->
      <!--</div>-->
   
   </div>
   <div id="charms" class="win-ui-dark slide">
   
      <div id="theme-charms-section" class="charms-section">
         <div class="charms-header">
            <a href="#" class="close-charms win-backbutton"></a>
            <h2>Settings</h2>
         </div>
   
         <div class="row-fluid">
            <div class="span12">
   
               <form class="">
                  <label for="win-theme-select">Change theme:</label>
                  <select id="win-theme-select" class="">
                     <option value="metro-ui-light">Light</option>
                     <option value="metro-ui-dark">Dark</option>
                  </select>
               </form>
   
            </div>
         </div>
      </div>
   
   </div>

   <!-- Grab Google CDN's jQuery. fall back to local if necessary -->
   <script src="//code.jquery.com/jquery-1.10.0.min.js"></script>
   <script>window.jQuery || document.write("<script src='<?php echo yii::app()->theme->baseUrl;?>/assets/js/jquery-1.10.0.min.js'>\x3C/script>")</script>

   <!--[if IE 7]>
   <script type="text/javascript" src="scripts/bootmetro-icons-ie7.js">
   <![endif]-->

   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/min/bootstrap.min.js"></script>
   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/bootmetro-panorama.js"></script>
   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/bootmetro-pivot.js"></script>
   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/bootmetro-charms.js"></script>
   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/bootstrap-datepicker.js"></script>

   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/jquery.mousewheel.min.js"></script>
   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/jquery.touchSwipe.min.js"></script>

   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/holder.js"></script>
   <!--<script type="text/javascript" src="../assets/js/perfect-scrollbar.with-mousewheel.min.js"></script>-->
   <script type="text/javascript" src="<?php echo yii::app()->theme->baseUrl;?>/assets/js/demo.js"></script>


   <script type="text/javascript">

      $('.panorama').panorama({
         //nicescroll: false,
         showscrollbuttons: true,
         keyboard: true,
         parallax: true
      });

//      $(".panorama").perfectScrollbar();

      $('#pivot').pivot();

   </script>
</body>

</html>