@import studentsystem.com.data.Student
@import studentsystem.com.data.Course
@import java.util.List
@param Student student
@param List<Course> courses
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register for Courses</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; padding-top: 20px; }
        .card { margin-bottom: 20px; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="/student/home">Student Portal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/student/home">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="/student/courses">My Courses</a></li>
                <li class="nav-item"><a class="nav-link active" href="/student/course/register">Register</a></li>
            </ul>
            <div class="d-flex">
                <span class="navbar-text text-white me-3">Welcome, ${student.getUsername()}</span>
                <a href="/logout" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <h2 class="mb-4">Available Courses</h2>
    <div class="row">
        @for(Course course : courses)
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">${course.getName()}</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Description:</strong> ${course.getDescription() != null ? course.getDescription() : "No description"}</p>
                        @if(course.getTeacher() != null)
                            <p><strong>Teacher:</strong> ${course.getTeacher().getFirstName()} ${course.getTeacher().getLastName()}</p>
                        @else
                            <p><strong>Teacher:</strong> Not assigned</p>
                        @endif
                    </div>
                    <div class="card-footer">
                        <form method="post" action="/student/course/register/${course.getId()}">
                            <button class="btn btn-success w-100">Register</button>
                        </form>
                    </div>
                </div>
            </div>
        @endfor
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
