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
 */
class Entidad extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdEntidad;
        
        
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
        
        public function agregarEntidad($nombre,$descripcion,$fechaCreacion,$institucionId,$entidadId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_agregar_entidad(:nombre,:descripcion,:fechaCreacion,:institucionId,:entidadId,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
            $comando->bindParam(':institucionId', $institucionId);
            $comando->bindParam(':entidadId', $entidadId);
            $comando->execute();
            $this->llaveIdEntidad = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarEntidad($id,$nombre,$descripcion,$fechaModificacion,$institucionId,$entidadId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_actualizar_entidad(:id,:nombre,:descripcion,:fechaModificacion,:institucionId,:entidadId)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->bindParam(':institucionId', $institucionId);
            $comando->bindParam(':entidadId', $entidadId);
            $comando->execute();
            return $comando;
        }
        
        public function eliminarLogicoEntidad($idEntidad) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_eliminado_logico_entidad(:idEntidad)");
            $comando->bindParam(':idEntidad', $idEntidad);
            $comando->execute();
            return $comando;
        }
        
        public function listarEntidadPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_listar_entidad_por_estado()");
            return $comando->queryAll();
        }
        
        public function listaEntidadEntidad($idEntidad) {
            
            $command = Yii::app()->db->createCommand("CALL sp_admin_institucion_listar_entidad_entidad(:entidadId)");
            $command->bindParam(':entidadId',$idEntidad);	
            $resultado = $command->queryAll();        
            return $resultado;
        }
        
        public function asignaEntidadEntidad($listaEntidadEntidad,$entidadId) {
            $lista = implode(',', $listaEntidadEntidad);
            var_dump($lista);
            $listaLen = count($listaEntidadEntidad);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_institucion_asigna_entidad_entidad(:lista_programa_id,:lista_largo,:nuevo_entidad2_id)");
            $command->bindParam(':lista_programa_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_entidad2_id',$entidadId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaProgramaEntidad($listaEntidadEntidad,$entidadId) {
            $lista = implode(',', $listaEntidadEntidad);
            var_dump($lista);
            $listaLen = count($listaEntidadEntidad);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_institucion_desasigna_entidad_entidad(:lista_programa_id,:lista_largo,:nuevo_entidad2_id)");
            $command->bindParam(':lista_programa_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_entidad2_id',$entidadId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
