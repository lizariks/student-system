@import studentsystem.com.data.Teacher
@import java.util.List
@import studentsystem.com.dto.TeacherSignupDTO

@param TeacherSignupDTO teacher
@param String error = null
@param String success = null

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Signup</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<section>
    <form id="signupForm" action="/signup/teachers" method="post">
        <h1>Teacher Sign Up</h1>

        @if(error != null)
            <div class="error-message">
                ${error}
            </div>
        @endif

        @if(success != null)
            <div class="success-message">
                ${success}
            </div>
        @endif

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="firstName" name="firstName" value="${teacher != null ? teacher.getFirstName() : ""}" required>
            <label for="firstName">First Name</label>
        </div>

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="lastName" name="lastName" value="${teacher != null ? teacher.getLastName() : ""}" required>
            <label for="lastName">Last Name</label>
        </div>

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="username" name="username" value="${teacher != null ? teacher.getUsername() : ""}" required>
            <label for="username">Username</label>
        </div>

        <div class="inputbox">
            <ion-icon name="mail-outline"></ion-icon>
            <input type="email" id="email" name="email" value="${teacher != null ? teacher.getEmail() : ""}" required>
            <label for="email">Email</label>
        </div>

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input type="password" id="password" name="password" required>
            <label for="password">Password</label>
        </div>

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input type="password" id="passwordcon" name="passwordcon" required>
            <label for="passwordcon">Confirm Password</label>
        </div>

        <button id="submit" type="submit">Sign Up as Teacher</button>

        <div class="register">
            <p>Already have an account? <a href="/login">Log In</a></p>
        </div>

        <div class="switch-form">
            <p>Are you a student? <a href="/signup/students">Sign up as Student</a></p>
        </div>
    </form>
</section>

<script>
    document.getElementById("signupForm").addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('passwordcon').value;
        const username = document.getElementById('username').value;
        const email = document.getElementById('email').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
            return false;
        }
    });
</script>
</body>
</html>