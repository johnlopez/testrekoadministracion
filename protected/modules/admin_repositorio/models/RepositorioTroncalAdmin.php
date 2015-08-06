<?php

/**
 * This is the model class for table "repositorio_troncal_admin".
 *
 * The followings are the available columns in table 'repositorio_troncal_admin':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 * @property string $fecha_creacion
 * @property integer $modelo_aprendizaje_id
 *
 * The followings are the available model relations:
 * @property ModeloAprendizaje $modeloAprendizaje
 */
class RepositorioTroncalAdmin extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'repositorio_troncal_admin';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('modelo_aprendizaje_id', 'numerical', 'integerOnly'=>true),
			array('nombre, descripcion', 'length', 'max'=>45),
			array('fecha_acceso, fecha_modificacion, fecha_creacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, fecha_acceso, fecha_modificacion, fecha_creacion, modelo_aprendizaje_id', 'safe', 'on'=>'search'),
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
			'modeloAprendizaje' => array(self::BELONGS_TO, 'ModeloAprendizaje', 'modelo_aprendizaje_id'),
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
			'fecha_acceso' => 'Fecha Acceso',
			'fecha_modificacion' => 'Fecha Modificacion',
			'fecha_creacion' => 'Fecha Creacion',
			'modelo_aprendizaje_id' => 'Modelo Aprendizaje',
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
		$criteria->compare('fecha_acceso',$this->fecha_acceso,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('modelo_aprendizaje_id',$this->modelo_aprendizaje_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RepositorioTroncalAdmin the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
