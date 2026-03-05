<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection, javax.servlet.http.HttpSession" %>
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
    <title>View Staff Users</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Staff Users</h2>

<table border="1">
    <tr>
        <th>User ID</th>
        <th>Username</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>
    <%
        try(Connection con = DBConnection.getConnection()) {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE role='staff'");
            while(rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("user_id") %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("role") %></td>
        <td>
            <!-- Edit Staff -->
            <form action="staff" method="post" style="display:inline;">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                Username: <input type="text" name="username" value="<%= rs.getString("username") %>" required>
                Password: <input type="text" name="password" placeholder="New password" required>
                <input type="submit" value="Update">
            </form>
            <!-- Delete Staff -->
            <form action="staff" method="post" style="display:inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
                <input type="submit" value="Delete">
            </form>
        </td>
    </tr>
    <%
            }
        } catch(Exception e) { e.printStackTrace(); }
    %>
</table>

<a href="admin_dashboard.jsp">Back to Dashboard</a>
</body>
</html>