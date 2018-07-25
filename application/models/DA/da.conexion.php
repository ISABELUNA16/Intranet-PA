<?php
	
	/**
    * funcion que permite conectar al servidor y base de datos "
    *
    * @author:  Rosmery Isabel Luna Tito
    * @versión:    1.0.0
    * @fecha:      04/02/2017
    */
		function fcConectar(){
		 
			$serverName = "54.165.224.4";
			$connectionInfo = array( "Database"=>"erpeduca_professionalair", "UID"=>"professionalair", "PWD"=>"Educa2o17");
			$conn = sqlsrv_connect($serverName,$connectionInfo);
			
			if($conn===false) {
				echo "la conexión no se pudo establecer.<br />";
				die (print_r(sqlsrv_connect(),true));
			}
			else
			{		
				return $conn;	
			}
			
		function fcDesconectar($conn){
			$conn->close();
		}
	}
?>