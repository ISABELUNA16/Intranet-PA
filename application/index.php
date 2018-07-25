
<?php
	include('models/Libs/smarty/Smarty.class.php');
	session_start();
	$view = new smarty;
	$action= isset($_GET['action']) ? $_GET['action'] : 'login' ;

	if(isset($_SESSION['id']) && isset($_SESSION['iperfil'])){
		if(!empty($_SESSION['id'])){
		}
	}

	if(is_file('controllers/BL/bl.'.$action.'.php'))
	{
		include_once('controllers/BL/bl.'.$action.'.php');
	}else{
		include_once('controllers/BL/bl.error.php');
	}

?>
