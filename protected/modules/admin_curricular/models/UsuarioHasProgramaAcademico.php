<?php

/**
 * This is the model class for table "usuario_has_programa_academico".
 *
 * The followings are the available columns in table 'usuario_has_programa_academico':
 * @property integer $usuario_id
 * @property integer $programa_academico_id
 */
class UsuarioHasProgramaAcademico extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'usuario_has_programa_academico';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id, programa_academico_id', 'required'),
			array('usuario_id, programa_academico_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('usuario_id, programa_academico_id', 'safe', 'on'=>'search'),
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
			'programa_academico_id' => 'Programa Academico',
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
		$criteria->compare('programa_academico_id',$this->programa_academico_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return UsuarioHasProgramaAcademico the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaUsuariosPorRol($idRol,$idPrograma) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_listar_usuarios_por_rol(:nuevoRolId,:nuevoProgramaId)");
            $command->bindParam(':nuevoRolId',$idRol);
            $command->bindParam(':nuevoProgramaId',$idPrograma);
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaProgramaUsuario($listaProgramaUsuario,$programaId,$rolId) {
            $lista = implode(',', $listaProgramaUsuario);
            var_dump($lista);
            $listaLen = count($listaProgramaUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_usuario_con_rol_programa(:listaUsuarioId,:listaLargo,:nuevoProgramaId,:nuevoRolId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoProgramaId',$programaId);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaProgramaUsuario($listaProgramaUsuario,$programaId,$rolId) {
            $lista = implode(',', $listaProgramaUsuario);
            var_dump($lista);
            $listaLen = count($listaProgramaUsuario);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_usuario_con_rol_programa(:listaUsuarioId,:listaLargo,:nuevoProgramaId,:nuevoRolId)");
            $command->bindParam(':listaUsuarioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoProgramaId',$programaId);
            $command->bindParam(':nuevoRolId',$rolId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
