<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession currentSession = request.getSession(false);
    if (currentSession == null || !"admin".equals(currentSession.getAttribute("role"))) {
        response.sendRedirect("index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Ocean View Admin | Management</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #0056b3;
            --secondary: #6c757d;
            --success: #28a745;
            --danger: #dc3545;
            --warning: #ffc107;
            --info: #17a2b8;
            --light: #f8f9fa;
            --dark: #343a40;
            --bg: #f0f2f5;
            --card-bg: #ffffff;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg);
            color: var(--dark);
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
        }

        /* Top Header Navigation */
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

        .top-bar h1 { margin: 0; font-size: 1.5rem; color: var(--primary); }

        /* Card Styling */
        .card {
            background: var(--card-bg);
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.03);
        }

        h2 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--dark);
            margin-top: 0;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        h2::before {
            content: '';
            width: 4px;
            height: 20px;
            background: var(--primary);
            border-radius: 10px;
        }

        /* Professional Grid System */
        .grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }

        .full-width { grid-column: span 2; }

        /* Input Styling */
        label {
            display: block;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--secondary);
            margin-bottom: 5px;
            margin-left: 2px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            border: 1px solid #e1e5eb;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 0.9rem;
            background-color: #fafbfd;
            transition: all 0.2s;
        }

        input:focus {
            outline: none;
            border-color: var(--primary);
            background-color: #fff;
            box-shadow: 0 0 0 3px rgba(0,86,179,0.1);
        }

        /* Button Styling */
        .btn {
            padding: 12px 20px;
            cursor: pointer;
            border: none;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            font-size: 0.9rem;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary { background-color: var(--primary); }
        .btn-success { background-color: var(--success); }
        .btn-danger { background-color: var(--danger); }
        .btn-warning { background-color: var(--warning); color: #000; }
        .btn-info { background-color: var(--info); }

        .btn:hover { opacity: 0.9; transform: translateY(-1px); }

        /* Status Alerts */
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
            font-size: 0.9rem;
        }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        .logout-section {
            text-align: center;
            margin-top: 40px;
            padding-bottom: 40px;
        }
    </style>
</head>
<body>

<div class="container">

    <div class="top-bar">
        <h1>Ocean View Admin</h1>
        <div>
            <span style="margin-right: 15px;">Welcome, <strong><%= currentSession.getAttribute("role") %></strong></span>
            <a href="login?action=logout" class="btn btn-danger" style="padding: 8px 15px; font-size: 0.8rem;">Logout</a>
        </div>
    </div>

    <%-- Success/Error Feedback --%>
    <% if (request.getParameter("success") != null) { %>
    <div class="alert alert-success">✓ Action completed: <%= request.getParameter("success") %></div>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-error">⚠ Error: <%= request.getParameter("error") %></div>
    <% } %>

    <div class="card">
        <h2>Reservation Reports</h2>
        <div style="display: flex; align-items: center; justify-content: space-between;">
            <p style="color: var(--secondary); margin: 0; font-size: 0.9rem;">Generate a real-time list of all guest bookings.</p>
            <form action="reservation" method="get">
                <input type="hidden" name="action" value="viewAll">
                <button type="submit" class="btn btn-info">Generate Report</button>
            </form>
        </div>
        <div class="dashboard-links">
            <a href="generate_report.jsp" target="_blank" class="report-btn">Generate Reservation PDF</a>
        </div>
    </div>

    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 25px;">

        <div class="card" style="grid-column: span 2;">
            <h2>Register New Staff Member</h2>
            <form action="staff" method="post">
                <input type="hidden" name="action" value="add">
                <input type="hidden" name="role" value="staff">

                <div class="grid">
                    <div>
                        <label>Staff ID </label>
                        <input type="number" name="user_id" placeholder="e.g. 01" required>
                    </div>
                    <div>
                        <label>Full Name</label>
                        <input type="text" name="full_name" placeholder="" required>
                    </div>
                    <div>
                        <label>Email Address</label>
                        <input type="email" name="email" placeholder="" required>
                    </div>
                    <div>
                        <label>Mobile Number</label>
                        <input type="text" name="mobile" placeholder="" required>
                    </div>
                    <div style="border-top: 1px solid #eee; padding-top: 15px; grid-column: span 2; margin-top: 5px;">
                        <span style="font-size: 0.8rem; font-weight: bold; color: var(--primary);">Login Credentials</span>
                    </div>
                    <div>
                        <label>Username</label>
                        <input type="text" name="username" placeholder="" required>
                    </div>
                    <div>
                        <label>Password</label>
                        <input type="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-success full-width" style="margin-top: 20px;">Register Account</button>
            </form>
        </div>

        <div class="card">
            <h2>Room Pricing</h2>
            <form action="rates" method="post">
                <label>Category</label>
                <select name="room_type" required>
                    <option value="Single">Single Room</option>
                    <option value="Double">Double Room</option>
                    <option value="Suite">Suite</option>
                </select>
                <label>Price ($)</label>
                <input type="number" step="0.01" name="new_rate" placeholder="Rate per Night" required>
                <button type="submit" class="btn btn-primary full-width" style="margin-top: 15px;">Update Price</button>
            </form>
        </div>

        <div class="card">
            <h2>Manage Accounts</h2>
            <form action="staff" method="post">
                <input type="hidden" name="action" value="edit">
                <label>Enter Staff ID</label>
                <input type="number" name="user_id" placeholder="" required>
                <label>New Details</label>
                <div style="display: flex; gap: 10px;">
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="password" name="password" placeholder="Password" required>
                </div>
                <button type="submit" class="btn btn-warning full-width" style="margin-top: 15px;">Modify Account</button>
            </form>
        </div>

    </div>

    <div class="card" style="border: 1px solid rgba(220, 53, 69, 0.2); background-color: #fffafa;">
        <h2 style="color: var(--danger);">Remove Staff Member</h2>
        <form action="staff" method="post" style="display: flex; gap: 20px; align-items: flex-end;">
            <input type="hidden" name="action" value="delete">
            <div style="flex-grow: 1;">
                <label>Staff ID</label>
                <input type="number" name="user_id" placeholder="" required>
            </div>
            <button type="submit" class="btn btn-danger" style="height: 45px; width: 180px;" onclick="return confirm('WARNING: This will permanently delete the account. Proceed?')">Delete User</button>
        </form>
    </div>

    <div class="logout-section">
        <p style="color: var(--secondary); font-size: 0.8rem;">Ocean View Resort Management System v2.0</p>
    </div>

</div>

</body>
</html>