<?php
    $view = new Smarty;
    $view->assign(array('nombres' => '', 'paterno' => '', 'materno' => '', 'perfil' => ''));
    $action = isset($_GET["action"]) ? $_GET["action"] : 'error';
    
    if(isset($_SESSION['id']) && isset($_SESSION['iperfil']))
    {
        $_SESSION['id']     =   $_SESSION['id'];
        $_SESSION['nombres']=   $_SESSION['nombres'];
        $_SESSION['paterno']=   $_SESSION['paterno'];
        $_SESSION['materno']=   $_SESSION['materno'];
        $_SESSION['iperfil']=   $_SESSION['iperfil'];
        $_SESSION['dperfil']=   $_SESSION['dperfil'];
        $_SESSION['genero'] =   $_SESSION['genero'];
        $_SESSION['estado'] =   $_SESSION['estado'];
        $_SESSION['modulos'] =  $_SESSION['modulos'];
        
        if(!empty($_SESSION['id']))
        {
            $view->assign(array(
                                    'nombres'   => $_SESSION['nombres'], 
                                    'paterno'   => $_SESSION['paterno'], 
                                    'materno'   => $_SESSION['materno'], 
                                    'perfil'    => $_SESSION['dperfil'], 
                                    'modulos'   => $_SESSION['modulos']
            ));
            $view->display('error.tpl');
        }else{
            $view->display('error.tpl');
        }
    }else{
        $view->display('error.tpl');
    }
?>