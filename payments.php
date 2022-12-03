<html>
<?php 
 require('keys.php');
 $key=$razorpayAPI;
 $name=$_POST['nme'];
 $email=$_POST['mail'];
 $amount=$_POST['amt'];
 $mobile=$_POST['ph'];
?>


<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
var options = {
    
    "key": "<?php echo $key; ?>", // Enter the Key ID generated from the Dashboard
    "amount": "<?php echo ($amount*100);?>", // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
    "currency": "INR",
    "name": "बेहतर समाज",
    "description": "Test Transaction",
    "image": "https://example.com/your_logo",
    // "order_id": "<?php echo 'ORD'.rand(10,100).'END';?>", //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
    "handler": function (response){
        alert("Payment Successful");
        window.location.href="pinak.php";
        
    },    
    "prefill": {
        "name": "<?php echo $name; ?>",
        "email": "<?php echo $email; ?>",
        "contact": "<?php echo $mobile; ?>"
    },
    "theme": {
        "color": "#3399cc"
    }
};
var rzp1 = new Razorpay(options);
rzp1.open();
e.preventDefault();
rzp1.on('payment.failed', function (response){
        alert(response.error.code);
        alert(response.error.description);
        alert(response.error.source);
        alert(response.error.step);
        alert(response.error.reason);
        alert(response.error.metadata.order_id);
        alert(response.error.metadata.payment_id);
});
</script>

</html>
