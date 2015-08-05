<?php

/**
 * This is the model class for table "pais".
 *
 * The followings are the available columns in table 'pais':
 * @property integer $id
 * @property string $nombre
 * @property string $codigo
 *
 * The followings are the available model relations:
 * @property DatoAcademico[] $datoAcademicos
 * @property DatoLaboral[] $datoLaborals
 * @property DatoPersonal[] $datoPersonals
 * @property Region[] $regions
 */
class Pais extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
        public $llaveIdPais;
        
	public function tableName()
	{
		return 'pais';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, codigo', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, codigo', 'safe', 'on'=>'search'),
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
			'datoAcademicos' => array(self::MANY_MANY, 'DatoAcademico', 'pais_has_dato_academico(pais_id, dato_academico_id)'),
			'datoLaborals' => array(self::MANY_MANY, 'DatoLaboral', 'pais_has_dato_laboral(pais_id, dato_laboral_id)'),
			'datoPersonals' => array(self::MANY_MANY, 'DatoPersonal', 'pais_has_dato_personal(pais_id, dato_personal_id)'),
			'regions' => array(self::HAS_MANY, 'Region', 'pais_id'),
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
			'codigo' => 'Codigo',
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
		$criteria->compare('codigo',$this->codigo,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Pais the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarPais($nombre,$codigo) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_administracionusuario_agregar_pais(:nombre,:codigo,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->execute();
            $this->llaveIdPais = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarPais($id,$nombre,$codigo) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_administracionusuario_actualizar_pais(:id,:nombre,:codigo)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->execute();
            return $comando;
        }
}
