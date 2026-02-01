import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class HelpSection {

    public static void showHelp() {
        String sql = "SELECT topic, description FROM help_section";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            System.out.println("\n===== Help Section =====");

            while (rs.next()) {
                System.out.println("\nTopic: " + rs.getString("topic"));
                System.out.println("Guideline: " + rs.getString("description"));
            }

            System.out.println("\n========================");

        } catch (SQLException e) {
            System.out.println("Error retrieving help information.");
            e.printStackTrace();
        }
    }
}