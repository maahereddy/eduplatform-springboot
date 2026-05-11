<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="UTF-8">


<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
  <div class="container">

    <!-- LOGO -->
    <a class="navbar-brand" href="/home">EduPlatform</a>

    <!-- TOGGLER -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarContent">

      <!-- LEFT SIDE -->
      <ul class="navbar-nav me-auto">

        <!-- HOME -->
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI == '/home' ? 'active' : ''}" href="/home">
            Home
          </a>
        </li>

        <!-- COURSES -->
        <li class="nav-item">
          <a class="nav-link ${pageContext.request.requestURI == '/courses' ? 'active' : ''}" href="/courses">
            Courses
          </a>
        </li>

        <!-- 👤 USER ONLY -->
        <sec:authorize access="hasRole('USER')">
            <li class="nav-item">
                <a class="nav-link" href="/my-courses">My Courses</a>
            </li>
        </sec:authorize>

        <!-- 🔥 ADMIN ONLY -->
        <sec:authorize access="hasRole('ADMIN')">
            <li class="nav-item">
                <a class="nav-link text-warning fw-bold" href="/admin/dashboard">Admin</a>
            </li>
        </sec:authorize>

      </ul>

      <!-- 🔍 SEARCH -->
      <form class="d-flex me-4" action="/courses" method="get">
        <input class="form-control me-2" type="search"
               name="keyword" placeholder="Search courses..." required>
        <button class="btn btn-outline-light" type="submit">Search</button>
      </form>

      <!-- RIGHT SIDE -->
      <div class="d-flex align-items-center gap-3">

        <!-- 🔐 LOGGED IN USER DROPDOWN -->
        <sec:authorize access="isAuthenticated()">

            <div class="dropdown">

              <button class="btn btn-dark border-light btn-sm dropdown-toggle px-3"
        type="button" data-bs-toggle="dropdown">

                    <i class="bi bi-person-circle me-1"></i>
<sec:authentication property="principal.username"/>

                </button>

                <ul class="dropdown-menu dropdown-menu-end shadow">

                    <li>
                        <a class="dropdown-item" href="/my-courses">My Courses</a>
                    </li>

                    <sec:authorize access="hasRole('ADMIN')">
                        <li>
                            <a class="dropdown-item" href="/admin/dashboard">Admin Dashboard</a>
                        </li>
                    </sec:authorize>

                    <li><hr class="dropdown-divider"></li>

                    <li>
                        <form action="/logout" method="post">
                            <button class="dropdown-item text-danger">Logout</button>
                        </form>
                    </li>
                    <a href="/payment-history" class="dropdown-item">
    💳 Payment History
</a>

                </ul>

            </div>

        </sec:authorize>

        <!-- 🔓 NOT LOGGED IN -->
        <sec:authorize access="!isAuthenticated()">
            <a href="/login" class="btn btn-outline-light btn-sm">Login</a>
            <a href="/register" class="btn btn-primary btn-sm">Sign Up</a>
        </sec:authorize>

        <!-- 🛒 CART -->
     <a href="/cart" class="btn btn-outline-light btn-sm position-relative">
    
    <i class="bi bi-cart3"></i> Cart

    <!-- 🔥 CART COUNT BADGE -->
    <c:if test="${cartCount > 0}">
        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
            ${cartCount}
        </span>
    </c:if>

</a>

      </div>

    </div>
  </div>
</nav>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>