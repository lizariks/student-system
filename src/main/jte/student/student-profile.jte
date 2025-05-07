@import studentsystem.com.data.Student
@import studentsystem.com.data.Course
@import java.util.Set
@param Student student
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .card {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .profile-section {
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .profile-info {
            margin-bottom: 30px;
        }
        .profile-header {
            background-color: #6c757d;
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="/student/home">Student Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/student/home">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/student/courses">My Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/student/profile">Profile</a>
                </li>
            </ul>
            <div class="d-flex">
                @if(student != null)
                    <span class="navbar-text me-3 text-white">
                        Welcome, ${student.getUsername()}
                    </span>
                @else
                    <span class="navbar-text me-3 text-white">
                        Welcome, Student
                    </span>
                @endif
                <a href="/logout" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </div>
</nav>
<div class="container">
    <!-- Profile header section -->
    <div class="profile-header text-center">
        <h1>Student Profile</h1>
        <p class="lead">Manage your personal information</p>
    </div>
    @if(student == null)
        <div class="alert alert-warning">
            <h4>Session Error</h4>
            <p>Unable to load student information. Please try logging in again or contact support if the issue persists.</p>
            <a href="/auth/login" class="btn btn-primary">Login Again</a>
        </div>
    @else
        <!-- Profile Information -->
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Profile Summary</h5>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <div class="avatar bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto" style="width: 100px; height: 100px; font-size: 3rem;">
                                ${student.getFirstName() != null ? student.getFirstName().substring(0, 1).toUpperCase() : "S"}
                            </div>
                        </div>
                        <p><strong>Username:</strong> ${student.getUsername()}</p>
                        <p><strong>Name:</strong> ${student.getFirstName() != null ? student.getFirstName() : ""} ${student.getLastName() != null ? student.getLastName() : ""}</p>
                        <p><strong>Email:</strong> ${student.getEmail() != null ? student.getEmail() : "Not provided"}</p>
                        @if(student.getGroup() != null)
                            <p><strong>Group:</strong> ${student.getGroup().getName()}</p>
                        @else
                            <p><strong>Group:</strong> Not assigned</p>
                        @endif
                        <p><strong>Courses:</strong> ${student.getCourses() != null ? student.getCourses().size() : 0} enrolled</p>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">Quick Links</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <a href="/student/home" class="list-group-item list-group-item-action">Dashboard</a>
                            <a href="/student/courses" class="list-group-item list-group-item-action">My Courses</a>
                            <a href="/student/course/register" class="list-group-item list-group-item-action">Register for Courses</a>
                            <a href="/student/calendar" class="list-group-item list-group-item-action">Academic Calendar</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Edit Profile</h5>
                    </div>
                    <div class="card-body">
                        <form action="/student/profile/update" method="post">
                            <div class="mb-3">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${student.getFirstName() != null ? student.getFirstName() : ""}">
                            </div>
                            <div class="mb-3">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${student.getLastName() != null ? student.getLastName() : ""}">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${student.getEmail() != null ? student.getEmail() : ""}">
                            </div>
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username" value="${student.getUsername()}" readonly>
                                <div class="form-text">Username cannot be changed</div>
                            </div>
                            <hr>
                            <h5>Change Password</h5>
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword">
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">Academic Progress</h5>
                    </div>
                    <div class="card-body">
                        <h6>Currently Enrolled Courses</h6>
                        @if(student.getCourses() == null || student.getCourses().isEmpty())
                            <div class="alert alert-info">
                                You are not enrolled in any courses yet. <a href="/student/course/register">Register now</a>.
                            </div>
                        @else
                            <ul class="list-group">
                                @for(Course course : student.getCourses())
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${course.getName()}
                                        <a href="/student/course/${course.getId()}" class="btn btn-sm btn-outline-primary">View Details</a>
                                    </li>
                                @endfor
                            </ul>
                        @endif
                    </div>
                </div>
            </div>
        </div>
    @endif
</div>
<footer class="bg-dark text-white text-center py-3 mt-5">
    <div class="container">
        <p class="mb-0">© 2025 Student Management System</p>
    </div>
</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>