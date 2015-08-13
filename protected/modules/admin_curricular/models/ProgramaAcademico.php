<?php

/**
 * This is the model class for table "programa_academico".
 *
 * The followings are the available columns in table 'programa_academico':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $version
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 *
 * The followings are the available model relations:
 * @property Modulo[] $modulos
 */
class ProgramaAcademico extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
        public $llaveIdPrograma;
        
	public function tableName()
	{
		return 'programa_academico';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, descripcion, version', 'length', 'max'=>45),
			array('fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, version, fecha_creacion, fecha_modificacion', 'safe', 'on'=>'search'),
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
			'modulos' => array(self::MANY_MANY, 'Modulo', 'programa_academico_has_modulo(programa_academico_id, modulo_id)'),
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
			'version' => 'Version',
			'fecha_creacion' => 'Fecha Creacion',
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
		$criteria->compare('version',$this->version,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ProgramaAcademico the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarProgramaAcademico($nombre,$descripcion,$version,$fechaCreacion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_programa_academico(:nombre,:descripcion,:version,:fechaCreacion,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':version', $version);
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
            $comando->execute();
            $this->llaveIdPrograma = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarProgramaAcademico($id,$nombre,$descripcion,$version,$fechaModificacion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_programa_academico(:id,:nombre,:descripcion,:version,:fechaModificacion)");
            $comando->bindParam('id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':version', $version);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->execute();
            return $comando;
        }
        
}
