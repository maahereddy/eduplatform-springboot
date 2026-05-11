<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<title>${course.title}</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f5f7fb;
}

/* TOP SECTION */
.course-hero{
    margin-top:40px;
}

.course-image{
    width:100%;
    border-radius:20px;
    height:400px;
    object-fit:cover;
    box-shadow:0 8px 25px rgba(0,0,0,0.15);
}

.course-info{
    background:linear-gradient(135deg,#0f172a,#1e293b);
    color:white;
    border-radius:20px;
    padding:40px;
    height:100%;
    box-shadow:0 8px 25px rgba(0,0,0,0.15);
}

.course-info h1{
    font-size:3rem;
    font-weight:bold;
}

.price{
    font-size:2.5rem;
    color:#0d6efd;
    font-weight:bold;
}

/* VIDEO */
.video-box{
    width:100%;
    height:500px;
    border-radius:15px;
}

/* SIDEBAR */
.sidebar{
    background:white;
    border-radius:15px;
    padding:20px;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
}

.lesson-item{
    padding:12px;
    border-bottom:1px solid #eee;
    cursor:pointer;
    transition:0.3s;
}

.lesson-item:hover{
    background:#f1f5f9;
}

.active-lesson{
    background:#dbeafe;
    font-weight:bold;
}

.locked{
    color:gray;
    cursor:not-allowed;
}

.details-box{
    background:white;
    padding:25px;
    border-radius:15px;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
}
</style>

<script>
function playVideo(url, element){

    if(url.includes("watch?v=")){
        url = url.replace("watch?v=", "embed/");
    }

    if(url.includes("youtu.be/")){
        url = url.replace("youtu.be/", "www.youtube.com/embed/");
    }

    document.getElementById("videoFrame").src = url;

    document.querySelectorAll(".lesson-item").forEach(el=>{
        el.classList.remove("active-lesson");
    });

    element.classList.add("active-lesson");

    document.getElementById("watchSection")
            .scrollIntoView({behavior:"smooth"});
}

function showDetails(){
    document.getElementById("detailsSection")
            .scrollIntoView({behavior:"smooth"});
}
</script>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container course-hero">

    <div class="row g-4">

        <!-- LEFT IMAGE -->
        <div class="col-md-6">

            <img src="${course.imageUrl}"
                 class="course-image">

        </div>

        <!-- RIGHT INFO -->
        <div class="col-md-6">

            <div class="course-info">

                <h1>${course.title}</h1>

                <p class="mt-3 fs-4">
                    ${course.description}
                </p>

                <h4 class="mt-4">
                    Instructor :
                    <span class="text-warning">
                        ${course.instructor}
                    </span>
                </h4>

                <h4 class="mt-3">
                    Duration :
                    ${course.duration}
                </h4>

                <div class="price mt-4">
                    ₹ ${course.price}
                </div>

                <div class="mt-5 d-flex gap-3">

                    <button class="btn btn-light btn-lg"
                            onclick="showDetails()">
                        Course Details
                    </button>

                    <a href="#watchSection"
                       class="btn btn-warning btn-lg">
                        ▶ Start Watching
                    </a>

                </div>

            </div>

        </div>

    </div>

    <!-- DETAILS SECTION -->
    <div id="detailsSection" class="mt-5">

        <div class="details-box">

            <h2 class="mb-4">Course Details</h2>

            <p>
                ${course.description}
            </p>

            <hr>

            <h5>What you'll learn</h5>

            <ul>
                <li>Real-world practical concepts</li>
                <li>Hands-on implementation</li>
                <li>Industry-level project understanding</li>
                <li>Backend + Frontend integration</li>
                <li>Database connectivity</li>
            </ul>

            <hr>

            <h5>Instructor</h5>

            <p>${course.instructor}</p>

            <hr>

            <h5>Course Duration</h5>

            <p>${course.duration}</p>

        </div>

    </div>

    <!-- WATCH SECTION -->
    <div id="watchSection" class="mt-5">

        <div class="row">

            <!-- VIDEO -->
            <div class="col-md-8">

                <iframe id="videoFrame"
                        class="video-box shadow"
                        src="${course.videoUrl}"
                        frameborder="0"
                        allowfullscreen>
                </iframe>

            </div>

            <!-- SIDEBAR -->
            <div class="col-md-4">

                <div class="sidebar">

                    <h3 class="mb-4">
                        Course Content
                    </h3>

                    <c:forEach var="lesson" items="${lessons}">

                        <c:choose>

                            <%-- FREE / ENROLLED --%>
                            <c:when test="${lesson.preview || isEnrolled}">

                                <div class="lesson-item"
                                     onclick="playVideo('${lesson.videoUrl}', this)">

                                    ▶ ${lesson.title}

                                </div>

                            </c:when>

                            <%-- LOCKED --%>
                            <c:otherwise>

                                <div class="lesson-item locked">

                                    🔒 ${lesson.title}

                                </div>

                            </c:otherwise>

                        </c:choose>

                    </c:forEach>

                </div>

            </div>

        </div>

    </div>

</div>

<jsp:include page="footer.jsp" />

</body>
</html>