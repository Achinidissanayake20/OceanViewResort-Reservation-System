package com.oceanview.controller; // Matches your LoginServlet

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet; // Needed for the annotation
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/staff") // This maps the URL to the Servlet
public class StaffServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Safety check: if action is null, redirect back
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

    private void addStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 1. Capture all the new fields from your JSP
        String userId = request.getParameter("user_id");
        String fullName = request.getParameter("full_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String role = "staff";

        try (Connection con = util.DBConnection.getConnection()) {
            // 2. The SQL must match the table exactly
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
            response.sendRedirect("admin_dashboard.jsp?success=Staff Registered Successfully");

        } catch (Exception e) {
            e.printStackTrace(); // This sends the REAL error to the IntelliJ Console
            response.sendRedirect("admin_dashboard.jsp?error=add_failed");
        }
    }

    private void editStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Ensure your HTML form passes "user_id" as a hidden field
        String idStr = request.getParameter("user_id");
        if (idStr == null) {
            response.sendRedirect("admin_dashboard.jsp?error=missingid");
            return;
        }

        int userId = Integer.parseInt(idStr);
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "UPDATE users SET username=?, password=? WHERE user_id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setInt(3, userId);
            pst.executeUpdate();
            response.sendRedirect("admin_dashboard.jsp?success=updated");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=updatefail");
        }
    }

    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int userId = Integer.parseInt(request.getParameter("user_id"));

        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "DELETE FROM users WHERE user_id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(3, userId); // Error in your original code: index should be 1
            pst.setInt(1, userId);
            pst.executeUpdate();
            response.sendRedirect("admin_dashboard.jsp?success=deleted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin_dashboard.jsp?error=deletefail");
        }
    }
}