import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.temporal.ChronoUnit;

public class CalculateBill {

    public static void calculateBill(String reservationNo) {

        String sql = "SELECT room_type, check_in, check_out FROM reservations WHERE reservation_no = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, reservationNo);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {

                String roomType = rs.getString("room_type");
                long nights = ChronoUnit.DAYS.between(
                        rs.getDate("check_in").toLocalDate(),
                        rs.getDate("check_out").toLocalDate()
                );

                double rate = switch (roomType) {
                    case "Single" -> 5000;
                    case "Double" -> 8000;
                    case "Suite" -> 12000;
                    default -> 0;
                };

                double total = nights * rate;

                System.out.println("===== BILL DETAILS =====");
                System.out.println("Room Type     : " + roomType);
                System.out.println("Nights Stayed : " + nights);
                System.out.println("Rate per Night: " + rate);
                System.out.println("Total Amount  : " + total);

            } else {
                System.out.println("Reservation not found.");
            }

        } catch (Exception e) {
            System.out.println("Error calculating bill: " + e.getMessage());
        }
    }
}