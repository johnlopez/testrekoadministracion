<?php

/**
 * This is the model class for table "ficha_tecnica_has_modulo".
 *
 * The followings are the available columns in table 'ficha_tecnica_has_modulo':
 * @property integer $ficha_tecnica_id
 * @property integer $modulo_id
 */
class FichaTecnicaHasModulo extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'ficha_tecnica_has_modulo';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('ficha_tecnica_id, modulo_id', 'required'),
			array('ficha_tecnica_id, modulo_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('ficha_tecnica_id, modulo_id', 'safe', 'on'=>'search'),
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
			'ficha_tecnica_id' => 'Ficha Tecnica',
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

		$criteria->compare('ficha_tecnica_id',$this->ficha_tecnica_id);
		$criteria->compare('modulo_id',$this->modulo_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return FichaTecnicaHasModulo the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaModulos($idFicha) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_lista_ficha_modulo(:idFicha)");
            $command->bindParam(':idFicha',$idFicha);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        
        public function asignaFichaModulo($listaModulos,$fichaId) {
            $lista = implode(',', $listaModulos);
            var_dump($lista);
            $listaLen = count($listaModulos);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_asigna_ficha_modulo(:listaModuloId,:listaLargo,:fichaId)");
            $command->bindParam(':listaModuloId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':fichaId',$fichaId);
            $resultado = $command->execute();        
            return $resultado;
        }
        
        public function desasignaFichaModulo($listaModulos,$fichaId) {
            $lista = implode(',', $listaModulos);
            var_dump($lista);
            $listaLen = count($listaModulos);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_curricular_desasigna_ficha_modulo(:listaModuloId,:listaLargo,:fichaId)");
            $command->bindParam(':listaModuloId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':fichaId',$fichaId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
