import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection connection;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
                String url = "jdbc:mysql://localhost:3306/ocean_view_resort";
                String user = "root";
                String password = "1234";

                connection = DriverManager.getConnection(url, user, password);
            }
        } catch (SQLException e) {
            System.out.println("Database connection failed");
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.out.println("Error closing database connection.");
        }
    }
}