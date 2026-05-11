<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<%@ include file="navbar.jsp" %>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<h2>Checkout</h2>

<h4>Total: ₹ ${total}</h4>

<button class="btn btn-primary" onclick="payNow()">Pay Now 💳</button>

<script>
function payNow() {

    fetch('/create-order?amount=${total}', {
        method: 'POST'
    })
    .then(res => res.json())
    .then(order => {

        var options = {
            "key": "rzp_test_SfFKZ5fuiQKiTO",
            "amount": order.amount,
            "currency": "INR",
            "name": "EduPlatform",
            "description": "Course Purchase",
            "order_id": order.id,

            "handler": function (response){

                fetch('/verify-payment', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        paymentId: response.razorpay_payment_id,
                        orderId: response.razorpay_order_id,
                        signature: response.razorpay_signature
                    })
                })
                .then(res => res.text())
                .then(data => {
                    if (data === "success") {
                        window.location.href = "/my-courses";
                    } else {
                        alert("Payment failed ❌");
                    }
                });
            }
        };

        var rzp = new Razorpay(options);
        rzp.open();
    });
}
</script>

</body>
</html>