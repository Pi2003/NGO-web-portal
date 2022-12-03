<?php
    //connect database
    $conn=mysqli_connect('localhost','root','','ngoproject');
    if($conn===false){
        die('Connection Failed: ' .mysqli_connect_error());
    }
    else{
        $paymentid=response.razorpay_payment_id;
        echo "Connected Successfully";
        $query="INSERT INTO `form` (`name`, `amount`, `status`, `payment_id`) VALUES ('$name', '$amount', 'Success', '$paymentid');";
        mysqli_query($conn,$query);
    } 
    // close the connection
    mysqli_close($conn);
?>