<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <h2 class="mb-4">🛒 Your Cart</h2>

    <c:choose>

        <c:when test="${empty cartCourses}">
            <div class="text-center mt-5">
                <h4>Your cart is empty 😔</h4>
                <a href="/courses" class="btn btn-primary mt-3">
                    Browse Courses
                </a>
            </div>
        </c:when>

        <c:otherwise>

         <c:forEach var="course" items="${cartCourses}">

    <div class="card p-3 mb-3 shadow-sm">
        <div class="d-flex justify-content-between align-items-center">

            <div>
                <h5>${course.title}</h5>
                <p class="text-muted mb-0">₹ ${course.price}</p>
            </div>

            <form action="/remove-from-cart" method="post">
                <input type="hidden" name="courseId" value="${course.id}" />
                <button class="btn btn-outline-danger btn-sm">
                    ❌ Remove
                </button>
            </form>

        </div>
    </div>

</c:forEach>
            <div class="card p-3 mt-4">
    <h4>Total: ₹ ${total}</h4>
</div>

            <a href="/checkout" class="btn btn-success mt-3">
                Proceed to Checkout 💳
            </a>

        </c:otherwise>

    </c:choose>

</div>

</body>
</html>