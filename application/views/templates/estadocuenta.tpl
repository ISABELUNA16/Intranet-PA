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

        <link href="views/css/input.css" rel="stylesheet">
        <link href="views/css/panel.css" rel="stylesheet">
		<link href="views/css/opciones.css" rel="stylesheet">
		<link href="views/css/font-awesome.css" rel="stylesheet">

		<script src="views/js/jquery-2.1.3.min.js"></script>
    </head>
    <script>
        function CtateAlumno(xTipo, xOpcion){

            var xCodigo = document.getElementById('id').value;
            var xConcepto = document.getElementById('concepto').value;

            if(xOpcion==0){
                xTipo = "TODOS"
            }

            //envío de parámetros al bl-controlador para procesarlos
            var param = {
                "action": "ListarCtaCte",
                "codigo": xCodigo,
                "concepto": xConcepto
            };
            //retorno la información devuelta por el bl - controlador
            $.ajax({
                type: "POST",
                url: "controllers/BL/bl.estadocuenta.php",
                dataType: 'JSON',
                data: param,

                success: function(data)
                {
                    var cboestados = '';
                    var divpaginas = '';
                    var divdeuda = '';
                    var diveecc  = '';
                    var C = 0;
                    var V = 0;
                    var P = 0;

                    if (data.aaData.length>0) {
                        for(i=0; i<data.aaData.length; i++){
                            if(xTipo == "TODOS"){
                                if (data.aaData[i]['idestadopago']=='C'){
                                    C += 1
                                    divdeuda+='<div class="panel panel-success">'
                                }else{
                                    if(data.aaData[i]['diferencia'] <= 0){
                                        divdeuda+='<div class="panel panel-danger">'
                                        V += 1
                                    }else{
                                        divdeuda+='<div class="panel panel-warning">'
                                        P += 1
                                    }
                                }

                                divdeuda+='<div class="panel-heading">'
                                divdeuda+='		<p>'+ data.aaData[i]['descripcion']+' '+ data.aaData[i]['cuota']+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    S/. '+data.aaData[i]['importeescalapago'] +'</p>'
                                divdeuda+='	</div>'
                                divdeuda+='		<div class="panel-body">'
                                divdeuda+=' 		<p>Fecha de Vencimiento: ' + data.aaData[i]['fechavencimiento'] + '</p>'
                                divdeuda+='    </div>'
                                divdeuda+=' </div>'
                            }else{
                                if(xOpcion==1){
                                    if (data.aaData[i]['idestadopago']=='C'){
                                        C += 1
                                        divdeuda+='<div class="panel panel-success">'
                                        divdeuda+='	<div class="panel-heading">'
                                        divdeuda+='		<p>'+ data.aaData[i]['descripcion']+' '+ data.aaData[i]['cuota']+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    S/. '+data.aaData[i]['importeescalapago'] +'</p>'
                                        divdeuda+='	</div>'
                                        divdeuda+='		<div class="panel-body">'
                                        divdeuda+=' 		<p>Fecha de Vencimiento: ' + data.aaData[i]['fechavencimiento'] + '</p>'
                                        divdeuda+='    </div>'
                                        divdeuda+=' </div>'
                                    }else{
                                        if(data.aaData[i]['diferencia'] <= 0){
                                            V += 1
                                        }else{
                                            P += 1
                                        }
                                    }
                                }
                                if(xOpcion==2){
                                    if (data.aaData[i]['idestadopago']=='C'){
                                        C += 1
                                    }else{
                                        if(data.aaData[i]['diferencia'] <= 0){
                                            divdeuda+='<div class="panel panel-danger">'
                                            divdeuda+='	<div class="panel-heading">'
                                            divdeuda+='		<p>'+ data.aaData[i]['descripcion']+' '+ data.aaData[i]['cuota']+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    S/. '+data.aaData[i]['importeescalapago'] +'</p>'
                                            divdeuda+='	</div>'
                                            divdeuda+='		<div class="panel-body">'
                                            divdeuda+=' 		<p>Fecha de Vencimiento: ' + data.aaData[i]['fechavencimiento'] + '</p>'
                                            divdeuda+='    </div>'
                                            divdeuda+=' </div>'
                                            V += 1
                                        }else{
                                            P += 1
                                        }
                                    }
                                }
                                if(xOpcion==3){
                                    if (data.aaData[i]['idestadopago']=='C'){
                                        C += 1
                                    }else{
                                        if(data.aaData[i]['diferencia'] <= 0){
                                            V += 1
                                        }else{
                                            divdeuda+='<div class="panel panel-warning">'
                                            divdeuda+='	<div class="panel-heading">'
                                            divdeuda+='		<p>'+ data.aaData[i]['descripcion']+' '+ data.aaData[i]['cuota']+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    S/. '+data.aaData[i]['importeescalapago'] +'</p>'
                                            divdeuda+='	</div>'
                                            divdeuda+='		<div class="panel-body">'
                                            divdeuda+=' 		<p>Fecha de Vencimiento: ' + data.aaData[i]['fechavencimiento'] + '</p>'
                                            divdeuda+='    </div>'
                                            divdeuda+=' </div>'
                                            P += 1
                                        }
                                    }
                                }

                            }
                        }
                    }

                    cboestados+= '<p>'
                    cboestados+='<label class="select">'
                    cboestados+= '<select id="estado" name="estado" onchange="javascript: CtateAlumno(0,this.value);">'
                    cboestados+= '    <option value=-1 select> Seleccione ... </option>'
                    cboestados+= '    <option value=0>Todos ('+(C+V+P)+')</option>'
                    cboestados+= '    <option value=1>Cancelados ('+C+')</option>'
                    cboestados+= '    <option value=2>Vencidos ('+V+')</option>'
                    cboestados+= '    <option value=3>Pendientes ('+P+')</option>'
                    cboestados+= '</select>'
                    cboestados+='</label>'
                    cboestados+= '</p>'

                    $('#estados').html(cboestados);
                    $('#deudas').html(diveecc + divdeuda);
            
                }
            });
        }
    </script>
    <body class="bg-fondo" onload="javascript: CtateAlumno('TODOS', 0);">
		<div class="login-form">
            <div class="cabecera">
				<div class="barra">
					<a href="?action=menus">
						<span class="fa fa-bars fa-2x"></span>
					</a>
				</div>
			</div>
          <br>
            <span class="fa fa-user fa-2x" style="float: left; margin-left:150PX;"></span>
            <div class="text-light titulo">
                <b>
                <center>
                <small>{$nombres} {$paterno} {$materno}</small><br></b>
                <div class="text-light subtitulo">{$carrera}</div>
                </center>
            </div>
            <br>
			<form class="div-form">
		    	<input type="hidden" id="codigo" name="codigo" value="{$id}">

				<center>
					<section style="width: auto;">
						<div class="div-alumno">
							MI CUENTA CORRIENTE
						</div>
                        <input type="hidden" id="id" name="id" value="{$id}" >

                        <br>
						<div class="div-descripcion text-justificado">
							En esta opción se muestra el listado general de todos los conceptos cancelados y pendientes.<br>Para ver en detalle hacer click en cada uno de los recuadros.
						</div>
                        <br>
                          <div class="row">
                            <input type="text" id="concepto" name="concepto" class="input" placeholder=" Buscar concepto..." autocomplete="off" maxlength="15">
                            <button class="btninfo" type="button" onclick="javascript: CtateAlumno('TODOS', 0);"><span class="fuente fa fa-search"></span>
                            </button>
                        </div>
					</section>
                    <fieldset class="info">
                        <div id="estados" name="estados">
                        </div>
                        <div id="deudas" name="deudas">
                        </div>
                    </fieldset>
				</center>
            </form>
        </div>
        <script type="text/javascript">
            $(function()
            {
                $('#concepto').keypress(function(e) {
                    if (e.which == 13) {
                        CtateAlumno('TODOS', 0);
                        return false;
                    }
                })
            });
        </script>
    </body>
</html>
