<?php

/**
 * This is the model class for table "modulo".
 *
 * The followings are the available columns in table 'modulo':
 * @property integer $id
 * @property string $nombre
 * @property string $codigo
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 * @property integer $estado_modulo_id
 * @property integer $entidad_id
 * @property integer $institucion_id
 *
 * The followings are the available model relations:
 * @property Entidad $entidad
 * @property EstadoModulo $estadoModulo
 * @property Institucion $institucion
 * @property ProgramaAcademico[] $programaAcademicos
 * @property Seccion[] $seccions
 * @property UsuarioHasModulo[] $usuarioHasModulos
 */
class Modulo extends CActiveRecord
{
	public $llaveIdModulo;
        
	public function tableName()
	{
		return 'modulo';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('estado_modulo_id, entidad_id, institucion_id', 'numerical', 'integerOnly'=>true),
			array('nombre, codigo, descripcion', 'length', 'max'=>45),
			array('fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, codigo, descripcion, fecha_creacion, fecha_modificacion, estado_modulo_id, entidad_id, institucion_id', 'safe', 'on'=>'search'),
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
			'estadoModulo' => array(self::BELONGS_TO, 'EstadoModulo', 'estado_modulo_id'),
			'institucion' => array(self::BELONGS_TO, 'Institucion', 'institucion_id'),
			'programaAcademicos' => array(self::MANY_MANY, 'ProgramaAcademico', 'programa_academico_has_modulo(modulo_id, programa_academico_id)'),
			'seccions' => array(self::HAS_MANY, 'Seccion', 'modulo_id'),
			'usuarioHasModulos' => array(self::HAS_MANY, 'UsuarioHasModulo', 'modulo_id'),
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
			'descripcion' => 'Descripcion',
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_modificacion' => 'Fecha Modificacion',
			'estado_modulo_id' => 'Estado Modulo',
			'entidad_id' => 'Entidad',
			'institucion_id' => 'Institucion',
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
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('estado_modulo_id',$this->estado_modulo_id);
		$criteria->compare('entidad_id',$this->entidad_id);
		$criteria->compare('institucion_id',$this->institucion_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Modulo the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarModulo($nombre,$codigo,$descripcion,$fechaCreacion,$estadoModuloId,$entidadId,$institucionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_modulo(:nombre,:codigo,:descripcion,:fechaCreacion,:estadoModuloId,:entidadId,:institucionId,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
            $comando->bindParam(':estadoModuloId', $estadoModuloId);
            $comando->bindParam(':entidadId', $entidadId);
            $comando->bindParam(':institucionId', $institucionId);
            $comando->execute();
            $this->llaveIdModulo = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarModulo($id,$nombre,$codigo,$descripcion,$fechaModificacion,$estadoModuloId,$entidadId,$institucionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_modulo(:id,:nombre,:codigo,:descripcion,:fechaModificacion,:estadoModuloId,:entidadId,:institucionId)");
            $comando->bindParam('id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->bindParam(':estadoModuloId', $estadoModuloId);
            $comando->bindParam(':entidadId', $entidadId);
            $comando->bindParam(':institucionId', $institucionId);
            $comando->execute();
            return $comando;
        }
        
        public function eliminarLogicoModulo($idModulo) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_eliminado_logico_modulo(:idModulo)");
            $comando->bindParam(':idModulo', $idModulo);
            $comando->execute();
            return $comando;
        }
        
        public function listaEntidadModulo($idEntidad) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_lista_entidad_modulo(:nuevo_entidad_id)");
            $command->bindParam(':nuevo_entidad_id',$idEntidad);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaModuloEntidad($listaEntidadModulo,$entidadId) {
            $lista = implode(',', $listaEntidadModulo);
            var_dump($lista);
            $listaLen = count($listaEntidadModulo);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_modulo_entidad(:lista_modulo_id,:lista_largo,:nuevo_entidad_id)");
            $command->bindParam(':lista_modulo_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_entidad_id',$entidadId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaModuloEntidad($listaEntidadModulo,$entidadId) {
            $lista = implode(',', $listaEntidadModulo);
            var_dump($lista);
            $listaLen = count($listaEntidadModulo);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_modulo_entidad(:lista_modulo_id,:lista_largo,:nuevo_entidad_id)");
            $command->bindParam(':lista_modulo_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_entidad_id',$entidadId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function listaInstitucionModulo($idInstitucion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_lista_institucion_modulo(:nuevo_institucion_id)");
            $command->bindParam(':nuevo_institucion_id',$idInstitucion);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaModuloInstitucion($listaInstitucionModulo,$institucionId) {
            $lista = implode(',', $listaInstitucionModulo);
            var_dump($lista);
            $listaLen = count($listaInstitucionModulo);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_modulo_institucion(:lista_modulo_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_modulo_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaModuloInstitucion($listaInstitucionModulo,$institucionId) {
            $lista = implode(',', $listaInstitucionModulo);
            var_dump($lista);
            $listaLen = count($listaInstitucionModulo);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_modulo_institucion(:lista_modulo_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_modulo_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function listarModulosPorInstitucion($idInstitucion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_modulos_por_institucion(:idInstitucion)");
            $comando->bindParam(':idInstitucion', $idInstitucion);
            return $comando->queryAll();
        }
        
        public function listarModulosPorPrograma($idPrograma) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_modulos_por_programa(:idPrograma)");
            $comando->bindParam(':idPrograma', $idPrograma);
            return $comando->queryAll();
        }
        
        public function listarModulosPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_modulos_por_estado()");
            return $comando->queryAll();
        }
        
        public function listarContratoModulo($idModulo) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_contrato_modulo(:idModulo)");
            $comando->bindParam(':idModulo', $idModulo);
            return $comando->queryAll();
        }
        
        public function aceptarContrato($contratoFichaTecnica,$moduloId,$programaAcademicoId,$usuarioId,$institucionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_aceptar_contrato(:contratoFichaTecnica,:moduloId,:programaAcademicoId,:usuarioId,:institucionId)");
            $comando->bindParam(':contratoFichaTecnica', $contratoFichaTecnica);
            $comando->bindParam(':moduloId', $moduloId);
            $comando->bindParam(':programaAcademicoId', $programaAcademicoId);
            $comando->bindParam(':usuarioId', $usuarioId);
            $comando->bindParam(':institucionId', $institucionId);
            $comando->execute();
        }
}
