<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Courses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <h2 class="mb-4">Manage Courses</h2>

    <a href="/admin/add-course" class="btn btn-primary mb-3">
        + Add Course
    </a>

    <table class="table table-bordered text-center align-middle">

        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody>
            <c:forEach var="c" items="${courses}">
                <tr>

                    <td>${c.id}</td>

                    <td>${c.title}</td>

                    <td>&#8377; ${c.price}</td>

                    <td>

                        <!-- EDIT COURSE -->
                        <a href="/admin/edit/${c.id}" 
                           class="btn btn-warning btn-sm">
                           Edit
                        </a>

                        <!-- ✅ NEW: MANAGE LESSONS -->
                        <a href="/admin/edit-lessons/${c.id}" 
                           class="btn btn-info btn-sm">
                            Manage Lessons
                        </a>

                        <!-- DELETE COURSE -->
                        <a href="/admin/delete/${c.id}" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this course?')">
                           Delete
                        </a>

                    </td>

                </tr>
            </c:forEach>
        </tbody>

    </table>

</div>

</body>
</html>