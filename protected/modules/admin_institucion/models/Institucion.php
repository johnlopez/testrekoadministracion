<?php

/**
 * This is the model class for table "institucion".
 *
 * The followings are the available columns in table 'institucion':
 * @property integer $id
 * @property string $nombre
 * @property string $vision
 * @property string $mision
 * @property integer $acreditada
 * @property string $fecha_inicio_acreditacion
 * @property string $fecha_termino_acreditacion
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 *
 * The followings are the available model relations:
 * @property Entidad[] $entidads
 */
class Institucion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdInstitucion;
        
	public function tableName()
	{
		return 'institucion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('acreditada', 'numerical', 'integerOnly'=>true),
			array('nombre, vision, mision, descripcion', 'length', 'max'=>45),
			array('fecha_inicio_acreditacion, fecha_termino_acreditacion, fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, vision, mision, acreditada, fecha_inicio_acreditacion, fecha_termino_acreditacion, descripcion, fecha_creacion, fecha_modificacion', 'safe', 'on'=>'search'),
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
			'entidads' => array(self::HAS_MANY, 'Entidad', 'institucion_id'),
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
			'vision' => 'Vision',
			'mision' => 'Mision',
			'acreditada' => 'Acreditada',
			'fecha_inicio_acreditacion' => 'Fecha Inicio Acreditacion',
			'fecha_termino_acreditacion' => 'Fecha Termino Acreditacion',
			'descripcion' => 'Descripcion',
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
		$criteria->compare('vision',$this->vision,true);
		$criteria->compare('mision',$this->mision,true);
		$criteria->compare('acreditada',$this->acreditada);
		$criteria->compare('fecha_inicio_acreditacion',$this->fecha_inicio_acreditacion,true);
		$criteria->compare('fecha_termino_acreditacion',$this->fecha_termino_acreditacion,true);
		$criteria->compare('descripcion',$this->descripcion,true);
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
	 * @return Institucion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarInstitucion($nombre,$vision,$mision,$acreditada,$fechaInicioAcreditacion,$fechaTerminoAcreditacion,$descripcion,$fechaCreacion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_agregar_institucion(:nuevo_nombre,:nuevo_vision,:nuevo_mision,:nuevo_acreditada,:nuevo_fecha_inicio_acreditacion,:nuevo_fecha_termino_acreditacion,:nuevo_descripcion,:nuevo_fecha_creacion,@llave_id)");
            $comando->bindParam('nuevo_nombre', $nombre);
            $comando->bindParam('nuevo_vision', $vision);
            $comando->bindParam('nuevo_mision', $mision);
            $comando->bindParam('nuevo_acreditada', $acreditada);
            $comando->bindParam('nuevo_fecha_inicio_acreditacion', $fechaInicioAcreditacion);
            $comando->bindParam('nuevo_fecha_termino_acreditacion', $fechaTerminoAcreditacion);
            $comando->bindParam('nuevo_descripcion', $descripcion);
            $comando->bindParam('nuevo_fecha_creacion', $fechaCreacion);
            $comando->execute();
            $this->llaveIdInstitucion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarInstitucion($id,$nombre,$vision,$mision,$acreditada,$fechaInicioAcreditacion,$fechaTerminoAcreditacion,$descripcion,$fechaModificacion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_actualizar_institucion(:id,:nuevo_nombre,:nuevo_vision,:nuevo_mision,:nuevo_acreditada,:nuevo_fecha_inicio_acreditacion,:nuevo_fecha_termino_acreditacion,:nuevo_descripcion,:nuevo_fecha_modificacion)");
            $comando->bindParam('id', $id);
            $comando->bindParam('nuevo_nombre', $nombre);
            $comando->bindParam('nuevo_vision', $vision);
            $comando->bindParam('nuevo_mision', $mision);
            $comando->bindParam('nuevo_acreditada', $acreditada);
            $comando->bindParam('nuevo_fecha_inicio_acreditacion', $fechaInicioAcreditacion);
            $comando->bindParam('nuevo_fecha_termino_acreditacion', $fechaTerminoAcreditacion);
            $comando->bindParam('nuevo_descripcion', $descripcion);
            $comando->bindParam('nuevo_fecha_modificacion', $fechaModificacion);
            $comando->execute();
            $this->llaveIdInstitucion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function eliminarLogicoInstitucion($idInstitucion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_eliminado_logico_institucion(:idInstitucion)");
            $comando->bindParam(':idInstitucion', $idInstitucion);
            $comando->execute();
            return $comando;
        }
        
        public function listarInstitucionPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_listar_institucion_por_estado()");
            return $comando->queryAll();
        }
}
