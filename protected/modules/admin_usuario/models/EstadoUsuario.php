<?php

/**
 * This is the model class for table "estado_usuario".
 *
 * The followings are the available columns in table 'estado_usuario':
 * @property integer $logica_estado_usuario_id
 * @property integer $usuario_id
 *
 * The followings are the available model relations:
 * @property LogicaEstadoUsuario $logicaEstadoUsuario
 * @property Usuario $usuario
 */
class EstadoUsuario extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'estado_usuario';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('logica_estado_usuario_id, usuario_id', 'required'),
			array('logica_estado_usuario_id, usuario_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('logica_estado_usuario_id, usuario_id', 'safe', 'on'=>'search'),
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
			'logicaEstadoUsuario' => array(self::BELONGS_TO, 'LogicaEstadoUsuario', 'logica_estado_usuario_id'),
			'usuario' => array(self::BELONGS_TO, 'Usuario', 'usuario_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'logica_estado_usuario_id' => 'Logica Estado Usuario',
			'usuario_id' => 'Usuario',
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

		$criteria->compare('logica_estado_usuario_id',$this->logica_estado_usuario_id);
		$criteria->compare('usuario_id',$this->usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return EstadoUsuario the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaEstadoUsuario($idEstado) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_usuario_lista_usuario_estado(:nuevo_estado_id)");
            $command->bindParam(':nuevo_estado_id',$idEstado);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaEstadoUsuario($listaEstadoUsuario,$estadoId) {
            $lista = implode(',', $listaEstadoUsuario);
            var_dump($lista);
            $listaLen = count($listaEstadoUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_usuario_asigna_estado_usuario(:listaUsuarioId,:listaLargo,:nuevoEstadoId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoEstadoId',$estadoId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaEstadoUsuario($listaEstadoUsuario,$estadoId) {
            $lista = implode(',', $listaEstadoUsuario);
            var_dump($lista);
            $listaLen = count($listaEstadoUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_usuario_desasigna_estado_usuario(:listaUsuarioId,:listaLargo,:nuevoEstadoId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoEstadoId',$estadoId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function listarEstadoUsuario($idUsuario) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_listar_estado_usuario(:idUsuario)");
            $comando->bindParam('idUsuario', $idUsuario);
            return $comando->queryAll();
        }
              
}
