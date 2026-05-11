<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Courses</title>
    <meta charset="UTF-8">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 12px;
            transition: all 0.3s ease;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
        }

        .course-img {
            height: 180px;
            object-fit: cover;
            width: 100%;
        }

        .course-title {
            font-size: 1.2rem;
        }

        .course-desc {
            font-size: 0.9rem;
            height: 60px;
            overflow: hidden;
        }

        .price {
            font-size: 1.1rem;
        }

        .btn {
            border-radius: 8px;
        }

        .btn-outline-primary {
            font-size: 0.9rem;
        }
    </style>
</head>

<body>

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container my-5">

    <h2 class="text-center mb-5 fw-bold">All Courses</h2>

    <div class="row g-4">

        <c:forEach var="course" items="${courses}">
            <div class="col-md-4">

                <div class="card shadow-sm border-0 h-100 d-flex flex-column">

                    <!-- ✅ IMAGE -->
                    <img src="${course.imageUrl != null ? course.imageUrl : '/images/default.jpg'}"
                         class="course-img">

                    <div class="p-4 d-flex flex-column h-100">

                        <!-- Title -->
                        <h5 class="fw-bold course-title">${course.title}</h5>

                        <!-- Description -->
                        <p class="text-muted course-desc">${course.description}</p>

                        <!-- View Details -->
                        <a href="/course/${course.id}" class="btn btn-outline-primary mb-3">
                            View Details
                        </a>

                        <!-- Bottom Section -->
                        <div class="mt-auto">

                            <!-- Price -->
                            <p class="text-primary fw-bold price mb-3">
                                ₹ ${course.price}
                            </p>

                            <!-- Check Enrollment -->
                            <c:set var="isEnrolled" value="false"/>
                            <c:forEach var="e" items="${enrolledCourses}">
                                <c:if test="${e.courseId == course.id}">
                                    <c:set var="isEnrolled" value="true"/>
                                </c:if>
                            </c:forEach>

                            <!-- Check Cart -->
                            <c:set var="isInCart" value="false"/>
                            <c:forEach var="c" items="${cartItems}">
                                <c:if test="${c.courseId == course.id}">
                                    <c:set var="isInCart" value="true"/>
                                </c:if>
                            </c:forEach>

                            <!-- Buttons -->
                           <c:choose>

    <%-- Enrolled --%>
    <c:when test="${isEnrolled}">
        <button class="btn btn-success w-100" disabled>
            ✔ Enrolled
        </button>
    </c:when>

    <%-- In Cart --%>
    <c:when test="${isInCart}">
        <button class="btn btn-secondary w-100" disabled>
            ✔ Added to Cart
        </button>
    </c:when>

    <%-- Add to Cart --%>
    <c:otherwise>
        <form action="/add-to-cart" method="post">
            <input type="hidden" name="courseId" value="${course.id}" />
            <button type="submit" class="btn btn-warning w-100">
                Add to Cart 🛒
            </button>
        </form>
    </c:otherwise>

</c:choose>

                        </div>

                    </div>

                </div>

            </div>
        </c:forEach>

    </div>

</div>

<!-- Footer -->
<jsp:include page="footer.jsp" />

</body>
</html>