<?php

/**
 * This is the model class for table "rol_administrador".
 *
 * The followings are the available columns in table 'rol_administrador':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 *
 * The followings are the available model relations:
 * @property AuthitemPermisoAdministrador[] $authitemPermisoAdministradors
 * @property UsuarioAdministrador[] $usuarioAdministradors
 */
class RolAdministrador extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'rol_administrador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre, descripcion', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion', 'safe', 'on'=>'search'),
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
			'authitemPermisoAdministradors' => array(self::MANY_MANY, 'AuthitemPermisoAdministrador', 'rol_administrador_has_authitem_permiso_administrador(rol_administrador_id, authitem_permiso_administrador_name)'),
			'usuarioAdministradors' => array(self::MANY_MANY, 'UsuarioAdministrador', 'usuario_administrador_has_rol_administrador(rol_administrador_id, usuario_administrador_id)'),
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

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RolAdministrador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        public function asignarPermisoARol($nuevo_rol_id,$nuevo_permiso_name) {
            
            $comando = Yii::app()->db->createCommand("CALL asignar_permiso_a_rol(:nuevo_rol_id,:nuevo_permiso_name)");
            $comando->bindParam(':nuevo_rol_id',$nuevo_rol_id);
            $comando->bindParam(':nuevo_permiso_name',$nuevo_permiso_name );
            $comando->execute();
            return $comando;
        }
        
        public function privilegioPermiso($nuevo_permiso) {
            
             $comando = Yii::app()->db->createCommand("CALL privilegio_permiso(:nuevo_permiso)");
             $comando->bindParam(':nuevo_permiso',$nuevo_permiso);
             return $comando->queryAll();
        }
        
        public function asignarPrivilegioRol($rol_id, $privilegio_id) {
            
            $comando = Yii::app()->db->createCommand("CALL asignar_privilegio_rol(:nuevo_rol_id,:nuevo_privilegio_id)");
            $comando->bindParam(':nuevo_rol_id',$rol_id);
            $comando->bindParam(':nuevo_privilegio_id',$privilegio_id);
            $comando->execute();
            return $comando;
            
        }
        
        public function desasignarPermisoRol($rol_id,$permiso_nombre) {
            
            $comando = Yii::app()->db->createCommand("CALL desasignar_permiso_rol(:nuevo_rol_id,:nuevo_permiso_name)");
            $comando->bindParam(':nuevo_rol_id',$rol_id);
            $comando->bindParam(':nuevo_permiso_name',$permiso_nombre);
            $comando->execute();
            return $comando;
        }
        
        public function desasignarPrivilegio($rol_id, $privilegio_id) {
            
            $comando = Yii::app()->db->createCommand("CALL desasignar_privilegio(:nuevo_rol_id,:nuevo_privilegio_id)");
            $comando->bindParam(':nuevo_rol_id',$rol_id);
            $comando->bindParam(':nuevo_privilegio_id',$privilegio_id);
            $comando->execute();
            return $comando;
        }
        
        
        public function checkRolPermiso($nuevo_rol_id,$nuevo_permiso_name) {
             $comando = Yii::app()->db->createCommand("CALL check_rol_permiso(:nuevo_rol_id,:nuevo_permiso_name,@retorno)");
             $comando->bindParam(':nuevo_rol_id',$nuevo_rol_id);
             $comando->bindParam(':nuevo_permiso_name',$nuevo_permiso_name );
             $comando->execute();
             return Yii::app()->db->createCommand("select @retorno as result;")->queryScalar();
        }
        
        
}
