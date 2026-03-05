<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || currentSession.getAttribute("role") == null) {
        response.sendRedirect("index.jsp?error=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Ocean View Resort | Staff Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0056b3;
            --secondary: #6c757d;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
            --highlight: #e7f1ff;
            --bg: #f0f2f5;
            --card-bg: #ffffff;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: #333;
            margin: 0;
            padding: 20px;
        }

        .container { max-width: 1200px; margin: auto; }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: var(--card-bg);
            padding: 15px 30px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
        }

        .search-container {
            background: var(--highlight);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,86,179,0.1);
            border: 2px solid var(--primary);
            margin-bottom: 25px;
        }

        .search-flex { display: flex; gap: 15px; align-items: center; }

        .card {
            background: var(--card-bg);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.03);
            margin-bottom: 25px;
        }

        h2 {
            font-size: 1.1rem;
            font-weight: 700;
            margin-top: 0;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--primary);
        }

        .grid { display: grid; grid-template-columns: 1fr 1fr; gap: 25px; }

        label { font-size: 0.8rem; font-weight: 600; color: var(--secondary); display: block; margin-bottom: 5px; }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #e1e5eb;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 0.9rem;
            margin-bottom: 15px;
            background-color: #fafbfd;
        }

        input:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(0,86,179,0.1); }

        .btn {
            padding: 12px;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-add { background-color: var(--success); width: 100%; }
        .btn-bill { background-color: var(--info); width: 100%; }
        .btn-search { background-color: var(--primary); min-width: 150px; }
        .btn-delete { background-color: var(--danger); width: 100%; }
        .btn-warning { background-color: var(--warning); color: #000; width: 100%; }

        .btn:hover { opacity: 0.9; transform: translateY(-1px); }

        .inner-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }

        .divider { height: 1px; background: #eee; margin: 20px 0; }

        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }

        /* Help Box Enhanced Styles */
        .help-box { background-color: #fff8e1; border-left: 5px solid var(--warning); padding: 20px; border-radius: 8px; }
        .help-box ul { padding-left: 20px; margin: 0; }
        .help-box li { margin-bottom: 8px; font-size: 0.9rem; line-height: 1.4; color: #555; }
    </style>
</head>
<body>

<div class="container">

    <div class="top-bar">
        <h1 style="margin:0; font-size: 1.4rem; color: var(--primary);">Ocean View | Staff Portal</h1>
        <div>
            <span>Welcome, <strong><%= currentSession.getAttribute("role") %></strong></span> |
            <a href="login?action=logout" style="color: var(--danger); text-decoration:none; font-weight:600; margin-left:10px;">Exit System</a>
        </div>
    </div>

    <% if (request.getParameter("success") != null) { %>
    <div class="alert">✓ Action Successful: <%= request.getParameter("success") %></div>
    <% } %>

    <div class="search-container">
        <h2>🔍 Quick Search</h2>
        <form action="reservation" method="get" class="search-flex">
            <input type="hidden" name="action" value="search">
            <input type="text" name="query" placeholder="Enter Guest Name or Reservation Number..." style="margin-bottom:0;" required>
            <button type="submit" class="btn btn-search">Search</button>
        </form>
    </div>

    <div class="grid">
        <div class="card">
            <h2>📝 Register New Guest</h2>
            <form action="reservation" method="post">
                <input type="hidden" name="action" value="add">

                <label>Reservation Number</label>
                <input type="text" name="reservation_no" placeholder="" required>

                <label>Guest Full Name</label>
                <input type="text" name="guest_name" required>

                <label>Address</label>
                <textarea name="address" rows="2" required></textarea>

                <label>Contact Number</label>
                <input type="text" name="contact_number" required>

                <div class="inner-grid">
                    <div>
                        <label>Room Type</label>
                        <select name="room_type" required>
                            <option value="Single">Single</option>
                            <option value="Double">Double</option>
                            <option value="Suite">Suite</option>
                        </select>
                    </div>
                    <div>
                        <label>Check-In</label>
                        <input type="date" name="check_in" required>
                    </div>
                </div>

                <label>Check-Out</label>
                <input type="date" name="check_out" required>

                <button type="submit" class="btn btn-add">Confirm Booking</button>
            </form>
        </div>

        <div class="column-right">

            <div class="card">
                <h2>⚙️ Update Booking Details</h2>
                <form action="reservation" method="post">
                    <input type="hidden" name="action" value="edit">
                    <label>Target Reservation No (Required)</label>
                    <input type="text" name="reservation_no" placeholder="" required>

                    <label>Updated Guest Name</label>
                    <input type="text" name="guest_name" required>

                    <label>Updated Address</label>
                    <textarea name="address" rows="1" required></textarea>

                    <div class="inner-grid">
                        <div>
                            <label>Update Contact</label>
                            <input type="text" name="contact_number" required>
                        </div>
                        <div>
                            <label>Update Room</label>
                            <select name="room_type" required>
                                <option value="Single">Single</option>
                                <option value="Double">Double</option>
                                <option value="Suite">Suite</option>
                            </select>
                        </div>
                    </div>

                    <div class="inner-grid">
                        <div>
                            <label>Update Check-In</label>
                            <input type="date" name="check_in" required>
                        </div>
                        <div>
                            <label>Update Check-Out</label>
                            <input type="date" name="check_out" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-warning">Update All Fields</button>
                </form>

                <div class="divider"></div>

                <h2>🗑️ Delete Reservation</h2>
                <form action="reservation" method="post">
                    <input type="hidden" name="action" value="delete">
                    <label>Reservation Number to Remove</label>
                    <input type="text" name="reservation_no" placeholder="" required>
                    <button type="submit" class="btn btn-delete" onclick="return confirm('Permanently delete this record?')">Delete Reservation</button>
                </form>
            </div>

            <div class="card" style="border-top: 4px solid var(--info);">
                <h2>💳 Billing & Invoices</h2>
                <form action="reservation" method="post">
                    <input type="hidden" name="action" value="bill">
                    <label>Reservation Number</label>
                    <input type="text" name="reservation_no" placeholder="" required>
                    <button type="submit" class="btn btn-bill">Generate Invoice</button>
                </form>
            </div>
        </div>
    </div>

    <div class="card">
        <h2>💡 System Guidelines & Help</h2>
        <div class="help-box">
            <ul>
                <li><strong>Registration:</strong> Always collect a unique Reservation Number for every guest to avoid database conflicts.</li>
                <li><strong>Validation:</strong> Ensure the Check-out date is strictly after the Check-in date to ensure accurate billing calculation.</li>
                <li><strong>Updates:</strong> All fields are required for updates to ensure the guest record remains complete in the database.</li>
                <li><strong>Security:</strong> Always use the "Exit System" button before leaving your terminal to protect guest data.</li>
            </ul>
        </div>
    </div>
</div>

</body>
</html>