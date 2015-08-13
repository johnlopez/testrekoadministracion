<?php

/**
 * This is the model class for table "programa_academico_has_modulo".
 *
 * The followings are the available columns in table 'programa_academico_has_modulo':
 * @property integer $programa_academico_id
 * @property integer $modulo_id
 */
class ProgramaAcademicoHasModulo extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'programa_academico_has_modulo';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('programa_academico_id, modulo_id', 'required'),
			array('programa_academico_id, modulo_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('programa_academico_id, modulo_id', 'safe', 'on'=>'search'),
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
			'programa_academico_id' => 'Programa Academico',
			'modulo_id' => 'Modulo',
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

		$criteria->compare('programa_academico_id',$this->programa_academico_id);
		$criteria->compare('modulo_id',$this->modulo_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ProgramaAcademicoHasModulo the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaProgramaModulo($idPrograma) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_lista_programa_modulo(:nuevo_programa_id)");
            $command->bindParam(':nuevo_programa_id',$idPrograma);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaProgramaModulo($listaProgramaModulo,$programaId) {
            $lista = implode(',', $listaProgramaModulo);
            var_dump($lista);
            $listaLen = count($listaProgramaModulo);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_modulo_programa_academico(:lista_modulo_id,:lista_largo,:nuevo_programa_id)");
            $command->bindParam(':lista_modulo_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_programa_id',$programaId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaProgramaModulo($listaProgramaModulo,$programaId) {
            $lista = implode(',', $listaProgramaModulo);
            var_dump($lista);
            $listaLen = count($listaProgramaModulo);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_modulo_programa_academico(:lista_modulo_id,:lista_largo,:nuevo_programa_id)");
            $command->bindParam(':lista_modulo_id',$lista);
            $command->bindParam(':lista_largo',$listaLen);
            $command->bindParam(':nuevo_programa_id',$programaId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
