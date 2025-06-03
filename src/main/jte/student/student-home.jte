@import studentsystem.com.data.Student
@import studentsystem.com.data.Course
@import java.util.Set
@param Student student
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
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
        .welcome-section {
            background-color: #e9ecef;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .course-card {
            transition: transform 0.3s;
        }
        .course-card:hover {
            transform: translateY(-5px);
        }
        .navbar-brand {
            font-weight: bold;
        }
        .student-info {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand" href="/student/home">Student Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="/student/home">Dashboard</a>
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
    <div class="welcome-section">
        <h2>Welcome to your Student Dashboard</h2>
        <p>Here you can manage your courses and view your academic information.</p>
    </div>
    @if(student == null)
        <div class="alert alert-warning">
            <h4>Session Error</h4>
            <p>Unable to load student information. Please try logging in again or contact support if the issue persists.</p>
            <a href="/auth/login" class="btn btn-primary">Login Again</a>
        </div>
    @else
        <!-- Student Information -->
        <div class="row student-info">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Student Information</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Username:</strong> ${student.getUsername()}</p>
                        @if(student.getGroup() != null)
                            <p><strong>Group:</strong> ${student.getGroup().getName()}</p>
                        @else
                            <p><strong>Group:</strong> Not assigned</p>
                        @endif
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="card-title mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-2">
                                <a href="/student/profile" class="btn btn-outline-primary w-100">Edit Profile</a>
                            </div>
                            <div class="col-md-6 mb-2">
                                <a href="/student/course/register" class="btn btn-outline-success w-100">Register for Courses</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h3 class="mb-3">Your Enrolled Courses</h3>
        <div class="row">
            @if(student.getCourses() == null || student.getCourses().isEmpty())
                <div class="col-12">
                    <div class="alert alert-info">
                        You are not enrolled in any courses yet. <a href="/student/course/register">Click here to register for courses</a>.
                    </div>
                </div>
            @else
                @for(Course course : student.getCourses())
                    <div class="col-md-4 mb-4">
                        <div class="card course-card h-100">
                            <div class="card-header bg-success text-white">
                                <h5 class="card-title mb-0">${course.getName()}</h5>
                            </div>
                            <div class="card-body">
                                @if(course.getDescription() != null)
                                    <p class="card-text">${course.getDescription()}</p>
                                @else
                                    <p class="card-text">No description available</p>
                                @endif
                                @if(course.getTeacher() != null)
                                    <p><strong>Professor:</strong> ${course.getTeacher().getFirstName()} ${course.getTeacher().getLastName()}</p>
                                @else
                                    <p><strong>Professor:</strong> Not assigned</p>
                                @endif
                            </div>
                            <div class="card-footer">
                                <a href="/student/course/${course.getId()}" class="btn btn-sm btn-primary">View Details</a>
                            </div>
                        </div>
                    </div>
                @endfor
            @endif
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