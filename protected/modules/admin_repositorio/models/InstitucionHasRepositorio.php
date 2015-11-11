<?php

/**
 * This is the model class for table "institucion_has_repositorio".
 *
 * The followings are the available columns in table 'institucion_has_repositorio':
 * @property integer $institucion_id
 * @property integer $repositorio_id
 */
class InstitucionHasRepositorio extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'institucion_has_repositorio';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('institucion_id, repositorio_id', 'required'),
			array('institucion_id, repositorio_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('institucion_id, repositorio_id', 'safe', 'on'=>'search'),
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
			'repositorio_id' => 'Repositorio',
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
		$criteria->compare('repositorio_id',$this->repositorio_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return InstitucionHasRepositorio the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function listaInstitucionRepositorio($idInstitucion) {        
            $command = Yii::app()->db->createCommand("CALL sp_admin_repositorio_lista_institucion_repositorio(:nuevoInstitucionId)");
            $command->bindParam(':nuevoInstitucionId',$idInstitucion);	
            $resultado = $command->queryAll();        
            return $resultado;       
        }
        public function asignaInstitucionRepositorio($listaInstitucionRepositorio,$institucionId) {
            $lista = implode(',', $listaInstitucionRepositorio);
            var_dump($lista);
            $listaLen = count($listaInstitucionRepositorio);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_repositorio_asigna_repositorio_institucion(:listaRepositorioId,:listaLargo,:nuevoInstitucionId)");
            $command->bindParam(':listaRepositorioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
        public function desasignaInstitucionRepositorio($listaInstitucionRepositorio,$institucionId) {
            $lista = implode(',', $listaInstitucionRepositorio);
            var_dump($lista);
            $listaLen = count($listaInstitucionRepositorio);        

            $command = Yii::app()->db->createCommand("CALL sp_admin_repositorio_desasigna_repositorio_institucion(:listaRepositorioId,:listaLargo,:nuevoInstitucionId)");
            $command->bindParam(':listaRepositorioId',$lista);
            $command->bindParam(':listaLargo',$listaLen);
            $command->bindParam(':nuevoInstitucionId',$institucionId);
            $resultado = $command->execute();        
            return $resultado;
        }
}
