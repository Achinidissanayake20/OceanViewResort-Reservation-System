import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class ViewReservation {

    public static void showReservationDetails() {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter Reservation Number: ");
        String reservationNo = sc.nextLine();

        String sql = "SELECT * FROM reservations WHERE reservation_no = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("\n===== Reservation Details =====");
                System.out.println("Reservation No: " + rs.getString("reservation_no"));
                System.out.println("Guest Name: " + rs.getString("guest_name"));
                System.out.println("Address: " + rs.getString("address"));
                System.out.println("Contact Number: " + rs.getString("contact_number"));
                System.out.println("Room Type: " + rs.getString("room_type"));
                System.out.println("Check-in Date: " + rs.getDate("check_in"));
                System.out.println("Check-out Date: " + rs.getDate("check_out"));
                System.out.println("===============================");
            } else {
                System.out.println("Reservation not found!");
            }

        } catch (SQLException e) {
            System.out.println("Error retrieving reservation details.");
            e.printStackTrace();
        }
    }
}