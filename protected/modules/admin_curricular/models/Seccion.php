<?php

/**
 * This is the model class for table "seccion".
 *
 * The followings are the available columns in table 'seccion':
 * @property integer $id
 * @property string $nombre
 * @property string $codigo
 * @property string $jornada
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 * @property integer $estado_seccion_id
 * @property integer $modulo_id
 *
 * The followings are the available model relations:
 * @property EstadoSeccion $estadoSeccion
 * @property Modulo $modulo
 * @property UsuarioHasSeccion[] $usuarioHasSeccions
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
			array('estado_seccion_id, modulo_id', 'numerical', 'integerOnly'=>true),
			array('nombre, codigo, jornada', 'length', 'max'=>45),
			array('descripcion, fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, codigo, jornada, descripcion, fecha_creacion, fecha_modificacion, estado_seccion_id, modulo_id', 'safe', 'on'=>'search'),
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
			'estadoSeccion' => array(self::BELONGS_TO, 'EstadoSeccion', 'estado_seccion_id'),
			'modulo' => array(self::BELONGS_TO, 'Modulo', 'modulo_id'),
			'usuarioHasSeccions' => array(self::HAS_MANY, 'UsuarioHasSeccion', 'seccion_id'),
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
			'jornada' => 'Jornada',
			'descripcion' => 'Descripcion',
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_modificacion' => 'Fecha Modificacion',
			'estado_seccion_id' => 'Estado Seccion',
			'modulo_id' => 'Modulo',
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
		$criteria->compare('jornada',$this->jornada,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('estado_seccion_id',$this->estado_seccion_id);
		$criteria->compare('modulo_id',$this->modulo_id);

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
        
        public function agregarSeccion($nombre,$codigo,$jornada,$descripcion,$fechaCreacion,$estadoSeccionId,$moduloId) {
            
          try{  
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_seccion(:nombre,:codigo,:jornada,:descripcion,:fechaCreacion,:estadoSeccionId,:moduloId,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->bindParam(':jornada', $jornada);
            $comando->bindParam(':descripcion', $descripcion);      
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
             $comando->bindParam(':estadoSeccionId', $estadoSeccionId);
            $comando->bindParam(':moduloId', $moduloId);
            $comando->execute();
            $this->llaveIdSeccion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
          }
        catch (Exception $e){
                echo $e->getMessage();
            }
        }
        
         public function modificarSeccion($id,$nombre,$codigo,$jornada,$descripcion,$fechaModificacion,$estadoSeccionId,$moduloId) {
            
            try{    
                $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_seccion(:id,:nombre,:codigo,:jornada,:descripcion,:fechaModificacion,:estadoSeccionId,:moduloId)");
                $comando->bindParam(':id', $id);
                $comando->bindParam(':nombre', $nombre);
                $comando->bindParam(':codigo', $codigo);
                $comando->bindParam(':jornada', $jornada);
                $comando->bindParam(':descripcion', $descripcion);
                $comando->bindParam(':fechaModificacion', $fechaModificacion);
                $comando->bindParam(':estadoSeccionId', $estadoSeccionId);
                $comando->bindParam(':moduloId', $moduloId);
                $comando->execute();
                return $comando;
            }
            catch (Exception $e){
                echo $e->getMessage();
            }
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
