<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Reservation</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<h2>Edit Reservation</h2>

<form action="reservation" method="post">
    <input type="hidden" name="action" value="edit">

    <label>Reservation No (to edit):</label><br>
    <input type="text" name="reservation_no" required><br><br>

    <label>Guest Name:</label><br>
    <input type="text" name="guest_name" required><br><br>

    <label>Address:</label><br>
    <input type="text" name="address" required><br><br>

    <label>Contact Number:</label><br>
    <input type="text" name="contact_number" required><br><br>

    <label>Room Type:</label><br>
    <select name="room_type" required>
        <option value="Single">Single</option>
        <option value="Double">Double</option>
        <option value="Suite">Suite</option>
    </select><br><br>

    <label>Check-in Date:</label><br>
    <input type="date" name="check_in" required><br><br>

    <label>Check-out Date:</label><br>
    <input type="date" name="check_out" required><br><br>

    <input type="submit" value="Update Reservation">
</form>

<a href="staff_dashboard.jsp">Back to Dashboard</a>
</body>
</html>