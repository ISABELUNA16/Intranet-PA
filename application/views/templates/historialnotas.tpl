<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
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
        <link rel="stylesheet" href="views/css/forms-tabla1.css">
		<script src="views/js/jquery-2.1.3.min.js"></script>
        <script>
    		
             function MostrarMes(xMes){
                var mes = '';

                 switch(xMes){
                    case 01:
                        mes = 'Enero';
                        break;

                    case 02:
                        mes = 'Febrero';
                        break;

                    case 03:
                        mes = 'Marzo';
                        break;

                    case 04:
                        mes = 'Abril';
                        break;

                    case 05:
                        mes = 'Mayo';
                        break;

                    case 06:
                        mes = 'Junio';
                        break;

                    case 07:
                        mes = 'Julio';
                        break;

                    case 08:
                        mes = 'Agosto';
                        break;

                    case 09:
                        mes = 'Setiembre';
                        break;

                    case 10:
                        mes = 'Octubre';
                        break;

                    case 11:
                        mes = 'Noviembre';
                        break;

                    case 12:
                        mes = 'Diciembre';
                        break;

                    default:
                        alert('No existe mes');
                }
                return mes;
             }

            function ListarNotas(xTipo, xOpcion){
                var xCodigo = document.getElementById('id').value;
                var xCarrera = document.getElementById('carrera').value;
                //envío de pará metros al bl-controlador para procesarlos

                if(xTipo==0 && xOpcion==0){
                    xTipo="TOTAL"
                }

                //alert(xTipo);

                var param = {
                    "action": "MostrarNotasCab",
                    "codigo": xCodigo
                };
                //retorno la información devuelta por el bl - controlador
                $.ajax({
                    type: "POST",
                    url: "controllers/BL/bl.historialnotas.php",
                    dataType: 'JSON',
                    data: param,
                    success: function(data)
                    {
                        var divnotas = '';
                        var aprobados = 0;
                        var desaprobados = 0;
                        var todos=0;

                        //divnotas+='<h4 style="color: rgb(64,97,140);">Relación de notas por mes</h4>'
                        divnotas+='<br>'
                        divnotas+='<center>'
                        divnotas+='<fieldset class="info">'
                        divnotas+='     <section class="aprobado success" onclick="javascript:ListarNotas(0,1)">'
                        divnotas+='          <p><div id="aprobado" name="aprobado"></div></p>'
                        divnotas+='     </section>'
                        divnotas+='<br>'
                        divnotas+='     <section class="desaprobado danger" onclick="javascript:ListarNotas(0,2)">'
                        divnotas+='          <p><div id="desaprobado" name="desaprobado" ></div></p>'
                        divnotas+='     </section>'
                        divnotas+='<br>'
                        divnotas+='     <section class="todos every" onclick="Javascript:ListarNotas(0, 0);">'
                        divnotas+='          <p><div id="todos" name="todos" ></div></p>'
                        divnotas+='     </section>'
                        divnotas+='</fieldset>'
                        divnotas+='</center>'
                        divnotas+='<br>'
                        divnotas+=' <table class="rwd_auto fontsize">'
                        divnotas+='     <thead>'
                        divnotas+='         <tr>'
                        divnotas+='           <th>Cód.</th>'
                        divnotas+='           <th>Curso</th>'
                        divnotas+='           <th>Sección</th>'
                        divnotas+='           <th>Mes</th>'
                        divnotas+='           <th>Prom.</th>'
                        divnotas+='         </tr>'
                        divnotas+='     </thead>'
                        divnotas+='<tbody>'

                        if (data.aaData.length>0) {
                            for(i=0; i<data.aaData.length; i++){
                                var xPromedio = parseInt(data.aaData[i]['promedio']).toFixed(2);

                                if (isNaN(xPromedio)){
                                    xPromedio = "0.00";
                                }

                                if (xTipo=="TOTAL"){
                                    divnotas+='<tr>'
                                    divnotas+='<td>'+data.aaData[i]['codigo']+'</td>'
                                    divnotas+='<td>'+data.aaData[i]['curso']+'</td>'
                                    divnotas+='<td><center>'+data.aaData[i]['seccion']+'</center></td>'
                                    divnotas+='<td>'+MostrarMes(parseInt(data.aaData[i]['mes']))+'</td>'

                                    if (xCarrera == 'GASTRONOMIA' || xCarrera == 'TRIPULANTE AUXILIAR' || xCarrera == 'AVIACION COMERCIAL' || xCarrera == 'COUNTER' || xCarrera == 'BARTENDER'){
                                        if (xPromedio>= 11){
                                            aprobados += 1;
                                            divnotas+='<td style="color:blue;">'+xPromedio+'</td>'

                                        }else{
                                            desaprobados += 1;
                                            divnotas+='<td style="color:red;">'+xPromedio+'</td>'
                                        }
                                    } else {
                                        if (xPromedio >= 80){
                                            aprobados += 1;
                                            divnotas+='<td style="color:blue;">'+xPromedio+'</td>'
                                        }else{

                                            desaprobados += 1;
                                            divnotas+='<td style="color:red;">'+xPromedio+'</td>'
                                        }
                                    }
                                }else{
                                    if (xOpcion==1){
                                         if (xCarrera == 'GASTRONOMIA' || xCarrera == 'TRIPULANTE AUXILIAR' || xCarrera == 'AVIACION COMERCIAL' || xCarrera == 'COUNTER' || xCarrera == 'BARTENDER'){
                                            if (xPromedio >= 11){
                                                aprobados += 1;
                                                divnotas+='<tr>'
                                                divnotas+='<td>'+data.aaData[i]['codigo']+'</td>'
                                                divnotas+='<td>'+data.aaData[i]['curso']+'</td>'
                                                divnotas+='<td><center>'+data.aaData[i]['seccion']+'</center></td>'
                                                divnotas+='<td>'+MostrarMes(parseInt(data.aaData[i]['mes']))+'</td>'
                                                divnotas+='<td style="color:blue;">'+xPromedio+'</td>'
                                            }else{
                                                desaprobados += 1;
                                            }
                                        }else {
                                            if (xPromedio >= 80){
                                                aprobados += 1;
                                                divnotas+='<tr>'
                                                divnotas+='<td>'+data.aaData[i]['codigo']+'</td>'
                                                divnotas+='<td>'+data.aaData[i]['curso']+'</td>'
                                                divnotas+='<td><center>'+data.aaData[i]['seccion']+'</center></td>'
                                                divnotas+='<td>'+MostrarMes(parseInt(data.aaData[i]['mes']))+'</td>'
                                                divnotas+='<td style="color:blue;">'+xPromedio+'</td>'
                                            }else{
                                                desaprobados += 1;
                                            }
                                        }
                                    }

                                    if (xOpcion==2){
                                         if (xCarrera == 'GASTRONOMIA' || xCarrera == 'TRIPULANTE AUXILIAR' || xCarrera == 'AVIACION COMERCIAL' || xCarrera == 'COUNTER' || xCarrera == 'BARTENDER'){
                                            if (xPromedio>= 11){
                                                aprobados += 1;
                                            }else{
                                                desaprobados += 1;
                                                divnotas+='<tr>'
                                                divnotas+='<td>'+data.aaData[i]['codigo']+'</td>'
                                                divnotas+='<td>'+data.aaData[i]['curso']+'</td>'
                                                divnotas+='<td><center>'+data.aaData[i]['seccion']+'</center></td>'
                                                divnotas+='<td>'+MostrarMes(parseInt(data.aaData[i]['mes']))+'</td>'
                                                divnotas+='<td style="color:red;">'+xPromedio+'</td>'
                                            }
                                        }else{
                                            if (xPromedio >= 80){
                                                aprobados += 1;
                                            }else{
                                                desaprobados += 1;
                                                divnotas+='<tr>'
                                                divnotas+='<td>'+data.aaData[i]['codigo']+'</td>'
                                                divnotas+='<td>'+data.aaData[i]['curso']+'</td>'
                                                divnotas+='<td><center>'+data.aaData[i]['seccion']+'</center></td>'
                                                divnotas+='<td>'+MostrarMes(parseInt(data.aaData[i]['mes']))+'</td>'
                                                divnotas+='<td style="color:red;">'+xPromedio+'</td>'
                                            }
                                        }
                                    }
                                }
                                divnotas+='</tr>'
                            }

                        }

                        divnotas+='</tbody>'
                        divnotas+='</table>'

                        todos= "Todos: " + (aprobados + desaprobados);

                        aprobados="Aprobados: " + aprobados
                        desaprobados="Desaprobados: " + desaprobados


                        $('#notas').html(divnotas);
                        $('#aprobado').html(aprobados);
                        $('#desaprobado').html(desaprobados);
                        $('#todos').html(todos);
                    }
                });
            }
        </script>
    </head>
    <body class="bg-fondo" onload="Javascript:ListarNotas('TOTAL', 0);">
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
							MI HISTORIAL DE NOTAS
						</div>
						<div class="div-descripcion text-justificado">
							En esta opción se mostrará sus notas por periodo.
						</div>
					</section>
				</center>
                <input type="hidden" id="id" name="id" value="{$id}">

                <div id="notas">
                </div>
                <input type="hidden" id="carrera" name="carrera" value="{$carrera}">

            </form>
        </div>
    </body>
 </html>
