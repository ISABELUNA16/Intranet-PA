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

		<link href="views/css/panel.css" rel="stylesheet">
		<link href="views/css/opciones.css" rel="stylesheet">
		<link href="views/css/font-awesome.css" rel="stylesheet">

		<script src="views/js/jquery-2.1.3.min.js"></script>
	</head>
	<script>
		function MostrarDeuda(){
			var xCodigo = document.getElementById('codigo').value;

			//envío de parámetros al bl-controlador para procesarlos
			var param = {
			"action": "ConsultarDeuda",
			"codigo": xCodigo
			};

			//retorno la información devuelta por el bl - controlador
			$.ajax({
				type: "POST",
				url: "controllers/BL/bl.pendientes.php",
				dataType: 'JSON',
				data: param,
				success: function(data)
				{
					var divdeuda = '';
					/*
					divdeuda+= ' <h4>Conceptos Pendientes</h4>'
					divdeuda+='<br>'
					*/
					divdeuda+='<div class="panel panel-danger">'

					if (data.aaData.length>0) {
						for(i=0; i<data.aaData.length; i++){
							divdeuda+='	<div class="panel-heading">'
							divdeuda+='		<p>'+ data.aaData[i]['descripcion']+' '+ data.aaData[i]['cuota']+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    S/.'+data.aaData[i]['importeescalapago'] +'</p>'
							divdeuda+='	</div>'
							divdeuda+='		<div class="panel-body">'
							divdeuda+=' <p>Fecha de Vencimiento: ' + data.aaData[i]['fechavencimiento'] + '</p>'
							divdeuda+='    </div>'
						}
					}else{
						divdeuda+= ' <h4>Ud no tiene conceptos pendientes</h4>'
					}

					divdeuda+= '</div>'
					$('#deudas').html(divdeuda);
				}
			});
		}
	</script>
	<body class="bg-fondo" onload="javascript:MostrarDeuda();">
		<div class="login-form">
			<div class="cabecera">
				<div class="barra">
					<a href="?action=menus">
						<span class="fa fa-bars fa-2x"></span>
					</a>
				</div>
			</div>
			<br>
			
			<div class="text-light titulo">
				<b>
				<center>
				<small>{$nombres} {$paterno}   {$materno}</small><br></b>
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
							MIS PENDIENTES
						</div>
						<div class="div-descripcion text-justificado">
							En esta opción se muestra el listado general de todos los conceptos en deuda.
						</div>
					</section>
				</center>
				<br>
				<fieldset class="info">
					<input type="hidden" id="codigo" name="codigo" value="{$id}">
					<div id="deudas" name="deudas">
					</div>
				</fieldset>
			</form>
		</div>
	</body>
</html>
