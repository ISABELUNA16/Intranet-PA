<?php
    /**
    * Clase que permite realizar la operación de consulta directamente a las tablas."
    *
    * @author:  Rosmery Isabel Luna Tito
    * @versión:    1.0.0
    * @fecha:      04/02/2017
    */

    class ClsUsuario {
        public $usuario;
        public $contrasena;

        var $_objMys=null;
        var $_msg= "";
        var $_nColumnas = 0;
        var $_nFilas = 0;

        function fcConsultarUsuario($usuario,$contrasena){
            $_ruta = "";
            require_once ($_ruta."models/DA/da.conexion.php");

            $sql = " SELECT a.idalumno as id, a.persona as codigo, case p.segundonombre
            when '' then p.primernombre
            else (p.primernombre + ' ' + p.segundonombre)
            end nombres, p.apellidopaterno as paterno, p.apellidomaterno as materno, p.sexo, p.fechanacimiento, p.idestadocivil, [o].descripcion as carrera, a.estado as estado
            FROM (mae_organizacion AS o RIGHT JOIN sa_mallacurricular AS mc ON [o].idorganizacion = mc.idorganizacion) LEFT JOIN ((sa_alumno AS a LEFT JOIN mae_persona AS p ON a.persona = p.persona) LEFT JOIN sa_alumno_programa AS ap ON a.idalumno = ap.idalumno) ON mc.idmallacurricular = ap.idmallacurricular
            WHERE a.idalumno is not null and (a.idalumno = '".$_POST['usuario']."' and a.idalumno = '".$_POST['contrasena']."') ORDER BY a.idalumno ASC";

            $conn = fcConectar();
            $stmt = sqlsrv_query($conn,$sql);
            $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);
            $result = array();

          
            for ($i=0;$i<sizeof($row);$i++)
            {
                array_push($result, array(
                    "id"            => $row['id'],
                    "codigo"        => $row['codigo'],
                    "nombres"       => $row['nombres'],
                    "codigo"        => $row['paterno'],
                    "codigo"        => $row['materno'],
                    "nacimiento"    => $row['fechanacimiento'],
                    "idestadocivil" => $row['idestadocivil'],
                    "carrera"       => $row['carrera']
                ));
            }
        }
    }
?>
