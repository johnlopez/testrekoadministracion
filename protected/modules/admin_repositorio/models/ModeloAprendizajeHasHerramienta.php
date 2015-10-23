<?php

/**
 * This is the model class for table "modelo_aprendizaje_has_herramienta".
 *
 * The followings are the available columns in table 'modelo_aprendizaje_has_herramienta':
 * @property integer $id
 * @property integer $trabajo_grupal
 * @property integer $archivo_recurso
 * @property integer $link_interes
 * @property integer $glosario
 * @property integer $contenido_libre
 * @property integer $foro
 * @property integer $evaluacion
 * @property integer $autoevaluacion
 * @property integer $proyecto
 * @property integer $recepcion_trabajo
 * @property integer $evaluacion_no_objetiva
 * @property integer $modelo_aprendizaje_id
 *
 * The followings are the available model relations:
 * @property ModeloAprendizaje $modeloAprendizaje
 */
class ModeloAprendizajeHasHerramienta extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'modelo_aprendizaje_has_herramienta';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('trabajo_grupal, archivo_recurso, link_interes, glosario, contenido_libre, foro, evaluacion, autoevaluacion, proyecto, recepcion_trabajo, evaluacion_no_objetiva, modelo_aprendizaje_id', 'numerical', 'integerOnly'=>true),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, trabajo_grupal, archivo_recurso, link_interes, glosario, contenido_libre, foro, evaluacion, autoevaluacion, proyecto, recepcion_trabajo, evaluacion_no_objetiva, modelo_aprendizaje_id', 'safe', 'on'=>'search'),
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
			'modeloAprendizaje' => array(self::BELONGS_TO, 'ModeloAprendizaje', 'modelo_aprendizaje_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'trabajo_grupal' => 'Trabajo Grupal',
			'archivo_recurso' => 'Archivo Recurso',
			'link_interes' => 'Link Interes',
			'glosario' => 'Glosario',
			'contenido_libre' => 'Contenido Libre',
			'foro' => 'Foro',
			'evaluacion' => 'Evaluacion',
			'autoevaluacion' => 'Autoevaluacion',
			'proyecto' => 'Proyecto',
			'recepcion_trabajo' => 'Recepcion Trabajo',
			'evaluacion_no_objetiva' => 'Evaluacion No Objetiva',
			'modelo_aprendizaje_id' => 'Modelo Aprendizaje',
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
		$criteria->compare('trabajo_grupal',$this->trabajo_grupal);
		$criteria->compare('archivo_recurso',$this->archivo_recurso);
		$criteria->compare('link_interes',$this->link_interes);
		$criteria->compare('glosario',$this->glosario);
		$criteria->compare('contenido_libre',$this->contenido_libre);
		$criteria->compare('foro',$this->foro);
		$criteria->compare('evaluacion',$this->evaluacion);
		$criteria->compare('autoevaluacion',$this->autoevaluacion);
		$criteria->compare('proyecto',$this->proyecto);
		$criteria->compare('recepcion_trabajo',$this->recepcion_trabajo);
		$criteria->compare('evaluacion_no_objetiva',$this->evaluacion_no_objetiva);
		$criteria->compare('modelo_aprendizaje_id',$this->modelo_aprendizaje_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ModeloAprendizajeHasHerramienta the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
