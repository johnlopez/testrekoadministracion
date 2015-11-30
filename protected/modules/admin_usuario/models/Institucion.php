<?php

/**
 * This is the model class for table "institucion".
 *
 * The followings are the available columns in table 'institucion':
 * @property integer $id
 * @property string $nombre
 * @property string $vision
 * @property string $mision
 * @property integer $acreditada
 * @property string $fecha_inicio_acreditacion
 * @property string $fecha_termino_acreditacion
 * @property string $descripcion
 * @property string $fecha_creacion
 * @property string $fecha_modificacion
 *
 * The followings are the available model relations:
 * @property Entidad[] $entidads
 * @property RolUsuario[] $rolUsuarios
 * @property ProgramaAcademico[] $programaAcademicos
 * @property RepositorioMaster[] $repositorioMasters
 * @property UsuarioHasInstitucion[] $usuarioHasInstitucions
 */
class Institucion extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'institucion';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('acreditada', 'numerical', 'integerOnly'=>true),
			array('nombre, vision, mision, descripcion', 'length', 'max'=>45),
			array('fecha_inicio_acreditacion, fecha_termino_acreditacion, fecha_creacion, fecha_modificacion', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, vision, mision, acreditada, fecha_inicio_acreditacion, fecha_termino_acreditacion, descripcion, fecha_creacion, fecha_modificacion', 'safe', 'on'=>'search'),
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
			'entidads' => array(self::HAS_MANY, 'Entidad', 'institucion_id'),
			'rolUsuarios' => array(self::MANY_MANY, 'RolUsuario', 'institucion_has_rol_usuario(institucion_id, rol_usuario_id)'),
			'programaAcademicos' => array(self::MANY_MANY, 'ProgramaAcademico', 'programa_academico_has_institucion(institucion_id, programa_academico_id)'),
			'repositorioMasters' => array(self::MANY_MANY, 'RepositorioMaster', 'repositorio_master_has_institucion(institucion_id, repositorio_master_id)'),
			'usuarioHasInstitucions' => array(self::HAS_MANY, 'UsuarioHasInstitucion', 'institucion_id'),
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
			'vision' => 'Vision',
			'mision' => 'Mision',
			'acreditada' => 'Acreditada',
			'fecha_inicio_acreditacion' => 'Fecha Inicio Acreditacion',
			'fecha_termino_acreditacion' => 'Fecha Termino Acreditacion',
			'descripcion' => 'Descripcion',
			'fecha_creacion' => 'Fecha Creacion',
			'fecha_modificacion' => 'Fecha Modificacion',
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
		$criteria->compare('vision',$this->vision,true);
		$criteria->compare('mision',$this->mision,true);
		$criteria->compare('acreditada',$this->acreditada);
		$criteria->compare('fecha_inicio_acreditacion',$this->fecha_inicio_acreditacion,true);
		$criteria->compare('fecha_termino_acreditacion',$this->fecha_termino_acreditacion,true);
		$criteria->compare('descripcion',$this->descripcion,true);
		$criteria->compare('fecha_creacion',$this->fecha_creacion,true);
		$criteria->compare('fecha_modificacion',$this->fecha_modificacion,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Institucion the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
}
