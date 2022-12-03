<?php


if(isset($_SESSION['admin_id'])){
    require_once "./adminIndex2.php";

}

 ?>
<?php 
session_start();
require_once "../pdo.php";
if(isset($_POST['cancel'])){
    header('Location: ../index1.html');
    return;
}
if ( isset($_POST['email'])) {
    if((strlen($_POST['email'])>0) && (strlen($_POST['password'])>0)){
        $stmt3 = $pdo->query("SELECT `admin_id` FROM `admin_login` WHERE email = '".$_POST['email']."' AND PASSWORD ='".$_POST['password']."'");
        $rows2 = $stmt3->fetchAll(PDO::FETCH_ASSOC);
        if(count($rows2)>=1){
           $_SESSION['admin_id']=$rows2[0]['admin_id'];
           $_SESSION['role']= 2;
           header("Location:../index.php");
           return;
        } else {
            $_SESSION['error']="Wrong Email and Password";
            header("Location: adminLogin.php");
            return;
        } 
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO - login</title>
    <link rel="stylesheet" href="../bootstrap/css/style.css">
    <?php include("bootstrap.php"); ?>
 
</head>
<body class="text-center">

<?php
    if(isset($_SESSION['success'])){
        echo '<div class="alert alert-success" role="alert">';
        echo $_SESSION['success'];
        unset ($_SESSION['success']);
        echo '</div>' ;
    }

    if(isset($_SESSION['error'])){
        echo '<div class="alert alert-danger" role="alert">';
        echo $_SESSION['error'];
        unset($_SESSION['error']);
        echo '</div>';
    }
?>
    <form class="form-signin"  method="post" >  
        <img class="mb-4" src="../images/index/logo.png" alt="" width="72" height="72">
        <h3 class="h3 mb-3 font-weight-normal">Admin Login</h3>  

    <p><label for="username" >Email :</label>
    <input type="text" name = "email" id = "email">
    </p>
    <p><label  for="password">Password :</label>
    <input type="password"  name = "password" id ="password">
    </p>
    <p><input type="submit" class="btn btn-lg btn-primary btn-bloc" name="submit">  <input type="submit" class="btn btn-lg btn-primary btn-bloc" name="cancel" value = "cancel"></p>

    </form>
 
</body>
</html>