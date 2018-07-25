<?php
	$_ruta = ""; 
    $action = isset($_GET["action"]) ? $_GET["action"] : 'login';
  
    if ($action=='cerrarsesion'){
       
        $view = new Smarty;

        $_SESSION['codigo']          =   '';
        $_SESSION['nombres']         =   '';
        $_SESSION['paterno']         =   '';
        $_SESSION['materno']         =   '';
        $_SESSION['sexo']            =   '';
        $_SESSION['fechanacimiento'] =   '';
        $_SESSION['idestadocivil']   =   '';
        $_SESSION['carrera']         =   '';
        $_SESSION['estado']          =   '';

		$view->assign(array(	
							'codigo'			=> '',
							'nombres'			=> '',
							'paterno'			=> '',
							'materno'			=> '',
							'sexo'				=> '',
							'fechanacimiento' 	=> '',
							'idestadocivil' 	=> '',
							'carrera' 			=> '', 
							'estado' 	   		=> '',
							
							'url'				=> '<meta http-equiv="refresh" content="0;url=?action=login">',
					));	
		

		session_destroy();
        $view->display('cerrarsesion.tpl');
	}
?>	