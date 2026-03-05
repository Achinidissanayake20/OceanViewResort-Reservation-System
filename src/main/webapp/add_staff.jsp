<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession session = request.getSession(false);
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Staff User</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Add New Staff</h2>

<form action="staff" method="post">
    <input type="hidden" name="action" value="add">

    <label>Username:</label><br>
    <input type="text" name="username" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <input type="hidden" name="role" value="staff">
    <input type="submit" value="Add Staff">
</form>

<a href="admin_dashboard.jsp">Back to Dashboard</a>
</body>
</html>