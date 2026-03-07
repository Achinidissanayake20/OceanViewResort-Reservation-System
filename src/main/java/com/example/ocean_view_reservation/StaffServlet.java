package com.oceanview.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("admin_dashboard.jsp");
            return;
        }

        switch(action) {
            case "add":
                addStaff(request, response);
                break;
            case "edit":
                editStaff(request, response);
                break;
            case "delete":
                deleteStaff(request, response);
                break;
            default:
                response.sendRedirect("admin_dashboard.jsp");
        }
    }

    // 1. ADD STAFF
    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userId = request.getParameter("user_id");
        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String role = "staff";

        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "INSERT INTO users (user_id, username, password, role, full_name, email, mobile) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, Integer.parseInt(userId));
            pst.setString(2, username);
            pst.setString(3, password);
            pst.setString(4, role);
            pst.setString(5, fullName);
            pst.setString(6, email);
            pst.setString(7, mobile);

            pst.executeUpdate();
            response.sendRedirect("admin_dashboard.jsp?success=Staff+Registered+Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=add_failed");
        }
    }

    // 2. EDIT STAFF
    private void editStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("user_id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("admin_dashboard.jsp?error=missingid");
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "UPDATE users SET username=?, password=? WHERE user_id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setInt(3, Integer.parseInt(idStr));
            pst.executeUpdate();
            response.sendRedirect("admin_dashboard.jsp?success=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=updatefail");
        }
    }

    // 3. DELETE STAFF
    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("user_id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("admin_dashboard.jsp?error=missingid");
            return;
        }

        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "DELETE FROM users WHERE user_id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            // Fixed: Only one parameter, so index is 1
            pst.setInt(1, Integer.parseInt(idStr));

            int rows = pst.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("admin_dashboard.jsp?success=deleted");
            } else {
                response.sendRedirect("admin_dashboard.jsp?error=usernotfound");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=deletefail");
        }
    }
}