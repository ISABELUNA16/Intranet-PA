<?php
/**
    * 
    * Configuración de la Base de Datos 
    * @author:  Rosmery Isabel Luna Tito
    * @versión:    1.0.0
    * @fecha:      04/02/2017
    */
    class ClsBd
    {
        //  Datos de configuración por defecto en ORACLE
        private $_db    ="erpeduca_professionalair";
        private $_sevID ="54.165.224.4";
        private $_port  ="1521";
        private $_usua  ="professionalair";
        private $_pwd   ='Educa2o17';
        private $_tipoBase          = "2"; // 0:: oracle 1:: postGree 2:: mysql
        private $_msgError          = "";
        var     $_codigoInsertado   = 0;
        var     $_metaData          = array();

        // constructor
        function ClsBd()
        { 		}

        function fcBD($nomBD)
        {	$this->_db=$nomBD;   }

        /**
         *  Descripcion :
         *  Metodo para asignar servidor en caso sea necesario
         */
        function fcServ($servID)
        {	$this->_sevID=$servID;	}

        /**
         * Descripcion :
         * Metodo para asignar usuario en caso sea necesario
         */

        function fcUsu($usuario)
        {	$this->_usua=$usuario;	}

        /**
         * Descripcion :
         * Metodo para asignar clave de ser necesario
         */
        function fcP($clave)
        {   $this->_pwd=$clave;  }

        /**
         * Descripcion :
         * Metodo para asignar puerto
         */

        function fcPuerto($puerto)
        {   $this->_port=$puerto;  }

        /**
         * Descripcion :
         * Metodo para conectar
         */
        function fcConectar()
        {
            $enlace = null;
            $enlace = new mysqli($this->_sevID, $this->_usua, $this->_pwd, $this->_db);
            $tildes = $enlace->query("SET NAMES 'utf8'");
            if ($enlace->connect_errno)
            {
                echo "Falló la conexión a MySQL: (".$mysqli->connect_errno.") " . $mysqli->connect_error;
                exit;
            }
            return $enlace;
        }

        function fcCerrarConexion($_cn)
        {
            $_cn->close();
        }

        /**
         * Descripcion :
         * Metodo que permite extraer la fila de una tabla
         */
        function fcExtraerCeldas($tabla)
        {   $fila=null;
            $fila = $tabla->fetch();
            return $fila;
        }

        /**
         * Metodo que permite extraer la cabecera de la tabla de resultado
         * @param type $_tabla
         * @return type
         */
        function fcExtraerCabecera($_tabla)
        {
            return $_tabla->fetch_field();
        }

        /**
         * Metodo que permite extrare una fila de datos
         * @param type $_tabla
         */
        function fcExtrarFilaAsociada($_tabla)
        {
            return $_tabla->fetch_array(MYSQLI_ASSOC);
        }

        /**
         * Metodo que permite ejecutar un store procedure
         * @param type $_sqlCall
         * @param type $_cn
         * @return type
         */
        function fcEjecutarSP($_sqlCall, $_cn , $_const)
        {
            return $_cn->query($_sqlCall , $_const);
        }

        /**
         *Descripcion:
         *Metodo que permite extraer todas las filas de una tabal de resultados
         */
        function fcExtraerTodos($tabla)
        {	$datos = array();
                $datos = $tabla->fetchAll(PDO::FETCH_NUM);
                $tabla->closeCursor();
                return $datos;
        }

        function formatearString($_cn , $_valor)
        {
            return $_cn->real_escape_string( $_valor);
        }

        function caracteres($str)
        {
                $search=array("\\","\0","\n","\r","\x1a","'",'"');
                $replace=array("\\\\","\\0","\\n","\\r","\Z","\'",'\"');
                return str_replace($search,$replace,$str);
        }
        /**
         * Descripcion:
         * Metodo que ejecuta una consulta y retorna una tabla de resultados
         * cuya cabecera de columnas estan en base al numero de columna
         * del resultado de la instruccion
         * @param type $sqlC
         * @param type $enlace
         * @param type $arrayParametros Array con los valores para el store
         * @param type $arrayTipoParametros array con los tipos de datos segun array anterior
         * @return type
         */
        function fcEjecutarConsulta($sqlC,  $enlace,
                                    $arrayParametros = array(),
                                    $arrayTipoParametros = array())
        {
            $_tabla=null;

            try
            {   //$_tabla= $enlace->stmt_init();
                $_tabla = $enlace->prepare($sqlC);
                $tipos = "";
                if (sizeof($arrayParametros)>0)
                {
                    for ($i=0; $i<sizeof($arrayParametros);$i++)
                    {   // si no tiene definido el tipo de parametro se asigna como string
                        $tipos.=(sizeof($arrayTipoParametros)>0)?"".$arrayTipoParametros[$i]:"s";
                        /*if ($arrayTipoParametros[$i]=='s')
                        {   //$arrayParametros[$i]= str_replace("\r\n"," " ,$this->caracteres($arrayParametros[$i]));
                            $arrayParametros[$i]=&$arrayParametros[$i];
                        }*/
                    }
                    $referencias = array_merge( array($tipos), $arrayParametros);
                    call_user_func_array(array($_tabla, 'bind_param'), $this->refValues($referencias) );
                }
                $_tabla->execute();
                $enlace->more_results();
                $_tabla->store_result();
            }
            catch(Exception $e)
            {		 echo "Error ".$e->getMessage()." ".$enlace->error;
                             $this->_msgError = $e->getMessage();
            }
            return $_tabla;
        }

        function fcEjecutarInstruccion($sqlC            , $enlace   ,
                                    $arrayParametros    = array(),
                                    $arrayTipoParametros= array())
        {
            $_tabla=null;
            try
            {   $_tabla= $enlace->stmt_init();
                $_tabla = $enlace->prepare($sqlC);
                $tipos = "";
                if (sizeof($arrayParametros)>0)
                {   for ($i=0; $i<sizeof($arrayParametros);$i++)
                    {  
                        $tipos.=(sizeof($arrayTipoParametros)>0)?"".$arrayTipoParametros[$i]:"s";
                    }
                }
                //$_tabla->bind_param();
                $_tabla->execute();
                $result = $stmt->get_result();
            }
            catch(Exception $e)
            {		 echo "Error ".$e->getMessage()." ".$enlace->error;
                             $this->_msgError = $e->getMessage();
            }
            return $result;
        }

        function refValues($arr){
            if (strnatcmp(phpversion(),'5.3') >= 0) //Reference is required for PHP 5.3+
            {
                $refs = array();
                $_arre = array();
                $_arre = &$arr;
                foreach($_arre as $key => $value)
                    $refs[$key] = &$_arre[$key];
                return $refs;
            }
            return $arr;
        }

        function crearStatement($_enlace , $_sql)
        {
            return $_enlace->prepare($_sql);
        }

        /**
         * Metodo que permite ordenar el resultado segun cabecera
         * @param type $stmt
         */
        function bind_result_array($stmt)
        {   $result = array();
            $this->_metaData = array();
            try
            {   $meta = $stmt->result_metadata();
                while ($field = $meta->fetch_field())
                {   $this->_metaData[]      = $field->name;
                    $result[$field->name]   = NULL;
                    $params[] = &$result[$field->name];
                }
                call_user_func_array(array(&$stmt, 'bind_result'), $this->refValues($params));
            }
            catch (Exception $ex)
            {
                echo "Error ".$ex->getMessage()." ".$stmt->error;
            }

            return $result;
        }

        public function getCopy($row)
        {
            return array_map(create_function('$a', 'return $a;'), $row);
        }

        /**
         * Metodo que permite obtener informacion de las columnas y otra metadata de la tabla de datos
         * @param type $_tabla tabla de datos
         * @return type Retrona la tabla de metadata
         */
        function retornaMetadata( $_tabla )
        {
            $tablaMD = $_tabla->result_metadata();
            return $tablaMD;
        }

        /**
         * Metodo que permite obtener informacion de una columna
         * @param type $_tablaMD
         * @return type  Campo ->Name
         */
        function retornarColumna($_tablaMD)
        {
            return $_tablaMD->fetch_field();
        }

       /**
        * MEtodo que libera de memoria el resultado
        * @param type $_tabla tabla de resultado
        */
        function cerrarTabla( $_tabla)
        {
            $_tabla->free_result();
            $_tabla->close();
        }

        /**
         * Metodo que
         * @param type $enlace
         * @return type
         */
        function fcUltimaCodigo($enlace)
        {
            return $enlace->insert_id;
        }

        /**
         * Metodo que ejecutar una consulta para Insertar o efectuar un update
         * @param type $sqlC Instruccion SQL
         * @param type $enlace Referencia MYSQLI
         * @param type $arrayParametros array de valores
         * @param type $arrayTipoParametros tipos de datos de cada uno de los valores
         * @return type
         */
        function fcEjecutaIU($sqlC       , $enlace       ,
                             $arrayParametros=array()    ,
                             $arrayTipoParametros= array())
        {   $this->_codigoInsertado = 0;
            $_tab = $enlace->prepare($sqlC);
            $tipos = "";
            if (sizeof($arrayParametros)>0)
            {
                 for ($i=0; $i<sizeof($arrayParametros);$i++)
                 {   // si no tiene definido el tipo de paramtero se asigna como string
                     $tipos.=(sizeof($arrayTipoParametros)>0)?$arrayTipoParametros[$i]:"s";
                 }
                 $referencias = array_merge( array($tipos), $arrayParametros);
                 call_user_func_array(array($_tab, 'bind_param'), $this->refValues($referencias ));
            }
            $_tab->execute();
            $this->_codigoInsertado = $_tab->insert_id;
            return $_tab->affected_rows;
        }

        /**
         * Metodo que genra opciones para un select
         * @param type $tabla
         * @param type $valor
         */
        function fcGeneraOpciones($tabla,$valor)
        {
            while ($fila=$this->fcExtraerCeldas($tabla))
            {
                echo "<option value='".$fila[0]."' ";
                if ($valor==$fila[0])
                {
                        echo " selected ";
                }

                echo " >";
                echo $fila[1];
                echo "</option>";
            }
        }

         /**
          * Metodo que me permite obtener el numero de filas
          * @param type $_resultado
          * @return type
          */
        function totalRegistros( $_resultado)
        {
            return $_resultado->num_rows;
        }

        // zona peruana
        function dateZone($fmt, $zone = 0)
        {
            return date($fmt, time() - date("Z") + $zone*3600);
        }

        // limpiar inyecciones sql
        function formatearCadena($cadena)
        {
            return str_replace("'","",$cadena);
        }
    }
?>
