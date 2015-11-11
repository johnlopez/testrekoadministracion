<?php
require 'InterfaceUsuarioHasRolUsuario.php';
/**
 * This is the model class for table "usuario_has_rol_usuario".
 *
 * The followings are the available columns in table 'usuario_has_rol_usuario':
 * @property integer $usuario_id
 * @property integer $rol_usuario_id
 *
 * The followings are the available model relations:
 * @property RolUsuario $rolUsuario
 */
class UsuarioHasRolUsuario extends CActiveRecord implements InterfaceUsuarioHasRolUsuario
{
        private $usuario;
        private $rut;
        private $primerNombre;
        private $apellidoPaterno;
        private $apellidoMaterno;

        public function setUsuario($data) {
            $this->usuario = $data;
        }
        public function getUsuario() {
            return $this->usuario;
        }
        
        public function setRut($data) {
            $this->rut = $data;
        }
        public function getRut() {
        return $this->rut;
        }
        
        public function setPrimerNombre($data) {
            $this->primerNombre = $data;
        }
        public function getPrimerNombre() {
        return $this->primerNombre;
        }

        public function setApellidoPaterno($data) {
            $this->apellidoPaterno = $data;
        }
        public function getApellidoPaterno() {
        return $this->apellidoPaterno;
        }

        public function setApellidoMaterno($data) {
            $this->apellidoMaterno = $data;
        }
        public function getApellidoMaterno() {
        return $this->apellidoMaterno;
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
            $newAttributes = Array('usuario','rut','primerNombre','apellidoPaterno','apellidoMaterno');        
            return array_merge($attributes, $newAttributes);      
        } 

        /**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'usuario_has_rol_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id, rol_usuario_id', 'required'),
			array('usuario_id, rol_usuario_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('usuario_id, rol_usuario_id', 'safe', 'on'=>'search'),
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
			'rolUsuario' => array(self::BELONGS_TO, 'RolUsuario', 'rol_usuario_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'usuario_id' => 'Usuario',
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

		$criteria->compare('usuario_id',$this->usuario_id);
		$criteria->compare('rol_usuario_id',$this->rol_usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return UsuarioHasRolUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaUsuarioInstitucionRolUsuario($nuevoRolId,$nuevoInstitucionId) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_lista_usuario_institucion_rol_usuario(:nuevoRolId,:nuevoInstitucionId)");
            $command->bindParam(':nuevoRolId',$nuevoRolId);	
            $command->bindParam(':nuevoInstitucionId',$nuevoInstitucionId);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaRolUsuarioUsuario($listaRolUsuarioUsuario,$rolUsuarioId) {
            $lista = implode(',', $listaRolUsuarioUsuario);
            var_dump($lista);
            $listaLen = count($listaRolUsuarioUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_asigna_usuario_institucion_rol_usuario(:listaUsuarioId,:listaLargo,:nuevoRolUsuarioId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoRolUsuarioId',$rolUsuarioId);
            $resultado = $command->execute();        
            return $resultado;
        }
        public function desasignaRolUsuarioUsuario($listaRolUsuarioUsuario,$rolUsuarioId) {
            $lista = implode(',', $listaRolUsuarioUsuario);
            var_dump($lista);
            $listaLen = count($listaRolUsuarioUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_desasigna_usuario_institucion_rol_usuario(:listaUsuarioId,:listaLargo,:nuevoRolUsuarioId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoRolUsuarioId',$rolUsuarioId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
}
