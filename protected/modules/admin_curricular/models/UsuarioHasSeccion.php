<?php

/**
 * This is the model class for table "usuario_has_seccion".
 *
 * The followings are the available columns in table 'usuario_has_seccion':
 * @property integer $usuario_id
 * @property integer $seccion_id
 */
class UsuarioHasSeccion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'usuario_has_seccion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id, seccion_id', 'required'),
			array('usuario_id, seccion_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('usuario_id, seccion_id', 'safe', 'on'=>'search'),
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
			'usuario_id' => 'Usuario',
			'seccion_id' => 'Seccion',
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
		$criteria->compare('seccion_id',$this->seccion_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return UsuarioHasSeccion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
         public function listaSeccionUsuario($idRol,$idSeccion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_usuarios_por_rol3(:nuevoRolId,:nuevoSeccionId)");
            $command->bindParam(':nuevoRolId',$idRol);
            $command->bindParam(':nuevoSeccionId',$idSeccion);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaSeccionUsuario($listaSeccionUsuario,$seccionId,$rolId) {
            $lista = implode(',', $listaSeccionUsuario);
            var_dump($lista);
            $listaLen = count($listaSeccionUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_usuario_con_rol_seccion(:listaUsuarioId,:listaLargo,:nuevoSeccionId,:nuevoRolId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoSeccionId',$seccionId);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaSeccionUsuario($listaSeccionUsuario,$seccionId,$rolId) {
            $lista = implode(',', $listaSeccionUsuario);
            var_dump($lista);
            $listaLen = count($listaSeccionUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_usuario_con_rol_seccion(:listaUsuarioId,:listaLargo,:nuevoSeccionId,:nuevoRolId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoSeccionId',$seccionId);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
