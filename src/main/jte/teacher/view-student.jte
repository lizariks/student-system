@import studentsystem.com.data.Student
@param Student student
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details</title>
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
        .student-header {
            background-color: #343a40;
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .avatar {
            width: 100px;
            height: 100px;
            font-size: 3rem;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/teacher/home">Teacher Portal</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/teacher/home">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/teacher/courses">My Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="/teacher/students/search">Students</a>
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
    <div class="student-header text-center">
        <h1>Student Details</h1>
        <p class="lead">Complete information about the student</p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">Student Profile</h5>
                </div>
                <div class="card-body text-center">
                    <div class="avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4">
                        ${student.getFirstName() != null ? student.getFirstName().substring(0, 1).toUpperCase() : "S"}
                    </div>
                    <h4>${student.getFirstName()} ${student.getLastName()}</h4>
                    <p class="text-muted">Student ID: ${student.getId()}</p>
                </div>
            </div>

            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="card-title mb-0">Quick Actions</h5>
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <a href="/teacher/students/search" class="btn btn-outline-primary">Back to Search</a>
                        @if(student.getGroup() != null)
                            <a href="/teacher/students/group/${student.getGroup().getId()}" class="btn btn-outline-secondary">View Group Students</a>
                        @endif
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card">
                <div class="card-header bg-dark text-white">
                    <h5 class="card-title mb-0">Personal Information</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>First Name:</strong> ${student.getFirstName()}</p>
                            <p><strong>Last Name:</strong> ${student.getLastName()}</p>
                            <p><strong>Username:</strong> ${student.getUsername()}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Email:</strong> ${student.getEmail() != null ? student.getEmail() : "Not provided"}</p>
                            <p><strong>Student ID:</strong> ${student.getId()}</p>
                            @if(student.getGroup() != null)
                                <p><strong>Group:</strong> ${student.getGroup().getName()}</p>
                            @else
                                <p><strong>Group:</strong> Not assigned</p>
                            @endif
                        </div>
                    </div>
                </div>
            </div>



            @if(student.getGroup() != null)
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="card-title mb-0">Group Information</h5>
                    </div>
                    <div class="card-body">
                        <p><strong>Group Name:</strong> ${student.getGroup().getName()}</p>
                        <a href="/teacher/students/group/${student.getGroup().getId()}" class="btn btn-outline-secondary">View All Group Students</a>
                    </div>
                </div>
            @endif
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