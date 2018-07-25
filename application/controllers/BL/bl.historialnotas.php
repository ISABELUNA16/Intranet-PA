<?php
	$_ruta = "";
    $action = isset($_REQUEST["action"]) ? $_REQUEST["action"] : 'login';

    if ($action=='historialnotas'){
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
                            'id'         => $_SESSION['id'],
                            'codigo'     => $_SESSION['codigo'],
                            'nombres'    => $_SESSION['nombres'],
                            'paterno'    => $_SESSION['paterno'],
                            'materno'    => $_SESSION['materno'],
                            'carrera'    => $_SESSION['carrera']
           ));

		   $view->display('historialnotas.tpl');
        }
    }
    if ($action=='MostrarNotasCab'){

    	$codigoalum = isset($_POST["codigo"]) ? $_POST["codigo"] : 0;

        $_ruta="../../";
        require_once ($_ruta."models/DA/da.conexion.php");
        
        $sql= "select cu.codigocurso as codigo, ms.descripcion as semestre, cu.descripcion as curso, CONCAT(ss.descripcion,'-', st.descripcion) AS seccion ,ra.promediofinal as promedio,cl.idmes as mes
                from sa_rendimientoacademico ra inner join sa_matricula_cursos mc on (ra.idmatriculacursos =mc.idmatriculacursos) 
                    inner join sa_matricula ma on (mc.idmatricula = ma.idmatricula)
                    inner join sa_alumno_programa  ap on (ma.idalumnoprograma =ap.idalumnoprograma)
                    inner join sa_cargalectiva  cl on (mc.idcargalectiva = cl.idcargalectiva)
                    inner join sa_cargalectiva_docente cd on (cd.idcargalectiva=cl.idcargalectiva) 
                    inner join sa_turno st on (cd.idturno=st.idturno)
                    inner join sa_seccion ss on (cl.idseccion=ss.idseccion)
                    inner join mae_semestre ms on (cl.idsemestre = ms.idsemestre)
                    inner join sa_curso  cu on (cl.idcurso = cu.idcurso) 
            where ap.idalumno = '".$codigoalum."'";

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
