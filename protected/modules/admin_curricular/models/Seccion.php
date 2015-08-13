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
 *
 * The followings are the available model relations:
 * @property Modulo $modulo
 */
class Seccion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
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
			array('modulo_id', 'numerical', 'integerOnly'=>true),
			array('nombre, jornada, descripcion', 'length', 'max'=>45),
			array('fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, jornada, descripcion, fecha_creacion, fecha_modificacion, modulo_id', 'safe', 'on'=>'search'),
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
        
        public function agregarSeccion($nombre,$jornada,$descripcion,$fechaCreacion,$moduloId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_seccion(:nombre,:jornada,:descripcion,:fechaCreacion,:moduloId,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':jornada', $jornada);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fechaCreacion', $fechaCreacion);
            $comando->bindParam(':moduloId', $moduloId);
            $comando->execute();
            $this->llaveIdSeccion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
         public function modificarSeccion($id,$nombre,$jornada,$descripcion,$fechaModificacion,$moduloId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_seccion(:id,:nombre,:jornada,:descripcion,:fechaModificacion,:moduloId)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':jornada', $jornada);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fechaModificacion', $fechaModificacion);
            $comando->bindParam(':moduloId', $moduloId);
            $comando->execute();
            return $comando;
        }
}
