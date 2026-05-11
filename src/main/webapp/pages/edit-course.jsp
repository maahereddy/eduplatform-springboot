<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Course</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .form-container {
            max-width: 600px;
            margin: auto;
        }

        .preview-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5 form-container">

    <h2 class="mb-4 text-center">Edit Course</h2>

    <form action="/admin/update-course" method="post" enctype="multipart/form-data">

        <input type="hidden" name="id" value="${course.id}" />

        <!-- IMAGE PREVIEW -->
        <img src="${course.imageUrl}" class="preview-img"/>

        <!-- TITLE -->
        <div class="mb-3">
            <label>Course Title</label>
            <input type="text" name="title" value="${course.title}" class="form-control" required>
        </div>

        <!-- DESCRIPTION -->
        <div class="mb-3">
            <label>Description</label>
            <input type="text" name="description" value="${course.description}" class="form-control" required>
        </div>

        <!-- PRICE -->
        <div class="mb-3">
            <label>Price</label>
            <input type="number" name="price" value="${course.price}" class="form-control" required>
        </div>

        <!-- VIDEO URL -->
        <div class="mb-3">
            <label>Course Intro Video</label>
            <input type="text" name="videoUrl" value="${course.videoUrl}" class="form-control">
        </div>

        <!-- INSTRUCTOR -->
        <div class="mb-3">
            <label>Instructor</label>
            <input type="text" name="instructor" value="${course.instructor}" class="form-control">
        </div>

        <!-- DURATION -->
        <div class="mb-3">
            <label>Duration</label>
            <input type="text" name="duration" value="${course.duration}" class="form-control">
        </div>

        <!-- IMAGE UPLOAD -->
        <div class="mb-3">
            <label>Update Image</label>
            <input type="file" name="imageFile" class="form-control">
        </div>

        <button type="submit" class="btn btn-success w-100">
            Update Course
        </button>

    </form>

</div>

</body>
</html>