<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container text-center mt-5">

    <h2 class="mb-4">Admin Dashboard</h2>

    <div class="d-flex justify-content-center gap-3">

        <a href="/admin/add-course" class="btn btn-primary btn-lg">
            ➕ Add Course
        </a>
        <a href="/admin/add-lesson" class="btn btn-primary">
    Add Lesson
</a>

        <a href="/admin/courses" class="btn btn-dark btn-lg">
            📚 View Courses
        </a>

    </div>

</div>

</body>
</html>