<?php
require 'InterfaceInstitucionHasRolUsuario.php';
/**
 * This is the model class for table "institucion_has_rol_usuario".
 *
 * The followings are the available columns in table 'institucion_has_rol_usuario':
 * @property integer $institucion_id
 * @property integer $rol_usuario_id
 */
class InstitucionHasRolUsuario extends CActiveRecord implements InterfaceInstitucionHasRolUsuario
{
        private $rolusuarionombre;   
        private $rolusuariotipo;    
   
        public function setRolUsuarioNombre($data){
           $this->rolusuarionombre = $data;
        }
        public function getRolUsuarioNombre() {
           return $this->rolusuarionombre;
        }
        public function setRolUsuarioTipo($data){
           $this->rolusuariotipo = $data;
        }
        public function getRolUsuarioTipo() {
           return $this->rolusuariotipo;
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
            $newAttributes = Array('rolusuarionombre','rolusuariotipo');        
            return array_merge($attributes, $newAttributes);      
        }   
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
        
        public function listaInstitucionRolUsuario($idInstitucion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_lista_institucion_rol(:nuevoInstitucionId)");
            $command->bindParam(':nuevoInstitucionId',$idInstitucion);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        public function asignaInstitucionRolUsuario($listaInstitucionRolUsuario,$institucionId) {
            $lista = implode(',', $listaInstitucionRolUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionRolUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_asigna_rol_institucion(:listaRolUsuarioId,:listaLargo,:nuevoInstitucionId)");
            $command->bindParam(':listaRolUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        public function desasignaInstitucionRolUsuario($listaInstitucionRolUsuario,$institucionId) {
            $lista = implode(',', $listaInstitucionRolUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionRolUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_desasigna_rol_institucion(:listaRolUsuarioId,:listaLargo,:nuevoInstitucionId)");
            $command->bindParam(':listaRolUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        
        public function asignaInstitucionRolUsuarioGeneral($listaInstitucionRolUsuario,$institucionId) {
            $lista = implode(',', $listaInstitucionRolUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionRolUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_asignar_roles_generales_a_institucion(:listaRolUsuarioId,:listaLargo,:nuevoInstitucionId)");
            $command->bindParam(':listaRolUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        public function desasignaInstitucionRolUsuarioGeneral($listaInstitucionRolUsuario,$institucionId) {
            $lista = implode(',', $listaInstitucionRolUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionRolUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_desasignar_roles_generales_a_institucion(:listaRolUsuarioId,:listaLargo,:nuevoInstitucionId)");
            $command->bindParam(':listaRolUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function listarRolUsuarioInstitucion($institucionId){        
            $command = Yii::app()->db->createCommand("CALL sp_admin_rol_usuario_listar_rol_usuario_institucion(:nuevoInstitucionId)");
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            return $command->queryAll(); 
        }
        
        
        
}
