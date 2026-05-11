<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f4f6f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.card {
    width: 400px;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.btn-primary {
    background-color: #042C53;
}
</style>
</head>

<body>

<div class="card">
    <h3 class="text-center mb-3">Login</h3>

    <!-- ✅ SUCCESS MESSAGE -->
    <% if (request.getParameter("success") != null) { %>
        <div class="alert alert-success">
            Registration successful! Please login.
        </div>
    <% } %>

    <!-- ❌ LOGIN ERROR -->
    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">
            Invalid email or password!
        </div>
    <% } %>

    <!-- ✅ LOGIN FORM -->
    <form action="/login" method="post">

        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="username" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary w-100">Login</button>
    </form>

    <div class="text-center mt-3">
        <span>New user?</span>
        <a href="/register">Create Account</a>
    </div>
</div>

</body>
</html>