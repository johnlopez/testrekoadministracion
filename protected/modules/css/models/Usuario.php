<?php

/**
 * This is the model class for table "usuario".
 *
 * The followings are the available columns in table 'usuario':
 * @property integer $id
 * @property string $usuario
 * @property string $clave
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 * @property string $fecha_creacion
 *
 * The followings are the available model relations:
 * @property DatoAcademico[] $datoAcademicos
 * @property DatoLaboral[] $datoLaborals
 * @property DatoLogin[] $datoLogins
 * @property DatoPersonal[] $datoPersonals
 * @property EscritorioUsuario[] $escritorioUsuarios
 * @property EstadoUsuario[] $estadoUsuarios
 * @property UsuarioHasInstitucion[] $usuarioHasInstitucions
 * @property RolUsuario[] $rolUsuarios
 */
class Usuario extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario, clave', 'length', 'max'=>45),
			array('fecha_acceso, fecha_modificacion, fecha_creacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, usuario, clave, fecha_acceso, fecha_modificacion, fecha_creacion', 'safe', 'on'=>'search'),
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
			'datoAcademicos' => array(self::HAS_MANY, 'DatoAcademico', 'usuario_id'),
			'datoLaborals' => array(self::HAS_MANY, 'DatoLaboral', 'usuario_id'),
			'datoLogins' => array(self::HAS_MANY, 'DatoLogin', 'usuario_id'),
			'datoPersonals' => array(self::HAS_MANY, 'DatoPersonal', 'usuario_id'),
			'escritorioUsuarios' => array(self::HAS_MANY, 'EscritorioUsuario', 'usuario_id'),
			'estadoUsuarios' => array(self::HAS_MANY, 'EstadoUsuario', 'usuario_id'),
			'usuarioHasInstitucions' => array(self::HAS_MANY, 'UsuarioHasInstitucion', 'usuario_id'),
			'rolUsuarios' => array(self::MANY_MANY, 'RolUsuario', 'usuario_has_rol_usuario(usuario_id, rol_usuario_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'usuario' => 'Usuario',
			'clave' => 'Clave',
			'fecha_acceso' => 'Fecha Acceso',
			'fecha_modificacion' => 'Fecha Modificacion',
			'fecha_creacion' => 'Fecha Creacion',
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
		$criteria->compare('usuario',$this->usuario,true);
		$criteria->compare('clave',$this->clave,true);
		$criteria->compare('fecha_acceso',$this->fecha_acceso,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Usuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
