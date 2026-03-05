<%@ page import="java.sql.*, util.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservations</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Reservations</h2>

<table border="1">
    <tr>
        <th>Reservation No</th>
        <th>Guest Name</th>
        <th>Room Type</th>
        <th>Check-in</th>
        <th>Check-out</th>
        <th>Actions</th>
    </tr>
    <%
        try(Connection con = DBConnection.getConnection()) {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM reservations");
            while(rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("reservation_no") %></td>
        <td><%= rs.getString("guest_name") %></td>
        <td><%= rs.getString("room_type") %></td>
        <td><%= rs.getDate("check_in") %></td>
        <td><%= rs.getDate("check_out") %></td>
        <td>
            <form action="reservation" method="post" style="display:inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="reservation_no" value="<%= rs.getString("reservation_no") %>">
                <input type="submit" value="Delete">
            </form>
            <a href="edit_reservation.jsp?reservation_no=<%= rs.getString("reservation_no") %>">Edit</a>
            <a href="reservation?action=bill&reservation_no=<%= rs.getString("reservation_no") %>">Bill</a>
        </td>
    </tr>
    <%
            }
        } catch(Exception e) { e.printStackTrace(); }
    %>
</table>

<a href="staff_dashboard.jsp">Back to Dashboard</a>
</body>
</html>