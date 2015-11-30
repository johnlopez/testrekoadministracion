<?php

/**
 * This is the model class for table "dato_academico".
 *
 * The followings are the available columns in table 'dato_academico':
 * @property integer $id
 * @property string $universidad
 * @property string $carrera
 * @property integer $ano_cursado
 * @property integer $duracion_carrera
 * @property string $sede
 * @property string $direccion_sede
 * @property string $comuna_sede
 * @property string $ciudad_sede
 * @property integer $usuario_id
 *
 * The followings are the available model relations:
 * @property Usuario $usuario
 * @property Pais[] $paises
 */
class DatoAcademico extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdAcademico;
        
	public function tableName()
	{
		return 'dato_academico';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id', 'required'),
			array('ano_cursado, duracion_carrera, usuario_id', 'numerical', 'integerOnly'=>true),
			array('universidad, carrera, sede, direccion_sede, comuna_sede, ciudad_sede', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, universidad, carrera, ano_cursado, duracion_carrera, sede, direccion_sede, comuna_sede, ciudad_sede, usuario_id', 'safe', 'on'=>'search'),
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
			'usuario' => array(self::BELONGS_TO, 'Usuario', 'usuario_id'),
			'paises' => array(self::MANY_MANY, 'Pais', 'pais_has_dato_academico(dato_academico_id, pais_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'universidad' => 'Universidad',
			'carrera' => 'Carrera',
			'ano_cursado' => 'Ano Cursado',
			'duracion_carrera' => 'Duracion Carrera',
			'sede' => 'Sede',
			'direccion_sede' => 'Direccion Sede',
			'comuna_sede' => 'Comuna Sede',
			'ciudad_sede' => 'Ciudad Sede',
			'usuario_id' => 'Usuario',
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
		$criteria->compare('universidad',$this->universidad,true);
		$criteria->compare('carrera',$this->carrera,true);
		$criteria->compare('ano_cursado',$this->ano_cursado);
		$criteria->compare('duracion_carrera',$this->duracion_carrera);
		$criteria->compare('sede',$this->sede,true);
		$criteria->compare('direccion_sede',$this->direccion_sede,true);
		$criteria->compare('comuna_sede',$this->comuna_sede,true);
		$criteria->compare('ciudad_sede',$this->ciudad_sede,true);
		$criteria->compare('usuario_id',$this->usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return DatoAcademico the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarDatoAcademico($universidad,$carrera,$ano_cursado,$duracion_carrera,$sede,$direccion_sede,$comuna_sede,$ciudad_sede,$usuario_id) 
        {
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_dato_academico(:universidad,:carrera,:ano_cursado,:duracion_carrera,:sede,:direccion_sede,:comuna_sede,:ciudad_sede,:usuario_id,@llave_id)");
            $comando->bindParam(':universidad', $universidad);
            $comando->bindParam(':carrera', $carrera);
            $comando->bindParam(':ano_cursado', $ano_cursado);
            $comando->bindParam(':duracion_carrera', $duracion_carrera);
            $comando->bindParam(':sede', $sede);
            $comando->bindParam(':direccion_sede', $direccion_sede);
            $comando->bindParam(':comuna_sede', $comuna_sede);
            $comando->bindParam(':ciudad_sede', $ciudad_sede);
            $comando->bindParam(':usuario_id', $usuario_id);
            $comando->execute();
            $this->llaveIdAcademico = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarDatoAcademico($id,$universidad,$carrera,$ano_cursado,$duracion_carrera,$sede,$direccion_sede,$comuna_sede,$ciudad_sede,$usuario_id) 
        {
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_actualizar_dato_academico(:id,:universidad,:carrera,:ano_cursado,:duracion_carrera,:sede,:direccion_sede,:comuna_sede,:ciudad_sede,:usuario_id)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':universidad', $universidad);
            $comando->bindParam(':carrera', $carrera);
            $comando->bindParam(':ano_cursado', $ano_cursado);
            $comando->bindParam(':duracion_carrera', $duracion_carrera);
            $comando->bindParam(':sede', $sede);
            $comando->bindParam(':direccion_sede', $direccion_sede);
            $comando->bindParam(':comuna_sede', $comuna_sede);
            $comando->bindParam(':ciudad_sede', $ciudad_sede);
            $comando->bindParam(':usuario_id', $usuario_id);
            $comando->execute();
            return $comando;
        }
        
        public function eliminadoFisicoDatoAcademico($idDatoAcademico) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_eliminado_fisico_dato_academico(:idDatoAcademico)");
            $comando->bindParam(':idDatoAcademico', $idDatoAcademico);
            $comando->execute();
            return $comando;
        }
        
        public function listarPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_listar_datos_academicos_por_estado()");
            return $comando->queryAll();
        }
        
        public function listarDatosAcademicosPorUsuario($id) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_listar_datos_academicos_por_usuario(:id)");
            $comando->bindParam(':id', $id);
            return $comando->queryAll();
        }
}
