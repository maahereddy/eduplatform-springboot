<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Course</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<div class="container mt-5">

    <h2 class="mb-4 text-center">Add New Course</h2>

   <form action="/admin/save-course" method="post" enctype="multipart/form-data">

    <input type="text" name="title" placeholder="Title" class="form-control mb-2" required>

    <input type="text" name="description" placeholder="Description" class="form-control mb-2" required>

    <input type="number" name="price" placeholder="Price" class="form-control mb-2" required>

    <input type="text" name="videoUrl" placeholder="YouTube URL" class="form-control mb-2">

    <input type="text" name="instructor" placeholder="Instructor" class="form-control mb-2">

    <input type="text" name="duration" placeholder="Duration" class="form-control mb-2">

    <!-- ✅ IMAGE -->
    <input type="file" name="image" class="form-control mb-2" required>

    <button class="btn btn-success w-100">Save Course</button>

</form>

</div>

</body>
</html>