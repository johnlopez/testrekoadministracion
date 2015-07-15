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


<?php echo $content;?>

</html>
