<?php
	$_ruta = "";
    $action = isset($_REQUEST["action"]) ? $_REQUEST["action"] : 'estadocuenta';

    if ($action=='estadocuenta'){
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
                            'id'          => $_SESSION['id'],
                            'codigo'      => $_SESSION['codigo'],
                            'nombres'     => $_SESSION['nombres'],
                            'paterno'     => $_SESSION['paterno'],
                            'materno'     => $_SESSION['materno'],
                            'carrera'     => $_SESSION['carrera']
           ));

		   $view->display('estadocuenta.tpl');
        }
    }

    if ($action=='ListarCtaCte'){
    	
        $codigoalum    = isset($_POST["codigo"]) ? $_POST["codigo"] : 0;
    	$concepto      = isset($_POST["concepto"]) ? $_POST["concepto"] : "";
        $_ruta="../../";
        
        require_once ($_ruta."models/DA/da.conexion.php");

        $sql = "SELECT convert(varchar,a.fechavencimiento,103) as fechavencimiento, datediff(day, cast(getdate() as date),cast(a.fechavencimiento as date)) as diferencia, b.descripcion ,a.cuota,(b.descripcion+' '+a.cuota) as busqueda, a.importeescalapago, a.idestadopago from cuco_ctactealumno_detalle a left join cuco_concepto b on a.idconcepto = b.idconcepto where idctactealumno in (select idctactealumno from cuco_ctactealumno where idalumno = '".$codigoalum."') and b.descripcion+' '+a.cuota LIKE '%".$concepto."%' ORDER BY a.cuota, b.descripcion ASC";

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
