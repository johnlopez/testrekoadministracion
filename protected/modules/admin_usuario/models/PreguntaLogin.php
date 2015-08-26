<?php

/**
 * This is the model class for table "pregunta_login".
 *
 * The followings are the available columns in table 'pregunta_login':
 * @property integer $id
 * @property string $pregunta
 *
 * The followings are the available model relations:
 * @property DatoLogin[] $datoLogins
 */
class PreguntaLogin extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdPregunta;
        
	public function tableName()
	{
		return 'pregunta_login';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('pregunta', 'length', 'max'=>250),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, pregunta', 'safe', 'on'=>'search'),
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
			'datoLogins' => array(self::MANY_MANY, 'DatoLogin', 'dato_login_has_pregunta_login(pregunta_login_id, dato_login_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'pregunta' => 'Pregunta',
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
		$criteria->compare('pregunta',$this->pregunta,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return PreguntaLogin the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarPregunta($pregunta) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_pregunta_login(:pregunta,@llave_id)");
            $comando->bindParam(':pregunta', $pregunta);
            $comando->execute();
            $this->llaveIdPregunta = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarPregunta($id,$pregunta) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_actualizar_pregunta_login(:id,:pregunta)");
            $comando->bindParam('id', $id);
            $comando->bindParam('pregunta', $pregunta);
            $comando->execute();
            return $comando;
        }
}
