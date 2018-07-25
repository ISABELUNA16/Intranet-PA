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

        <link href="views/css/splash.css" rel="stylesheet">
    </head>

    <body class="bg-fondo">
        <div class="login-form">
            <div class="cabecera">
            </div>

            <div class="container">
				{$url}
                <form method="POST" action="?action=login">
                    <big class="text-light">Iniciar Sesión</big>
                    <hr class="thin">
                    <br>
                    <div class="{$clase}">
                        {$titulo} <br><br> {$mensaje}
                    </div>
                    <br>

                    <input class="form-control" id="usuario" name="usuario" placeholder="Usuario" maxlength="20"  {$desactivar} autocomplete="off" value="{$usuario}" {$focus} >
                    <br>
                    <br>

                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" maxlength="20" {$desactivar} value="{$contrasena}" {$focps} >
                    <br>
                    <br>

                    <button class="button-control text-centrado">Ingresar </button>

                    <br>
                    <!--
                    <div class="form-usu">
                        <input type="text" class="text" id="usuario" name="usuario" placeholder="Usuario" autocomplete="off" value="{$usuario}" {$focus} ><br><br>
                    </div>
                    <div class="form-pass">
                        <input type="password" class="text" id="contrasena" name="contrasena" placeholder="Contraseña" value="{$contrasena}" {$focps} ><br><br>
                        <button type="submit" style="padding: 15px; border:none;color: white; background-color: rgb(78,117,171);">Ingresar</button><br>
                    </div>
                    -->
                </form>
			</div>
        </div>
    </body>
</html>
