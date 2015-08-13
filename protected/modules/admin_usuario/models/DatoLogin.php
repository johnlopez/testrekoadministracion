<?php

/**
 * This is the model class for table "dato_login".
 *
 * The followings are the available columns in table 'dato_login':
 * @property integer $id
 * @property string $pregunta_secreta_1
 * @property string $pregunta_secreta_2
 * @property string $respuesta_secreta_1
 * @property string $respuesta_secreta_2
 * @property integer $usuario_id
 *
 * The followings are the available model relations:
 * @property Usuario $usuario
 */
class DatoLogin extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdLogin;
        
	public function tableName()
	{
		return 'dato_login';
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
			array('usuario_id', 'numerical', 'integerOnly'=>true),
			array('pregunta_secreta_1, pregunta_secreta_2, respuesta_secreta_1, respuesta_secreta_2', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, pregunta_secreta_1, pregunta_secreta_2, respuesta_secreta_1, respuesta_secreta_2, usuario_id', 'safe', 'on'=>'search'),
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
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'pregunta_secreta_1' => 'Pregunta Secreta 1',
			'pregunta_secreta_2' => 'Pregunta Secreta 2',
			'respuesta_secreta_1' => 'Respuesta Secreta 1',
			'respuesta_secreta_2' => 'Respuesta Secreta 2',
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
		$criteria->compare('pregunta_secreta_1',$this->pregunta_secreta_1,true);
		$criteria->compare('pregunta_secreta_2',$this->pregunta_secreta_2,true);
		$criteria->compare('respuesta_secreta_1',$this->respuesta_secreta_1,true);
		$criteria->compare('respuesta_secreta_2',$this->respuesta_secreta_2,true);
		$criteria->compare('usuario_id',$this->usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return DatoLogin the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarDatoLogin($preguntaSecreta1,$preguntarSecreta2,$respuestaSecreta1,$respuestaSecreta2,$usuarioId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_dato_login(:pregunta_secreta_1,:pregunta_secreta_2,:respuesta_secreta_1,:respuesta_secreta_2,:usuario_id,@llave_id)");
            $comando->bindParam(':pregunta_secreta_1', $preguntaSecreta1);
            $comando->bindParam(':pregunta_secreta_2', $preguntarSecreta2);
            $comando->bindParam(':respuesta_secreta_1', $respuestaSecreta1);
            $comando->bindParam(':respuesta_secreta_2', $respuestaSecreta2);
            $comando->bindParam('usuario_id', $usuarioId);
            $comando->execute();
            $this->llaveIdLogin = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;   
        }
        
         public function modificarDatoLogin($id,$preguntaSecreta1,$preguntarSecreta2,$respuestaSecreta1,$respuestaSecreta2,$usuarioId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_actualizar_dato_login(:id,:pregunta_secreta_1,:pregunta_secreta_2,:respuesta_secreta_1,:respuesta_secreta_2,:usuario_id)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':pregunta_secreta_1', $preguntaSecreta1);
            $comando->bindParam(':pregunta_secreta_2', $preguntarSecreta2);
            $comando->bindParam(':respuesta_secreta_1', $respuestaSecreta1);
            $comando->bindParam(':respuesta_secreta_2', $respuestaSecreta2);
            $comando->bindParam('usuario_id', $usuarioId);
            $comando->execute();
            return $comando;   
        }
}
