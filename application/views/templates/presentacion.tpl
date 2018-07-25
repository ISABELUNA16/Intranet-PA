<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="description" content="SGA - Sistema de Gestión Académico." />
        <meta name="keywords" content="escuela de pilotos, aviación comercial y gastronomía." />
        <meta name="Title" content="Professional Air"/>
        <meta name="author" content="Professional Air - www.professionalair.com" />
        <meta name="robots" content="all"/>
        <meta name="Distribution" content="Global"/>
        <title>Sistema de Gestión Académico</title>
		<link href="views/css/opciones.css" rel="stylesheet">
		<link href="views/css/font-awesome.css" rel="stylesheet">
		<script src="views/js/jquery-2.1.3.min.js"></script>
	
	</head>
	
	<body class="bg-fondo">
		<div class="login-form">
			<div class="cabecera">
				<div class="barra">
					<a href="?action=menus">
						<span class="fa fa-bars fa-2x"></span>
					</a>
				</div>
			</div>	
			<br>
			<br>
			<div class="text-light titulo">
				<b>
				<center>
				<small>{$nombres} {$paterno}  {$materno}</small><br></b>
				<div class="text-light subtitulo">{$carrera}</div>
				</center>
			</div>
			<span class="fa fa-user fa-2x" style="float: right; margin-right:90px;margin-top: -25px; "></span>
			<br>

			<form class="div-form">
		    	<input type="hidden" id="codigo" name="codigo" value="{$id}">

				<center>
					<section style="width: auto;">
						<div class="div-alumno">
							TUTORIAL DE USO
						</div>
						<div class="div-descripcion text-justificado">
							La escuela Professional Air ha desarrollado la aplicación Intranet Móvil, la cual te permitirá ver tus notas, asistencias, cursos aprobados y pagos realizados.
						</div>
					</section>
				</center>

				<div class="opciones">
					<table class="tabla01">
						<tbody>
							<tr>
								<td style="background: rgb(51,51,51);"><img src="views/image/pendientes.PNG" onclick="location.href='?action=pendientes'"></td>
								
								<td style="background: rgb(77,77,77);color: white; text-align: justify;font-size: 11px; padding-left: 10px; padding-right: 10px;">Al ingresar a esta opción se mostrará el listado de los conceptos en deuda si es que tuviera alguno.</td>
							</tr>
							<tr>
								<td style="background: rgb(22,73,154);"><img src="views/image/estadodecuenta.PNG" onclick="location.href='?action=estadocuenta'"></td>
								<td style="background: rgb(44,112,224);color: white;text-align: justify;font-size: 11px; padding-left: 10px; padding-right: 10px;">Al ingresar a la opción Pagos podrás consultar tus pagos realizados, los que aún están pendientes y los nuevos pagos.</td>
							</tr>
							<tr>
								<td style="background: rgb(191,90,21);"><img src="views/image/notas.PNG" onclick="location.href='?action=historialnotas'"></td>
								
								<td style="background: rgb(234,134,68);color: white; text-align: justify;font-size: 11px; padding-left: 10px; padding-right: 10px;">Al ingresar a esta opción podrás visualizar tu historial de notas por mes y año. </td>
							</tr>
							<tr>
								<td style="background: rgb(0,64,80);"><img src="views/image/asistencias.PNG" onclick="location.href='?action=asistencias'"></td>
								
								<td style="background: rgb(0,136,170);color: white; text-align: justify;font-size: 11px; padding-left: 10px; padding-right: 10px;">Al ingresar a esta opción  podrás visualizar  tu historial de asistencia a clases, además de poder buscar fácilmente por un intervalo de fechas.</td>
							</tr>
							<tr>
								<td style="background: rgb(162,0,37);"><img src="views/image/salir.PNG" onclick="location.href='?action=cerrarsesion'"></td>
								<td style="background: rgb(255,32,82); color:white; text-align: justify;font-size: 11px; padding-left: 10px; padding-right: 10px;">Salir del Sistema</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
		</div>
	</body>
</html>
