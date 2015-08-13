<?php

/**
 * This is the model class for table "institucion_has_rol_usuario".
 *
 * The followings are the available columns in table 'institucion_has_rol_usuario':
 * @property integer $institucion_id
 * @property integer $rol_usuario_id
 */
class InstitucionHasRolUsuario extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'institucion_has_rol_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('institucion_id, rol_usuario_id', 'required'),
			array('institucion_id, rol_usuario_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('institucion_id, rol_usuario_id', 'safe', 'on'=>'search'),
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
			'institucion_id' => 'Institucion',
			'rol_usuario_id' => 'Rol Usuario',
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

		$criteria->compare('institucion_id',$this->institucion_id);
		$criteria->compare('rol_usuario_id',$this->rol_usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return InstitucionHasRolUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaRolInstitucion($idRol) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_lista_rol_institucion(:nuevo_rol_id)");
            $command->bindParam(':nuevo_rol_id',$idRol);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaRolInstitucion($listaRolInstitucion,$rolId) {
            $lista = implode(',', $listaRolInstitucion);
            var_dump($lista);
            $listaLen = count($listaRolInstitucion);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_asigna_rol_institucion(:lista_institucion_id,:lista_largo,:nuevo_rol_id)");
            $command->bindParam(':lista_institucion_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_rol_id',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaRolInstitucion($listaRolInstitucion,$rolId) {
            $lista = implode(',', $listaRolInstitucion);
            var_dump($lista);
            $listaLen = count($listaRolInstitucion);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_desasigna_rol_institucion(:lista_institucion_id,:lista_largo,:nuevo_rol_id)");
            $command->bindParam(':lista_institucion_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_rol_id',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
