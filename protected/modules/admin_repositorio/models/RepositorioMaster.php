<?php

/**
 * This is the model class for table "repositorio_master".
 *
 * The followings are the available columns in table 'repositorio_master':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 * @property string $fecha_creacion
 * @property integer $modelo_aprendizaje_master_id
 * @property integer $secuencia_master_id
 * @property integer $repositorio_master_id
 * @property integer $tipo_repositorio_master_id
 *
 * The followings are the available model relations:
 * @property HerramientaMaster[] $herramientaMasters
 * @property Institucion[] $institucions
 * @property Repositorio[] $repositorios
 * @property TipoRepositorioMaster $tipoRepositorioMaster
 * @property ModeloAprendizajeMaster $modeloAprendizajeMaster
 * @property RepositorioMaster $repositorioMaster
 * @property RepositorioMaster[] $repositorioMasters
 * @property SecuenciaMaster $secuenciaMaster
 */
class RepositorioMaster extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'repositorio_master';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('modelo_aprendizaje_master_id, secuencia_master_id, repositorio_master_id, tipo_repositorio_master_id', 'numerical', 'integerOnly'=>true),
			array('nombre, descripcion', 'length', 'max'=>45),
			array('fecha_acceso, fecha_modificacion, fecha_creacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, fecha_acceso, fecha_modificacion, fecha_creacion, modelo_aprendizaje_master_id, secuencia_master_id, repositorio_master_id, tipo_repositorio_master_id', 'safe', 'on'=>'search'),
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
			'herramientaMasters' => array(self::HAS_MANY, 'HerramientaMaster', 'repositorio_master_id'),
			'institucions' => array(self::MANY_MANY, 'Institucion', 'institucion_has_repositorio_master(repositorio_master_id, institucion_id)'),
			'repositorios' => array(self::HAS_MANY, 'Repositorio', 'repositorio_master_id'),
			'tipoRepositorioMaster' => array(self::BELONGS_TO, 'TipoRepositorioMaster', 'tipo_repositorio_master_id'),
			'modeloAprendizajeMaster' => array(self::BELONGS_TO, 'ModeloAprendizajeMaster', 'modelo_aprendizaje_master_id'),
			'repositorioMaster' => array(self::BELONGS_TO, 'RepositorioMaster', 'repositorio_master_id'),
			'repositorioMasters' => array(self::HAS_MANY, 'RepositorioMaster', 'repositorio_master_id'),
			'secuenciaMaster' => array(self::BELONGS_TO, 'SecuenciaMaster', 'secuencia_master_id'),
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
			'descripcion' => 'Descripcion',
			'fecha_acceso' => 'Fecha Acceso',
			'fecha_modificacion' => 'Fecha Modificacion',
			'fecha_creacion' => 'Fecha Creacion',
			'modelo_aprendizaje_master_id' => 'Modelo Aprendizaje Master',
			'secuencia_master_id' => 'Secuencia Master',
			'repositorio_master_id' => 'Repositorio Master',
			'tipo_repositorio_master_id' => 'Tipo Repositorio Master',
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
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_acceso',$this->fecha_acceso,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('modelo_aprendizaje_master_id',$this->modelo_aprendizaje_master_id);
		$criteria->compare('secuencia_master_id',$this->secuencia_master_id);
		$criteria->compare('repositorio_master_id',$this->repositorio_master_id);
		$criteria->compare('tipo_repositorio_master_id',$this->tipo_repositorio_master_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return RepositorioMaster the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
                
        public function asignarModeloAprendizajeMasterRepositorioMaster($nuevo_repositorio_id,$nuevo_modelo_id) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_repositorio_asignar_mod_aprendizaje_master_rep_master(:nuevo_repositorio_id,:nuevo_modelo_id)");
            $comando->bindParam(':nuevo_repositorio_id',$nuevo_repositorio_id);
            $comando->bindParam(':nuevo_modelo_id',$nuevo_modelo_id );
            $comando->execute();
            return $comando;
        }
}
