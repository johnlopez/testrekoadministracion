<?php

/**
 * This is the model class for table "modelo_aprendizaje".
 *
 * The followings are the available columns in table 'modelo_aprendizaje':
 * @property integer $id
 * @property string $nombre
 * @property string $descripcion
 * @property string $fecha_acceso
 * @property string $fecha_modificacion
 * @property string $fecha_creacion
 * @property string $fecha_eliminacion
 *
 * The followings are the available model relations:
 * @property ModeloAprendizajeHasHerramienta[] $modeloAprendizajeHasHerramientas
 * @property Repositorio[] $repositorios
 */
class ModeloAprendizaje extends CActiveRecord
{
        public $lastInsertModeloAprendizajeId;
        public $lastInsertModeloAprendizajeHerramientaId;
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'modelo_aprendizaje';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre', 'length', 'max'=>45),
			array('descripcion, fecha_acceso, fecha_modificacion, fecha_creacion, fecha_eliminacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, descripcion, fecha_acceso, fecha_modificacion, fecha_creacion, fecha_eliminacion', 'safe', 'on'=>'search'),
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
			'modeloAprendizajeHasHerramientas' => array(self::HAS_MANY, 'ModeloAprendizajeHasHerramienta', 'modelo_aprendizaje_id'),
			'repositorios' => array(self::HAS_MANY, 'Repositorio', 'modelo_aprendizaje_id'),
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
			'fecha_eliminacion' => 'Fecha Eliminacion',
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
		$criteria->compare('fecha_eliminacion',$this->fecha_eliminacion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return ModeloAprendizaje the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarModeloAprendizaje(                
                
                $nuevoModeloAprendizajeNombre,
                $nuevoModeloAprendizajeDescripcion,

                $nuevoTrabajoGrupalBool,
                $nuevoArchivoRecursoBool,
                $nuevoLinkInteresBool,
                $nuevoGlosarioBool,
                $nuevoContenidoLibreBool,
                $nuevoForoBool,
                $nuevoEvaluacionBool,
                $nuevoAutoevaluacionBool,
                $nuevoProyectoBool,
                $nuevoRecepcionTrabajoBool,
                $nuevoEvaluacionNoObjetivaBool                
        ) 
        {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_repositorio_agregar_modelo_aprendizaje_herramienta(
                :nuevoModeloAprendizajeNombre,
                :nuevoModeloAprendizajeDescripcion,

                :nuevoTrabajoGrupalBool,
                :nuevoArchivoRecursoBool,
                :nuevoLinkInteresBool,
                :nuevoGlosarioBool,
                :nuevoContenidoLibreBool,
                :nuevoForoBool,
                :nuevoEvaluacionBool,
                :nuevoAutoevaluacionBool,
                :nuevoProyectoBool,
                :nuevoRecepcionTrabajoBool,
                :nuevoEvaluacionNoObjetivaBool,
                @last_insert_modelo_aprendizaje_id,
                @last_insert_modelo_aprendizaje_herramienta_id)"
            );              
                    
            $comando->bindParam(':nuevoModeloAprendizajeNombre',$nuevoModeloAprendizajeNombre);
            $comando->bindParam(':nuevoModeloAprendizajeDescripcion',$nuevoModeloAprendizajeDescripcion);

            $comando->bindParam(':nuevoTrabajoGrupalBool',$nuevoTrabajoGrupalBool);
            $comando->bindParam(':nuevoArchivoRecursoBool',$nuevoArchivoRecursoBool);
            $comando->bindParam(':nuevoLinkInteresBool',$nuevoLinkInteresBool);
            $comando->bindParam(':nuevoGlosarioBool',$nuevoGlosarioBool);
            $comando->bindParam(':nuevoContenidoLibreBool',$nuevoContenidoLibreBool);
            $comando->bindParam(':nuevoForoBool',$nuevoForoBool);
            $comando->bindParam(':nuevoEvaluacionBool',$nuevoEvaluacionBool);
            $comando->bindParam(':nuevoAutoevaluacionBool',$nuevoAutoevaluacionBool);
            $comando->bindParam(':nuevoProyectoBool',$nuevoProyectoBool);
            $comando->bindParam(':nuevoRecepcionTrabajoBool',$nuevoRecepcionTrabajoBool);
            $comando->bindParam(':nuevoEvaluacionNoObjetivaBool',$nuevoEvaluacionNoObjetivaBool);
           
            $comando->execute();
            $this->lastInsertModeloAprendizajeId = Yii::app()->db->createCommand("select @last_insert_modelo_aprendizaje_id as result;")->queryScalar();
            $this->lastInsertModeloAprendizajeHerramientaId = Yii::app()->db->createCommand("select @last_insert_modelo_aprendizaje_herramienta_id as result;")->queryScalar();

            return $comando;
        }
        
        
        public function modificarModeloAprendizaje(                
                $nuevoModeloAprendizajeId,
                $nuevoModeloAprendizajeNombre,
                $nuevoModeloAprendizajeDescripcion,

                $nuevoTrabajoGrupalBool,
                $nuevoArchivoRecursoBool,
                $nuevoLinkInteresBool,
                $nuevoGlosarioBool,
                $nuevoContenidoLibreBool,
                $nuevoForoBool,
                $nuevoEvaluacionBool,
                $nuevoAutoevaluacionBool,
                $nuevoProyectoBool,
                $nuevoRecepcionTrabajoBool,
                $nuevoEvaluacionNoObjetivaBool                
        ) 
        {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_repositorio_modificar_modelo_aprendizaje_herramienta(
                :nuevoModeloAprendizajeId,
                :nuevoModeloAprendizajeNombre,
                :nuevoModeloAprendizajeDescripcion,

                :nuevoTrabajoGrupalBool,
                :nuevoArchivoRecursoBool,
                :nuevoLinkInteresBool,
                :nuevoGlosarioBool,
                :nuevoContenidoLibreBool,
                :nuevoForoBool,
                :nuevoEvaluacionBool,
                :nuevoAutoevaluacionBool,
                :nuevoProyectoBool,
                :nuevoRecepcionTrabajoBool,
                :nuevoEvaluacionNoObjetivaBool,
                @last_insert_modelo_aprendizaje_id,
                @last_insert_modelo_aprendizaje_herramienta_id)"
            );              
            $comando->bindParam(':nuevoModeloAprendizajeId',$nuevoModeloAprendizajeId);
            $comando->bindParam(':nuevoModeloAprendizajeNombre',$nuevoModeloAprendizajeNombre);
            $comando->bindParam(':nuevoModeloAprendizajeDescripcion',$nuevoModeloAprendizajeDescripcion);

            $comando->bindParam(':nuevoTrabajoGrupalBool',$nuevoTrabajoGrupalBool);
            $comando->bindParam(':nuevoArchivoRecursoBool',$nuevoArchivoRecursoBool);
            $comando->bindParam(':nuevoLinkInteresBool',$nuevoLinkInteresBool);
            $comando->bindParam(':nuevoGlosarioBool',$nuevoGlosarioBool);
            $comando->bindParam(':nuevoContenidoLibreBool',$nuevoContenidoLibreBool);
            $comando->bindParam(':nuevoForoBool',$nuevoForoBool);
            $comando->bindParam(':nuevoEvaluacionBool',$nuevoEvaluacionBool);
            $comando->bindParam(':nuevoAutoevaluacionBool',$nuevoAutoevaluacionBool);
            $comando->bindParam(':nuevoProyectoBool',$nuevoProyectoBool);
            $comando->bindParam(':nuevoRecepcionTrabajoBool',$nuevoRecepcionTrabajoBool);
            $comando->bindParam(':nuevoEvaluacionNoObjetivaBool',$nuevoEvaluacionNoObjetivaBool);
           
            $comando->execute();
            $this->lastInsertModeloAprendizajeId = Yii::app()->db->createCommand("select @last_insert_modelo_aprendizaje_id as result;")->queryScalar();
            $this->lastInsertModeloAprendizajeHerramientaId = Yii::app()->db->createCommand("select @last_insert_modelo_aprendizaje_herramienta_id as result;")->queryScalar();

            return $comando;
        }
}
