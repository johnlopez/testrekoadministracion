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
 * @property integer $entidad_id
 * @property integer $institucion_id
 * @property integer $estado_programa_academico_id
 *
 * The followings are the available model relations:
 * @property Entidad $entidad
 * @property EstadoProgramaAcademico $estadoProgramaAcademico
 * @property Institucion $institucion
 * @property Modulo[] $modulos
 * @property UsuarioHasProgramaAcademico[] $usuarioHasProgramaAcademicos
 */
class ProgramaAcademico extends CActiveRecord
{
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
			array('entidad_id, institucion_id, estado_programa_academico_id', 'numerical', 'integerOnly'=>true),
			array('nombre, descripcion, version', 'length', 'max'=>45),
			array('fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, version, fecha_creacion, fecha_modificacion, entidad_id, institucion_id, estado_programa_academico_id', 'safe', 'on'=>'search'),
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
			'estadoProgramaAcademico' => array(self::BELONGS_TO, 'EstadoProgramaAcademico', 'estado_programa_academico_id'),
			'institucion' => array(self::BELONGS_TO, 'Institucion', 'institucion_id'),
			'modulos' => array(self::MANY_MANY, 'Modulo', 'programa_academico_has_modulo(programa_academico_id, modulo_id)'),
			'usuarioHasProgramaAcademicos' => array(self::HAS_MANY, 'UsuarioHasProgramaAcademico', 'programa_academico_id'),
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
			'entidad_id' => 'Entidad',
			'institucion_id' => 'Institucion',
			'estado_programa_academico_id' => 'Estado Programa Academico',
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
		$criteria->compare('entidad_id',$this->entidad_id);
		$criteria->compare('institucion_id',$this->institucion_id);
		$criteria->compare('estado_programa_academico_id',$this->estado_programa_academico_id);

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
        
        public function agregarProgramaAcademico($nombre,$descripcion,$version,$entidadId,$institucionId,$estadoProgramaId,$fechaCreacion) {
            
            try{    
                $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_programa_academico(:nombre,:descripcion,:version,:entidadId,:institucionId,:nuevoEstadoProgramaId,:fechaCreacion,@llave_id)");
                $comando->bindParam(':nombre', $nombre);
                $comando->bindParam(':descripcion', $descripcion);
                $comando->bindParam(':version', $version);
                $comando->bindParam(':entidadId', $entidadId);
                $comando->bindParam(':institucionId', $institucionId);
                $comando->bindParam(':nuevoEstadoProgramaId', $estadoProgramaId);
                $comando->bindParam(':fechaCreacion', $fechaCreacion);
                //$comando->bindParam(':institucionId', $institucionId);
                $comando->execute();
                $this->llaveIdPrograma = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
                return $comando;
            }
            catch (Exception $e){
                $e->getMessage();
                echo 'Error al agregar el programa academico';
            }
        }
        
        public function modificarProgramaAcademico($id,$nombre,$descripcion,$version,$entidadId,$institucionId,$estadoProgramaId,$fechaModificacion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_programa_academico(:id,:nombre,:descripcion,:version,:entidadId,:institucionId,:nuevoEstadoProgramaId,:fechaModificacion)");
            $comando->bindParam('id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':version', $version);
            $comando->bindParam(':entidadId', $entidadId);
            $comando->bindParam(':institucionId', $institucionId);
            $comando->bindParam(':nuevoEstadoProgramaId', $estadoProgramaId);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->execute();
            return $comando;
        }
        
        public function listaEntidadProgrma($idEntidad) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_lista_entidad_programa(:nuevo_entidad_id)");
            $command->bindParam(':nuevo_entidad_id',$idEntidad);    
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaProgramaEntidad($listaEntidadPrograma,$entidadId) {
            $lista = implode(',', $listaEntidadPrograma);
            var_dump($lista);
            $listaLen = count($listaEntidadPrograma);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_programa_entidad(:lista_programa_id,:lista_largo,:nuevo_entidad_id)");
            $command->bindParam(':lista_programa_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_entidad_id',$entidadId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaProgramaEntidad($listaEntidadPrograma,$entidadId) {
            $lista = implode(',', $listaEntidadPrograma);
            var_dump($lista);
            $listaLen = count($listaEntidadPrograma);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_programa_entidad(:lista_programa_id,:lista_largo,:nuevo_entidad_id)");
            $command->bindParam(':lista_programa_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_entidad_id',$entidadId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function listaInstitucionProgrma($idInstitucion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_lista_institucion_programa(:nuevo_institucion_id)");
            $command->bindParam(':nuevo_institucion_id',$idInstitucion);    
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaProgramaInstitucion($listaInstitucionPrograma,$institucionId) {
            $lista = implode(',', $listaInstitucionPrograma);
            var_dump($lista);
            $listaLen = count($listaInstitucionPrograma);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_programa_institucion(:lista_programa_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_programa_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaProgramaInstitucion($listaInstitucionPrograma,$institucionId) {
            $lista = implode(',', $listaInstitucionPrograma);
            var_dump($lista);
            $listaLen = count($listaInstitucionPrograma);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_programa_institucion(:lista_programa_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_programa_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function eliminarLogicoProgramaAcademico($idPrograma) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_eliminado_logico_programa_academico(:idPrograma)");
            $comando->bindParam(':idPrograma', $idPrograma);
            $comando->execute();
            return $comando;
        }
        
        public function listarProgramasAcademicosPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_programas_academicos_por_estado()");
            return $comando->queryAll();
        }
        
        public function listarProgramasPorInstitucion($id) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_programas_por_institucion(:id)");
            $comando->bindParam(':id', $id);
            return $comando->queryAll();
        }
}
