<?php

/**
 * This is the model class for table "rol_usuario".
 *
 * The followings are the available columns in table 'rol_usuario':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_eliminacion
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 *
 * The followings are the available model relations:
 * @property Institucion[] $institucions
 * @property AuthitemPermisoUsuario[] $authitemPermisoUsuarios
 * @property PrivilegioUsuario[] $privilegioUsuarios
 * @property Usuario[] $usuarios
 */
class RolUsuario extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'rol_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, descripcion,tipo', 'length', 'max'=>45),
			array('fecha_creacion, fecha_eliminacion, fecha_acceso, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, tipo, fecha_creacion, fecha_eliminacion, fecha_acceso, fecha_modificacion', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'institucions' => array(self::MANY_MANY, 'Institucion', 'institucion_has_rol_usuario(rol_usuario_id, institucion_id)'),
			'authitemPermisoUsuarios' => array(self::MANY_MANY, 'AuthitemPermisoUsuario', 'rol_usuario_has_authitem_permiso_usuario(rol_usuario_id, authitem_permiso_usuario_name)'),
			'privilegioUsuarios' => array(self::MANY_MANY, 'PrivilegioUsuario', 'rol_usuario_has_privilegio_usuario(rol_usuario_id, privilegio_usuario_id)'),
			'usuarios' => array(self::MANY_MANY, 'Usuario', 'usuario_has_rol_usuario(rol_usuario_id, usuario_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'nombre' => 'Nombre',
			'descripcion' => 'Descripcion',
                        'tipo' => 'Tipo',
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_eliminacion' => 'Fecha Eliminacion',
			'fecha_acceso' => 'Fecha Acceso',
			'fecha_modificacion' => 'Fecha Modificacion',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('nombre',$this->nombre,true);
		$criteria->compare('descripcion',$this->descripcion,true);
                $criteria->compare('tipo',$this->descripcion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_eliminacion',$this->fecha_eliminacion,true);
		$criteria->compare('fecha_acceso',$this->fecha_acceso,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RolUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listarRolUsuarioGeneral(){        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_listar_rol_usuario_general()");
            return $command->queryAll(); 
        }
}
