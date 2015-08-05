<?php
 Yii::setPathOfAlias('bootstrap',dirname(__FILE__).'/../extensions/bootstrap');

// uncomment the following to define a path alias
// Yii::setPathOfAlias('local','path/to/local-folder');

// This is the main Web application configuration. Any writable
// CWebApplication properties can be configured here.
return array(
	'basePath'=>dirname(__FILE__).DIRECTORY_SEPARATOR.'..',
	'name'=>'My Web Application',
//        'theme'=>"bootmetro",
//        'theme'=>"bootmetro2",
//        'theme'=>"bootstrap",
//        'theme'=>"metroui", 
        'theme'=>"metroui-bootstrap",       

	// preloading 'log' component
	'preload'=>array('log'),

	// autoloading model and component classes
	'import'=>array(
		'application.models.*',
		'application.components.*',
	),

	'modules'=>array(
		// uncomment the following to enable the Gii tool
		
		'gii'=>array(
                        'generatorPaths'=>array(
                            'bootstrap.gii',
                        ),
			'class'=>'system.gii.GiiModule',
			'password'=>'123',
			// If removed, Gii defaults to localhost only. Edit carefully to taste.
			'ipFilters'=>array('127.0.0.1','::1'),
		),
                
            'administracion_usuario_administrador',
            'administracion_usuario',
            'administracion_rol_administrador',
            'administracion_rol_usuario',
            'escritorio_administrador',
            'cajita',
            'admin_aplicacion',
            'admin_aula',
            'admin_curricular',
            'admin_error_log_mensaje',
            'admin_escritorio',
            'admin_institucion',
            'admin_repositorio',
            'admin_rol_administrador',
            'admin_rol_usuario',
            'admin_usuario',
            'admin_usuario_administrador',


		
	),

	// application components
	'components'=>array(
                'Validar' => array(
                    'class'=>'application.components.Validar',
                ),
                'bootstrap'=>array(
                    'class'=>'bootstrap.components.Bootstrap',
                ),
                'authManager'=>array(
                    "class"=>"CDbAuthManager",
                    "connectionID"=>"db",
                    'itemTable'=>'authitem_permiso_administrador', // Tabla que contiene los elementos de autorizacion rol_institucion
                    'assignmentTable'=>'authassignment_administrador', // Tabla que contiene la asignacion usuario_rol_administrador
                    'itemChildTable'=>'authitemchild_administrador', // Tabla que contiene los elementos padre-hijo                    
                ),

		'user'=>array(
			// enable cookie-based authentication
			'allowAutoLogin'=>true,
		),

		// uncomment the following to enable URLs in path-format
		
		'urlManager'=>array(
                        'showScriptName'=>false,
			'urlFormat'=>'path',
			'rules'=>array(
				'<controller:\w+>/<id:\d+>'=>'<controller>/view',
				'<controller:\w+>/<action:\w+>/<id:\d+>'=>'<controller>/<action>',
				'<controller:\w+>/<action:\w+>'=>'<controller>/<action>',
			),
		),
		

		// database settings are configured in database.php
		'db'=>require(dirname(__FILE__).'/database.php'),

		'errorHandler'=>array(
			// use 'site/error' action to display errors
			'errorAction'=>'site/error',
		),

		'log'=>array(
			'class'=>'CLogRouter',
			'routes'=>array(
				array(
					'class'=>'CFileLogRoute',
					'levels'=>'error, warning',
				),
				// uncomment the following to show log messages on web pages
			
				array(
					'class'=>'CWebLogRoute',
				),
				
			),
		),

	),

	// application-level parameters that can be accessed
	// using Yii::app()->params['paramName']
	'params'=>array(
		// this is used in contact page
		'adminEmail'=>'webmaster@example.com',
	),
);
