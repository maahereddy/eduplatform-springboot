<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment History</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>
    body {
        background-color: #f8f9fa;
    }

    .table {
        border-radius: 10px;
        overflow: hidden;
    }

    .page-title {
        font-weight: 700;
    }

    .empty-box {
        margin-top: 100px;
    }
</style>

</head>

<body>

<!-- Navbar -->
<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <!-- TITLE -->
    <h2 class="mb-4 page-title">
        <i class="bi bi-credit-card"></i> Payment History
    </h2>

   <c:choose>

    <c:when test="${empty payments}">
        <div class="text-center mt-5">
            <h4>No payments yet 😔</h4>
            <a href="/courses" class="btn btn-primary mt-3">
                Browse Courses
            </a>
        </div>
    </c:when>

    <c:otherwise>

        <div class="table-responsive">

            <table class="table table-hover shadow-sm">

                <thead class="table-dark">
                    <tr>
                        <th>Course</th>
                        <th>Amount</th>
                        <th>Payment ID</th>
                        <th>Status</th>
                        <th>Date</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="p" items="${payments}">
                        <tr>

                            <td>${p.courseName}</td>

                            <td class="text-primary fw-bold">
                                ₹ ${p.amount}
                            </td>

                            <td>${p.paymentId}</td>

                            <td>
                                <span class="badge bg-success">
                                    ${p.status}
                                </span>
                            </td>

                            <td>${p.date}</td>

                        </tr>
                    </c:forEach>

                </tbody>

            </table>

        </div>

    </c:otherwise>

</c:choose>

</div>

</body>
</html>