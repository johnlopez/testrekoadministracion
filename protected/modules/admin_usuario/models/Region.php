<?php

/**
 * This is the model class for table "region".
 *
 * The followings are the available columns in table 'region':
 * @property integer $id
 * @property string $nombre
 * @property string $codigo
 * @property integer $pais_id
 *
 * The followings are the available model relations:
 * @property Pais $pais
 */
class Region extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdRegion;
        
	public function tableName()
	{
		return 'region';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('pais_id', 'required'),
			array('pais_id', 'numerical', 'integerOnly'=>true),
			array('nombre, codigo', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, codigo, pais_id', 'safe', 'on'=>'search'),
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
			'pais' => array(self::BELONGS_TO, 'Pais', 'pais_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'nombre' => 'Nombre',
			'codigo' => 'Codigo',
			'pais_id' => 'Pais',
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

		$criteria->compare('id',$this->id);
		$criteria->compare('nombre',$this->nombre,true);
		$criteria->compare('codigo',$this->codigo,true);
		$criteria->compare('pais_id',$this->pais_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Region the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarRegion($nombre,$codigo,$paisId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_region(:nombre,:codigo,:paisId,@llave_id)");
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->bindParam(':paisId', $paisId);
            $comando->execute(); 
            $this->llaveIdRegion = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarRegion($id,$nombre,$codigo,$paisId) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_actualizar_region(:id,:nombre,:codigo,:paisId)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre', $nombre);
            $comando->bindParam(':codigo', $codigo);
            $comando->bindParam(':paisId', $paisId);
            $comando->execute();
            return $comando;
        }
        
        public function eliminadoFisicoPais($idRegion) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_eliminado_fisico_region(:idRegion)");
            $comando->bindParam(':idRegion', $idRegion);
            $comando->execute();
            return $comando;
        }
}
