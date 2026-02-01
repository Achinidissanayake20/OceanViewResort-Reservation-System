import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class EditReservation {

    public static void editReservation() {

        Scanner sc = new Scanner(System.in);
        Connection con = DBConnection.getConnection();

        try {
            System.out.print("Enter Reservation Number to Edit: ");
            String resNo = sc.nextLine();

            // Check if reservation exists
            String checkSql = "SELECT * FROM reservations WHERE reservation_no = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkSql);
            checkStmt.setString(1, resNo);

            ResultSet rs = checkStmt.executeQuery();

            if (!rs.next()) {
                System.out.println("Reservation not found!");
                return;
            }

            System.out.println("Reservation found. Enter new details:");

            System.out.print("New Guest Name: ");
            String guestName = sc.nextLine();

            System.out.print("New Address: ");
            String address = sc.nextLine();

            System.out.print("New Contact Number: ");
            String contact = sc.nextLine();

            System.out.print("New Room Type (Single/Double/Suite): ");
            String roomType = sc.nextLine();

            System.out.print("New Check-in Date (YYYY-MM-DD): ");
            String checkIn = sc.nextLine();

            System.out.print("New Check-out Date (YYYY-MM-DD): ");
            String checkOut = sc.nextLine();

            // Update query
            String sql = """
                UPDATE reservations
                SET guest_name = ?, 
                    address = ?, 
                    contact_number = ?, 
                    room_type = ?, 
                    check_in = ?, 
                    check_out = ?
                WHERE reservation_no = ?
                """;

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, guestName);
            ps.setString(2, address);
            ps.setString(3, contact);
            ps.setString(4, roomType);
            ps.setDate(5, java.sql.Date.valueOf(checkIn));
            ps.setDate(6, java.sql.Date.valueOf(checkOut));
            ps.setString(7, resNo);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("Reservation updated successfully!");
            } else {
                System.out.println("Update failed.");
            }

        } catch (Exception e) {
            System.out.println("Error while updating reservation.");
            e.printStackTrace();
        }
    }
}