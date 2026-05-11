<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Courses</title>
    <meta charset="UTF-8">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .card {
            transition: 0.3s;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container my-5">

    <h2 class="text-center mb-4">My Enrolled Courses</h2>

    <div class="row g-4">

        <!-- If no courses -->
        <c:if test="${empty myCourses}">
            <div class="text-center">
                <h5>No courses enrolled yet 😔</h5>
                <a href="/courses" class="btn btn-primary mt-3">Browse Courses</a>
            </div>
        </c:if>

        <!-- Course List -->
        <c:forEach var="e" items="${myCourses}">
            <div class="col-md-4">

                <div class="card p-4 border-0 shadow-sm h-100">

                    <h5 class="fw-bold">Course ID: ${e.courseId}</h5>

                    <p class="text-muted">You are enrolled in this course</p>

                    <button class="btn btn-success w-100" disabled>
                        Enrolled
                    </button>

                </div>

            </div>
        </c:forEach>

    </div>
</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

</body>
</html>