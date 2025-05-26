@import studentsystem.com.data.Teacher
@import studentsystem.com.data.Group
@import studentsystem.com.data.Student
@param Teacher teacher
@param Group group

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Group Details - ${group.getName()}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background-color: #f8f9fa; padding-top: 20px; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .navbar-brand { font-weight: bold; }
        .student-row:hover { background-color: #f8f9fa; }
        .group-header { background: linear-gradient(135deg, #007bff, #0056b3); color: white; }
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
                <li class="nav-item"><a class="nav-link" href="/teacher/home">Dashboard</a></li>
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
        <h2>Group Details</h2>
        <a href="/teacher/groups" class="btn btn-secondary">Back to Groups</a>
    </div>

    <div class="card mb-4">
        <div class="card-header group-header">
            <h3 class="mb-0">${group.getName()}</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Group ID:</strong> ${group.getId()}</p>
                    <p><strong>Academic Year:</strong> ${group.getYear()}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Total Students:</strong>
                        @if(group.getStudents() != null)
                            <span class="badge bg-primary">${group.getStudents().size()}</span>
                        @else
                            <span class="badge bg-secondary">0</span>
                        @endif
                    </p>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0">Students in this Group</h5>
        </div>
        <div class="card-body">
            @if(group.getStudents() == null || group.getStudents().isEmpty())
                <div class="alert alert-info">
                    <h6>No Students Enrolled</h6>
                    <p class="mb-0">This group currently has no students enrolled.</p>
                </div>
            @else
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-dark">
                        <tr>
                            <th>Student ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                        </tr>
                        </thead>
                        <tbody>
                        @for(Student student : group.getStudents())
                            <tr class="student-row">
                                <td>${student.getId()}</td>
                                <td>
                                    @if(student.getFirstName() != null && student.getLastName() != null)
                                        ${student.getFirstName()} ${student.getLastName()}
                                    @else
                                        N/A
                                    @endif
                                </td>
                                <td>
                                    @if(student.getUsername() != null)
                                        ${student.getUsername()}
                                    @else
                                        N/A
                                    @endif
                                </td>
                                <td>
                                    @if(student.getEmail() != null)
                                        ${student.getEmail()}
                                    @else
                                        N/A
                                    @endif
                                </td>
                            </tr>
                        @endfor
                        </tbody>
                    </table>
                </div>
                <div class="mt-4">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="alert alert-light">
                                <strong>Summary:</strong>
                                Group "${group.getName()}" has ${group.getStudents().size()} student(s) enrolled for the ${group.getYear()} academic year.
                            </div>
                        </div>
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