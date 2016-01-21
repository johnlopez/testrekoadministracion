<?php

/**
 * This is the model class for table "contrato_ficha_tecnica".
 *
 * The followings are the available columns in table 'contrato_ficha_tecnica':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 * @property integer $ficha_tecnica_id
 */
class ContratoFichaTecnica extends CActiveRecord
{
        public $llaveIdContrato;
   
        public function tableName()
	{
		return 'contrato_ficha_tecnica';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('ficha_tecnica_id', 'required'),
			array('ficha_tecnica_id', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>45),
			array('descripcion, fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, fecha_creacion, fecha_modificacion, ficha_tecnica_id', 'safe', 'on'=>'search'),
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
			'ficha_tecnica_id' => 'Ficha Tecnica',
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
		$criteria->compare('ficha_tecnica_id',$this->ficha_tecnica_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ContratoFichaTecnica the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
         
        public function agregarContratoFichaTecnica($nombre,$descripcion,$fichaTecnicaId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_agregar_contrato_ficha_tecnica(:nombre,:descripcion,:fichaTecnicaId,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fichaTecnicaId', $fichaTecnicaId);
            $comando->execute();
            $this->llaveIdContrato = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarContratoFichaTecnica($id,$nombre,$descripcion,$fichaTecnicaId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_curricular_actualizar_contrato_ficha_tecnica(:id,:nombre,:descripcion,:fichaTecnicaId)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':descripcion', $descripcion);
            $comando->bindParam(':fichaTecnicaId', $fichaTecnicaId);
            $comando->execute();
            return $comando;
        }
}
