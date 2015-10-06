<?php
require 'InterfaceRolUsuarioHasPrivilegioUsuario.php';

/**
 * This is the model class for table "rol_usuario_has_privilegio_usuario".
 *
 * The followings are the available columns in table 'rol_usuario_has_privilegio_usuario':
 * @property integer $rol_usuario_id
 * @property integer $privilegio_usuario_id
 */
class RolUsuarioHasPrivilegioUsuario extends CActiveRecord implements InterfaceRolUsuarioHasPrivilegioUsuario
{
        private $controladorusuarionombre;    
        private $privilegiousuarionombre;
   
        public function setControladorUsuarioNombre($data){
           $this->controladorusuarionombre = $data;
        }
        public function getControladorUsuarioNombre() {
           return $this->controladorusuarionombre;
        }
        public function setPrivilegioUsuarioNombre($data){
           $this->privilegiousuarionombre = $data;
        }
        public function getPrivilegioUsuarioNombre() {
           return $this->privilegiousuarionombre;
        }
        
        public function setAttributes($values, $safeOnly = true) {
        if (!is_array($values))
                return;
            $attributes = array_flip($safeOnly ? $this->getSafeAttributeNames() : $this->attributeNames());      
            foreach ($values as $name => $value) {
                $nameRest = substr($name, 1);
                $func = 'set' . strtoupper($name[0]) . $nameRest;            
                if (method_exists($this, $func)) {
                    $this->$func($value);                
                } else if (isset($attributes[$name])) {
                    $this->$name = $value;                
                }
                else if ($safeOnly) {                
                    $this->onUnsafeAttribute($name, $value);
                }
            }
        }
        
        public function attributeNames() {
            $attributes = parent::attributeNames();
            $newAttributes = Array('controladorusuarionombre','privilegiousuarionombre');        
            return array_merge($attributes, $newAttributes);      
        }    

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'rol_usuario_has_privilegio_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('rol_usuario_id, privilegio_usuario_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('rol_usuario_id, privilegio_usuario_id', 'safe', 'on'=>'search'),
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
			'privilegio_usuario_id' => 'Privilegio Usuario',
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
		$criteria->compare('privilegio_usuario_id',$this->privilegio_usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RolUsuarioHasPrivilegioUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaRolPrivilegio($idRol) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_lista_rol_privilegio(:nuevoRolId)");
            $command->bindParam(':nuevoRolId',$idRol);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        public function listaRolPermisoPrivilegio($idRol,$namePermiso) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_lista_rol_permiso_privilegio(:nuevoRolId,:nuevoPermisoName)");
            $command->bindParam(':nuevoRolId',$idRol);	
            $command->bindParam(':nuevoPermisoName',$namePermiso);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaRolPrivilegio($listaRolPrivilegio,$rolId) {
            $lista = implode(',', $listaRolPrivilegio);
            var_dump($lista);
            $listaLen = count($listaRolPrivilegio);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_asigna_privilegio_rol(:listaPrivilegioId,:listaLargo,:nuevoRolId)");
            $command->bindParam(':listaPrivilegioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaRolPrivilegio($listaRolPrivilegio,$rolId) {
            $lista = implode(',', $listaRolPrivilegio);
            var_dump($lista);
            $listaLen = count($listaRolPrivilegio);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_desasigna_privilegio_rol(:listaPrivilegioId,:listaLargo,:nuevoRolId)");
            $command->bindParam(':listaPrivilegioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
