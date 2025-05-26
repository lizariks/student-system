@import studentsystem.com.data.Course
@param Course course
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Course</title>
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
        .form-header {
            background-color: #ffc107;
            color: #212529;
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
    <div class="form-header text-center">
        <h1>Edit Course</h1>
        <p class="lead">Update course information and settings</p>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-warning text-dark">
                    <h5 class="card-title mb-0">Course Information</h5>
                </div>
                <div class="card-body">
                    <form action="/teacher/course/edit/${course.getId()}" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Course Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="${course.getName() != null ? course.getName() : ""}"
                                   required placeholder="Enter course name">
                            <div class="form-text">Provide a clear and descriptive name for your course</div>
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">Course Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4"
                                      placeholder="Enter course description (optional)">${course.getDescription() != null ? course.getDescription() : ""}</textarea>
                            <div class="form-text">Describe what students will learn in this course</div>
                        </div>


                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-warning btn-lg">Update Course</button>
                            <a href="/teacher/course" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Course Statistics -->
            <div class="card mt-4">
                <div class="card-header bg-info text-white">
                    <h5 class="card-title mb-0">Course Statistics</h5>
                </div>
            </div>

            <!-- Danger Zone -->
            <div class="card mt-4 border-danger">
                <div class="card-header bg-danger text-white">
                    <h5 class="card-title mb-0">Danger Zone</h5>
                </div>
                <div class="card-body">
                    <p class="text-danger">
                        <strong>Warning:</strong> Deleting this course will permanently remove all associated data including enrollments and grades.
                    </p>
                    <a href="/teacher/course/delete/${course.getId()}" class="btn btn-danger"
                       onclick="return confirm('Are you sure you want to delete this course? This action cannot be undone.')">
                        Delete Course
                    </a>
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