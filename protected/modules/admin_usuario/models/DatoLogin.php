<?php

/**
 * This is the model class for table "dato_login".
 *
 * The followings are the available columns in table 'dato_login':
 * @property integer $id
 * @property integer $usuario_id
 * @property integer $codigo_seguridad_id
 *
 * The followings are the available model relations:
 * @property CodigoSeguridad $codigoSeguridad
 * @property Usuario $usuario
 * @property PreguntaLogin[] $preguntaLogins
 * @property RespuestaLogin[] $respuestaLogins
 */
class DatoLogin extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'dato_login';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id, codigo_seguridad_id', 'required'),
			array('usuario_id, codigo_seguridad_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, usuario_id, codigo_seguridad_id', 'safe', 'on'=>'search'),
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
			'codigoSeguridad' => array(self::BELONGS_TO, 'CodigoSeguridad', 'codigo_seguridad_id'),
			'usuario' => array(self::BELONGS_TO, 'Usuario', 'usuario_id'),
			'preguntaLogins' => array(self::MANY_MANY, 'PreguntaLogin', 'dato_login_has_pregunta_login(dato_login_id, pregunta_login_id)'),
			'respuestaLogins' => array(self::MANY_MANY, 'RespuestaLogin', 'dato_login_has_respuesta_login(dato_login_id, respuesta_login_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'usuario_id' => 'Usuario',
			'codigo_seguridad_id' => 'Codigo Seguridad',
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
		$criteria->compare('usuario_id',$this->usuario_id);
		$criteria->compare('codigo_seguridad_id',$this->codigo_seguridad_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return DatoLogin the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
