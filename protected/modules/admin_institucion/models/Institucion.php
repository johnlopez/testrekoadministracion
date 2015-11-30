<?php

/**
 * This is the model class for table "institucion".
 *
 * The followings are the available columns in table 'institucion':
 * @property integer $id
 * @property string $nombre
 * @property string $sigla
 * @property string $vision
 * @property string $mision
 * @property integer $acreditada
 * @property string $fecha_inicio_acreditacion
 * @property string $fecha_termino_acreditacion
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 * @property integer $estado_institucion_id
 * @property integer $pais_id
 * @property integer $region_id
 *
 * The followings are the available model relations:
 * @property Entidad[] $entidads
 * @property Pais $pais
 * @property Region $region
 * @property EstadoInstitucion $estadoInstitucion
 * @property Repositorio[] $repositorios
 * @property RolUsuario[] $rolUsuarios
 * @property Modulo[] $modulos
 * @property ProgramaAcademico[] $programaAcademicos
 * @property UsuarioHasInstitucion[] $usuarioHasInstitucions
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
			array('acreditada, estado_institucion_id, pais_id, region_id', 'numerical', 'integerOnly'=>true),
			array('nombre, sigla', 'length', 'max'=>45),
			array('vision, mision, fecha_inicio_acreditacion, fecha_termino_acreditacion, descripcion, fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, sigla, vision, mision, acreditada, fecha_inicio_acreditacion, fecha_termino_acreditacion, descripcion, fecha_creacion, fecha_modificacion, estado_institucion_id, pais_id, region_id', 'safe', 'on'=>'search'),
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
			//'pais' => array(self::BELONGS_TO, 'Pais', 'pais_id'),
			//'region' => array(self::BELONGS_TO, 'Region', 'region_id'),
			//'estadoInstitucion' => array(self::BELONGS_TO, 'EstadoInstitucion', 'estado_institucion_id'),
			'repositorios' => array(self::MANY_MANY, 'Repositorio', 'institucion_has_repositorio(institucion_id, repositorio_id)'),
			'rolUsuarios' => array(self::MANY_MANY, 'RolUsuario', 'institucion_has_rol_usuario(institucion_id, rol_usuario_id)'),
			'modulos' => array(self::HAS_MANY, 'Modulo', 'institucion_id'),
			'programaAcademicos' => array(self::HAS_MANY, 'ProgramaAcademico', 'institucion_id'),
			'usuarioHasInstitucions' => array(self::HAS_MANY, 'UsuarioHasInstitucion', 'institucion_id'),
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
			'sigla' => 'Sigla',
			'vision' => 'Vision',
			'mision' => 'Mision',
			'acreditada' => 'Acreditada',
			'fecha_inicio_acreditacion' => 'Fecha Inicio Acreditacion',
			'fecha_termino_acreditacion' => 'Fecha Termino Acreditacion',
			'descripcion' => 'Descripcion',
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_modificacion' => 'Fecha Modificacion',
			'estado_institucion_id' => 'Estado Institucion',
			'pais_id' => 'Pais',
			'region_id' => 'Region',
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
		$criteria->compare('sigla',$this->sigla,true);
		$criteria->compare('vision',$this->vision,true);
		$criteria->compare('mision',$this->mision,true);
		$criteria->compare('acreditada',$this->acreditada);
		$criteria->compare('fecha_inicio_acreditacion',$this->fecha_inicio_acreditacion,true);
		$criteria->compare('fecha_termino_acreditacion',$this->fecha_termino_acreditacion,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('estado_institucion_id',$this->estado_institucion_id);
		$criteria->compare('pais_id',$this->pais_id);
		$criteria->compare('region_id',$this->region_id);

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
        
        public function listarInstitucionPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_listar_institucion_por_estado()");
            return $comando->queryAll();
        }
        
        public function agregarInstitucion($nombre,$sigla,$vision,$mision,$acreditada,$fechaInicioAcreditacion,$fechaTerminoAcreditacion,$descripcion,
                $fechaCreacion,$estadoId,$paisId,$regionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_agregar_institucion(:nombre,:sigla,:vision,:mision,:acreditada,:fecha_inicio_acreditacion,:fecha_termino_acreditacion,:descripcion,:fecha_creacion,:estado_id,:pais_id,:region_id,@llave_id)");
            
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':sigla', $sigla);
            $comando->bindParam(':vision', $vision);
            $comando->bindParam(':mision', $mision);
            $comando->bindParam(':acreditada', $acreditada);
            $comando->bindParam(':fecha_inicio_acreditacion', $fechaInicioAcreditacion);
            $comando->bindParam(':fecha_termino_acreditacion', $fechaTerminoAcreditacion);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fecha_creacion', $fechaCreacion);
            $comando->bindParam(':estado_id', $estadoId);
            $comando->bindParam(':pais_id', $paisId);
            $comando->bindParam(':region_id', $regionId);
            $comando->execute();
            $this->llaveIdInstitucion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarInstitucion($id,$nombre,$sigla,$vision,$mision,$acreditada,$fechaInicioAcreditacion,$fechaTerminoAcreditacion,$descripcion,
                $fechaModificacion,$estadoId,$paisId,$regionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_actualizar_institucion(:id,:nombre,:sigla,:vision,:mision,:acreditada,:fecha_inicio_acreditacion,:fecha_termino_acreditacion,:descripcion,:fecha_modificacion,:estado_id,:pais_id,:region_id)");
            
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':sigla', $sigla);
            $comando->bindParam(':vision', $vision);
            $comando->bindParam(':mision', $mision);
            $comando->bindParam(':acreditada', $acreditada);
            $comando->bindParam(':fecha_inicio_acreditacion', $fechaInicioAcreditacion);
            $comando->bindParam(':fecha_termino_acreditacion', $fechaTerminoAcreditacion);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fecha_modificacion', $fechaModificacion);
            $comando->bindParam(':estado_id', $estadoId);
            $comando->bindParam(':pais_id', $paisId);
            $comando->bindParam(':region_id', $regionId);
            $comando->execute();
            return $comando;
        }
        
        public function eliminarLogicoInstitucion($idInstitucion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_institucion_eliminado_logico_institucion(:idInstitucion)");
            $comando->bindParam(':idInstitucion', $idInstitucion);
            $comando->execute();
            return $comando;
        }
}
