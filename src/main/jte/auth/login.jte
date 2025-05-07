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

<style>
    .error-message {
        color: #ff3333;
        background-color: rgba(255, 51, 51, 0.1);
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
        text-align: center;
    }

    .success-message {
        color: #00cc66;
        background-color: rgba(0, 204, 102, 0.1);
        padding: 10px;
        border-radius: 5px;
        margin-bottom: 15px;
        text-align: center;
    }

    .remember-forgot {
        display: flex;
        justify-content: space-between;
        margin: 10px 0 15px;
        font-size: 14px;
    }

    .remember-forgot label {
        display: flex;
        align-items: center;
    }

    .remember-forgot input {
        margin-right: 5px;
    }

    .remember-forgot a {
        color: #0066cc;
    }

    .signup-options {
        display: flex;
        justify-content: space-between;
        margin-top: 10px;
        gap: 10px;
    }

    .signup-option {
        padding: 8px 12px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 5px;
        font-size: 14px;
        transition: all 0.3s ease;
    }

    .signup-option:hover {
        background: rgba(255, 255, 255, 0.2);
    }
</style>
</body>
</html>