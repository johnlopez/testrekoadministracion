<?php

/**
 * This is the model class for table "logica_estado_usuario".
 *
 * The followings are the available columns in table 'logica_estado_usuario':
 * @property integer $id
 * @property string $estado
 *
 * The followings are the available model relations:
 * @property EstadoUsuario[] $estadoUsuarios
 */
class LogicaEstadoUsuario extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
        public $llaveIdLogica;
        
	public function tableName()
	{
		return 'logica_estado_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('estado', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, estado', 'safe', 'on'=>'search'),
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
			'estadoUsuarios' => array(self::HAS_MANY, 'EstadoUsuario', 'logica_estado_usuario_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'estado' => 'Estado',
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
		$criteria->compare('estado',$this->estado,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return LogicaEstadoUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarLogicaEstadoUsuario($estado) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_logica_estado_usuario(:estado,@llave_id)");
            $comando->bindParam(':estado', $estado);
            $comando->execute();
            $this->llaveIdLogica = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarLogicaEstadoUsuario($id,$estado) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_logica_estado_usuario(:id,:estado)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':estado', $estado);
            $comando->execute();
            return $comando;
        }
        
        
}
