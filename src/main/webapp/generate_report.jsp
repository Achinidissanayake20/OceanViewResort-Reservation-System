<%@ page import="java.sql.*, util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reservation Report - Ocean View Resort</title>
    <style>
        body { font-family: serif; padding: 40px; color: #333; }
        .header { text-align: center; border-bottom: 2px solid #004080; margin-bottom: 30px; padding-bottom: 10px; }
        .resort-name { font-size: 28px; font-weight: bold; color: #004080; text-transform: uppercase; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #999; padding: 10px; text-align: left; font-size: 12px; }
        th { background-color: #f2f2f2; }
        .footer { margin-top: 50px; font-size: 10px; text-align: center; color: #777; }
        @media print {
            .no-print { display: none; }
        }
    </style>
</head>
<body>

<div class="header">
    <div class="resort-name">Ocean View Resort</div>
    <p>Galle, Sri Lanka | Management Report: Reservations</p>
    <p>Generated on: <%= new java.util.Date() %></p>
</div>

<button class="no-print" onclick="window.print()" style="padding: 10px 20px; background: #004080; color: white; border: none; cursor: pointer; border-radius: 5px; margin-bottom: 20px;">
    Save as PDF / Print Report
</button>

<table>
    <thead>
    <tr>
        <th>Res No</th>
        <th>Guest Name</th>
        <th>Room Type</th>
        <th>Check In</th>
        <th>Check Out</th>
        <th>Contact</th>
    </tr>
    </thead>
    <tbody>
    <%
        try (Connection con = DBConnection.getConnection()) {
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM reservations ORDER BY check_in DESC");
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("reservation_no") %></td>
        <td><%= rs.getString("guest_name") %></td>
        <td><%= rs.getString("room_type") %></td>
        <td><%= rs.getDate("check_in") %></td>
        <td><%= rs.getDate("check_out") %></td>
        <td><%= rs.getString("contact_number") %></td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("Error generating report: " + e.getMessage());
        }
    %>
    </tbody>
</table>

<div class="footer">
    <p>End of Official Reservation Report - Confidential Information</p>
</div>

</body>
</html>