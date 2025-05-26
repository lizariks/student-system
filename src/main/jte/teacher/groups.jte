@import studentsystem.com.data.Teacher
@import studentsystem.com.data.Group
@import java.util.List
@param Teacher teacher
@param List<Group> groups

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Student Groups - Teacher Portal</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f8f9fa; padding-top: 20px; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .group-card { transition: transform 0.3s; }
        .group-card:hover { transform: translateY(-5px); }
        .navbar-brand { font-weight: bold; }
        .student-count-badge { font-size: 0.85em; }
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
                <li class="nav-item"><a class="nav-link" href="/teacher-home">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/course">My Courses</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/search">Students</a></li>
                <li class="nav-item"><a class="nav-link active" href="/teacher/groups">Groups</a></li>
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
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Student Groups</h2>
        <a href="/teacher-home" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    @if(groups == null || groups.isEmpty())
        <div class="alert alert-info">
            <h4>No Groups Available</h4>
            <p>There are currently no student groups in the system.</p>
        </div>
    @else
        <div class="row">
            @for(Group group : groups)
                <div class="col-md-4 mb-4">
                    <div class="card group-card h-100">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">${group.getName()}</h5>
                            <span class="badge bg-light text-dark student-count-badge">
                                @if(group.getStudents() != null)
                                    ${group.getStudents().size()} students
                                @else
                                    0 students
                                @endif
                            </span>
                        </div>
                        <div class="card-body">
                            <p class="card-text">
                                <strong>Year:</strong> ${group.getYear()}<br>
                                <strong>Group ID:</strong> ${group.getId()}
                            </p>
                            @if(group.getStudents() != null && !group.getStudents().isEmpty())
                                <p class="text-muted mb-0">
                                    <small>Students enrolled in this group</small>
                                </p>
                            @else
                                <p class="text-muted mb-0">
                                    <small>No students enrolled yet</small>
                                </p>
                            @endif
                        </div>
                        <div class="card-footer">
                            <a href="/teacher/groups/${group.getId()}" class="btn btn-sm btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            @endfor
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