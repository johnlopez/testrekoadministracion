<?php

/**
 * This is the model class for table "usuario_has_institucion".
 *
 * The followings are the available columns in table 'usuario_has_institucion':
 * @property integer $usuario_id
 * @property integer $institucion_id
 *
 * The followings are the available model relations:
 * @property Institucion $institucion
 * @property Usuario $usuario
 */
class UsuarioHasInstitucion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'usuario_has_institucion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id, institucion_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('usuario_id, institucion_id', 'safe', 'on'=>'search'),
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
			'institucion' => array(self::BELONGS_TO, 'Institucion', 'institucion_id'),
			'usuario' => array(self::BELONGS_TO, 'Usuario', 'usuario_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'usuario_id' => 'Usuario',
			'institucion_id' => 'Institucion',
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

		$criteria->compare('usuario_id',$this->usuario_id);
		$criteria->compare('institucion_id',$this->institucion_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return UsuarioHasInstitucion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaInstitucionUsuario($idInstitucion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_usuario_lista_institucion_usuario(:nuevo_institucion_id)");
            $command->bindParam(':nuevo_institucion_id',$idInstitucion);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaInstitucionUsuario($listaInstitucionUsuario,$institucionId) {
            $lista = implode(',', $listaInstitucionUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_usuario_asigna_usuario_institucion(:lista_usuario_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_usuario_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaInstitucionUsuario($listaInstitucionUsuario,$institucionId) {
            $lista = implode(',', $listaInstitucionUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_usuario_desasigna_usuario_institucion(:lista_usuario_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_usuario_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
