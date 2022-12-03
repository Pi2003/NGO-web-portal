<?php 

session_start();
require_once "./pdo.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NGO INDEX</title>
 
    <?php include("bootstrap.php"); ?>
    <link rel="stylesheet" href="bootstrap/css/style.css">
</head>
<div class = "row ">
    <div class="col-6 "><h3>SKILLS ACQUIRED BY PEOPLE WHO ARE IN JAIL(FOR THEIR CRIMES) DURING THEIR SERVICE IN NGO</h3></div>
  </div>
  <div class = "row ">
    <div class="col-6">
      <table class="table shadow-lg p-3 mb-5 bg-light rounded ">
        <thead class="thead-dark">
          <tr class="">
            <th class="" scope="col">Sno </th>
            <th class="" scope="col">Task</th>
            <th class="" scope="col">Name</th>
            <th class="" scope="col">Working for NGO</th>
            <th></th>
          </tr>
        </thead>
        <tbody class="">
        <?php 
             $stmt3 = $pdo->query("SELECT task.task ,task.task_id, volunteer.name,city.cname FROM task INNER JOIN volunteer ON volunteer.volunteer_id = task.volunteer_id AND volunteer.STATUS='community service' INNER JOIN city ON volunteer.city_id=city.city_id");
             $rows = $stmt3->fetchAll(PDO::FETCH_ASSOC);
             $count = 1;
              foreach($rows as $row){
                echo "<tr class=''>";
                echo "<th scope='row' class=''>".$count."</th>";
                echo "<td class=''>".htmlentities($row['task'])."</td>";
                echo "<td class=''>".htmlentities($row['name'])."</td>";
                echo "<td class=''>".htmlentities($row['cname'])."</td>";
                echo("<td  > <a class='btn btn-primary btn-m' href='volunteer/deleteTask2.php?task_id=".$row['task_id']."'>Remove Task</a></td>");
                echo "</tr>";
              $count++;
              }
            ?>
            
        </tbody>
      </table>
   </div>
  </div>
 
  <div class = "row ">
    <div class="col-6">
   </div>
</div>