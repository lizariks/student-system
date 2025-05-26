@param String errorMessage = null
@param String success = null

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<section>
    <form method="post" action="/login">
        <h1>Login</h1>

        @if(errorMessage != null)
            <div class="error-message">
                ${errorMessage}
            </div>
        @endif

        @if(success != null)
            <div class="success-message">
                ${success}
            </div>
        @endif

        <div class="inputbox">
            <ion-icon name="person-outline"></ion-icon>
            <input name="username" id="username" type="text" required>
            <label for="username">Username</label>
        </div>

        <div class="inputbox">
            <ion-icon name="lock-closed-outline"></ion-icon>
            <input name="password" type="password" id="password" required>
            <label for="password">Password</label>
        </div>

        <div class="remember-forgot">
            <label><input type="checkbox" name="remember-me"> Remember me</label>
            <a href="/reset-password">Forgot Password?</a>
        </div>

        <button type="submit">Log in</button>

        <div class="register">
            <p>Don't have an account?</p>
            <div class="signup-options">
                <a href="/signup/students" class="signup-option">Register as Student</a>
                <a href="/signup/teachers" class="signup-option">Register as Teacher</a>
            </div>
        </div>
    </form>
</section>
</body>
</html>