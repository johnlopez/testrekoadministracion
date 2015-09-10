<?php

/**
 * This is the model class for table "repositorio".
 *
 * The followings are the available columns in table 'repositorio':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 * @property string $fecha_creacion
 * @property integer $modelo_aprendizaje_id
 * @property integer $tipo_repositorio_id
 * @property integer $repositorio_id
 *
 * The followings are the available model relations:
 * @property ModeloAprendizaje $modeloAprendizaje
 * @property TipoRepositorio $tipoRepositorio
 * @property Repositorio $repositorio
 * @property Repositorio[] $repositorios
 * @property Herramienta[] $herramientas
 */
class Repositorio extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'repositorio';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('modelo_aprendizaje_id, tipo_repositorio_id, repositorio_id', 'numerical', 'integerOnly'=>true),
			array('nombre, descripcion', 'length', 'max'=>45),
			array('fecha_acceso, fecha_modificacion, fecha_creacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, fecha_acceso, fecha_modificacion, fecha_creacion, modelo_aprendizaje_id, tipo_repositorio_id, repositorio_id', 'safe', 'on'=>'search'),
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
			'tipoRepositorio' => array(self::BELONGS_TO, 'TipoRepositorio', 'tipo_repositorio_id'),
			'repositorio' => array(self::BELONGS_TO, 'Repositorio', 'repositorio_id'),
			'repositorios' => array(self::HAS_MANY, 'Repositorio', 'repositorio_id'),
			'herramientas' => array(self::MANY_MANY, 'Herramienta', 'repositorio_has_herramienta(repositorio_id, herramienta_id)'),
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
			'tipo_repositorio_id' => 'Tipo Repositorio',
			'repositorio_id' => 'Repositorio',
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
		$criteria->compare('tipo_repositorio_id',$this->tipo_repositorio_id);
		$criteria->compare('repositorio_id',$this->repositorio_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Repositorio the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
