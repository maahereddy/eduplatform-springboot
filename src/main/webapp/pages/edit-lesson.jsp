<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Lesson</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <h2 class="mb-4">Edit Lesson</h2>

    <form action="/admin/update-lesson" method="post">

        <!-- Hidden ID -->
        <input type="hidden" name="id" value="${lesson.id}" />

        <!-- Title -->
        <div class="mb-3">
            <label>Lesson Title</label>
            <input type="text" name="title" value="${lesson.title}" class="form-control" required>
        </div>

        <!-- Video URL -->
        <div class="mb-3">
            <label>Video URL</label>
            <input type="text" name="videoUrl" value="${lesson.videoUrl}" class="form-control" required>
        </div>

        <!-- Course (optional readonly) -->
        <div class="mb-3">
            <label>Course ID</label>
            <input type="text" name="courseId" value="${lesson.course.id}" class="form-control" readonly>
        </div>

        <!-- Preview -->
        <div class="mb-3 form-check">
            <input type="checkbox" class="form-check-input"
                   name="preview"
                   ${lesson.preview ? "checked" : ""}>
            <label class="form-check-label">Free Preview</label>
        </div>

        <button type="submit" class="btn btn-success">
            Update Lesson
        </button>

    </form>

</div>

</body>
</html>