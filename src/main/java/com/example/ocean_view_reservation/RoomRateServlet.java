package com.oceanview.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/rates")
public class RoomRateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomType = request.getParameter("room_type");
        double newRate = Double.parseDouble(request.getParameter("new_rate"));

        try (Connection con = util.DBConnection.getConnection()) {
            // "INSERT ... ON DUPLICATE KEY UPDATE" works for MySQL
            String sql = "INSERT INTO room_rates (room_type, rate_per_night) VALUES (?, ?) " +
                    "ON DUPLICATE KEY UPDATE rate_per_night = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, roomType);
            pst.setDouble(2, newRate);
            pst.setDouble(3, newRate);
            pst.executeUpdate();

            response.sendRedirect("admin_dashboard.jsp?success=rate_updated");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=rate_update_failed");
        }
    }
}