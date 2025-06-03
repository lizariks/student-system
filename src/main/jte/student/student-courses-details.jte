@import studentsystem.com.data.Student
@import studentsystem.com.data.Course
@import java.util.Set
@param Student student
@param Course course
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Details</title>
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
        .course-header {
            background-color: #6c757d;
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .navbar-brand {
            font-weight: bold;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="/student-home">Student Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/student-home">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/student/courses">My Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/student/profile">Profile</a>
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
    @if(student == null)
        <div class="alert alert-warning">
            <h4>Session Error</h4>
            <p>Unable to load student information. Please try logging in again or contact support if the issue persists.</p>
            <a href="/login" class="btn btn-primary">Login Again</a>
        </div>
    @elseif(course == null)
        <div class="alert alert-warning">
            <h4>Course Error</h4>
            <p>Unable to load course information. This course may not exist or you don't have access to it.</p>
            <a href="/student/home" class="btn btn-primary">Return to Dashboard</a>
        </div>
    @else
        <div class="course-header text-center">
            <h1>${course.getName()}</h1>
            <p class="lead">Course Details</p>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Course Information</h5>
                    </div>
                    <div class="card-body">
                        <h4>${course.getName()}</h4>
                        <hr>
                        @if(course.getDescription() != null)
                            <p>${course.getDescription()}</p>
                        @else
                            <p>No description available</p>
                        @endif

                        <div class="row mt-4">
                            <div class="col-md-6">
                                <h5>Course Details</h5>
                                <ul class="list-group">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Course ID
                                        <span class="badge bg-primary rounded-pill">${course.getId()}</span>
                                    </li>
                                </ul>
                            </div>

                            <div class="col-md-6">
                                <h5>Instructor Information</h5>
                                @if(course.getTeacher() != null)
                                    <ul class="list-group">
                                        <li class="list-group-item">
                                            <strong>Name:</strong> ${course.getTeacher().getFirstName()} ${course.getTeacher().getLastName()}
                                        </li>
                                        @if(course.getTeacher().getEmail() != null)
                                            <li class="list-group-item">
                                                <strong>Email:</strong> ${course.getTeacher().getEmail()}
                                            </li>
                                        @endif
                                    </ul>
                                @else
                                    <div class="alert alert-info">
                                        No instructor has been assigned to this course yet.
                                    </div>
                                @endif
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">Course Materials</h5>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            No materials have been added to this course yet.
                        </div>
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
