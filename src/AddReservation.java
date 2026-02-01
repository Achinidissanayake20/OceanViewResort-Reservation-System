import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Scanner;

public class AddReservation {

    public static void addNewReservation() {

        Scanner sc = new Scanner(System.in);

        System.out.print("Reservation Number: ");
        String reservationNo = sc.nextLine();

        System.out.print("Guest Name: ");
        String guestName = sc.nextLine();

        System.out.print("Address: ");
        String address = sc.nextLine();

        System.out.print("Contact Number: ");
        String contact = sc.nextLine();

        System.out.print("Room Type (Single/Double/Suite): ");
        String roomType = sc.nextLine();

        System.out.print("Check-in Date (YYYY-MM-DD): ");
        LocalDate checkIn = LocalDate.parse(sc.nextLine());

        System.out.print("Check-out Date (YYYY-MM-DD): ");
        LocalDate checkOut = LocalDate.parse(sc.nextLine());

        // Validation
        if (checkOut.isBefore(checkIn)) {
            System.out.println("Error: Check-out date must be after check-in date.");
            return;
        }

        String sql = """
            INSERT INTO reservations 
            (reservation_no, guest_name, address, contact_number, room_type, check_in, check_out) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setString(2, guestName);
            ps.setString(3, address);
            ps.setString(4, contact);
            ps.setString(5, roomType);
            ps.setDate(6, java.sql.Date.valueOf(checkIn));
            ps.setDate(7, java.sql.Date.valueOf(checkOut));

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                System.out.println("Reservation added successfully!");
            }

        } catch (SQLException e) {
            System.out.println("Error adding reservation.");
            e.printStackTrace();
        }
    }
}