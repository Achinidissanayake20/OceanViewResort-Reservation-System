<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort | Management Login</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Updated styles to support the background image */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            /* THE FIX: Apply the image here with a dark overlay for readability */
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
            url('images/oceanview1.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Glass-morphism effect for the card */
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2.5rem;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            width: 380px;
            backdrop-filter: blur(5px); /* Makes the glass effect look modern */
        }

        .resort-title { color: #0056b3; text-align: center; margin-bottom: 0.2rem; font-size: 1.8rem; }
        .error-msg { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; border-radius: 4px; margin-bottom: 1rem; font-size: 0.9rem; text-align: center; }
        .form-group { margin-bottom: 1.2rem; }
        label { display: block; margin-bottom: 5px; font-weight: 600; color: #333; }
        input[type="text"], input[type="password"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; }
        input[type="submit"] { width: 100%; padding: 12px; background-color: #0056b3; border: none; color: white; border-radius: 6px; cursor: pointer; font-weight: bold; transition: 0.3s; margin-top: 10px; }
        input[type="submit"]:hover { background-color: #004494; transform: translateY(-1px); }
    </style>
</head>
<body>

<div class="login-card">
    <h1 class="resort-title">Ocean View Resort</h1>
    <p style="text-align: center; color: #666; margin-top: 0;">Galle, Sri Lanka</p>
    <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">

    <h3 style="text-align: center; color: #444; margin-bottom: 20px;">Staff Authentication</h3>

    <%
        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
    %>
    <div class="error-msg">
        Incorrect username or password.
    </div>
    <% } %>

    <% if ("exited".equals(request.getParameter("msg"))) { %>
    <div style="background-color: #d1ecf1; color: #0c5460; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: center; border: 1px solid #bee5eb; font-size: 0.9rem;">
        Successfully logged out.
    </div>
    <% } %>

    <form action="login" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter username" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <input type="submit" value="Sign In">
    </form>

    <p style="text-align: center; font-size: 0.75rem; color: #999; margin-top: 25px;">
        &copy; 2026 Ocean View Resort Management System
    </p>
</div>

</body>
</html>