@import studentsystem.com.dto.StudentSignupDTO
@import java.util.List
@import studentsystem.com.data.Group

@param StudentSignupDTO student
@param String error = null
@param String success = null
@param List<Group> groups = null

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Signup</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        .debug-info {
            background: #f8f9fa;
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px 0;
            font-family: monospace;
            font-size: 12px;
        }
    </style>
</head>
<body>
<section>
    <form id="signupForm" action="/signup/students" method="post">
        <h1>Student Sign Up</h1>

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

        <!-- Debug info - can be removed in production -->
        <div class="debug-info">
            <p>Student DTO present: ${student != null}</p>
            <p>Groups available: ${groups != null ? String.valueOf(groups.size()) : "null"}</p>
        </div>

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="firstName" name="firstName" value="${student != null ? student.getFirstName() : ""}" required>
            <label for="firstName">First Name</label>
        </div>

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="lastName" name="lastName" value="${student != null ? student.getLastName() : ""}" required>
            <label for="lastName">Last Name</label>
        </div>

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input type="text" id="username" name="username" value="${student != null ? student.getUsername() : ""}" required>
            <label for="username">Username</label>
        </div>

        <div class="inputbox">
            <ion-icon name="mail-outline"></ion-icon>
            <input type="email" id="email" name="email" value="${student != null ? student.getEmail() : ""}" required>
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

        @if(groups != null && !groups.isEmpty())
            <div class="inputbox">
                <ion-icon name="people-outline"></ion-icon>
                <select id="groupId" name="groupId">
                    <option value="">Select your group</option>
                    @for(Group group : groups)
                        <option value="${group.getId()}">${group.getName()}</option>
                    @endfor
                </select>
                <label for="groupId">Group</label>
            </div>
        @else
            <div class="error-message">No groups available</div>
        @endif

        <button id="submit" type="submit">Sign Up as Student</button>

        <div class="register">
            <p>Already have an account? <a href="/login">Log In</a></p>
        </div>

        <div class="switch-form">
            <p>Are you a teacher? <a href="/signup/teachers">Sign up as Teacher</a></p>
        </div>
    </form>
</section>

<script>
    document.getElementById("signupForm").addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('passwordcon').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
            return false;
        }
    });
</script>
</body>
</html>