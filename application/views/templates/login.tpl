<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<link href="views/css/font-awesome.css" rel="stylesheet">
		<link href="views/css/login.css" rel="stylesheet">
		<link rel="stylesheet" href="views/css/font-awesome.css">
		<script src="views/js/jquery-2.1.3.min.js"></script>
	</head>
	<script language="JavaScript">
	//alert(screen.width + " x " + screen.height);
	</script>
	<style>
		.hide{
			display: none;
		}
		.success{
			padding-top: 5px;
			padding-bottom:-2px;
			text-align: center;
			background-color: #aad7b9;
			border-color: #2f995e;
			color: #2f995e;
			width: 80%;
		}
		.alert{
			text-align: center;
			background-color: #d7b1aa;
			border-color: #993f2f;
			color: #993f2f;
		}
	</style>
	<body class="index">
		<center>
			<div class="container">
				{$url}
				<form method="POST" action="?action=login">
					<br>
					<div class="logo">
						<h1 style="color: rgb(96,142,184);">INICIO DE SESION</h1><br>
					</div>
					<!--<div class="{$clase}">
						{$titulo} <br><br> {$mensaje}
					</div><br>-->
					<div class="form-usu">
						<input type="text" class="text" id="usuario" name="usuario" placeholder="Usuario" autocomplete="off" value="{$usuario}" {$focus} ><br><br>
					</div>
					<div class="form-pass">
						<input type="password" class="text" id="contrasena" name="contrasena" placeholder="Contraseña" value="{$contrasena}" {$focps} ><br><br>
						<button type="submit" style="padding: 15px; border:none;color: white; background-color: rgb(78,117,171);">Ingresar</button><br>
					</div>
				</form>
			</div>
		</center>
	</body>

</html>
