@import studentsystem.com.data.Teacher
@import studentsystem.com.data.Course
@import java.util.Set
@param Teacher teacher
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; padding-top: 20px; }
        .card { box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .profile-header { background-color: #343a40; color: white; padding: 2rem 0; margin-bottom: 2rem; }
        .navbar-brand { font-weight: bold; }
        .avatar { width: 100px; height: 100px; font-size: 3rem; }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="/teacher/home">Teacher Portal</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="/teacher/home">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="/teacher/courses">My Courses</a></li>
                <li class="nav-item"><a class="nav-link active" href="/teacher/profile">Profile</a></li>
            </ul>
            <div class="d-flex">
                @if(teacher != null)
                    <span class="navbar-text me-3 text-white">Welcome, ${teacher.getUsername()}</span>
                @else
                    <span class="navbar-text me-3 text-white">Welcome, Teacher</span>
                @endif
                <a href="/logout" class="btn btn-outline-light">Logout</a>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="profile-header text-center">
        <h1>Teacher Profile</h1>
        <p class="lead">Manage your personal and teaching information</p>
    </div>

    @if(teacher == null)
        <div class="alert alert-warning">
            <h4>Session Error</h4>
            <p>Unable to load teacher information. Please try logging in again or contact support.</p>
            <a href="/auth/login" class="btn btn-primary">Login Again</a>
        </div>
    @else
        <div class="row">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h5 class="card-title mb-0">Profile Summary</h5>
                    </div>
                    <div class="card-body text-center">
                        <div class="avatar bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center mx-auto mb-4">
                            ${teacher.getFirstName() != null ? teacher.getFirstName().substring(0, 1).toUpperCase() : "T"}
                        </div>
                        <p><strong>Username:</strong> ${teacher.getUsername()}</p>
                        <p><strong>Name:</strong> ${teacher.getFirstName()} ${teacher.getLastName()}</p>
                        <p><strong>Email:</strong> ${teacher.getEmail() != null ? teacher.getEmail() : "Not provided"}</p>
                        <p><strong>Courses:</strong> ${teacher.getCourses() != null ? teacher.getCourses().size() : 0} teaching</p>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">Quick Links</h5>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <a href="/teacher/home" class="list-group-item list-group-item-action">Dashboard</a>
                            <a href="/teacher/courses" class="list-group-item list-group-item-action">My Courses</a>
                            <a href="/teacher/schedule" class="list-group-item list-group-item-action">Schedule</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-dark text-white">
                        <h5 class="card-title mb-0">Edit Profile</h5>
                    </div>
                    <div class="card-body">
                        <form action="/teacher/profile/update" method="post">
                            <div class="mb-3">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" value="${teacher.getFirstName() != null ? teacher.getFirstName() : ""}">
                            </div>
                            <div class="mb-3">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" value="${teacher.getLastName() != null ? teacher.getLastName() : ""}">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" value="${teacher.getEmail() != null ? teacher.getEmail() : ""}">
                            </div>
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username" value="${teacher.getUsername()}" readonly>
                                <div class="form-text">Username cannot be changed</div>
                            </div>
                            <hr>
                            <h5>Change Password</h5>
                            <div class="mb-3">
                                <label for="currentPassword" class="form-label">Current Password</label>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword">
                            </div>
                            <div class="mb-3">
                                <label for="newPassword" class="form-label">New Password</label>
                                <input type="password" class="form-control" id="newPassword" name="newPassword">
                            </div>
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword">
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-dark">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="card-title mb-0">My Courses</h5>
                    </div>
                    <div class="card-body">
                        @if(teacher.getCourses() == null || teacher.getCourses().isEmpty())
                            <div class="alert alert-info">
                                You are not assigned to any courses yet.
                            </div>
                        @else
                            <ul class="list-group">
                                @for(Course course : teacher.getCourses())
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${course.getName()}
                                        <a href="/teacher/course/${course.getId()}" class="btn btn-sm btn-outline-dark">Manage</a>
                                    </li>
                                @endfor
                            </ul>
                        @endif
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
</body>
</html>
