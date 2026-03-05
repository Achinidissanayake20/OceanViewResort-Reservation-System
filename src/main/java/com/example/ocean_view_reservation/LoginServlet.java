package com.oceanview.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    /**
     * Handles Logout (Exit System)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp?msg=exited");
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    /**
     * Handles Login Authentication
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Console Debugging - This helps you see if the button click reached the code
        System.out.println("Login attempt: Username=" + user + " Password=" + pass);

        // 1. Admin Logic
        if ("admin".equals(user) && "admin123".equals(pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "admin");
            System.out.println("Redirecting to Admin Dashboard...");
            response.sendRedirect("admin_dashboard.jsp");
            return;
        }

        // 2. Staff Logic
        // IMPORTANT: Ensure the password matches exactly (staff123)
        else if ("staff".equals(user) && "staff123".equals(pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "staff");
            System.out.println("Redirecting to Staff Dashboard (staff_dashboard.jsp)...");
            response.sendRedirect("staff_dashboard.jsp");
            return;
        }

        // 3. Failure Logic
        else {
            System.out.println("Login failed. Redirecting back to index.");
            response.sendRedirect("index.jsp?error=invalid");
        }
    }
}