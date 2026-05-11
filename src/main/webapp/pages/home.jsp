<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>EduPlatform</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background-color: #f8f9fa;
}

/* HERO */
.hero {
    background: linear-gradient(to right, #1c1d1f, #3e4143);
    color: white;
    padding: 80px 20px;
    text-align: center;
}

.hero h1 {
    font-size: 3rem;
    font-weight: bold;
}

.hero p {
    font-size: 1.2rem;
    color: #ccc;
}

/* COURSE CARD */
.course-card {
    border-radius: 12px;
    transition: 0.3s;
    background: white;
}

.course-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.2);
}

/* IMAGE */
.course-img {
    height: 180px;
    object-fit: cover;
    border-top-left-radius: 12px;
    border-top-right-radius: 12px;
}

/* PRICE */
.price {
    font-weight: bold;
    color: #0d6efd;
}
</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<!-- HERO -->
<div class="hero">
    <h1>Learn Anytime, Anywhere 🚀</h1>
    <p>Upgrade your skills with top online courses</p>

    <a href="/courses" class="btn btn-primary btn-lg mt-3">Browse Courses</a>
</div>

<!-- COURSES -->
<div class="container my-5">

    <h3 class="text-center mb-4 fw-bold">Popular Courses</h3>

    <div class="row g-4">

        <c:forEach var="course" items="${courses}">

            <div class="col-md-4">

                <div class="card course-card shadow-sm">

                    <!-- IMAGE -->
                   <c:choose>
    <c:when test="${not empty course.imageUrl}">
        <img src="${course.imageUrl}" class="course-img">
    </c:when>
    <c:otherwise>
        <img src="https://source.unsplash.com/400x300/?coding" class="course-img">
    </c:otherwise>
</c:choose>

                    <div class="card-body">

                        <h5 class="fw-bold">${course.title}</h5>

                        <p class="text-muted">
                            ${course.description}
                        </p>

                        <div class="d-flex justify-content-between align-items-center">

                            <span class="price">₹ ${course.price}</span>

                            <a href="/course/${course.id}" class="btn btn-outline-primary btn-sm">
                                View
                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

<!-- FOOTER -->
<footer class="bg-dark text-white pt-4 pb-2 mt-5">
    <div class="container">

        <div class="row">

            <!-- LOGO / ABOUT -->
            <div class="col-md-4">
                <h5>EduPlatform</h5>
                <p class="small">
                    Learn new skills anytime, anywhere. 
                    Build your future with top-quality online courses.
                </p>
            </div>

            <!-- QUICK LINKS -->
            <div class="col-md-2">
                <h6>Links</h6>
                <ul class="list-unstyled small">
                    <li><a href="/home" class="text-white text-decoration-none">Home</a></li>
                    <li><a href="/courses" class="text-white text-decoration-none">Courses</a></li>
                    <li><a href="/my-courses" class="text-white text-decoration-none">My Courses</a></li>
                </ul>
            </div>

            <!-- CATEGORY -->
            <div class="col-md-3">
                <h6>Categories</h6>
                <ul class="list-unstyled small">
                    <li>Development</li>
                    <li>AI & ML</li>
                    <li>Web Development</li>
                    <li>Data Science</li>
                </ul>
            </div>

            <!-- SOCIAL -->
            <div class="col-md-3">
                <h6>Follow Us</h6>
                <div>
                    <a href="#" class="text-white me-3">
                        <i class="bi bi-facebook"></i> Facebook
                    </a><br>
                    <a href="#" class="text-white me-3">
                        <i class="bi bi-instagram"></i> Instagram
                    </a><br>
                    <a href="#" class="text-white">
                        <i class="bi bi-linkedin"></i> LinkedIn
                    </a>
                </div>
            </div>

        </div>

        <hr class="bg-light">

        <!-- COPYRIGHT -->
        <div class="text-center small">
            © 2026 EduPlatform | All Rights Reserved
        </div>

    </div>
</footer>

</body>
</html>