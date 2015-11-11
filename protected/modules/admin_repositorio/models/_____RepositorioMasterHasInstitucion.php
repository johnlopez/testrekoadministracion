<?php

/**
 * This is the model class for table "repositorio_master_has_institucion".
 *
 * The followings are the available columns in table 'repositorio_master_has_institucion':
 * @property integer $repositorio_master_id
 * @property integer $institucion_id
 */
class RepositorioMasterHasInstitucion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'repositorio_master_has_institucion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('repositorio_master_id, institucion_id', 'required'),
			array('repositorio_master_id, institucion_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('repositorio_master_id, institucion_id', 'safe', 'on'=>'search'),
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
			'repositorio_master_id' => 'Repositorio Master',
			'institucion_id' => 'Institucion',
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

		$criteria->compare('repositorio_master_id',$this->repositorio_master_id);
		$criteria->compare('institucion_id',$this->institucion_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RepositorioMasterHasInstitucion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaInstitucionRepositorioMaster($idInstitucion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_repositorio_lista_institucion_repositorio_master(:nuevo_institucion_id)");
            $command->bindParam(':nuevo_institucion_id',$idInstitucion);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaInstitucionRepositorioMaster($listaInstitucionRepositorioMaster,$institucionId) {
            $lista = implode(',', $listaInstitucionReposiorioMaster);
            var_dump($lista);
            $listaLen = count($listaInstitucionRepositorioMaster);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_repositorio_asigna_repositorio_master_institucion(:lista_repositorio_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_repositorio_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaInstitucionRepositorioMaster($listaInstitucionRepositorioMaster,$institucionId) {
            $lista = implode(',', $listaInstitucionUsuario);
            var_dump($lista);
            $listaLen = count($listaInstitucionRepositorioMaster);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_repositorio_desasigna_repositorio_master_institucion(:lista_repositorio_id,:lista_largo,:nuevo_institucion_id)");
            $command->bindParam(':lista_repositorio_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_institucion_id',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
