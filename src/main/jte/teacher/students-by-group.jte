@import studentsystem.com.data.Student
@import java.util.List
@param List<Student> students
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students by Group</title>
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
        .student-card {
            transition: transform 0.3s;
        }
        .student-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
<!-- Navigation -->
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Students in Group</h2>
        <a href="/teacher/courses" class="btn btn-secondary">Back to Courses</a>
    </div>

    @if(students == null || students.isEmpty())
        <div class="alert alert-info">
            <h4>No Students Found</h4>
            <p>There are no students in this group yet.</p>
        </div>
    @else
        <div class="row">
            @for(Student student : students)
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card student-card h-100">
                        <div class="card-header bg-primary text-white">
                            <div class="d-flex align-items-center">
                                <div class="bg-white text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px; font-weight: bold;">
                                    ${student.getFirstName() != null ? student.getFirstName().substring(0, 1).toUpperCase() : "S"}
                                </div>
                                <div>
                                    <h6 class="card-title mb-0">${student.getFirstName()} ${student.getLastName()}</h6>
                                    <small>ID: ${student.getId()}</small>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <p class="card-text">
                                <strong>Username:</strong> ${student.getUsername()}<br>
                                @if(student.getEmail() != null)
                                    <strong>Email:</strong> ${student.getEmail()}<br>
                                @endif
                                @if(student.getGroup() != null)
                                    <strong>Group:</strong> ${student.getGroup().getName()}
                                @endif
                            </p>
                        </div>
                        <div class="card-footer">
                            <a href="/teacher/students/${student.getId()}" class="btn btn-sm btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            @endfor
        </div>

        <div class="mt-4">
            <div class="alert alert-secondary">
                <strong>Total Students:</strong> ${students.size()}
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