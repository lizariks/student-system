@import studentsystem.com.data.Teacher
@import studentsystem.com.data.Course
@import java.util.Set
@param Teacher teacher

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Teacher Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f8f9fa; padding-top: 20px; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .welcome-section { background-color: #e9ecef; padding: 20px; border-radius: 5px; margin-bottom: 20px; }
        .course-card { transition: transform 0.3s; }
        .course-card:hover { transform: translateY(-5px); }
        .navbar-brand { font-weight: bold; }
        .teacher-info { margin-bottom: 30px; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/teacher-home">Teacher Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="/teacher-home">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/course">My Courses</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/search">Students</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/groups">Groups</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/profile">Profile</a></li>
            </ul>
            <div class="d-flex">
                @if(teacher != null)
                    <span class="navbar-text me-3 text-white">Welcome, ${teacher.getFirstName()} ${teacher.getLastName()}</span>
                @else
                    <span class="navbar-text me-3 text-white">Welcome, Teacher</span>
                @endif
                <a href="/logout" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="welcome-section">
        <h2>Welcome to your Teacher Dashboard</h2>
        <p>Here you can manage your courses, view student groups, and access teaching-related information.</p>
    </div>

    @if(teacher == null)
        <div class="alert alert-warning">
            <h4>Session Error</h4>
            <p>Unable to load teacher information. Please try logging in again or contact support if the issue persists.</p>
            <a href="/auth/login" class="btn btn-dark">Login Again</a>
        </div>
    @else
        <div class="row teacher-info">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h5 class="card-title mb-0">Teacher Information</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Username:</strong> ${teacher.getUsername()}</p>
                        <p><strong>Email:</strong> ${teacher.getEmail()}</p>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h5 class="card-title mb-0">Quick Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-2">
                            <div class="col-md-6">
                                <a href="/teacher/course" class="btn btn-outline-dark w-100">Manage My Courses</a>
                            </div>
                            <div class="col-md-6">
                                <a href="/teacher/profile" class="btn btn-outline-dark w-100">Edit Profile</a>
                            </div>
                            <div class="col-md-6">
                                <a href="/teacher/course/create" class="btn btn-outline-success w-100">Create New Course</a>
                            </div>
                            <div class="col-md-6">
                                <a href="/teacher/groups" class="btn btn-outline-info w-100">View Student Groups</a>
                            </div>
                            <div class="col-md-12">
                                <a href="/teacher/search" class="btn btn-outline-primary w-100 mt-2">Search Students</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <h3 class="mb-3">Courses You Teach</h3>
        <div class="row">
            @if(teacher.getCourses() == null || teacher.getCourses().isEmpty())
                <div class="col-12">
                    <div class="alert alert-info">
                        You are not teaching any courses yet. <a href="/teacher/course/create">Click here to create one</a>.
                    </div>
                </div>
            @else
                @for(Course course : teacher.getCourses())
                    <div class="col-md-4 mb-4">
                        <div class="card course-card h-100">
                            <div class="card-header bg-secondary text-white">
                                <h5 class="card-title mb-0">${course.getName()}</h5>
                            </div>
                            <div class="card-body">
                                @if(course.getDescription() != null)
                                    <p class="card-text">${course.getDescription()}</p>
                                @else
                                    <p class="card-text">No description available</p>
                                @endif
                            </div>
                            <div class="card-footer">
                                <a href="/teacher/course/${course.getId()}" class="btn btn-sm btn-secondary">View Details</a>
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