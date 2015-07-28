<?php

/**
 * This is the model class for table "authitem_permiso_administrador".
 *
 * The followings are the available columns in table 'authitem_permiso_administrador':
 * @property string $name
 * @property integer $type
 * @property string $description
 * @property string $bizrule
 * @property string $data
 *
 * The followings are the available model relations:
 * @property AuthassignmentAdministrador[] $authassignmentAdministradors
 * @property AuthitemchildAdministrador[] $authitemchildAdministradors
 * @property AuthitemchildAdministrador[] $authitemchildAdministradors1
 * @property ControladorAdministrador[] $controladorAdministradors
 * @property UsuarioAdministrador $usuarioAdministrador
 * @property RolAdministrador[] $rolAdministradors
 */
class EscritorioAdministrador extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'authitem_permiso_administrador';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, type', 'required'),
			array('type', 'numerical', 'integerOnly'=>true),
			array('name', 'length', 'max'=>64),
			array('description, bizrule, data', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('name, type, description, bizrule, data', 'safe', 'on'=>'search'),
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
			'authassignmentAdministradors' => array(self::HAS_MANY, 'AuthassignmentAdministrador', 'itemname'),
			'authitemchildAdministradors' => array(self::HAS_MANY, 'AuthitemchildAdministrador', 'parent'),
			'authitemchildAdministradors1' => array(self::HAS_MANY, 'AuthitemchildAdministrador', 'child'),
			'controladorAdministradors' => array(self::HAS_MANY, 'ControladorAdministrador', 'authitem_permiso_administrador_name'),
			'usuarioAdministrador' => array(self::BELONGS_TO, 'UsuarioAdministrador', 'usuario_administrador_id'),
			'rolAdministradors' => array(self::MANY_MANY, 'RolAdministrador', 'rol_administrador_has_authitem_permiso_administrador(authitem_permiso_administrador_name, rol_administrador_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'name' => 'Name',
			'type' => 'Type',
			'description' => 'Description',
			'bizrule' => 'Bizrule',
			'data' => 'Data',
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

		$criteria->compare('name',$this->name,true);
		$criteria->compare('type',$this->type);
		$criteria->compare('description',$this->description,true);
		$criteria->compare('bizrule',$this->bizrule,true);
		$criteria->compare('data',$this->data,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return EscritorioAdministrador the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function getPermisoUsuario($nuevo_usuario_id) {
            
             $comando = Yii::app()->db->createCommand("CALL sp_escritorio_administrador_get_permiso_usuario(:nuevo_usuario_id)");
             $comando->bindParam(':nuevo_usuario_id',$nuevo_usuario_id);
             return $comando->queryAll();
        }
        
        public function getIconoPermisoUsuario($nuevo_usuario_id) {
            
             $comando = Yii::app()->db->createCommand("CALL sp_escritorio_administrador_get_icono_permiso_usuario(:nuevo_usuario_id)");
             $comando->bindParam(':nuevo_usuario_id',$nuevo_usuario_id);
             return $comando->queryAll();
        }
}
