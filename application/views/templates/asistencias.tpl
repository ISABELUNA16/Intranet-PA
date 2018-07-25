<!DOCTYPE HTML>
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

		<link href="views/css/forms-tabla.css" rel="stylesheet">
		<link href="views/css/opciones.css" rel="stylesheet">
		<link href="views/css/font-awesome.css" rel="stylesheet">

		<script src="views/js/jquery-2.1.3.min.js"></script>
	</head>
	<script type="text/javascript">
		function MostrarAsistencias(xTipo,xOpcion){
			var xCodigo = document.getElementById('id').value;
	        var asistencia = 0;
	        var falta = 0;
	        var todos = 0;

			//alert(xOpcion);

            if(xOpcion==0){
                xTipo = "TODOS"
            }
			//alert(xTipo);

            //envío de parámetros al bl-controlador para procesarlos
            var param = {
                "action": "ListarAsistencias",
                "codigo": xCodigo
            };
                //retorno la información devuelta por el bl - bl-controlador
                $.ajax({
                    type: "POST",
                    url: "controllers/BL/bl.asistencias.php",
                    dataType: 'JSON',
                    data: param,
                    success: function(data)
                    {
						var cboestados = '';
						var divasistencia='';

						divasistencia+=' <table class="rwd_auto fontsize">'
						divasistencia+='     <thead>'
						divasistencia+='         <tr>'
						divasistencia+='             <th>FECHA </th>'
						divasistencia+='             <th>CURSO</th>'
						divasistencia+='             <th>HORARIO</th>'
						divasistencia+='             <th>CONDICION</th>'
						divasistencia+='         </tr>'
						divasistencia+='     </thead>'
						divasistencia+='  <tbody>'

						if (data.aaData.length>0){
							for(i=0; i<data.aaData.length; i++){
								if (xTipo=="TODOS"){
									if (data.aaData[i]['condicion']=='ASISTENCIA'){
										asistencia += 1
										condicion= '<img src="views/image/check.png" width="25px" height="25px" margin-top:10px;>'
									}else{
										falta += 1
										condicion= '<img src="views/image/aspa.png" width="20px" height="20px">'
									}

									todos =asistencia + falta
									divasistencia+='   <tr>'
									divasistencia+='     <td>'+ data.aaData[i]['fecha'] + '</td>'
									divasistencia+='     <td>'+ data.aaData[i]['curso'] +'</td>'
									divasistencia+='     <td>'+ data.aaData[i]['horario'] +'</td>'
									divasistencia+='     <td>'+ condicion + '</td>'
									divasistencia+='   </tr>'
								}else{
									if (xOpcion==1){
										if (data.aaData[i]['condicion']=='ASISTENCIA'){
											asistencia += 1
											condicion= '<img src="views/image/check.png" width="25px" height="25px" margin-top:10px;>'
											divasistencia+='   <tr>'
											divasistencia+='     <td>'+ data.aaData[i]['fecha'] + '</td>'
											divasistencia+='     <td>'+ data.aaData[i]['curso'] +'</td>'
											divasistencia+='     <td>'+ data.aaData[i]['horario'] +'</td>'
											divasistencia+='     <td>'+ condicion + '</td>'
											divasistencia+='   </tr>'
										}else{
											falta += 1
										}
									}else{
										if (xOpcion==2){
											if (data.aaData[i]['condicion']=='FALTA'){
												falta += 1
												condicion= '<img src="views/image/aspa.png" width="25px" height="25px" margin-top:10px;>'
												divasistencia+='   <tr>'
												divasistencia+='     <td>'+ data.aaData[i]['fecha'] + '</td>'
												divasistencia+='     <td>'+ data.aaData[i]['curso'] +'</td>'
												divasistencia+='     <td>'+ data.aaData[i]['horario'] +'</td>'
												divasistencia+='     <td>'+ condicion + '</td>'
												divasistencia+='   </tr>'
											}else{
												asistencia += 1
											}
										}
									}
								}
							}
						}
						//divanio+= '</select>'
						divasistencia+='</tbody>'
						divasistencia+='</table>'

						cboestados+= '<p>'
						cboestados+='<label class="select">'
	                    cboestados+= '<select id="estado" name="estado" onchange="javascript: MostrarAsistencias(0,this.value);">'
	                    cboestados+= '    <option value="" select> Seleccione ....</option>'
	                    cboestados+= '    <option value="0">Todos ('+(asistencia+falta)+')</option>'
	                    cboestados+= '    <option value="1">Asistencias ('+asistencia+')</option>'
	                    cboestados+= '    <option value="2">Faltas ('+falta+')</option>'
	                    cboestados+= '</select>'
	                     cboestados+='</label>'
	                    cboestados+= '</p>'
	                    cboestados+='<br>'

	                    $('#estados').html(cboestados);
						$('#TotAsistencia').html(divasistencia);
						//$('#asistencia').html(asistencia);
						//$('#falta').html(falta);
                  }
                });
			}
	</script>
	<body class="bg-fondo" onload="Javascript:MostrarAsistencias('TODOS',0);">
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
				<span class="fa fa-user-circle fa-2x"></span>
				<small>{$nombres} {$paterno}   {$materno}</small><br></b>
				<div class="text-light subtitulo">{$carrera}</div>
				</center>
			</div>
			
			
			<br>
			
			<form class="div-form">
				<input type="hidden" id="id" name="id" value="{$id}">

				<center>
					<section style="width: auto;">
						<div class="div-alumno">
							MI ASISTENCIA
						</div>
						<div class="div-descripcion text-centrado">
							En esta opción se muestra el listado de su asistencia diaria.<br>Para ver en detalle hacer click en cada uno de los recuadros.
						</div>
					</section>
				</center>

				<fieldset class="info">
					<div id="estados" name="estados">
					</div>
					<div id="TotAsistencia" name="TotAsistencia">
					</div>
				</fieldset>
			</form>
		</div>
	</body>
</html>
