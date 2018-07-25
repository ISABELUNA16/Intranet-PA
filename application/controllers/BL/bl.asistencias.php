<?php
	$_ruta = "";
    $action = isset($_REQUEST["action"]) ? $_REQUEST["action"] : 'login';

    if ($action=='asistencias'){

        $view = new Smarty;
        if (isset($_SESSION['id']))
        {

            $_SESSION['id']              =   $_SESSION['id'];
            $_SESSION['codigo']          =   $_SESSION['codigo'];
            $_SESSION['nombres']         =   $_SESSION['nombres'];
            $_SESSION['paterno']         =   $_SESSION['paterno'];
            $_SESSION['materno']         =   $_SESSION['materno'];
            $_SESSION['sexo']            =   $_SESSION['sexo'];
            $_SESSION['fechanacimiento'] =   $_SESSION['fechanacimiento'];
            $_SESSION['idestadocivil']   =   $_SESSION['idestadocivil'];
            $_SESSION['carrera']         =   $_SESSION['carrera'];
            $_SESSION['estado']          =   $_SESSION['estado'];

            $view->assign(array(
                            'id'                => $_SESSION['id'],
                            'codigo'            => $_SESSION['codigo'],
                            'nombres'           => $_SESSION['nombres'],
                            'paterno'           => $_SESSION['paterno'],
                            'materno'           => $_SESSION['materno'],
                            'carrera'           => $_SESSION['carrera']
           ));
		   $view->display('asistencias.tpl');
        }
    }

    if ($action=='ListarAsistencias'){
    	$codigoalum = isset($_POST["codigo"]) ? $_POST["codigo"] : 0;

        $_ruta="../../";
        require_once ($_ruta."models/DA/da.conexion.php");

        $sql= "SELECT al.idalumno AS id,c.descripcion AS curso,convert(varchar,hd.fecha,103) AS fecha, CONCAT(st.horainicio,'-',st.horafin) AS horario ,at.descripcion AS condicion
                FROM dbo.sa_alumno_programa AS g RIGHT OUTER JOIN
                         dbo.sa_cargalectiva_asistencia AS a ON g.idalumnoprograma = a.idalumnoprograma LEFT OUTER JOIN
                         dbo.sa_alumno AS al ON g.idalumno = al.idalumno LEFT OUTER JOIN
                         dbo.sa_cargalectiva AS cl LEFT OUTER JOIN
                         dbo.sa_curso AS c ON cl.idcurso = c.idcurso LEFT OUTER JOIN
                         dbo.sa_cargalectiva_docente AS d ON cl.idcargalectiva = d.idcargalectiva RIGHT OUTER JOIN
                         dbo.sa_turno AS st ON st.idturno = d.idturno LEFT OUTER JOIN
                         dbo.sa_cargalectiva_horario AS h ON d.idcargalectivadocente = h.idcargalectivadocente LEFT OUTER JOIN
                         dbo.sa_cargalectiva_horario_detalle AS hd ON h.idcargalectivahorario = hd.idcargalectivahorario ON
                         a.idcargalectivahorario = h.idcargalectivahorario LEFT OUTER JOIN
                         dbo.sa_cargalectiva_asistencia_tipo AS at ON a.idcargalectivaasistenciatipo = at.idcargalectivaasistenciatipo
                WHERE (al.idalumno = '".$codigoalum."')
                GROUP BY al.idalumno, hd.fecha, c.descripcion, at.descripcion, st.horainicio, st.horafin
                ORDER BY hd.fecha";
		
        $conn = fcConectar();
        $stmt =sqlsrv_query($conn, $sql);
        $i = 0;
        while ( $data = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)){
            $array[$i] = $data;
            $i++;
        }
         $datos = array('aaData' => $array);
         echo json_encode($datos);
    }
?>
