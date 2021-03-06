<?php

/**
 * This is the model class for table "rol_usuario_has_authitem_permiso_usuario".
 *
 * The followings are the available columns in table 'rol_usuario_has_authitem_permiso_usuario':
 * @property integer $rol_usuario_id
 * @property string $authitem_permiso_usuario_name
 */
class RolUsuarioHasAuthitemPermisoUsuario extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'rol_usuario_has_authitem_permiso_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('rol_usuario_id, authitem_permiso_usuario_name', 'required'),
			array('rol_usuario_id', 'numerical', 'integerOnly'=>true),
			array('authitem_permiso_usuario_name', 'length', 'max'=>64),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('rol_usuario_id, authitem_permiso_usuario_name', 'safe', 'on'=>'search'),
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
			'rol_usuario_id' => 'Rol Usuario',
			'authitem_permiso_usuario_name' => 'Authitem Permiso Usuario Name',
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

		$criteria->compare('rol_usuario_id',$this->rol_usuario_id);
		$criteria->compare('authitem_permiso_usuario_name',$this->authitem_permiso_usuario_name,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RolUsuarioHasAuthitemPermisoUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaRolPermiso($idRol) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_lista_rol_permiso(:nuevoRolId)");
            $command->bindParam(':nuevoRolId',$idRol);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaRolPermiso($listaRolPermiso,$rolId) {
            $lista = implode(',', $listaRolPermiso);
            var_dump($lista);
            $listaLen = count($listaRolPermiso);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_asigna_permiso_rol(:listaPermisoName,:listaLargo,:nuevoRolId)");
            $command->bindParam(':listaPermisoName',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaRolPermiso($listaRolPermiso,$rolId) {
            $lista = implode(',', $listaRolPermiso);
            var_dump($lista);
            $listaLen = count($listaRolPermiso);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_desasigna_permiso_rol(:listaPermisoName,:listaLargo,:nuevoRolId)");
            $command->bindParam(':listaPermisoName',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
