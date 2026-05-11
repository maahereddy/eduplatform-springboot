<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f4f6f9;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
}

.card{
    width:450px;
    padding:30px;
    border-radius:15px;
    box-shadow:0 4px 20px rgba(0,0,0,0.1);
}

.btn-primary{
    background-color:#042C53;
    border:none;
}

.btn-primary:hover{
    background:#06427c;
}

h3{
    font-weight:bold;
}

.error{
    color:red;
    font-size:14px;
    margin-top:4px;
}

input:focus{
    box-shadow:none !important;
    border-color:#042C53 !important;
}
</style>

</head>

<body>

<div class="card">

    <h3 class="text-center mb-4">Create Account</h3>

    <!-- SERVER ERROR -->
    <c:if test="${not empty error}">
        <div class="alert alert-danger text-center">
            ${error}
        </div>
    </c:if>

    <!-- FORM -->
    <form action="/register" method="post" onsubmit="return validateForm()">

        <!-- NAME -->
        <div class="mb-3">
            <label>Full Name</label>

            <input type="text"
                   id="name"
                   name="name"
                   class="form-control"
                   placeholder="Enter your name">

            <div id="nameError" class="error"></div>
        </div>

        <!-- EMAIL -->
        <div class="mb-3">
            <label>Email</label>

            <input type="email"
                   id="email"
                   name="email"
                   class="form-control"
                   placeholder="Enter your email">

            <div id="emailError" class="error"></div>
        </div>

        <!-- PASSWORD -->
        <div class="mb-3">
            <label>Password</label>

            <input type="password"
                   id="password"
                   name="password"
                   class="form-control"
                   placeholder="Enter password">

            <div id="passwordError" class="error"></div>
        </div>

        <!-- CONFIRM PASSWORD -->
        <div class="mb-3">
            <label>Confirm Password</label>

            <input type="password"
                   id="confirmPassword"
                   name="confirmPassword"
                   class="form-control"
                   placeholder="Confirm password">

            <div id="confirmPasswordError" class="error"></div>
        </div>

        <!-- ADDRESS -->
        <div class="mb-3">
            <label>Address</label>

            <input type="text"
                   id="address"
                   name="address"
                   class="form-control"
                   placeholder="Enter address">

            <div id="addressError" class="error"></div>
        </div>

        <!-- MOBILE -->
        <div class="mb-3">
            <label>Mobile Number</label>

            <input type="text"
                   id="mobileNo"
                   name="mobileNo"
                   class="form-control"
                   placeholder="Enter mobile number">

            <div id="mobileError" class="error"></div>
        </div>

        <!-- BUTTON -->
        <button type="submit" class="btn btn-primary w-100">
            Register
        </button>

    </form>

    <!-- LOGIN -->
    <div class="text-center mt-3">
        Already have an account?
        <a href="/login">Login</a>
    </div>

</div>

<!-- VALIDATION SCRIPT -->
<script>

function validateForm(){

    let isValid = true;

    // CLEAR ERRORS
    document.getElementById("nameError").innerHTML = "";
    document.getElementById("emailError").innerHTML = "";
    document.getElementById("passwordError").innerHTML = "";
    document.getElementById("confirmPasswordError").innerHTML = "";
    document.getElementById("addressError").innerHTML = "";
    document.getElementById("mobileError").innerHTML = "";

    // GET VALUES
    let name = document.getElementById("name").value.trim();
    let email = document.getElementById("email").value.trim();
    let password = document.getElementById("password").value.trim();
    let confirmPassword = document.getElementById("confirmPassword").value.trim();
    let address = document.getElementById("address").value.trim();
    let mobile = document.getElementById("mobileNo").value.trim();

    // NAME
    if(name.length < 3){
        document.getElementById("nameError").innerHTML =
            "Name must be at least 3 characters";
        isValid = false;
    }

    // EMAIL
    let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;

    if(!email.match(emailPattern)){
        document.getElementById("emailError").innerHTML =
            "Enter valid email address";
        isValid = false;
    }

    // PASSWORD
    let passwordPattern =
        /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    if(!password.match(passwordPattern)){
        document.getElementById("passwordError").innerHTML =
            "Password must contain uppercase, lowercase, number & special character";
        isValid = false;
    }

    // CONFIRM PASSWORD
    if(password !== confirmPassword){
        document.getElementById("confirmPasswordError").innerHTML =
            "Passwords do not match";
        isValid = false;
    }

    // ADDRESS
    if(address.length < 5){
        document.getElementById("addressError").innerHTML =
            "Enter valid address";
        isValid = false;
    }

    // MOBILE
    let mobilePattern = /^[6-9]\d{9}$/;

    if(!mobile.match(mobilePattern)){
        document.getElementById("mobileError").innerHTML =
            "Enter valid 10-digit mobile number";
        isValid = false;
    }

    return isValid;
}

</script>

</body>
</html>