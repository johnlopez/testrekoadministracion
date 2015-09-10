<?php

/**
 * This is the model class for table "entidad".
 *
 * The followings are the available columns in table 'entidad':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 * @property integer $institucion_id
 * @property integer $entidad_id
 *
 * The followings are the available model relations:
 * @property Entidad $entidad
 * @property Entidad[] $entidads
 * @property Institucion $institucion
 * @property ProgramaAcademico[] $programaAcademicos
 */
class Entidad extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'entidad';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('institucion_id', 'required'),
			array('institucion_id, entidad_id', 'numerical', 'integerOnly'=>true),
			array('nombre, descripcion', 'length', 'max'=>45),
			array('fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, fecha_creacion, fecha_modificacion, institucion_id, entidad_id', 'safe', 'on'=>'search'),
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
			'entidad' => array(self::BELONGS_TO, 'Entidad', 'entidad_id'),
			'entidads' => array(self::HAS_MANY, 'Entidad', 'entidad_id'),
			'institucion' => array(self::BELONGS_TO, 'Institucion', 'institucion_id'),
			'programaAcademicos' => array(self::MANY_MANY, 'ProgramaAcademico', 'programa_academico_has_entidad(entidad_id, programa_academico_id)'),
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
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_modificacion' => 'Fecha Modificacion',
			'institucion_id' => 'Institucion',
			'entidad_id' => 'Entidad',
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
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('institucion_id',$this->institucion_id);
		$criteria->compare('entidad_id',$this->entidad_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Entidad the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listarEntidadPorInstitucion($idInstitucion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_listar_entidad_por_institucion(:idInstitucion)");
            $comando->bindParam(':idInstitucion', $idInstitucion);
            return $comando->queryAll();
        }
        
        public function listarEntidadPorEntidad($idEntidad) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_listar_entidad_entidad(:idEntidad)");
            $comando->bindParam(':idEntidad', $idEntidad);
            return $comando->queryAll();
        }
}
