<?php

	$_ruta = "";
    $action = isset($_REQUEST["action"]) ? $_REQUEST["action"] : 'login';

    if ($action=='menus'){

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

		   $view->display('menus.tpl');
        }
    }

	
?>