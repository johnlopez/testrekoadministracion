<?php

/**
 * This is the model class for table "usuario".
 *
 * The followings are the available columns in table 'usuario':
 * @property integer $id
 * @property string $usuario
 * @property string $clave
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 * @property string $fecha_creacion
 * @property integer $estado_usuario_id
 *
 * The followings are the available model relations:
 * @property DatoAcademico[] $datoAcademicos
 * @property DatoLaboral[] $datoLaborals
 * @property DatoLogin[] $datoLogins
 * @property DatoPersonal[] $datoPersonals
 * @property EstadoUsuario $estadoUsuario
 * @property UsuarioHasInstitucion[] $usuarioHasInstitucions
 * @property Modulo[] $modulos
 * @property ProgramaAcademico[] $programaAcademicos
 * @property RolUsuario[] $rolUsuarios
 * @property Seccion[] $seccions
 */
class Usuario extends CActiveRecord
{
        public $llaveIdUsuario;
      
	public function tableName()
	{
		return 'usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('estado_usuario_id', 'numerical', 'integerOnly'=>true),
                        array('usuario, clave', 'length', 'max'=>45),
			array('fecha_acceso, fecha_modificacion, fecha_creacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, usuario, clave, fecha_acceso, fecha_modificacion, fecha_creacion, estado_usuario_id', 'safe', 'on'=>'search'),
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
			'datoAcademicos' => array(self::HAS_MANY, 'DatoAcademico', 'usuario_id'),
			'datoLaborals' => array(self::HAS_MANY, 'DatoLaboral', 'usuario_id'),
			'datoLogins' => array(self::HAS_MANY, 'DatoLogin', 'usuario_id'),
			'datoPersonals' => array(self::HAS_MANY, 'DatoPersonal', 'usuario_id'),
			'estadoUsuario' => array(self::BELONGS_TO, 'EstadoUsuario', 'estado_usuario_id'),
			'usuarioHasInstitucions' => array(self::HAS_MANY, 'UsuarioHasInstitucion', 'usuario_id'),
			'modulos' => array(self::MANY_MANY, 'Modulo', 'usuario_has_modulo(usuario_id, modulo_id)'),
			'programaAcademicos' => array(self::MANY_MANY, 'ProgramaAcademico', 'usuario_has_programa_academico(usuario_id, programa_academico_id)'),
			'rolUsuarios' => array(self::MANY_MANY, 'RolUsuario', 'usuario_has_rol_usuario(usuario_id, rol_usuario_id)'),
			'seccions' => array(self::MANY_MANY, 'Seccion', 'usuario_has_seccion(usuario_id, seccion_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'usuario' => 'Usuario',
			'clave' => 'Clave',
			'fecha_acceso' => 'Fecha Acceso',
			'fecha_modificacion' => 'Fecha Modificacion',
			'fecha_creacion' => 'Fecha Creacion',
			'estado_usuario_id' => 'Estado Usuario',
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
		$criteria->compare('usuario',$this->usuario,true);
		$criteria->compare('clave',$this->clave,true);
		$criteria->compare('fecha_acceso',$this->fecha_acceso,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('estado_usuario_id',$this->estado_usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Usuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarUsuario($usuario,$clave,$fechaCreacion,$estadoUsuarioId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_usuario(:usuario,:clave,:fechaCreacion,:estadoUsuarioId,@llave_id)");
            $comando->bindParam(':usuario', $usuario);
            $comando->bindParam(':clave', $clave);
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
            $comando->bindParam(':estadoUsuarioId', $estadoUsuarioId);
            $comando->execute();
            $this->llaveIdUsuario = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarUsuario($id,$usuario,$clave,$fechaModificacion,$estadoUsuarioId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_actualizar_usuario(:id,:usuario,:clave,:fechaModificacion,:estadoUsuarioId)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':usuario', $usuario);
            $comando->bindParam(':clave', $clave);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->bindParam(':estadoUsuarioId', $estadoUsuarioId);
            $comando->execute();
            return $comando;
        }
        
        public function cargarUsuarios($tempLoc) {
            
            $comando = Yii::app()->db->createCommand(
                    "LOAD DATA LOCAL INFILE '".addslashes($tempLoc)."'
                    INTO TABLE usuario
                    FIELDS TERMINATED BY ','
                    LINES TERMINATED BY '\r\n'  
                    (usuario,clave,fecha_acceso,fecha_modificacion,fecha_creacion)"); 
            
            $comando->execute();
        }
        
        public function eliminarLogico($idUsuario) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_eliminado_logico_usuario(:idUsuario)");
            $comando->bindParam(':idUsuario', $idUsuario);
            $comando->execute();
            return $comando;
        }
        
        public function listarPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_listar_usuarios_por_estado()");
            return $comando->queryAll();
        }
        
}
