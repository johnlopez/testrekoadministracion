<?php

/**
 * This is the model class for table "dato_personal".
 *
 * The followings are the available columns in table 'dato_personal':
 * @property integer $id
 * @property string $primer_nombre
 * @property string $segundo_nombre
 * @property string $apellido_paterno
 * @property string $apellido_materno
 * @property string $fecha_nacimiento
 * @property integer $edad
 * @property integer $rut
 * @property integer $digito_verificador
 * @property string $direccion_personal
 * @property integer $numero_casa
 * @property integer $telefono_personal
 * @property integer $celular_personal
 * @property string $dato_personalcol
 * @property string $comuna_personal
 * @property string $ciudad_personal
 * @property string $interes
 * @property string $estado_civil
 * @property string $idioma
 * @property string $nacionalidad
 * @property integer $usuario_id
 *
 * The followings are the available model relations:
 * @property Usuario $usuario
 * @property Pais[] $paises
 */
class DatoPersonal extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
        public $llaveIdPersonal;
        
	public function tableName()
	{
		return 'dato_personal';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('usuario_id', 'required'),
			array('edad, rut, digito_verificador, numero_casa, telefono_personal, celular_personal, usuario_id', 'numerical', 'integerOnly'=>true),
			array('primer_nombre, segundo_nombre, apellido_paterno, apellido_materno, direccion_personal, dato_personalcol, comuna_personal, ciudad_personal, interes, estado_civil, idioma, nacionalidad', 'length', 'max'=>45),
			array('fecha_nacimiento', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, primer_nombre, segundo_nombre, apellido_paterno, apellido_materno, fecha_nacimiento, edad, rut, digito_verificador, direccion_personal, numero_casa, telefono_personal, celular_personal, dato_personalcol, comuna_personal, ciudad_personal, interes, estado_civil, idioma, nacionalidad, usuario_id', 'safe', 'on'=>'search'),
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
			'usuario' => array(self::BELONGS_TO, 'Usuario', 'usuario_id'),
			'paises' => array(self::MANY_MANY, 'Pais', 'pais_has_dato_personal(dato_personal_id, pais_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'primer_nombre' => 'Primer Nombre',
			'segundo_nombre' => 'Segundo Nombre',
			'apellido_paterno' => 'Apellido Paterno',
			'apellido_materno' => 'Apellido Materno',
			'fecha_nacimiento' => 'Fecha Nacimiento',
			'edad' => 'Edad',
			'rut' => 'Rut',
			'digito_verificador' => 'Digito Verificador',
			'direccion_personal' => 'Direccion Personal',
			'numero_casa' => 'Numero Casa',
			'telefono_personal' => 'Telefono Personal',
			'celular_personal' => 'Celular Personal',
			'dato_personalcol' => 'Dato Personalcol',
			'comuna_personal' => 'Comuna Personal',
			'ciudad_personal' => 'Ciudad Personal',
			'interes' => 'Interes',
			'estado_civil' => 'Estado Civil',
			'idioma' => 'Idioma',
			'nacionalidad' => 'Nacionalidad',
			'usuario_id' => 'Usuario',
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
		$criteria->compare('primer_nombre',$this->primer_nombre,true);
		$criteria->compare('segundo_nombre',$this->segundo_nombre,true);
		$criteria->compare('apellido_paterno',$this->apellido_paterno,true);
		$criteria->compare('apellido_materno',$this->apellido_materno,true);
		$criteria->compare('fecha_nacimiento',$this->fecha_nacimiento,true);
		$criteria->compare('edad',$this->edad);
		$criteria->compare('rut',$this->rut);
		$criteria->compare('digito_verificador',$this->digito_verificador);
		$criteria->compare('direccion_personal',$this->direccion_personal,true);
		$criteria->compare('numero_casa',$this->numero_casa);
		$criteria->compare('telefono_personal',$this->telefono_personal);
		$criteria->compare('celular_personal',$this->celular_personal);
		$criteria->compare('dato_personalcol',$this->dato_personalcol,true);
		$criteria->compare('comuna_personal',$this->comuna_personal,true);
		$criteria->compare('ciudad_personal',$this->ciudad_personal,true);
		$criteria->compare('interes',$this->interes,true);
		$criteria->compare('estado_civil',$this->estado_civil,true);
		$criteria->compare('idioma',$this->idioma,true);
		$criteria->compare('nacionalidad',$this->nacionalidad,true);
		$criteria->compare('usuario_id',$this->usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return DatoPersonal the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarDatoPersonal($primerNombre,$segundoNombre,$apellidoPaterno,$apellidoMaterno,$fechaNacimiento,$edad,$rut,
                $digitoVerificador,$direccionPersonal, $numeroCasa, $telefonoPersonal, $celularPersonal, $comunaPersonal, 
                $ciudadPersonal, $interes, $estadoCivil, $idioma, $nacionalidad,$usuarioId)     
        {
        
            $comando = Yii::app()->db->createCommand("CALL sp_administracionusuario_agregar_dato_personal(:primer_nombre,:segundo_nombre,:apellido_paterno,:apellido_materno,:fecha_nacimiento,:edad,:rut,:digito_verificador,:direccion_personal,:numero_casa,:telefono_personal,:celular_personal,:comuna_personal,:ciudad_personal,:interes,:estado_civil,:idioma,:nacionalidad,:usuario_id,@llave_id)");
            $comando->bindParam(':primer_nombre', $primerNombre);
            $comando->bindParam(':segundo_nombre', $segundoNombre);
            $comando->bindParam(':apellido_paterno', $apellidoPaterno);
            $comando->bindParam(':apellido_materno', $apellidoMaterno);
            $comando->bindParam(':fecha_nacimiento', $fechaNacimiento);
            $comando->bindParam(':edad', $edad);
            $comando->bindParam(':rut', $rut);
            $comando->bindParam(':digito_verificador', $digitoVerificador);
            $comando->bindParam(':direccion_personal', $direccionPersonal);
            $comando->bindParam(':numero_casa', $numeroCasa);
            $comando->bindParam(':telefono_personal', $telefonoPersonal);
            $comando->bindParam(':celular_personal', $celularPersonal);
            $comando->bindParam(':comuna_personal', $comunaPersonal);
            $comando->bindParam(':ciudad_personal', $ciudadPersonal);
            $comando->bindParam(':interes', $interes);
            $comando->bindParam(':estado_civil', $estadoCivil);
            $comando->bindParam(':idioma', $idioma);
            $comando->bindParam(':nacionalidad', $nacionalidad);
            $comando->bindParam(':usuario_id', $usuarioId);
            $comando->execute();
            $this->llaveIdPersonal = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
        }
        
        public function modificarDatoPersonal($id,$primerNombre,$segundoNombre,$apellidoPaterno,$apellidoMaterno,$fechaNacimiento,$edad,$rut,$digitoVerificador,
                $direccionPersonal, $numeroCasa, $telefonoPersonal, $celularPersonal, $comunaPersonal, 
                $ciudadPersonal, $interes, $estadoCivil, $idioma, $nacionalidad, $usuarioId)     
        {
        
            $comando = Yii::app()->db->createCommand("CALL sp_administracionusuario_actualizar_dato_personal(:id,:primer_nombre,:segundo_nombre,:apellido_paterno,:apellido_materno,:fecha_nacimiento,:edad,:rut,:digito_verificador,:direccion_personal,:numero_casa,:telefono_personal,:celular_personal,:comuna_personal,:ciudad_personal,:interes,:estado_civil,:idioma,:nacionalidad,:usuario_id)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':primer_nombre', $primerNombre);
            $comando->bindParam(':segundo_nombre', $segundoNombre);
            $comando->bindParam(':apellido_paterno', $apellidoPaterno);
            $comando->bindParam(':apellido_materno', $apellidoMaterno);
            $comando->bindParam(':fecha_nacimiento', $fechaNacimiento);
            $comando->bindParam(':edad', $edad);
            $comando->bindParam(':rut', $rut);
            $comando->bindParam(':digito_verificador', $digitoVerificador);
            $comando->bindParam(':direccion_personal', $direccionPersonal);
            $comando->bindParam(':numero_casa', $numeroCasa);
            $comando->bindParam(':telefono_personal', $telefonoPersonal);
            $comando->bindParam(':celular_personal', $celularPersonal);
            $comando->bindParam(':comuna_personal', $comunaPersonal);
            $comando->bindParam(':ciudad_personal', $ciudadPersonal);
            $comando->bindParam(':interes', $interes);
            $comando->bindParam(':estado_civil', $estadoCivil);
            $comando->bindParam(':idioma', $idioma);
            $comando->bindParam(':nacionalidad', $nacionalidad);
            $comando->bindParam(':usuario_id', $usuarioId);
            $comando->execute();
            return $comando;
        }
}
