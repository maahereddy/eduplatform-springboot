<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<title>Add Lesson</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <h3>Add Lesson</h3>

    <form action="/admin/save-lesson" method="post">

        <!-- Title -->
        <div class="mb-3">
            <label>Lesson Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <!-- Video URL -->
        <div class="mb-3">
            <label>Video URL</label>
            <input type="text" name="videoUrl" class="form-control" required>
        </div>

        <!-- Course -->
        <div class="mb-3">
            <label>Select Course</label>
            <select name="courseId" class="form-control">

                <c:forEach var="c" items="${courses}">
                    <option value="${c.id}">
                        ${c.title}
                    </option>
                </c:forEach>

            </select>
        </div>

        <!-- Preview -->
        <div class="form-check mb-3">
            <input type="checkbox" name="preview" value="true" class="form-check-input">
            <label class="form-check-label">Free Preview</label>
        </div>

        <button class="btn btn-success">
            Add Lesson
        </button>

    </form>

</div>

</body>
</html>