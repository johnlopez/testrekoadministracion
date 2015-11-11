<?php

/**
 * This is the model class for table "seccion".
 *
 * The followings are the available columns in table 'seccion':
 * @property integer $id
 * @property string $nombre
 * @property string $jornada
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 * @property integer $modulo_id
 * @property integer $estado_seccion_id
 *
 * The followings are the available model relations:
 * @property Modulo $modulo
 * @property EstadoSeccion $estadoSeccion
 * @property Usuario[] $usuarios
 */
class Seccion extends CActiveRecord
{
	public $llaveIdSeccion;
        
	public function tableName()
	{
		return 'seccion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('modulo_id', 'required'),
			array('modulo_id, estado_seccion_id', 'numerical', 'integerOnly'=>true),
			array('nombre, jornada, descripcion', 'length', 'max'=>45),
			array('fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, jornada, descripcion, fecha_creacion, fecha_modificacion, modulo_id, estado_seccion_id', 'safe', 'on'=>'search'),
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
			'modulo' => array(self::BELONGS_TO, 'Modulo', 'modulo_id'),
			'estadoSeccion' => array(self::BELONGS_TO, 'EstadoSeccion', 'estado_seccion_id'),
			'usuarios' => array(self::MANY_MANY, 'Usuario', 'usuario_has_seccion(seccion_id, usuario_id)'),
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
			'jornada' => 'Jornada',
			'descripcion' => 'Descripcion',
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_modificacion' => 'Fecha Modificacion',
			'modulo_id' => 'Modulo',
			'estado_seccion_id' => 'Estado Seccion',
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
		$criteria->compare('jornada',$this->jornada,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('modulo_id',$this->modulo_id);
		$criteria->compare('estado_seccion_id',$this->estado_seccion_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Seccion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarSeccion($nombre,$jornada,$descripcion,$fechaCreacion,$moduloId,$estadoSeccionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_seccion(:nombre,:jornada,:descripcion,:moduloId,:estadoSeccionId,:fechaCreacion,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':jornada', $jornada);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':moduloId', $moduloId);
            $comando->bindParam(':estadoSeccionId', $estadoSeccionId);
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
            $comando->execute();
            $this->llaveIdSeccion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
         public function modificarSeccion($id,$nombre,$jornada,$descripcion,$fechaModificacion,$moduloId,$estadoSeccionId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_seccion(:id,:nombre,:jornada,:descripcion,:moduloId,:estadoSeccionId,:fechaModificacion)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':jornada', $jornada);
            $comando->bindParam(':descripcion', $descripcion);
             $comando->bindParam(':moduloId', $moduloId);
            $comando->bindParam(':estadoSeccionId', $estadoSeccionId);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->execute();
            return $comando;
        }
        
        public function eliminarLogicoSeccion($idSeccion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_eliminado_logico_seccion(:idSeccion)");
            $comando->bindParam(':idSeccion', $idSeccion);
            $comando->execute();
            return $comando;
        }
        
        public function listarSeccionesPorModulo($idModulo) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_secciones_por_modulo(:idModulo)");
            $comando->bindParam(':idModulo', $idModulo);
            return $comando->queryAll();
        }
        
        public function listarSeccionesPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_secciones_por_estado()");
            return $comando->queryAll();
        }
}
