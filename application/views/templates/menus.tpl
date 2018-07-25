<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
		<link href="views/css/opciones.css" rel="stylesheet">
		<link href="views/css/font-awesome.css" rel="stylesheet">

		<script src="views/js/jquery-2.1.3.min.js"></script>
	</head>
	<body class="bg-fondo">
		<div class="login-form">
			<div class="cabecera">
			</div>
			<br><br>
			<div class="text-light titulo">
				<center>
					<b><big style="color: rgb(0,0,72);">Bienvenido</big><b><br><br>
					<small>{$nombres}{$paterno}{$materno}</small><br>
					<div class="text-light subtitulo">{$carrera}</div>
				</center>
			</div>
			<br><br>
			<form class="div-form">
		    	<input type="hidden" id="codigo" name="codigo" value="{$id}">
		    	
				<center>
					<section style="width: auto;">
						<div class="div-alumno">
							OPCIONES DE ACCESO
						</div>
					</section>
				</center>
				<br>
				<div class="div-opciones">
					<center>
						<div class="espacio"></div>
						<button type="button" class="text-light btn-guinda" onclick="location.href='?action=presentacion'">
							<span class="fa fa-info fa-3x"></span> <br/>Tutorial <br> de Uso
						</button>
						<button type="button" class="text-light btn-dark" onclick="location.href='?action=pendientes'">
							<span class="fa fa-laptop fa-3x"></span><br>Pagos <br>Pendientes
						</button>
						<!-- <br /> -->
						<button type="button" class="text-light btn-azul" onclick="location.href='?action=estadocuenta'">
							<span class="fa fa-money fa-3x"></span><br>Estado de <br>Cuenta
						</button>
						<button type="button" class="text-light btn-naranja" onclick="location.href='?action=historialnotas'">
							<span class="fa fa-check-square-o fa-3x"></span><br/>Historial de <br>Notas
						</button>
						<!-- <br /> -->
						<button type="button" class="text-light btn-tile" onclick="location.href='?action=asistencias'">
							<span class="fa fa-edit fa-3x"></span><br/>Registro de <br>Asistencias
						</button>
						<button type="button" class="text-light btn-rojo" onclick="location.href='?action=cerrarsesion'">
							<span class="fa fa-check-square-o fa-3x	"></span><br/><br/>Salir
						</button>
						<!-- <br /> -->
					</center>
				</div>
				<footer>

				</footer>
			</form>
		</div>
	</body>
</html>
