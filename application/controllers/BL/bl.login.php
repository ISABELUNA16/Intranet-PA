<?php
    $action = isset($_REQUEST['action']) ? $_REQUEST['action'] : 'login';
    if ($action=='login')
    {
        $view = new Smarty;

        $usuario = isset($_POST['usuario']) ? $_POST['usuario'] : '';
        $contrasena = isset($_POST['contrasena']) ? $_POST['contrasena'] : '';

        if(empty($usuario) && empty($contrasena))
        {
            $view->assign(array('clase' => 'hide', 'titulo' => '', 'mensaje' => '', 'usuario' => '', 'contrasena' => '', 'desactivar' => '', 'focus' => 'autofocus', 'focps' => '', 'nombres' => '', 'paterno' => '', 'materno' => '', 'url' => ''));
        }
        else
        {
            if(!empty($usuario))
            {
                if(!empty($contrasena))
                {
                    $_ruta = "";
                    require_once ($_ruta."models/DA/da.conexion.php");

                    $sql = "SELECT a.idalumno as id, a.persona as codigo, case p.segundonombre
                    when '' then p.primernombre
                    else (p.primernombre + ' ' + p.segundonombre)
                    end nombres, p.apellidopaterno as paterno, p.apellidomaterno as materno, p.sexo, p.fechanacimiento, p.idestadocivil, [o].descripcion as carrera, a.estado as estado
                    FROM (mae_organizacion AS o RIGHT JOIN sa_mallacurricular AS mc ON [o].idorganizacion = mc.idorganizacion) LEFT JOIN ((sa_alumno AS a LEFT JOIN mae_persona AS p ON a.persona = p.persona) LEFT JOIN sa_alumno_programa AS ap ON a.idalumno = ap.idalumno) ON mc.idmallacurricular = ap.idmallacurricular
                    WHERE a.idalumno is not null and (a.idalumno = '".$usuario."' and a.idalumno = '".$contrasena."') ORDER BY a.idalumno ASC";

                    $conn = fcConectar();
                    $stmt = sqlsrv_query($conn,$sql);

                    $row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC);

                    if($row['estado']==0)
                    {
                        $view->assign(array('clase' => 'alert', 'titulo' => '<b>Ops!</b>', 'mensaje' => 'Esta cuenta está desactivada', 'desactivar' => '', 'usuario' => '', 'contrasena' => '', 'focus' => 'autofocus', 'focps' => '', 'nombres' => '', 'paterno' => '', 'materno' => '', 'url' => ''));

                    }else{

                        $_SESSION['id']              =   $row['id'];
                        $_SESSION['codigo']          =   $row['codigo'];
                        $_SESSION['nombres']         =   utf8_encode($row['nombres']);
                        $_SESSION['paterno']         =   utf8_encode($row['paterno']);
                        $_SESSION['materno']         =   utf8_encode($row['materno']);
                        $_SESSION['sexo']            =   utf8_encode($row['sexo']);
                        $_SESSION['fechanacimiento'] =   $row['fechanacimiento'];
                        $_SESSION['idestadocivil']   =   $row['idestadocivil'];
                        $_SESSION['carrera']         =   $row['carrera'];
                        $_SESSION['estado']          =   $row['estado'];


                       //$view->assign(array('clase' => 'success', 'titulo' => '<b>Bienvenido al Sistema</b>', 'mensaje' => $_SESSION['nombres'].' '.$_SESSION['paterno']."<br><br>", 'desactivar' => 'disabled', 'usuario' => '', 'contrasena' => '', 'focus' => 'autofocus', 'focps' => 'autofocus', 'nombres' => $_SESSION['nombres'], 'paterno' => $_SESSION['paterno'], 'materno' => $_SESSION['materno'], 'url' => '<meta http-equiv="refresh" content="1;url=?action=menus">'));


                       $view->assign(array('clase' => 'success','titulo'=>'','mensaje'=> '','desactivar'=> '','usuario'=>'','contrasena' => '', 'focus' => 'autofocus', 'focps' => 'autofocus', 'nombres' => $_SESSION['nombres'], 'paterno' => $_SESSION['paterno'], 'materno' => $_SESSION['materno'], 'url' => '<meta http-equiv="refresh" content="0;url=?action=menus">'));

                    }
                }else{
                    $view->assign(array('clase' => 'alert', 'titulo' => '<b>Ops!</b>', 'mensaje' => 'Ingrese su contraseña.', 'desactivar' => '', 'usuario' => $usuario, 'contrasena' => '', 'focus' => '', 'focps' => 'autofocus', 'nombres' => '', 'paterno' => '', 'materno' => '', 'url' => ''));
                }
            }else{
                $view->assign(array('clase' => 'alert', 'titulo' => '<b>Ops!</b>', 'mensaje' => 'Ingrese su nombre de usuario.', 'desactivar' => '', 'usuario' => '', 'contrasena' => '', 'focus' => 'autofocus', 'focps' => '', 'nombres' => '', 'paterno' => '', 'materno' => '', 'url' => ''));
            }
        }
        $view->display('login/login.tpl');
    }
?>
