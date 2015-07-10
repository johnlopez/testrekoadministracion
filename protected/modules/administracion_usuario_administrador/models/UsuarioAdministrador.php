<?php

/**
 * This is the model class for table "usuario_administrador".
 *
 * The followings are the available columns in table 'usuario_administrador':
 * @property integer $id
 * @property string $usuario
 * @property string $clave
 */
class UsuarioAdministrador extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'usuario_administrador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario, clave', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, usuario, clave', 'safe', 'on'=>'search'),
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
			'usuario' => 'Usuario',
			'clave' => 'Clave',
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

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return UsuarioAdministrador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function checkUsuarioRol($nuevo_usuario_id,$nuevo_rol_id) {
             $comando = Yii::app()->db->createCommand("CALL check_usuario_rol(:nuevo_usuario_id,:nuevo_rol_id,@retorno)");
             $comando->bindParam(':nuevo_usuario_id',$nuevo_usuario_id);
             $comando->bindParam(':nuevo_rol_id',$nuevo_rol_id );
             $comando->execute();
             return Yii::app()->db->createCommand("select @retorno as result;")->queryScalar();
        }
        
        public function desasignarRolUsuario($nuevo_usuario_id,$nuevo_rol_id) {
            
            $comando = Yii::app()->db->createCommand("CALL desasignar_rol_usuario(:nuevo_usuario_id,:nuevo_rol_id)");
            $comando->bindParam(':nuevo_usuario_id',$nuevo_usuario_id);
            $comando->bindParam(':nuevo_rol_id',$nuevo_rol_id);
            $comando->execute();
            return $comando;
        }
        public function asignarRolUsuario($nuevo_usuario_id,$nuevo_rol_id){
            
            $comando = Yii::app()->db->createCommand("CALL asignar_rol_usuario(:nuevo_usuario_id,:nuevo_rol_id)");
            $comando->bindParam(':nuevo_usuario_id',$nuevo_usuario_id);
            $comando->bindParam(':nuevo_rol_id',$nuevo_rol_id );
            $comando->execute();
            return $comando;
        }
}
