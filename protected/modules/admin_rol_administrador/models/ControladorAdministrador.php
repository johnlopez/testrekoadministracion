<?php

/**
 * This is the model class for table "controlador_administrador".
 *
 * The followings are the available columns in table 'controlador_administrador':
 * @property integer $id
 * @property string $nombre
 * @property string $authitem_permiso_administrador_name
 *
 * The followings are the available model relations:
 * @property AuthitemPermisoAdministrador $authitemPermisoAdministradorName
 * @property PrivilegioAdministrador[] $privilegioAdministradors
 */
class ControladorAdministrador extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'controlador_administrador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('authitem_permiso_administrador_name', 'required'),
			array('nombre', 'length', 'max'=>45),
			array('authitem_permiso_administrador_name', 'length', 'max'=>64),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, authitem_permiso_administrador_name', 'safe', 'on'=>'search'),
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
			'authitemPermisoAdministradorName' => array(self::BELONGS_TO, 'AuthitemPermisoAdministrador', 'authitem_permiso_administrador_name'),
			'privilegioAdministradors' => array(self::HAS_MANY, 'PrivilegioAdministrador', 'controlador_administrador_id'),
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
			'authitem_permiso_administrador_name' => 'Authitem Permiso Administrador Name',
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
		$criteria->compare('authitem_permiso_administrador_name',$this->authitem_permiso_administrador_name,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ControladorAdministrador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
