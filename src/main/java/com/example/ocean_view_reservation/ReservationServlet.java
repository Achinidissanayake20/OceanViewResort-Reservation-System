package com.oceanview.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.time.*;
import java.time.temporal.ChronoUnit;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    // --- GET METHOD: Handles both View All and Search ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if ("viewAll".equals(action) || "search".equals(action)) {
            String searchQuery = request.getParameter("query");

            out.println("<html><head><title>Reservation Management</title><link rel='stylesheet' href='css/style.css'></head><body>");
            out.println("<div style='padding:20px; font-family:Arial;'>");
            out.println("<h2>Ocean View Resort - " + ("search".equals(action) ? "Search Results" : "All Reservations") + "</h2>");

            out.println("<table border='1' cellpadding='10' style='border-collapse: collapse; width:100%;'>");
            out.println("<tr style='background-color:#f2f2f2;'><th>Res No</th><th>Guest Name</th><th>Room Type</th><th>Check In</th><th>Check Out</th></tr>");

            // Standardized Connection Handling
            try (Connection con = util.DBConnection.getConnection()) {
                PreparedStatement pst;

                if ("search".equals(action) && searchQuery != null && !searchQuery.trim().isEmpty()) {
                    String sql = "SELECT * FROM reservations WHERE guest_name LIKE ? OR reservation_no LIKE ?";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, "%" + searchQuery + "%");
                    pst.setString(2, "%" + searchQuery + "%");
                } else {
                    pst = con.prepareStatement("SELECT * FROM reservations");
                }

                try (ResultSet rs = pst.executeQuery()) {
                    boolean dataFound = false;
                    while (rs.next()) {
                        dataFound = true;
                        out.println("<tr>");
                        out.println("<td>" + rs.getString("reservation_no") + "</td>");
                        out.println("<td>" + rs.getString("guest_name") + "</td>");
                        out.println("<td>" + rs.getString("room_type") + "</td>");
                        out.println("<td>" + rs.getDate("check_in") + "</td>");
                        out.println("<td>" + rs.getDate("check_out") + "</td>");
                        out.println("</tr>");
                    }
                    if (!dataFound) {
                        out.println("<tr><td colspan='5' style='text-align:center;'>No reservations found.</td></tr>");
                    }
                }
                out.println("</table><br><a href='staff_dashboard.jsp'>Back to Dashboard</a></div></body></html>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
            }
        }
    }

    // --- POST METHOD: Add, Edit, Delete, Calculate ---
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("staff_dashboard.jsp");
            return;
        }

        switch (action) {
            case "add": addReservation(request, response); break;
            case "edit": editReservation(request, response); break;
            case "delete": deleteReservation(request, response); break;
            case "bill": calculateBill(request, response); break;
        }
    }

    private void addReservation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "INSERT INTO reservations(reservation_no, guest_name, address, contact_number, room_type, check_in, check_out) VALUES(?,?,?,?,?,?,?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, request.getParameter("reservation_no"));
            pst.setString(2, request.getParameter("guest_name"));
            pst.setString(3, request.getParameter("address"));
            pst.setString(4, request.getParameter("contact_number"));
            pst.setString(5, request.getParameter("room_type"));
            pst.setDate(6, Date.valueOf(request.getParameter("check_in")));
            pst.setDate(7, Date.valueOf(request.getParameter("check_out")));
            pst.executeUpdate();
            response.sendRedirect("staff_dashboard.jsp?success=added");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("staff_dashboard.jsp?error=addfail");
        }
    }

    private void editReservation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String resNo = request.getParameter("reservation_no");
        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "UPDATE reservations SET guest_name=?, address=?, contact_number=?, room_type=?, check_in=?, check_out=? WHERE reservation_no=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, request.getParameter("guest_name"));
            pst.setString(2, request.getParameter("address"));
            pst.setString(3, request.getParameter("contact_number"));
            pst.setString(4, request.getParameter("room_type"));
            pst.setDate(5, Date.valueOf(request.getParameter("check_in")));
            pst.setDate(6, Date.valueOf(request.getParameter("check_out")));
            pst.setString(7, resNo);
            pst.executeUpdate();
            response.sendRedirect("staff_dashboard.jsp?success=updated");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("staff_dashboard.jsp?error=updatefail");
        }
    }

    private void deleteReservation(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String resNo = request.getParameter("reservation_no");
        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "DELETE FROM reservations WHERE reservation_no=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, resNo);
            pst.executeUpdate();
            response.sendRedirect("staff_dashboard.jsp?success=deleted");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("staff_dashboard.jsp?error=deletefail");
        }
    }

    private void calculateBill(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String resNo = request.getParameter("reservation_no");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection con = util.DBConnection.getConnection()) {
            String sql = "SELECT room_type, check_in, check_out FROM reservations WHERE reservation_no=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, resNo);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    String roomType = rs.getString("room_type");
                    LocalDate checkIn = rs.getDate("check_in").toLocalDate();
                    LocalDate checkOut = rs.getDate("check_out").toLocalDate();

                    long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
                    if (nights <= 0) nights = 1;

                    double rate = 100.0; // Default fallback
                    String rateSql = "SELECT rate_per_night FROM room_rates WHERE room_type=?";
                    PreparedStatement ratePst = con.prepareStatement(rateSql);
                    ratePst.setString(1, roomType);
                    try (ResultSet rateRs = ratePst.executeQuery()) {
                        if (rateRs.next()) rate = rateRs.getDouble("rate_per_night");
                    }

                    double total = rate * nights;
                    out.println("<html><body style='font-family:Arial; padding:20px; border: 2px solid #0056b3;'>");
                    out.println("<h1>Ocean View Resort - Invoice</h1>");
                    out.println("<p>Guest Reservation: <strong>" + resNo + "</strong></p>");
                    out.println("<p>Room Category: " + roomType + " (@ $" + rate + "/night)</p>");
                    out.println("<p>Stay Duration: " + nights + " Night(s)</p>");
                    out.println("<hr><h2>Total Payable: $" + String.format("%.2f", total) + "</h2>");
                    out.println("<br><button onclick='window.print()'>Print Receipt</button>");
                    out.println("<br><br><a href='staff_dashboard.jsp'>Back to Menu</a></body></html>");
                } else {
                    out.println("Reservation not found.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error calculating bill.");
        }
    }
}