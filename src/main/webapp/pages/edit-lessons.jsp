<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Lessons</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- ✅ Drag Library -->
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>

    <style>
        .lesson-item {
            cursor: grab;
        }
    </style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

    <h2 class="text-center mb-4">Edit Lessons</h2>

    <!-- MAIN FORM -->
    <form action="/admin/update-lessons" method="post">

        <input type="hidden" name="courseId" value="${courseId}" />

        <!-- ✅ IMPORTANT: DRAG CONTAINER -->
        <div id="lessonList">

            <c:forEach var="lesson" items="${lessons}" varStatus="i">

                <div class="card p-3 mb-3 lesson-item"
                     data-id="${lesson.id}">

                    <!-- ID -->
                    <input type="hidden" name="lessons[${i.index}].id" value="${lesson.id}" />

                    <!-- Title -->
                    <input type="text"
                           name="lessons[${i.index}].title"
                           value="${lesson.title}"
                           class="form-control mb-2"/>

                    <!-- Video -->
                    <input type="text"
                           name="lessons[${i.index}].videoUrl"
                           value="${lesson.videoUrl}"
                           class="form-control mb-2"/>

                    <!-- Preview -->
                    <label class="mb-2">
                        <input type="checkbox"
                               name="lessons[${i.index}].preview"
                               value="true"
                               <c:if test="${lesson.preview}">checked</c:if> />
                        Free Preview
                    </label>

                    <!-- ACTION BUTTONS -->
                    <div class="mt-2">

                        <!-- DELETE -->
                        <form action="/admin/delete-lesson" method="post" style="display:inline;">
                            <input type="hidden" name="lessonId" value="${lesson.id}" />
                            <input type="hidden" name="courseId" value="${lesson.courseId}" />
                            <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                        </form>

                    </div>

                </div>

            </c:forEach>

        </div>

        <!-- UPDATE BUTTON -->
        <button class="btn btn-success w-100 mt-3">
            Update All Lessons
        </button>

    </form>

</div>

<!-- ✅ DRAG SCRIPT -->
<script>
new Sortable(document.getElementById("lessonList"), {
    animation: 150,

    onEnd: function () {

        let order = [];

        document.querySelectorAll(".lesson-item").forEach((el, index) => {
            order.push({
                id: el.getAttribute("data-id"),
                position: index + 1
            });
        });

        fetch("/admin/update-order", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(order)
        });
    }
});
</script>

</body>
</html>