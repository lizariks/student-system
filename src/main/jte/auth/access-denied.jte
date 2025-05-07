@param String message = "Access Denied"

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Access Denied</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="access-denied-container">
    <h1>Access Denied</h1>
    <p class="error-message">${message}</p>
    <p>You do not have permission to access this page.</p>
    <div class="actions">
        <a href="/login" class="btn btn-primary">Return to Login</a>
        <a href="/" class="btn btn-secondary">Go to Homepage</a>
    </div>
</div>
</body>
</html>