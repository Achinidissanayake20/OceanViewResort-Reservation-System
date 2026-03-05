<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ocean View Resort | Management Login</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Internal fallback styles in case your CSS folder isn't linked yet */
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f4f8; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); width: 350px; }
        .resort-title { color: #0056b3; text-align: center; margin-bottom: 0.5rem; }
        .error-msg { color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 10px; border-radius: 4px; margin-bottom: 1rem; font-size: 0.9rem; text-align: center; }
        .form-group { margin-bottom: 1rem; }
        input[type="text"], input[type="password"] { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        input[type="submit"] { width: 100%; padding: 10px; background-color: #0056b3; border: none; color: white; border-radius: 4px; cursor: pointer; font-weight: bold; }
        input[type="submit"]:hover { background-color: #004494; }
    </style>
</head>
<body>

<div class="login-card">
    <h1 class="resort-title">Ocean View Resort</h1>
    <p style="text-align: center; color: #666;">Galle, Sri Lanka</p>
    <hr>

    <h3 style="text-align: center;">Authentication</h3>

    <%-- Error Handling: Displays only if 'error' param is passed back from LoginServlet --%>
    <%
        String error = request.getParameter("error");
        if ("invalid".equals(error)) {
    %>
    <div class="error-msg">
        Incorrect username or password.
    </div>
    <% } %>
    <% if ("exited".equals(request.getParameter("msg"))) { %>
    <div style="background-color: #d1ecf1; color: #0c5460; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: center; border: 1px solid #bee5eb;">
        Successfully logged out of Ocean View System.
    </div>
    <% } %>

    <form action="login" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="" required>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>

        <input type="submit" value="Sign In">
    </form>
</div>

</body>
</html>