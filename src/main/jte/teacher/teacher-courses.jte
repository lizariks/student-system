@import studentsystem.com.data.Course
@import java.util.List
@param List<Course> courses
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses</title>
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
        .navbar-brand {
            font-weight: bold;
        }
        .course-card {
            transition: transform 0.3s;
        }
        .course-card:hover {
            transform: translateY(-5px);
        }
        .course-header {
            background-color: #343a40;
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/teacher-home">Teacher Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/teacher-home">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/teacher/course">My Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/teacher/search">Students</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/teacher/profile">Profile</a>
                </li>
            </ul>
            <div class="d-flex">
                <a href="/logout" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="course-header text-center">
        <h1>My Courses</h1>
        <p class="lead">Manage and view all your teaching courses</p>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>Course Management</h3>
        <a href="/teacher/course/create" class="btn btn-success">
            <i class="fas fa-plus"></i> Add New Course
        </a>
    </div>

    @if(courses == null || courses.isEmpty())
        <div class="alert alert-info text-center">
            <h4>No Courses Found</h4>
            <p>You haven't created any courses yet. Start by adding your first course!</p>
            <a href="/teacher/course/create" class="btn btn-primary">Create Your First Course</a>
        </div>
    @else
        <div class="row">
            @for(Course course : courses)
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card course-card h-100">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">${course.getName()}</h5>
                        </div>
                        <div class="card-body">
                            @if(course.getDescription() != null && !course.getDescription().trim().isEmpty())
                                <p class="card-text">${course.getDescription()}</p>
                            @else
                                <p class="card-text text-muted">No description available</p>
                            @endif

                            <div class="mt-3">
                                <small class="text-muted">
                                    <strong>Course ID:</strong> ${course.getId()}
                                </small>
                            </div>

                        </div>
                        <div class="card-footer">
                            <div class="btn-group w-100" role="group">
                                <a href="/teacher/course/${course.getId()}" class="btn btn-sm btn-outline-primary">View</a>
                                <a href="/teacher/course/edit/${course.getId()}" class="btn btn-sm btn-outline-secondary">Edit</a>
                                <a href="/teacher/course/delete/${course.getId()}" class="btn btn-sm btn-outline-danger"
                                   onclick="return confirm('Are you sure you want to delete this course?')">Delete</a>
                            </div>
                        </div>
                    </div>
                </div>
            @endfor
        </div>

        <div class="mt-4">
            <div class="alert alert-secondary">
                <strong>Total Courses:</strong> ${courses.size()}
            </div>
        </div>
    @endif

    <div class="card mt-4">
        <div class="card-header bg-info text-white">
            <h5 class="card-title mb-0">Quick Actions</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3 mb-2">
                    <a href="/teacher/course/create" class="btn btn-success w-100">Add New Course</a>
                </div>
                <div class="col-md-3 mb-2">
                    <a href="/teacher/search" class="btn btn-primary w-100">Search Students</a>
                </div>
                <div class="col-md-3 mb-2">
                    <a href="/teacher-home" class="btn btn-secondary w-100">Dashboard</a>
                </div>
                <div class="col-md-3 mb-2">
                    <a href="/teacher/profile" class="btn btn-outline-dark w-100">My Profile</a>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3 mt-5">
    <div class="container">
        <p class="mb-0">© 2025 Student Management System</p>
    </div>
</footer>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>