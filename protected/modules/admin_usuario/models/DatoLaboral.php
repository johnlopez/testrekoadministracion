<?php

/**
 * This is the model class for table "dato_laboral".
 *
 * The followings are the available columns in table 'dato_laboral':
 * @property integer $id
 * @property string $nombre_empresa
 * @property integer $ano_antiguedad
 * @property string $cargo
 * @property string $actividad
 * @property string $comuna_empresa
 * @property string $ciudad_empresa
 * @property integer $telefono_empresa
 * @property integer $celular_empresa
 * @property integer $rut_numero
 * @property integer $digito_verificador
 * @property integer $usuario_id
 *
 * The followings are the available model relations:
 * @property Usuario $usuario
 * @property Pais[] $paises
 */
class DatoLaboral extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    
        public $llaveIdLaboral;
        
	public function tableName()
	{
		return 'dato_laboral';
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
			array('ano_antiguedad, telefono_empresa, celular_empresa, rut_numero, digito_verificador, usuario_id', 'numerical', 'integerOnly'=>true),
			array('nombre_empresa, cargo, actividad, comuna_empresa, ciudad_empresa', 'length', 'max'=>45),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre_empresa, ano_antiguedad, cargo, actividad, comuna_empresa, ciudad_empresa, telefono_empresa, celular_empresa, rut_numero, digito_verificador, usuario_id', 'safe', 'on'=>'search'),
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
			'paises' => array(self::MANY_MANY, 'Pais', 'pais_has_dato_laboral(dato_laboral_id, pais_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'nombre_empresa' => 'Nombre Empresa',
			'ano_antiguedad' => 'Ano Antiguedad',
			'cargo' => 'Cargo',
			'actividad' => 'Actividad',
			'comuna_empresa' => 'Comuna Empresa',
			'ciudad_empresa' => 'Ciudad Empresa',
			'telefono_empresa' => 'Telefono Empresa',
			'celular_empresa' => 'Celular Empresa',
			'rut_numero' => 'Rut Numero',
			'digito_verificador' => 'Digito Verificador',
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
		$criteria->compare('nombre_empresa',$this->nombre_empresa,true);
		$criteria->compare('ano_antiguedad',$this->ano_antiguedad);
		$criteria->compare('cargo',$this->cargo,true);
		$criteria->compare('actividad',$this->actividad,true);
		$criteria->compare('comuna_empresa',$this->comuna_empresa,true);
		$criteria->compare('ciudad_empresa',$this->ciudad_empresa,true);
		$criteria->compare('telefono_empresa',$this->telefono_empresa);
		$criteria->compare('celular_empresa',$this->celular_empresa);
		$criteria->compare('rut_numero',$this->rut_numero);
		$criteria->compare('digito_verificador',$this->digito_verificador);
		$criteria->compare('usuario_id',$this->usuario_id);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return DatoLaboral the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
        public function agregarDatoLaboral($nombreEmpresa,$anoAntiguedad,$cargo,$actividad,$comunaEmpresa,$ciudadEmpresa,$telefonoEmpresa,$celularEmpresa, $rutNumero,$digitoVerificador,$usuarioId)
        {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_agregar_dato_laboral(:nombre_empresa,:ano_antiguedad,:cargo,:actividad,:comuna_empresa,:ciudad_empresa,:telefono_empresa,:celular_empresa,:rut_numero,:digito_verificador,:usuario_id,@llave_id)");
            $comando->bindParam(':nombre_empresa', $nombreEmpresa);
            $comando->bindParam(':ano_antiguedad', $anoAntiguedad);
            $comando->bindParam(':cargo', $cargo);
            $comando->bindParam(':actividad', $actividad);
            $comando->bindParam(':comuna_empresa', $comunaEmpresa);
            $comando->bindParam(':ciudad_empresa', $ciudadEmpresa);
            $comando->bindParam(':telefono_empresa', $telefonoEmpresa);
            $comando->bindParam(':celular_empresa', $celularEmpresa);
            $comando->bindParam(':rut_numero', $rutNumero);
            $comando->bindParam(':digito_verificador', $digitoVerificador);
            $comando->bindParam(':usuario_id', $usuarioId);
            $comando->execute();
            $this->llaveIdLaboral = Yii::app()->db->createCommand("select @llave_id as result;")->queryScalar();
            return $comando;
            
        }
        
        public function modificarDatoLaboral($id,$nombreEmpresa,$anoAntiguedad,$cargo,$actividad,$comunaEmpresa,$ciudadEmpresa,$telefonoEmpresa,$celularEmpresa, $rutNumero,$digitoVerificador,$usuarioId)
        {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_actualizar_dato_laboral(:id,:nombre_empresa,:ano_antiguedad,:cargo,:actividad,:comuna_empresa,:ciudad_empresa,:telefono_empresa,:celular_empresa,:rut_numero,:digito_verificador,:usuario_id)");
            $comando->bindParam(':id', $id);
            $comando->bindParam(':nombre_empresa', $nombreEmpresa);
            $comando->bindParam(':ano_antiguedad', $anoAntiguedad);
            $comando->bindParam(':cargo', $cargo);
            $comando->bindParam(':actividad', $actividad);
            $comando->bindParam(':comuna_empresa', $comunaEmpresa);
            $comando->bindParam(':ciudad_empresa', $ciudadEmpresa);
            $comando->bindParam(':telefono_empresa', $telefonoEmpresa);
            $comando->bindParam(':celular_empresa', $celularEmpresa);
            $comando->bindParam(':rut_numero', $rutNumero);
            $comando->bindParam(':digito_verificador', $digitoVerificador);
            $comando->bindParam(':usuario_id', $usuarioId);
            $comando->execute();
            return $comando;
            
        }
        
        public function eliminarFisicoDatoLaboral($idDatoLaboral) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_eliminado_fisico_dato_academico(:idDatoLaboral)");
            $comando->bindParam(':idDatoLaboral', $idDatoLaboral);
            $comando->execute();
            return $comando;
        }
        
        public function listarPorEstado() {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_listar_datos_laborales_por_estado()");
            return $comando->queryAll();
        }
        
        public function listarDatosLaboralesPorUsuario($id) {
            
            $comando = Yii::app()->db->createCommand("CALL sp_admin_usuario_listar_datos_laborales_por_usuario(:id)");
            $comando->bindParam(':id', $id);
            return $comando->queryAll();
        }
        
        
}
